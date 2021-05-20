<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Thread_report extends CI_Controller {
	/**
	 * スレッドスパム報告
	 * @param  [type] $thread_id [description]
	 * @return [type]            [description]
	 */
	public function get($thread_id) {

		//-------------------------------------------------------------------------
		// ロード
		//-------------------------------------------------------------------------

		$this->load->library('session');
		$this->load->model('www/report_model', 'this_model');
		$this->load->library('lib_base');

		//-------------------------------------------------------------------------
		// リダイレクト
		//-------------------------------------------------------------------------

		if (empty($thread_id) || !preg_match('/^[0-9]+$/', $thread_id)) {
			$this->lib_base->output_404();
		}

		if (empty($_SESSION['user_id'])) {
			$this->lib_base->output_404();
		}

		//-------------------------------------------------------------------------
		// template変数
		//-------------------------------------------------------------------------

		$temp = new stdClass;
		$temp->content = '';
		$temp->s_user = null;
		$temp->head_params = array('c_name' => 'report', 'title' => 'スレッドのスパム報告', 'nofollow' => true);
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

		$posted = false;
		if (!empty($_SESSION['user_id'])) {
			$posted = $this->this_model->postedReportThread($this->session->user_id, $thread_id);
		}
		// スレッドを取得
		$thread = $this->this_model->getThread($thread_id, $this->session->user_id);
		if (empty($thread) || $thread->t_privated != 0) {
			redirect('404', 'location', 303);
			exit();
		}
		// カテゴリ
		if (!empty($thread->sub_category_id)) {
			$temp->category = $this->this_model->getCategory($thread->t_sub_category);
		}
		$temp->p_category = $this->this_model->getCategory($thread->t_main_category);
		// タグを取得
		$thread_tags = $this->this_model->getThreadTag($thread_id);
		// 報告の種類
		$report_types = $this->this_model->getThreadReportTypes();

		// 報告一覧を取得
		$reports = array();
		$report_title = 'このスレッドをスパム報告する';
		if (!empty($thread->t_report_count)) {
			if ($this->session->twitter_primary_id == ADMIN_TWITTER_PRIMARY_ID || $thread->t_user_id == $this->session->user_id) {
				$reports = $this->this_model->getThreadReports($thread_id, $thread->t_first_report_id, $thread->t_last_report_id);
				if (!empty($reports)) {
					$report_count = count($reports);
					$report_title = 'スパム報告（' . $report_count . '）';
				}
			} else {
				if ($posted == true) {
					$reports = $this->this_model->getThreadReport($this->session->user_id, $thread_id);
					$report_title = 'あなたのスパム報告';
				}
			}
		}

		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------

		$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
		$temp->directories[] = array('dir' => 'u/' . $thread->u_twitter_id, 'title' => '@' . $thread->u_twitter_id);
		$temp->directories[] = array('dir' => 'report/thread/' . $thread_id, 'title' => 'スレッドをスパム報告 #' . $thread_id);
		$temp->dir_title = 'スレッドの問題を報告';

		$user_title_data = array();
		$user_title_data['method'] = 'default';
		$user_title_data['user'] = $thread;
		$user_title_data['disp_current_dir'] = true;
		$temp->content .= $this->load->view('user_title', $user_title_data, true);

		$thread_title_data = array();
		$thread_title_data['thread'] = $thread;
		$thread_title_data['category'] = $temp->category;
		$thread_title_data['p_category'] = $temp->p_category;
		$thread_title_data['tags'] = $thread_tags;
		$temp->content .= $this->load->view('thread_title', $thread_title_data, true);

		$report_form = '';
		if ($posted == false) {
			$report_form_data = array();
			$report_form_data['method'] = 'thread';
			$report_form_data['target_id'] = $thread_id;
			$report_form_data['s_user'] = $temp->s_user;
			$report_form_data['report_types'] = $report_types;
			$report_form = $this->load->view('report_form', $report_form_data, true);
		}

		$report_entry_data = array();
		$report_entry_data['disp_num'] = true;
		$report_entry_data['reports'] = $reports;
		$report_entry_data['adv'] = $this->lib_base->get_adv('entry');
		$temp->content .= '<div id="comments">' . "\n";
		$temp->content .= '<h3 class="report-title">' . $report_title . '</h3>' . "\n";
		$temp->content .= $report_form;
		$temp->content .= $this->load->view('report_entry', $report_entry_data, true);
		$temp->content .= '</div>' . "\n";

		//-------------------------------------------------------------------------
		// 描画
		//-------------------------------------------------------------------------

		$this->lib_base->output_template($temp);
	}
}
