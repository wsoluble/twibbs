<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Res extends CI_Controller {
	/**
	 * レス投稿
	 */
	public function add() {
		$thread_id = null;
		$err_msgs = array();
		if ($this->input->is_ajax_request()) {
			// セッション読み込み
			$this->load->library('lib_ajax');
			$this->load->model('www/thread_model', 'this_model');
			// セッションがない場合は空を出力
			$s_user = null;
			if (!empty($_SESSION['user_id'])) {
				$s_user = $this->this_model->getUser($_SESSION['user_id']);
			}
			if (empty($s_user)) {
				echo '<div id="ajax-error"><span class="error">ログインしてください</span></div>';
				exit();
			}
			if (!empty($s_user->u_privilege_comment)) {
				echo '<div id="ajax-error"><span class="error">レス権限がありません</span></div>';
				exit();
			}
			$start = $this->input->post('start');
			if (!empty($start) && !preg_match('/^[0-9]+$/', $start)) {
				echo '<div id="ajax-error"><span class="error">不正な値を検出しました。</span></div>';
				exit();
			}
			$thread_id = $this->input->post('thread');
			if (empty($thread_id) || !preg_match('/^[0-9]+$/', $thread_id)) {
				echo '<div id="ajax-error"><span class="error">スレッドの指定が不正です</span></div>';
				exit();
			}
			// スレッドを取得
			$thread = $this->this_model->getThread($thread_id);
			if (empty($thread)) {
				echo '<div id="ajax-error"><span class="error">存在しないスレッドが指定されました</span></div>';
				exit();
			}
			// NGユーザー
			if ($this->this_model->isNgUser($thread->t_user_id, $s_user->user_id)) {
				echo '<div id="ajax-error"><span class="error">このスレッドではレスを書き込むことはできません</span></div>';
				exit();
			}
			// 満杯
			if ($thread->t_filled == 1) {
				echo '<div id="ajax-error" data-redirect="1" data-sec="' . POST_COMMENT_FILLED_REDIRECT_SEC . '"><span class="error">スレッドが満杯です。' . POST_COMMENT_FILLED_REDIRECT_SEC . '秒後に更新します。</span></div>';
				exit();
			}
			// 前回の投稿から時間が経過しているか
			$check_interval = $this->this_model->checkIntervalComment($s_user->u_last_comment_id);
			if (empty($check_interval)) {
				echo '<div id="ajax-error"><span class="error">前回の書き込みから' . POST_COMMENT_INTERVAL . '秒経過してから投稿してください</span></div>';
				exit();
			}
			// 検証
			$this->load->library('lib_valid', array('user' => $thread));
			$body = $this->lib_valid->valid_body($this->input->post('body'), $err_msgs);
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				$input = new stdClass;
				$input->thread_id = $thread_id;
				$input->user_id = $s_user->user_id;
				$input->body = $body;
				$input->ip = $this->input->ip_address();
				// 登録
				$result = $this->this_model->registerComment($input);
				if (!isset($result->successful)) {
					switch ($result->error) {
						case 'invalid_parameter':
							echo '<div id="ajax-error"><span class="error">パラメータが不正です</span></div>';
							break;

						case 'record_not_found':
							echo '<div id="ajax-error"><span class="error">存在しないスレッドが指定されました</span></div>';
							break;

						case 'privated':
							echo '<div id="ajax-error"><span class="error">削除済みのスレッドが指定されました</span></div>';
							break;

						case 'filled':
							echo '<div id="ajax-error" data-redirect="1" data-sec="' . POST_COMMENT_FILLED_REDIRECT_SEC . '"><span class="error">スレッドが満杯です。' . POST_COMMENT_FILLED_REDIRECT_SEC . '秒後に更新します。</span></div>';
							break;

						default:
							echo '<div id="ajax-error"><span class="error">レスの登録に失敗しました</span></div>';
							break;
					}
					exit();
				}
				// ツイート
				$post_tweet = $this->input->post('tweet');
				if (!empty($post_tweet)) {
					$this->lib_ajax->post_tweet_res($thread, $body);
				}
				// コメント一覧を描画
				$comments = $this->this_model->getCommentsRange($thread_id, $start, $result->successful, $s_user->user_id);
				$comment_entry_data = array();
				$comment_entry_data['comments'] = $comments;
				$comment_entry_data['disp_thread'] = false;
				$comment_entry_data['before_url'] = '';
				$comment_entry_data['after_url'] = '/t/' . $thread_id . '/after/' . $result->successful;
				$comment_entry_data['after_id'] = $result->successful;
				$thread_after = $this->this_model->getThread($thread_id);
				$content = '<div id="ajax-successful" data-count="' . $thread_after->t_comment_count . '" data-filled="' . $thread_after->t_filled . '">' . "\n";
				$content .= $this->load->view('comment_entry', $comment_entry_data, true);
				$content .= '</div>' . "\n";
				echo $content;
				exit();
			} else {
				echo '<div id="ajax-error">' . "\n";
				echo '<ul class="error">' . "\n";
				foreach ($err_msgs as $msg) {
					echo '<li>' . $msg . '</li>' . "\n";
				}
				echo '</ul>' . "\n";
				echo '</div>' . "\n";
				exit();
			}
		}
		header('HTTP/1.0 404 Not Found');
		echo '<div id="ajax-error"><span class="error">不正なリクエスト</span></div>';
	}
	/**
	 * レス削除
	 * @return [type] [description]
	 */
	public function remove() {
		$err_msgs = array();
		if ($this->input->is_ajax_request()) {
			// セッション読み込み
			$this->load->library('lib_ajax');
			$this->load->model('www/thread_model', 'this_model');
			if (empty($_SESSION['user_id'])) {
				echo '<div id="ajax-error"><span class="error">ログインしてください</span></div>';
				exit();
			}
			$s_user_id = empty($_SESSION['user_id']) ? null : $_SESSION['user_id'];
			$comment_id = $this->input->post('target');
			if (empty($comment_id) || !preg_match('/^[0-9]+$/', $comment_id)) {
				echo '<div id="ajax-error"><span class="error">レスの指定が不正です</span></div>';
				exit();
			}
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				// 削除
				$result = $this->this_model->removeComment($comment_id, $s_user_id);
				if (!isset($result->successful)) {
					switch ($result->error) {
						case 'invalid_parameter':
							echo '<div id="ajax-error"><span class="error">パラメータが不正です</span></div>';
							break;

						case 'record_not_found':
							echo '<div id="ajax-error"><span class="error">存在しないスレッドが指定されました</span></div>';
							break;

						default:
							echo '<div id="ajax-error"><span class="error">レスの削除に失敗しました</span></div>';
							break;
					}
					exit();
				}
				// コメント一覧を描画
				$comment = $this->this_model->getComment($comment_id, $s_user_id);
				$comment_entry_data = array();
				$comment_entry_data['comments'] = array($comment);
				$content = '<div id="ajax-successful">' . "\n";
				$content .= $this->load->view('comment_entry', $comment_entry_data, true);
				$content .= '</div>' . "\n";
				echo $content;
				exit();
			} else {
				echo '<div id="ajax-error">' . "\n";
				echo '<ul class="error">' . "\n";
				foreach ($err_msgs as $msg) {
					echo '<li>' . $msg . '</li>' . "\n";
				}
				echo '</ul>' . "\n";
				echo '</div>' . "\n";
				exit();
			}
		}
		header('HTTP/1.0 404 Not Found');
		echo '<div id="ajax-error"><span class="error">不正なリクエスト</span></div>';
	}
}
