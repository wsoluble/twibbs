<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Thread extends CI_Controller {
	/**
	 * ページ出力
	 * @param  [type] $thread_id [description]
	 * @return [type]            [description]
	 */
	public function get($thread_id, $td, $base) {
		//-------------------------------------------------------------------------
		// ロード
		//-------------------------------------------------------------------------
		$this->load->library('lib_base');
		$this->load->model('www/thread_model', 'this_model');
		//-------------------------------------------------------------------------
		// Input
		//-------------------------------------------------------------------------
		//$q_thread_id = $this->input->get('thread_id');
		if (!preg_match('/^[0-9]+$/', $thread_id) || $thread_id > PHP_INT_MAX) {
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
		// どちらも値がセットされている場合、どちらも値がセットされていない場合に続行
		if (empty($td) xor empty($base)) {
			$this->lib_base->output_404();
		}
		//-------------------------------------------------------------------------
		// 出力
		//-------------------------------------------------------------------------
		// クエリ
		$queries = array();
		$queries['thread_id'] = $thread_id;
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
		$temp->head_params = array('c_name' => 'thread');
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
		// スレッドを取得
		$thread = $this->ci->this_model->getThread($this->q['thread_id'], $s_user_id);
		$thread_url = '';
		$thread_tags = array();
		$comments = array();
		$base_id = null;
		$first_id = null;
		// 作成済みスレッドの場合
		if (!empty($thread)) {
			$thread_url = '/t/' . $this->q['thread_id'];
			if (!empty($this->q['td'])) {
				$temp->head_params['canonical'] = $thread_url;
			}
			// 削除済みでない場合
			if ($thread->t_privated == 0) {
				// カテゴリ
				if (!empty($thread->t_sub_category)) {
					$temp->category = $this->ci->this_model->getCategory($thread->t_sub_category);
				}
				$temp->p_category = $this->ci->this_model->getCategory($thread->t_main_category);
				// タグを取得
				$thread_tags = $this->ci->this_model->getThreadTag($this->q['thread_id']);
				// コメント一覧を取得
				$first_id = $thread->t_first_comment_id;
				// 範囲チェック
				if (!empty($this->q['base'])) {
					$base_id = ($this->q['base'] < $thread->t_first_comment_id) ? $thread->t_first_comment_id : $this->q['base'];
					$base_id = ($this->q['base'] > $thread->t_last_comment_id) ? $thread->t_last_comment_id : $this->q['base'];
					if ($this->q['base'] >= $thread->t_last_comment_id && $this->q['td'] == 'after') {
						header('Location: ' . $thread_url);
						exit();
					}
				} else {
					$base_id = $thread->t_last_comment_id + 1;
					$this->q['td'] = 'before';
				}
				if (!empty($thread->t_comment_count)) {
					$comments = $this->ci->this_model->getComments($this->q['thread_id'], $base_id, $this->q['td'], $s_user_id);
				}
			}
		} else {
			$this->ci->lib_base->output_404();
		}
		// afterの場合は順番を逆にする（新しい順に）
		if ($this->q['td'] == 'after') {
			$comments = array_reverse($comments);
		}
		$after_url = '';
		$before_url = '';
		$after_id = null;
		if (!empty($comments)) {
			if ($thread->t_filled == 0 || $thread->t_last_comment_id > $comments[0]->comment_id) {
				$after_url = $thread_url . '/after/' . $comments[0]->comment_id;
				$after_id = $comments[0]->comment_id;
			}
			if ($first_id < $comments[count($comments) - 1]->comment_id) {
				$before_url = $thread_url . '/before/' . $comments[count($comments) - 1]->comment_id;
			}
		}
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		// 公開スレッド
		if ($thread->t_privated == 0) {

			$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
			$temp->directories[] = array('dir' => 'u/' . $thread->u_twitter_id, 'title' => '@' . $thread->u_twitter_id);
			$temp->directories[] = array('dir' => $thread_url, 'title' => $thread->t_title);
			$temp->dir_title = 'スレッド';

			$og_description = mb_substr(str_replace(array("\r\n","\n","\r"), '', $thread->t_body), 0, 100);
			$temp->head_params['title'] = $thread->t_title;
			$temp->head_params['og'] = array();
			$temp->head_params['og']['type'] = 'article';
			$temp->head_params['og']['title'] = $thread->t_title;
			$temp->head_params['og']['url'] = $thread_url;
			$temp->head_params['og']['description'] = $og_description;
			$temp->head_params['twitter'] = array();
			$temp->head_params['twitter']['card'] = 'summary';

			$temp->head_params['description'] = $og_description;
			$temp->head_params['keywords'] = array();
			foreach ($thread_tags as $tg) {
				$temp->head_params['keywords'][] = $tg->tg_word;
			}

			$user_title_data = array();
			$user_title_data['method'] = 'default';
			$user_title_data['user'] = $thread;
			$user_title_data['disp_current_dir'] = true;
			$user_title_data['record_count'] = 1;
			$temp->content .= $this->ci->load->view('user_title', $user_title_data, true);

			$thread_title_data = array();
			$thread_title_data['thread'] = $thread;
			$thread_title_data['category'] = $temp->category;
			$thread_title_data['p_category'] = $temp->p_category;
			$thread_title_data['tags'] = $thread_tags;
			$temp->content .= $this->ci->load->view('thread_title', $thread_title_data, true);

			$comment_form_data = array();
			$comment_form_data['thread'] = $thread;
			$comment_form_data['s_user'] = $temp->s_user;
			$temp->content .= $this->ci->load->view('comment_form', $comment_form_data, true);

			$comment_entry_data = array();
			$comment_entry_data['comments'] = empty($comments) ? array() : $comments;
			$comment_entry_data['empty_display'] = true;
			$comment_entry_data['disp_thread'] = false;
			$comment_entry_data['before_url'] = $before_url;
			$comment_entry_data['after_url'] = $after_url;
			$comment_entry_data['after_id'] = $after_id;
			$comment_entry_data['use_push_state'] = false;
			$comment_entry_data['adv'] = $this->ci->lib_base->get_adv('entry');
			$temp->content .= $this->ci->load->view('comment_entry', $comment_entry_data, true);

			$temp->content .= '<div class="fixed-comment-count"><i class="fa fa-commenting" aria-hidden="true"></i><var id="current-comment-count">' . $thread->t_comment_count . '</var>/<var class="max-count">' . THREAD_COMMENT_MAX . '</var></div>';

		// 削除されたスレッド
		} else {
			$this->ci->output->set_status_header('404');
			$temp->head_params['nofollow'] = true;

			$temp->directories[] = array('dir' => '', 'title' => '<i class="fa fa-home" aria-hidden="true"></i>ホーム');
			$temp->directories[] = array('dir' => '/404', 'title' => '404 Not Found.');
			$temp->dir_title = '削除されたページ';

			$user_title_data = array();
			$user_title_data['method'] = 'default';
			$user_title_data['user'] = $thread;
			$user_title_data['disp_current_dir'] = true;
			$user_title_data['record_count'] = 1;
			$temp->content .= $this->ci->load->view('user_title', $user_title_data, true);

			$thread_title_data = array();
			$thread_title_data['thread'] = $thread;
			$thread_title_data['category'] = $temp->category;
			$thread_title_data['p_category'] = $temp->p_category;
			$thread_title_data['tags'] = $thread_tags;
			$temp->content .= $this->ci->load->view('thread_title', $thread_title_data, true);

			$msg = '';
			switch ($thread->t_privated) {
				case 1:
					$msg = 'このスレッドは、管理者が削除したため閲覧できません。';
					break;

				case 2:
					$msg = 'このスレッドは、スレ主が削除したため閲覧できません。';
					break;

				default:
					$msg = 'このスレッドは削除されたため閲覧できません。';
					break;
			}
			$msg .= '';
			$site_error_data = array();
			$site_error_data['message'] = $msg;
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
		// スレッドを取得
		$thread = $this->ci->this_model->getThread($this->q['thread_id'], $s_user_id);
		$thread_url = '';
		$comments = array();
		$base_id = null;
		$first_id = null;
		// 作成済みスレッドの場合
		if (!empty($thread)) {
			$thread_url = '/t/' . $this->q['thread_id'];
			// 削除済みでない場合
			if ($thread->t_privated == 0) {
				// コメント一覧を取得
				$first_id = $thread->t_first_comment_id;
				// 範囲チェック
				if (!empty($this->q['base'])) {
					$base_id = ($this->q['base'] < $thread->t_first_comment_id) ? $thread->t_first_comment_id : $this->q['base'];
					$base_id = ($this->q['base'] > $thread->t_last_comment_id) ? $thread->t_last_comment_id : $this->q['base'];
				} else {
					$base_id = $thread->t_last_comment_id + 1;
					$this->q['td'] = 'before';
				}
				if (!empty($thread->t_comment_count)) {
					$comments = $this->ci->this_model->getComments($this->q['thread_id'], $base_id, $this->q['td'], $s_user_id);
				}
			}
		} else {
			return false;
		}
		// afterの場合は順番を逆にする（新しい順に）
		if ($this->q['td'] == 'after') {
			$comments = array_reverse($comments);
		}
		$after_url = '';
		$before_url = '';
		$after_id = null;
		if (!empty($comments)) {
			switch ($this->q['td']) {
				case 'after':
					if ($thread->t_filled == 0 || $thread->t_last_comment_id > $comments[0]->comment_id) {
						$after_url = $thread_url . '/after/' . $comments[0]->comment_id;
						$after_id = $comments[0]->comment_id;
					}
					break;

				case 'before':
					if ($first_id < $comments[count($comments) - 1]->comment_id) {
						$before_url = $thread_url . '/before/' . $comments[count($comments) - 1]->comment_id;
					}
					break;
			}
		}
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		$content = '';
		if (empty($comments)) {
			$content .= '<div id="ajax-error" data-count="' . $thread->t_comment_count . '" data-filled="' . $thread->t_filled . '">' . "\n";
			$content .= '</div>' . "\n";
			echo $content;
		} else {
			$comment_entry_data = array();
			$comment_entry_data['comments'] = $comments;
			$comment_entry_data['disp_thread'] = false;
			$comment_entry_data['before_url'] = $before_url;
			$comment_entry_data['after_url'] = $after_url;
			$comment_entry_data['after_id'] = $after_id;
			$comment_entry_data['adv'] = $this->ci->lib_base->get_adv('entry');
			$content = '<div id="ajax-successful" data-count="' . $thread->t_comment_count . '" data-filled="' . $thread->t_filled . '">' . "\n";
			$content .= $this->ci->load->view('comment_entry', $comment_entry_data, true);
			$content .= '</div>' . "\n";
			echo $content;
		}
		return true;
	}
}
