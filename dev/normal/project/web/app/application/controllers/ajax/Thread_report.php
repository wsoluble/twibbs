<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Thread_report extends CI_Controller {
	/**
	 * スレッド報告を登録
	 */
	public function add() {
		$thread_id = null;
		$err_msgs = array();
		if ($this->input->is_ajax_request()) {
			// セッション読み込み
			$this->load->library('lib_ajax');
			$this->load->model('www/report_model', 'this_model');
			// セッションがない場合は空を出力
			if (empty($_SESSION['user_id'])) {
				echo '<div id="ajax-error"><span class="error">ログインしてください</span></div>';
				exit();
			}
			$s_user_id = empty($_SESSION['user_id']) ? null : $_SESSION['user_id'];
			$thread_id = $this->input->post('target');
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
			// スパム通報の種類
			$rtype = $this->input->post('rtype');
			if (empty($rtype) || !preg_match('/^[0-9]+$/', $rtype)) {
				echo '<div id="ajax-error"><span class="error">スパム報告の種類を選択してください</span></div>';
				exit();
			}
			// 検証
			$this->load->library('lib_valid', array('user' => $thread));
			$body = $this->lib_valid->valid_body($this->input->post('body'), $err_msgs);
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				$input = new stdClass;
				$input->user_id = $s_user_id;
				$input->thread_id = $thread_id;
				$input->body = $body;
				$input->report_type = $rtype;
				$input->ip = $this->input->ip_address();
				$input->host = '';
				$input->ua = '';
				// 登録
				$result = $this->this_model->registerThreadReport($input);
				if (!isset($result->successful)) {
					switch ($result->error) {
						case 'invalid_parameter':
							echo '<div id="ajax-error"><span class="error">パラメータが不正です</span></div>';
							break;

						case 'record_not_found':
							echo '<div id="ajax-error"><span class="error">存在しないデータが指定されました</span></div>';
							break;

						case 'no_privilege':
							echo '<div id="ajax-error"><span class="error">登録できませんでした</span></div>';
							break;

						case 'filled':
							echo '<div id="ajax-error"><span class="error">問題の報告が' . SPAM_REPORT_MAX . '件に達しました。これ以上は投稿できません。</span></div>';
							break;

						case 'privated':
							echo '<div id="ajax-error"><span class="error">削除済みのスレッドが指定されました</span></div>';
							break;

						default:
							echo '<div id="ajax-error"><span class="error">登録できませんでした</span></div>';
							break;
					}
					exit();
				}
				// スパム報告投稿者のコメントを返す
				$reports = $this->this_model->getThreadReport($s_user_id, $thread_id);
				$report_entry_data = array();
				$report_entry_data['disp_num'] = false;
				$report_entry_data['reports'] = $reports;
				$content = '<div id="ajax-successful">' . "\n";
				$content .= '<h3 class="report-title">あなたのスパム報告</h3>' . "\n";
				$content .= $this->load->view('report_entry', $report_entry_data, true);
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
	 * スレッド報告を削除
	 */
	public function remove() {
		$err_msgs = array();
		if ($this->input->is_ajax_request()) {
			// セッション読み込み
			$this->load->library('lib_ajax');
			$this->load->model('www/report_model', 'this_model');
			// セッションがない場合は空を出力
			if (empty($_SESSION['user_id'])) {
				echo '<div id="ajax-error"><span class="error">ログインしてください</span></div>';
				exit();
			}
			$s_user_id = empty($_SESSION['user_id']) ? null : $_SESSION['user_id'];
			$target_id = $this->input->post('target');
			$r_user_id = $this->input->post('user');
			if (empty($target_id) || !preg_match('/^[0-9]+$/', $target_id)) {
				echo '<div id="ajax-error"><span class="error">対象の指定が不正です</span></div>';
				exit();
			}
			if (empty($r_user_id) || !preg_match('/^[0-9]+$/', $r_user_id)) {
				echo '<div id="ajax-error"><span class="error">ユーザーの指定が不正です</span></div>';
				exit();
			}
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				// 削除
				$result = $this->this_model->deleteThreadReport($r_user_id, $target_id, $s_user_id);
				if (!isset($result->successful)) {
					switch ($result->error) {
						case 'invalid_parameter':
							echo '<div id="ajax-error"><span class="error">パラメータが不正です</span></div>';
							break;

						case 'record_not_found':
							echo '<div id="ajax-error"><span class="error">対象のデータが存在しません</span></div>';
							break;

						case 'invalid_user':
							echo '<div id="ajax-error"><span class="error">不正な操作です</span></div>';
							break;

						default:
							echo '<div id="ajax-error"><span class="error">スパム報告の削除に失敗しました</span></div>';
							break;
					}
					exit();
				}
				// 返す
				$content = '<div id="ajax-successful">スパム報告を削除しました</div>' . "\n";
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
