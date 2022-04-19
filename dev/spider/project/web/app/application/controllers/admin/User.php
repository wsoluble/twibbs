<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class User extends CI_Controller {
	/**
	 * ユーザー非公開画面
	 * @param  [type] $method [description]
	 */
	public function get($twitter_id, $method, $td, $base) {
		//-------------------------------------------------------------------------
		// ロード
		//-------------------------------------------------------------------------
		$this->load->library('session');
		$this->load->library('lib_base');
		$this->load->library('lib_admin');
		$this->load->helper('url');
		$this->load->model('admin/user_model', 'this_model');
		//-------------------------------------------------------------------------
		// Input
		//-------------------------------------------------------------------------
		// ユーザー名
		if (!preg_match('/^[a-zA-Z0-9_]{1,15}$/', $twitter_id)) {
			$this->lib_base->output_404();
		}
		if (!empty($td) && !preg_match('/^(before|after)$/', $td)) {
			$this->lib_base->output_404();
		}
		if (!empty($base) && (!preg_match('/^[0-9]+$/', $base) || $base > PHP_INT_MAX)) {
			$this->lib_base->output_404();
		}
		// メソッド
		$method = empty($method) ? '' : $method;
		switch ($method) {
			case 'report_res':
			case 'report_thread':
				break;

			default:
				$this->lib_base->output_404();
				break;
		}
		// どちらも値がセットされている場合、どちらも値がセットされていない場合に続行
		if (empty($td) xor empty($base)) {
			$this->lib_base->output_404();
		}
		//-------------------------------------------------------------------------
		// 出力
		//-------------------------------------------------------------------------
		// クエリ
		$queries = array();
		$queries['twitter_id'] = $twitter_id;
		$queries['method'] = $method;
		$queries['td'] = $td;
		$queries['base'] = $base;
		// 出力クラス
		$out = new OutPuter($queries);
		if ($this->input->is_ajax_request()) {
			if (!$out->ajax()) {
				$this->output->set_status_header('404');
			}
		} else {
			$out->page();
		}
	}
}

/**
 * ページ出力クラス
 */
