<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Tag extends CI_Controller {
	/**
	 * [get description]
	 * @param  [type] $word [description]
	 * @return [type]       [description]
	 */
	public function get($word, $td, $base) {
		//-------------------------------------------------------------------------
		// ロード
		//-------------------------------------------------------------------------
		$this->load->library('session');
		$this->load->library('lib_base');
		//-------------------------------------------------------------------------
		// Input
		//-------------------------------------------------------------------------
		if (empty($word)) {
			$this->lib_base->output_404();
		}
		if (!empty($td) && !preg_match('/^(before|after)$/', $td)) {
			$this->lib_base->output_404();
		}
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
		$this->load->model('www/tag_model', 'this_model');
		// クエリ
		$queries = array();
		$queries['word'] = urldecode($word);
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
		$temp->head_params = array('c_name' => 'tag');
		$temp->categories = null;
		$temp->category = null;
		$temp->p_category = null;
		$temp->dir_title = '';
		$temp->directories = array();
		//-------------------------------------------------------------------------
		// Model
		//-------------------------------------------------------------------------
		if (!empty($_SESSION['user_id'])) {
			$temp->s_user = $this->ci->this_model->getUser($_SESSION['user_id']);
		}
		$temp->categories = $this->ci->this_model->getAllCategories();
		// タグを取得
		$tag = $this->ci->this_model->getTagFromWord($this->q['word']);
		if (empty($tag)) {
			$this->ci->output->set_status_header('404');
		}
		$tag_url = '';
		// スレッド一覧を取得
		$base_id = null;
		$records = null;
		$first_id = null;
		if (!empty($tag)) {
			$tag_url = '/tag/' . urlencode($tag->tg_word);
			$first_id = $tag->tg_first_thread_id;
			if (!empty($this->q['td'])) {
				$temp->head_params['canonical'] = $tag_url;
			}
			// 範囲チェック
			if (!empty($this->q['base'])) {
				$base_id = ($this->q['base'] < $tag->tg_first_thread_id) ? $tag->tg_first_thread_id : $this->q['base'];
				$base_id = ($this->q['base'] > $tag->tg_last_thread_id) ? $tag->tg_last_thread_id : $this->q['base'];
				if ($this->q['base'] >= $tag->tg_last_thread_id && $this->q['td'] == 'after') {
					header('Location: ' . $tag_url);
					exit();
				}
			} else {
				$base_id = $tag->tg_last_thread_id + 1;
				$this->q['td'] = 'before';
			}
			if (!empty($tag->tg_thread_count)) {
				$records = $this->ci->this_model->getThreadsWithTag($tag->tag_id, $base_id, $this->q['td'], $this->ci->session->user_id);
			}
		}
		// afterの場合は順番を逆にする（新しい順に）
		if ($this->q['td'] == 'after') {
			$records = array_reverse($records);
		}
		$after_url = '';
		$before_url = '';
		if (!empty($records)) {
			$after_url = $tag_url . '/after/' . $records[0]->thread_id;
			if ($first_id < $records[count($records) - 1]->thread_id) {
				$before_url = $tag_url . '/before/' . $records[count($records) - 1]->thread_id;
			}
		}
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		$word = htmlspecialchars($this->q['word'], ENT_QUOTES);
		$url_word = urlencode($word);
		$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
		$temp->directories[] = array('dir' => '/tag/' . $url_word, 'title' => $word);
		$temp->dir_title = '<i class="fa fa-hashtag" aria-hidden="true"></i>タグ検索';
		$temp->head_params['title'] = $word;

		$temp->head_params['og'] = array();
		$temp->head_params['og']['type'] = 'article';
		$temp->head_params['og']['title'] = $word;
		$temp->head_params['og']['url'] = $tag_url;
		$temp->head_params['og']['description'] = '「' . $word . '」タグのスレッドを検索';
		$temp->head_params['twitter'] = array();
		$temp->head_params['twitter']['card'] = 'summary';

		$tag_title_data = array();
		$tag_title_data['tag'] = $this->q['word'];
		$tag_title_data['thread_count'] = empty($tag) ? 0 : $tag->tg_thread_count;
		$temp->content .= $this->ci->load->view('tag_title', $tag_title_data, true);

		$thread_entry_data = array();
		$thread_entry_data['threads'] = $records;
		$thread_entry_data['before_url'] = $before_url;
		$thread_entry_data['after_url'] = $after_url;
		$thread_entry_data['adv'] = $this->ci->lib_base->get_adv('entry');
		$temp->content .= $this->ci->load->view('thread_entry', $thread_entry_data, true);
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
		// タグを取得
		$tag = $this->ci->this_model->getTagFromWord($this->q['word']);
		if (empty($tag)) {
			return false;
		}
		$tag_url = '';
		// スレッド一覧を取得
		$base_id = null;
		$records = null;
		$first_id = null;
		if (!empty($tag)) {
			$tag_url = '/tag/' . urlencode($tag->tg_word);
			$first_id = $tag->tg_first_thread_id;
			// 範囲チェック
			if (!empty($this->q['base'])) {
				$base_id = ($this->q['base'] < $tag->tg_first_thread_id) ? $tag->tg_first_thread_id : $this->q['base'];
				$base_id = ($this->q['base'] > $tag->tg_last_thread_id) ? $tag->tg_last_thread_id : $this->q['base'];
			} else {
				$base_id = $tag->tg_last_thread_id + 1;
				$this->q['td'] = 'before';
			}
			if (!empty($tag->tg_thread_count)) {
				$records = $this->ci->this_model->getThreadsWithTag($tag->tag_id, $base_id, $this->q['td'], $this->ci->session->user_id);
			}
		}
		// afterの場合は順番を逆にする（新しい順に）
		if ($this->q['td'] == 'after') {
			$records = array_reverse($records);
		}
		$after_url = '';
		$before_url = '';
		if (!empty($records)) {
			switch ($this->q['td']) {
				case 'after':
					$after_url = $tag_url .'/after/' . $records[0]->thread_id;
					break;

				case 'before':
					if ($first_id < $records[count($records) - 1]->thread_id) {
						$before_url = $tag_url . '/before/' . $records[count($records) - 1]->thread_id;
					}
					break;
			}
		}
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		if (empty($records)) {
			$content .= '<div id="ajax-error">' . "\n";
			$content .= '</div>' . "\n";
			echo $content;
		} else {
			$thread_entry_data = array();
			$thread_entry_data['threads'] = $records;
			$thread_entry_data['before_url'] = $before_url;
			$thread_entry_data['after_url'] = $after_url;
			$thread_entry_data['adv'] = $this->ci->lib_base->get_adv('entry');
			$content = '<div id="ajax-successful">' . "\n";
			$content .= $this->ci->load->view('thread_entry', $thread_entry_data, true);
			$content .= '</div>' . "\n";
			echo $content;
		}
		return true;
	}
}
