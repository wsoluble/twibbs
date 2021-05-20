<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Thread extends CI_Controller {
	/**
	 * スレッド削除
	 * @return [type] [description]
	 */
	public function remove() {
		$err_msgs = array();
		if ($this->input->is_ajax_request()) {
			// セッション読み込み
			$this->load->library('session');
			$this->load->model('www/thread_model', 'this_model');
			$this->load->library('lib_base');
			if (empty($_SESSION['user_id'])) {
				echo '<div id="ajax-error"><span class="error">ログインしてください</span></div>';
				exit();
			}
			$thread_id = $this->input->post('target');
			if (empty($thread_id) || !preg_match('/^[0-9]+$/', $thread_id)) {
				echo '<div id="ajax-error"><span class="error">スレッドの指定が不正です</span></div>';
				exit();
			}
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				// 削除
				$result = $this->this_model->removeThread($thread_id, $_SESSION['user_id']);
				if (!isset($result->successful)) {
					switch ($result->error) {
						case 'invalid_parameter':
							echo '<div id="ajax-error"><span class="error">パラメータが不正です</span></div>';
							break;

						case 'record_not_found':
							echo '<div id="ajax-error"><span class="error">存在しないスレッドが指定されました</span></div>';
							break;

						default:
							echo '<div id="ajax-error"><span class="error">スレッドの削除に失敗しました</span></div>';
							break;
					}
					exit();
				}
				// コメント一覧を描画
				$threads = array();
				$threads[] = $this->this_model->getThread($thread_id, $_SESSION['user_id']);
				$thread_entry_data = array();
				$thread_entry_data['threads'] = $threads;
				$content = '<div id="ajax-successful">' . "\n";
				$content .= $this->load->view('thread_entry', $thread_entry_data, true);
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
	 * ブックマーク
	 * @return [type] [description]
	 */
	public function bookmark($method) {
		$thread_id = null;
		$err_msgs = array();
		if ($this->input->is_ajax_request()) {
			// セッション読み込み
			$this->load->library('session');
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
			if (!empty($s_user->u_privilege_thread_favorite)) {
				echo '<div id="ajax-error"><span class="error">権限がありません</span></div>';
				exit();
			}
			$thread_id = $this->input->post('thread');
			if (empty($thread_id) || !preg_match('/^[0-9]+$/', $thread_id)) {
				echo '<div id="ajax-error"><span class="error">スレッドの指定が不正です</span></div>';
				exit();
			}
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				// 登録
				$result = null;
				switch ($method) {
					case 'add':
						$result = $this->this_model->registerThreadFavorite($s_user->user_id, $thread_id);
						if (!isset($result->successful)) {
							switch ($result->error) {
								case 'invalid_parameter':
									echo '<div id="ajax-error"><span class="error">パラメータが不正です</span></div>';
									break;

								case 'record_not_found':
									echo '<div id="ajax-error"><span class="error">存在しないスレッドが指定されました</span></div>';
									break;

								default:
									echo '<div id="ajax-error"><span class="error">ぶくま登録に失敗しました</span></div>';
									break;
							}
							exit();
						}
						echo '<div id="ajax-successful">ぶくま登録しました</div>';
						break;

					case 'remove':
						$result = $this->this_model->deleteThreadFavorite($s_user->user_id, $thread_id);
						if (!isset($result->successful)) {
							switch ($result->error) {
								case 'invalid_parameter':
									echo '<div id="ajax-error"><span class="error">パラメータが不正です</span></div>';
									break;

								case 'record_not_found':
									echo '<div id="ajax-error"><span class="error">存在しないスレッドが指定されました</span></div>';
									break;

								default:
									echo '<div id="ajax-error"><span class="error">ぶくまの解除に失敗しました</span></div>';
									break;
							}
							exit();
						}
						echo '<div id="ajax-successful">ぶくまを解除しました</div>';
						break;

					default:
						break;
				}
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