class OutPuter {
	// ci
	private $ci = null;
	private $q = null;
	/**
	 * [__construct description]
	 */
	function __construct($queries) {
		$this->ci = &get_instance();
		$this->q = $queries;
	}
	/**
	 * ページを出力
	 * @return [type] [description]
	 */
	public function page() {
		//-------------------------------------------------------------------------
		// template変数
		//-------------------------------------------------------------------------
		$temp = new stdClass;
		$temp->content = '';
		$temp->s_user = null;
		$temp->head_params = array('c_name' => 'user', 'nofollow' => true);
		$temp->categories = null;
		$temp->category = null;
		$temp->p_category = null;
		$temp->dir_title = '';
		$temp->directories = array();
		//-------------------------------------------------------------------------
		// Model
		//-------------------------------------------------------------------------
		if (!empty($_SESSION['user_id'])) {
			$temp->s_user = $this->ci->this_model->getUser($this->ci->session->user_id);
		}
		$temp->categories = $this->ci->this_model->getAllCategories();
		// ユーザーを取得
		$user = $this->ci->this_model->getUserFromTwitterID($this->q['twitter_id']);
		$user_url = '';
		// スレッド一覧を取得
		$record_max = 0;
		$records = null;
		$base_id = null;
		$first_id = null;
		$last_id = null;
		if (!empty($user)) {
			switch ($this->q['method']) {
				case 'report_res':
					$user_url = '/admin/u/' . $this->q['twitter_id'] . '/report_res';
					if (!empty($this->q['td'])) {
						$temp->head_params['canonical'] = $user_url;
					}
					$record_max = $user->u_comment_report_count;
					$first_id = $user->u_first_comment_report_id;
					$last_id = $user->u_last_comment_report_id;
					if (!empty($this->q['base'])) {
						$base_id = ($this->q['base'] < $first_id) ? $first_id : $this->q['base'];
						$base_id = ($this->q['base'] > $last_id) ? $last_id : $this->q['base'];
						if ($this->q['base'] >= $last_id && $this->q['td'] == 'after') {
							header('Location: ' . $user_url);
							exit();
						}
					} else {
						$base_id = $last_id + 1;
						$this->q['td'] = 'before';
					}
					if (!empty($record_max)) {
						$records = $this->ci->this_model->getCommentReportsFromUserID($user->user_id, $base_id, $this->q['td']);
					}
					break;

				case 'report_thread':
					$user_url = '/admin/u/' . $this->q['twitter_id'] . '/report_thread';
					if (!empty($this->q['td'])) {
						$temp->head_params['canonical'] = $user_url;
					}
					$record_max = $user->u_thread_report_count;
					$first_id = $user->u_first_thread_report_id;
					$last_id = $user->u_last_thread_report_id;
					if (!empty($this->q['base'])) {
						$base_id = ($this->q['base'] < $first_id) ? $first_id : $this->q['base'];
						$base_id = ($this->q['base'] > $last_id) ? $last_id : $this->q['base'];
						if ($this->q['base'] >= $last_id && $this->q['td'] == 'after') {
							header('Location: ' . $user_url);
							exit();
						}
					} else {
						$base_id = $last_id + 1;
						$this->q['td'] = 'before';
					}
					if (!empty($record_max)) {
						$records = $this->ci->this_model->getThreadReportsFromUserID($user->user_id, $base_id, $this->q['td']);
					}
					break;

				default:
					break;
			}
		}
		// afterの場合は順番を逆にする（新しい順に）
		if ($this->q['td'] == 'after') {
			$records = array_reverse($records);
		}
		$after_url = '';
		$before_url = '';
		if (!empty($records)) {
			switch ($this->q['method']) {
				case 'report_res':
					$after_url = $user_url . '/after/' . $records[0]->comment_report_id;
					if ($first_id < $records[count($records) - 1]->comment_report_id) {
						$before_url = $user_url . '/before/' . $records[count($records) - 1]->comment_report_id;
					}
					break;

				case 'report_thread':
					$after_url = $user_url . '/after/' . $records[0]->thread_report_id;
					if ($first_id < $records[count($records) - 1]->thread_report_id) {
						$before_url = $user_url . '/before/' . $records[count($records) - 1]->thread_report_id;
					}
					break;
			}
		}
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		if (!empty($user)) {
			$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
			$temp->directories[] = array('dir' => $user_url, 'title' => '@' . $this->q['twitter_id']);
			$temp->head_params['title'] = '@' . $this->q['twitter_id'];
			switch ($this->q['method']) {
				case 'report_res':
					$temp->directories[] = array('dir' => $user_url, 'title' => 'レススパム報告');
					$temp->head_params['title'] .= ' - レススパム報告';
					break;

				case 'report_thread':
					$temp->directories[] = array('dir' => $user_url, 'title' => 'スレッドスパム報告');
					$temp->head_params['title'] .= ' - スレッドスパム報告';
					break;

				default:
					break;
			}
			$temp->dir_title = '@' . $this->q['twitter_id'];

			$user_title_data = array();
			$user_title_data['method'] = $this->q['method'];
			$user_title_data['user'] = $user;
			$user_title_data['disp_current_dir'] = true;
			$user_title_data['record_count'] = $record_max;
			$temp->content .= $this->ci->load->view('user_title', $user_title_data, true);

			switch ($this->q['method']) {
				case 'report_res':
				case 'report_thread':
					$report_entry_data = array();
					$report_entry_data['disp_num'] = false;
					$report_entry_data['disp_link'] = true;
					$report_entry_data['reports'] = $records;
					$report_entry_data['before_url'] = $before_url;
					$report_entry_data['after_url'] = $after_url;
					$temp->content .= $this->ci->load->view('report_entry', $report_entry_data, true);
					break;

				default:
					break;
			}
		// Not Found
		} else {
			$this->ci->output->set_status_header('404');

			$temp->directories[] = array('dir' => '', 'title' => '<i class="fa fa-home" aria-hidden="true"></i>ホーム');
			$temp->directories[] = array('dir' => '/404', 'title' => '<i class="fa fa-info-circle" aria-hidden="true"></i>お探しのユーザーは見つかりません。');
			$temp->dir_title = 'User Not Found.';

			$site_error_data = array();
			$site_error_data['message'] = 'お探しのユーザーは見つかりませんでした。';
			$temp->content .= $this->ci->load->view('site_error', $site_error_data, true);
		}
		//-------------------------------------------------------------------------
		// 描画
		//-------------------------------------------------------------------------
		$this->ci->lib_base->output_template($temp);
	}
	/**
	 * Ajax出力
	 * @return [type] [description]
	 */
	public function ajax() {
		// ユーザーを取得
		$user = $this->ci->this_model->getUserFromTwitterID($this->q['twitter_id']);
		$user_url = '';
		// スレッド一覧を取得
		$record_max = 0;
		$records = null;
		$base_id = null;
		$first_id = null;
		$last_id = null;
		if (!empty($user)) {
			switch ($this->q['method']) {
				case 'report_res':
					$user_url = '/admin/u/' . $this->q['twitter_id'] . '/report_res';
					$record_max = $user->u_comment_report_count;
					$first_id = $user->u_first_comment_report_id;
					$last_id = $user->u_last_comment_report_id;
					if (!empty($this->q['base'])) {
						$base_id = ($this->q['base'] < $first_id) ? $first_id : $this->q['base'];
						$base_id = ($this->q['base'] > $last_id) ? $last_id : $this->q['base'];
					} else {
						$base_id = $last_id + 1;
						$this->q['td'] = 'before';
					}
					if (!empty($record_max)) {
						$records = $this->ci->this_model->getCommentReportsFromUserID($user->user_id, $base_id, $this->q['td']);
					}
					break;

				case 'report_thread':
					$user_url = '/admin/u/' . $this->q['twitter_id'] . '/report_thread';
					$record_max = $user->u_thread_report_count;
					$first_id = $user->u_first_thread_report_id;
					$last_id = $user->u_last_thread_report_id;
					if (!empty($this->q['base'])) {
						$base_id = ($this->q['base'] < $user->u_first_thread_id) ? $user->u_first_thread_id : $this->q['base'];
						$base_id = ($this->q['base'] > $user->u_last_thread_id) ? $user->u_last_thread_id : $this->q['base'];
					} else {
						$base_id = $user->u_last_thread_id + 1;
						$this->q['td'] = 'before';
					}
					if (!empty($user->u_thread_count)) {
						$records = $this->ci->this_model->getThreadReportsFromUserID($user->user_id, $base_id, $this->q['td']);
					}
					break;

				default:
					break;
			}
		} else {
			return false;
		}
		// afterの場合は順番を逆にする（新しい順に）
		if ($this->q['td'] == 'after') {
			$records = array_reverse($records);
		}
		$after_url = '';
		$before_url = '';
		if (!empty($records)) {
			switch ($this->q['method']) {
				case 'report_res':
					switch ($this->q['td']) {
						case 'after':
							$after_url = $user_url . '/after/' . $records[0]->comment_report_id;
							break;

						case 'before':
							if ($first_id < $records[count($records) - 1]->comment_report_id) {
								$before_url = $user_url . '/before/' . $records[count($records) - 1]->comment_report_id;
							}
							break;
					}
					break;

				case 'report_thread':
					switch ($this->q['td']) {
						case 'after':
							$after_url = $user_url . '/after/' . $records[0]->thread_report_id;
							break;

						case 'before':
							if ($first_id < $records[count($records) - 1]->thread_report_id) {
								$before_url = $user_url . '/before/' . $records[count($records) - 1]->thread_report_id;
							}
							break;
					}
					break;
			}
		}
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		$content = '';
		if (empty($records)) {
			$content .= '<div id="ajax-error">' . "\n";
			$content .= '</div>' . "\n";
			echo $content;
		} else {
			switch ($this->q['method']) {
				case 'report_res':
				case 'report_thread':
					$report_entry_data = array();
					$report_entry_data['disp_num'] = false;
					$report_entry_data['disp_link'] = true;
					$report_entry_data['reports'] = $records;
					$report_entry_data['before_url'] = $before_url;
					$report_entry_data['after_url'] = $after_url;
					$content = $this->ci->load->view('report_entry', $report_entry_data, true);
					break;

				default:
					break;
			}
			echo $content;
		}
		return true;
	}
}