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
		$s_user_id = empty($_SESSION['user_id']) ? null : $_SESSION['user_id'];
		if (!empty($_SESSION['user_id'])) {
			$temp->s_user = $this->this_model->getUser($_SESSION['user_id']);
		}
		$temp->categories = $this->this_model->getAllCategories();
		// 最新のエントリ
		$site = $this->this_model->getSite();
		$records = null;
		if (!empty($site->s_thread_count)) {
			$records = $this->this_model->getThreads(intval($site->s_thread_count + 1), 'before', $s_user_id);
		}
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		$temp->head_params['description'] = 'ちょっと長い文でお話できるツイッタラー向けのパーソナル掲示板。';
		$temp->head_params['keywords'] = array(SITE_NAME, '掲示板', 'スレッド', 'レス', 'Twitter', 'ツイッタラー');
		$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
		$temp->dir_title = 'ホーム';

		$temp->head_params['og'] = array();
		$temp->head_params['og']['type'] = 'website';
		$temp->head_params['og']['title'] = SITE_NAME;
		$temp->head_params['og']['url'] = base_url();
		$temp->head_params['og']['description'] = 'じぶんのスレッドを立ててしゃべり放題！Twitterを使ってる人なら誰でも参加できる掲示板だよ。荒らしはやめようね。';
		$temp->head_params['og']['image'] = base_url() . 'img/twitter_card_summary.png';
		$temp->head_params['twitter'] = array();
		$temp->head_params['twitter']['card'] = 'summary';
		$temp->head_params['twitter']['image'] = base_url() . 'img/twitter_card_summary.png';

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
