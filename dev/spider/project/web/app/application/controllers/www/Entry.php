<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Entry extends CI_Controller {
	/**
	 * スレッドエントリ一覧
	 * @param  [type] $url_name [description]
	 */
	public function get($url_name, $td, $base) {
		// var_dump($this->input->get(NULL, FALSE));
		// exit();
		//-------------------------------------------------------------------------
		// ロード
		//-------------------------------------------------------------------------
		$this->load->library('session');
		$this->load->library('lib_base');
		$this->load->model('www/entry_model', 'this_model');
		//-------------------------------------------------------------------------
		// 入力チェック
		//-------------------------------------------------------------------------
		//$url_name = $this->input->get('cat');
		if (!empty($url_name) && !preg_match('/^[a-zA-Z0-9_]+$/', $url_name)) {
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
		$queries['url_name'] = $url_name;
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
		$temp->c_name = 'entry';
		$temp->head_params = array('c_name' => 'entry');
		$temp->categories = null;
		$temp->category = null;
		$temp->p_category = null;
		$temp->dir_title = '';
		$temp->directories = array();
		//-------------------------------------------------------------------------
		// Model
		//-------------------------------------------------------------------------
		$site = $this->ci->this_model->getSite();
		if (!empty($_SESSION['user_id'])) {
			$temp->s_user = $this->ci->this_model->getUser($_SESSION['user_id']);
		}
		$temp->categories = $this->ci->this_model->getAllCategories();
		if (!empty($this->q['url_name'])) {
			$temp->category = $this->ci->this_model->getCategoryFromUrlName($this->q['url_name']);
			if (empty($temp->category)) {
				$this->ci->lib_base->output_404();
			}
			if (!empty($temp->category->cat_parent)) {
				$temp->p_category = $this->ci->this_model->getCategory($temp->category->cat_parent);
			}
		}
		// スレッド一覧を取得
		$base_id = null;
		$records = null;
		$first_id = null;
		$entry_url = null;
		if (empty($temp->category)) {
			$temp->head_params['title'] = 'エントリ';
			$entry_url = '/entry';
			$first_id = 1;
			// 範囲チェック
			if (!empty($this->q['base'])) {
				$base_id = ($this->q['base'] < 1) ? 1 : $this->q['base'];
				$base_id = ($this->q['base'] > $site->s_thread_count) ? $site->s_thread_count : $this->q['base'];
				if ($this->q['base'] >= $site->s_thread_count && $this->q['td'] == 'after') {
					header('Location: /entry');
					exit();
				}
			}
			// スレッドのレコードが存在する
			if (!empty($site->s_thread_count)) {
				$records = $this->ci->this_model->getThreads($base_id, $this->q['td'], $this->ci->session->user_id);
			}
		} else {
			$temp->head_params['title'] = $temp->category->cat_word;
			$entry_url = '/entry/' . $temp->category->cat_url_name;
			$first_id = $temp->category->cat_first_thread_id;
			// 範囲チェック
			if (!empty($this->q['base'])) {
				$base_id = ($this->q['base'] < $temp->category->cat_first_thread_id) ? $temp->category->cat_first_thread_id : $this->q['base'];
				$base_id = ($this->q['base'] > $temp->category->cat_last_thread_id) ? $temp->category->cat_last_thread_id : $this->q['base'];
				if ($this->q['base'] >= $temp->category->cat_last_thread_id && $this->q['td'] == 'after') {
					header('Location: /entry/' . $temp->category->cat_url_name);
					exit();
				}
			}
			if (!empty($temp->category->cat_thread_count)) {
				$records = $this->ci->this_model->getThreadsWithCategory($base_id, $this->q['td'], $temp->category, $this->ci->session->user_id);
			}
		}
		// afterの場合は順番を逆にする（新しい順に）
		if ($this->q['td'] == 'after') {
			$records = array_reverse($records);
		}
		$after_url = '';
		$before_url = '';
		if (!empty($records)) {
			if (!empty($this->q['td'])) {
				$temp->head_params['canonical'] = $entry_url;
			}
			$after_url = $entry_url . '/after/' . $records[0]->thread_id;
			if ($first_id < $records[count($records) - 1]->thread_id) {
				$before_url = $entry_url . '/before/' . $records[count($records) - 1]->thread_id;
			}
		}
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
		$temp->directories[] = array('dir' => 'entry', 'title' => 'エントリ');
		$temp->dir_title = 'エントリ';
		$url = 'entry';
		if (!empty($temp->p_category)) {
			$url = 'entry/' . $temp->p_category->cat_url_name;
			$temp->directories[] = array('dir' => 'entry/' . $temp->p_category->cat_url_name, 'title' => $temp->p_category->cat_word);
			$temp->dir_title = $temp->p_category->cat_word;
		}
		if (!empty($temp->category)) {
			$url = 'entry/' . $temp->category->cat_url_name;
			$temp->directories[] = array('dir' => 'entry/' . $temp->category->cat_url_name, 'title' => $temp->category->cat_word);
			$temp->dir_title = $temp->category->cat_word;
		}
		$thread_entry_title_data = array();
		$thread_entry_title_data['site'] = $site;
		$thread_entry_title_data['p_category'] = $temp->p_category;
		$thread_entry_title_data['category'] = $temp->category;
		$thread_entry_title_data['adv'] = '';
		$temp->content .= $this->ci->load->view('thread_entry_title', $thread_entry_title_data, true);
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
		$site = $this->ci->this_model->getSite();
		$category = null;
		if (!empty($this->q['url_name'])) {
			$category = $this->ci->this_model->getCategoryFromUrlName($this->q['url_name']);
			if (empty($category)) {
				return false;
			}
		}
		// スレッド一覧を取得
		$base_id = null;
		$records = null;
		$first_id = null;
		if (empty($category)) {
			$first_id = 1;
			// 範囲チェック
			if (!empty($this->q['base'])) {
				$base_id = ($this->q['base'] < 1) ? 1 : $this->q['base'];
				$base_id = ($this->q['base'] > $site->s_thread_count) ? $site->s_thread_count : $this->q['base'];
			} else {
				$base_id = $site->s_thread_count + 1;
				$this->q['td'] = 'before';
			}
			// スレッドのレコードが存在する
			if (!empty($site->s_thread_count)) {
				$records = $this->ci->this_model->getThreads($base_id, $this->q['td'], $this->ci->session->user_id);
			}
		} else {
			$first_id = $category->cat_first_thread_id;
			// 範囲チェック
			if (!empty($this->q['base'])) {
				$base_id = ($this->q['base'] < $category->cat_first_thread_id) ? $category->cat_first_thread_id : $this->q['base'];
				$base_id = ($this->q['base'] > $category->cat_last_thread_id) ? $category->cat_last_thread_id : $this->q['base'];
			} else {
				$base_id = $category->cat_last_thread_id + 1;
				$this->q['td'] = 'before';
			}
			if (!empty($category->cat_thread_count)) {
				$records = $this->ci->this_model->getThreadsWithCategory($base_id, $this->q['td'], $category, $this->ci->session->user_id);
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
					$after_url = (empty($category)) ? '/entry/after/' . $records[0]->thread_id : '/entry/' . $category->cat_url_name .'/after/' . $records[0]->thread_id;
					break;

				case 'before':
					if ($first_id < $records[count($records) - 1]->thread_id) {
						$before_url = (empty($category)) ? '/entry/before/' . $records[count($records) - 1]->thread_id : '/entry/' . $category->cat_url_name .'/before/' . $records[count($records) - 1]->thread_id;
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
