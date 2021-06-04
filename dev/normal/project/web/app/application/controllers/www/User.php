<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class User extends CI_Controller {
	/**
	 * [get description]
	 * @return [type] [description]
	 */
	public function get($twitter_id, $method, $td, $base) {
		//-------------------------------------------------------------------------
		// ロード
		//-------------------------------------------------------------------------
		$this->load->helper('url');
		$this->load->library('lib_base');
		$this->load->model('www/user_model', 'this_model');
		//-------------------------------------------------------------------------
		// Input
		//-------------------------------------------------------------------------
		// ユーザー名
		//$q_twitter_id = $this->input->get('twitter_id');
		if (!preg_match('/^[a-zA-Z0-9_]{1,15}$/', $twitter_id)) {
			$this->lib_base->output_404();
		}
		//$q_td = $this->input->get('td');
		if (!empty($td) && !preg_match('/^(before|after)$/', $td)) {
			$this->lib_base->output_404();
		}
		//$q_base = $this->input->get('base');
		if (!empty($base) && (!preg_match('/^[0-9]+$/', $base) || $base > PHP_INT_MAX)) {
			$this->lib_base->output_404();
		}
		// メソッド
		//$q_method = $this->input->get('method');
		$method = empty($method) ? '' : $method;
		switch ($method) {
			case '':
			case 'thread':
			case 'bookmark':
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
		$temp->head_params = array('c_name' => 'user');
		$temp->categories = null;
		$temp->category = null;
		$temp->p_category = null;
		$temp->dir_title = '';
		$temp->directories = array();
		//-------------------------------------------------------------------------
		// Model
		//-------------------------------------------------------------------------
		$s_user_id = empty($_SESSION['user_id']) ? null : $_SESSION['user_id'];
		if (!empty($_SESSION['user_id'])) {
			$temp->s_user = $this->ci->this_model->getUser($s_user_id);
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
				case '':
					$user_url = '/u/' . $this->q['twitter_id'];
					if (!empty($this->q['td'])) {
						$temp->head_params['canonical'] = $user_url;
					}
					$record_max = $user->u_comment_count - $user->u_privated_comment_count;
					$first_id = $user->u_first_comment_id;
					$last_id = $user->u_last_comment_id;
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
						$records = $this->ci->this_model->getCommentsFromUserID($user->user_id, $base_id, $this->q['td'], $s_user_id);
					}
					break;

				case 'thread':
					$user_url = '/u/' . $this->q['twitter_id'] . '/thread';
					if (!empty($this->q['td'])) {
						$temp->head_params['canonical'] = $user_url;
					}
					$record_max = $user->u_thread_count - $user->u_privated_thread_count;
					$first_id = $user->u_first_thread_id;
					$last_id = $user->u_last_thread_id;
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
						$records = $this->ci->this_model->getThreadsFromUserID($user->user_id, $base_id, $this->q['td'], $s_user_id);
					}
					break;

				case 'bookmark':
					$user_url = '/u/' . $this->q['twitter_id'] . '/bookmark';
					if (!empty($this->q['td'])) {
						$temp->head_params['canonical'] = $user_url;
					}
					$record_max = $user->u_thread_favorite_count;
					$first_id = $user->u_first_thread_favorite_id;
					$last_id = $user->u_last_thread_favorite_id;
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
						$records = $this->ci->this_model->getFavoriteThreadsFromUserID($user->user_id, $base_id, $this->q['td'], $s_user_id);
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
				case '':
					$after_url = $user_url . '/after/' . $records[0]->comment_id;
					if ($first_id < $records[count($records) - 1]->comment_id) {
						$before_url = $user_url . '/before/' . $records[count($records) - 1]->comment_id;
					}
					break;

				case 'thread':
					$after_url = $user_url . '/after/' . $records[0]->thread_id;
					if ($first_id < $records[count($records) - 1]->thread_id) {
						$before_url = $user_url . '/before/' . $records[count($records) - 1]->thread_id;
					}
					break;

				case 'bookmark':
					$after_url = $user_url . '/after/' . $records[0]->bookmark_id;
					if ($first_id < $records[count($records) - 1]->bookmark_id) {
						$before_url = $user_url . '/before/' . $records[count($records) - 1]->bookmark_id;
					}
					break;
			}
		}
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		if (!empty($user)) {
			$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
			$temp->directories[] = array('dir' => 'u/' . $this->q['twitter_id'], 'title' => '@' . $this->q['twitter_id']);
			$temp->head_params['title'] = '@' . $this->q['twitter_id'];
			switch ($this->q['method']) {
				case '':
					$temp->head_params['title'] .= 'さんのレス';
					$temp->head_params['description'] = '@' . $this->q['twitter_id'] . 'さんが投稿したレス';
					$temp->head_params['keywords'] = array($this->q['twitter_id'], 'レス');
					break;

				case 'thread':
					$temp->directories[] = array('dir' => $user_url, 'title' => 'スレッド');
					$temp->head_params['title'] .= 'さんのスレッド';
					$temp->head_params['description'] = '@' . $this->q['twitter_id'] . 'さんが投稿したスレッド';
					$temp->head_params['keywords'] = array($this->q['twitter_id'], 'スレッド');
					break;

				case 'bookmark':
					$temp->directories[] = array('dir' => $user_url, 'title' => 'ぶくま！');
					$temp->head_params['title'] .= 'さんのぶくま！';
					$temp->head_params['description'] = '@' . $this->q['twitter_id'] . 'さんのブックマーク';
					$temp->head_params['keywords'] = array($this->q['twitter_id'], 'ブックマーク', 'ぶくま！');
					break;

				default:
					break;
			}
			$temp->dir_title = '@' . $this->q['twitter_id'];

			$temp->head_params['og'] = array();
			$temp->head_params['og']['type'] = 'article';
			$temp->head_params['og']['title'] = '@' . $this->q['twitter_id'];
			$temp->head_params['og']['url'] = $user_url;
			$temp->head_params['og']['description'] = $temp->head_params['title'];
			$temp->head_params['twitter'] = array();
			$temp->head_params['twitter']['card'] = 'summary';

			$user_title_data = array();
			$user_title_data['method'] = $this->q['method'];
			$user_title_data['user'] = $user;
			$user_title_data['disp_current_dir'] = true;
			$user_title_data['record_count'] = $record_max;
			$temp->content .= $this->ci->load->view('user_title', $user_title_data, true);

			switch ($this->q['method']) {
				case 'thread':
				case 'bookmark':
					$thread_entry_data = array();
					$thread_entry_data['threads'] = $records;
					$thread_entry_data['before_url'] = $before_url;
					$thread_entry_data['after_url'] = $after_url;
					$thread_entry_data['adv'] = $this->ci->lib_base->get_adv('entry');
					$temp->content .= $this->ci->load->view('thread_entry', $thread_entry_data, true);
					break;

				case '':
					$comment_entry_data = array();
					$comment_entry_data['comments'] = $records;
					$comment_entry_data['disp_thread'] = true;
					$comment_entry_data['before_url'] = $before_url;
					$comment_entry_data['after_url'] = $after_url;
					$comment_entry_data['disp_no_entry'] = true;
					$comment_entry_data['use_push_state'] = true;
					$comment_entry_data['adv'] = $this->ci->lib_base->get_adv('entry');
					$temp->content .= $this->ci->load->view('comment_entry', $comment_entry_data, true);
					break;

				default:
					break;
			}
		// Not Found
		} else {
			$this->ci->output->set_status_header('404');
			$temp->head_params['nofollow'] = true;

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
		$s_user_id = empty($_SESSION['user_id']) ? null : $_SESSION['user_id'];
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
				case '':
					$user_url = '/u/' . $this->q['twitter_id'];
					$record_max = $user->u_comment_count;
					$first_id = $user->u_first_comment_id;
					$last_id = $user->u_last_comment_id;
					if (!empty($this->q['base'])) {
						$base_id = ($this->q['base'] < $user->u_first_comment_id) ? $user->u_first_comment_id : $this->q['base'];
						$base_id = ($this->q['base'] > $user->u_last_comment_id) ? $user->u_last_comment_id : $this->q['base'];
					} else {
						$base_id = $user->u_last_comment_id + 1;
						$this->q['td'] = 'before';
					}
					if (!empty($user->u_comment_count)) {
						$records = $this->ci->this_model->getCommentsFromUserID($user->user_id, $base_id, $this->q['td'], $s_user_id);
					}
					break;

				case 'thread':
					$user_url = '/u/' . $this->q['twitter_id'] . '/thread';
					$record_max = $user->u_thread_count;
					$first_id = $user->u_first_thread_id;
					$last_id = $user->u_last_thread_id;
					if (!empty($this->q['base'])) {
						$base_id = ($this->q['base'] < $user->u_first_thread_id) ? $user->u_first_thread_id : $this->q['base'];
						$base_id = ($this->q['base'] > $user->u_last_thread_id) ? $user->u_last_thread_id : $this->q['base'];
					} else {
						$base_id = $user->u_last_thread_id + 1;
						$this->q['td'] = 'before';
					}
					if (!empty($user->u_thread_count)) {
						$records = $this->ci->this_model->getThreadsFromUserID($user->user_id, $base_id, $this->q['td'], $s_user_id);
					}
					break;

				case 'bookmark':
					$user_url = '/u/' . $this->q['twitter_id'] . '/bookmark';
					$record_max = $user->u_thread_favorite_count;
					$first_id = $user->u_first_thread_favorite_id;
					$last_id = $user->u_last_thread_favorite_id;
					if (!empty($this->q['base'])) {
						$base_id = ($this->q['base'] < $user->u_first_thread_favorite_id) ? $user->u_first_thread_favorite_id : $this->q['base'];
						$base_id = ($this->q['base'] > $user->u_last_thread_favorite_id) ? $user->u_last_thread_favorite_id : $this->q['base'];
					} else {
						$base_id = $user->u_last_thread_favorite_id + 1;
						$this->q['td'] = 'before';
					}
					if (!empty($user->u_thread_favorite_count)) {
						$records = $this->ci->this_model->getFavoriteThreadsFromUserID($user->user_id, $base_id, $this->q['td'], $s_user_id);
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
				case '':
					switch ($this->q['td']) {
						case 'after':
							$after_url = $user_url . '/after/' . $records[0]->comment_id;
							break;

						case 'before':
							if ($first_id < $records[count($records) - 1]->comment_id) {
								$before_url = $user_url . '/before/' . $records[count($records) - 1]->comment_id;
							}
							break;
					}
					break;

				case 'thread':
					switch ($this->q['td']) {
						case 'after':
							$after_url = $user_url . '/after/' . $records[0]->thread_id;
							break;

						case 'before':
							if ($first_id < $records[count($records) - 1]->thread_id) {
								$before_url = $user_url . '/before/' . $records[count($records) - 1]->thread_id;
							}
							break;
					}
					break;

				case 'bookmark':
					switch ($this->q['td']) {
						case 'after':
							$after_url = $user_url . '/after/' . $records[0]->bookmark_id;
							break;

						case 'before':
							if ($first_id < $records[count($records) - 1]->bookmark_id) {
								$before_url = $user_url . '/before/' . $records[count($records) - 1]->bookmark_id;
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
				case '':
					$comment_entry_data = array();
					$comment_entry_data['comments'] = $records;
					$comment_entry_data['disp_thread'] = true;
					$comment_entry_data['before_url'] = $before_url;
					$comment_entry_data['after_url'] = $after_url;
					$comment_entry_data['adv'] = $this->ci->lib_base->get_adv('entry');
					$content = '<div id="ajax-successful">' . "\n";
					$content .= $this->ci->load->view('comment_entry', $comment_entry_data, true);
					$content .= '</div>' . "\n";
					break;

				case 'thread':
				case 'bookmark':
					$thread_entry_data = array();
					$thread_entry_data['threads'] = $records;
					$thread_entry_data['before_url'] = $before_url;
					$thread_entry_data['after_url'] = $after_url;
					$thread_entry_data['adv'] = $this->ci->lib_base->get_adv('entry');
					$content = '<div id="ajax-successful">' . "\n";
					$content .= $this->ci->load->view('thread_entry', $thread_entry_data, true);
					$content .= '</div>' . "\n";
					break;
			}
			echo $content;
		}
		return true;
	}
}
