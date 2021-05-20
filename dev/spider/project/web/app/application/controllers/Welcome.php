<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Welcome extends CI_Controller {
	/**
	 * トップページ
	 * @return [type] [description]
	 */
	public function index() {
		//-------------------------------------------------------------------------
		// ロード
		//-------------------------------------------------------------------------
		$this->load->library('session');
		$this->load->library('lib_base');
		$this->load->model('www/base_model', 'this_model');
		//-------------------------------------------------------------------------
		// template変数
		//-------------------------------------------------------------------------
		$temp = new stdClass;
		$temp->content = '';
		$temp->s_user = null;
		$temp->head_params = array('c_name' => 'top');
		$temp->categories = null;
		$temp->category = null;
		$temp->p_category = null;
		$temp->dir_title = '';
		$temp->directories = array();
		//-------------------------------------------------------------------------
		// Model
		//-------------------------------------------------------------------------
		if (!empty($_SESSION['user_id'])) {
			$temp->s_user = $this->this_model->getUser($_SESSION['user_id']);
		}
		$temp->categories = $this->this_model->getAllCategories();
		// 最新のエントリ
		$site = $this->this_model->getSite();
		$records = null;
		if (!empty($site->s_thread_count)) {
			$records = $this->this_model->getThreads(intval($site->s_thread_count + 1), 'before', $this->session->user_id);
		}
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
		$temp->dir_title = 'ホーム';

		$welcome_data = array();
		$welcome_data['notices'] = $this->this_model->getSiteInfomations();
		$temp->content .= $this->load->view('welcome', $welcome_data, true);

		$thread_entry_title_data = array();
		$thread_entry_title_data['site'] = $site;
		$thread_entry_title_data['p_category'] = $temp->p_category;
		$thread_entry_title_data['category'] = $temp->category;
		$temp->content .= $this->load->view('thread_entry_title', $thread_entry_title_data, true);

		$thread_entry_data = array();
		$thread_entry_data['threads'] = $records;
		$thread_entry_data['adv'] = $this->lib_base->get_adv('entry');
		$temp->content .= $this->load->view('thread_entry', $thread_entry_data, true);

		$temp->content .= '<div class="more-entry"><a href="/entry"><i class="fa fa-angle-double-down" aria-hidden="true"></i>もっとスレッドを見る</a></div>';
		//-------------------------------------------------------------------------
		// 描画
		//-------------------------------------------------------------------------
		$this->lib_base->output_template($temp);
	}
}
