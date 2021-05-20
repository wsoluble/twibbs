<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Res_report extends CI_Controller {
	/**
	 * レススパム報告
	 * @param  [type] $comment_id [description]
	 * @return [type]             [description]
	 */
	public function get($comment_id) {

		//-------------------------------------------------------------------------
		// ロード
		//-------------------------------------------------------------------------

		$this->load->library('session');
		$this->load->model('www/report_model', 'this_model');
		$this->load->library('lib_base');

		//-------------------------------------------------------------------------
		// リダイレクト
		//-------------------------------------------------------------------------

		if (empty($comment_id) || !preg_match('/^[0-9]+$/', $comment_id)) {
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
		$temp->head_params = array('c_name' => 'report', 'title' => 'レスのスパム報告', 'nofollow' => true);
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
			$posted = $this->this_model->postedReportComment($this->session->user_id, $comment_id);
		}
		// レスを取得
		$comment = $this->this_model->getComment($comment_id, $this->session->user_id);
		if (empty($comment) || $comment->c_privated != 0) {
			redirect('404', 'location', 303);
			exit();
		}
		// スレッドを取得
		$thread = $this->this_model->getThread($comment->c_thread_id, $this->session->user_id);
		// 報告の種類
		$report_types = $this->this_model->getCommentReportTypes();

		// 報告一覧を取得
		$reports = array();
		$report_title = 'このレスをスパム報告する';
		if (!empty($comment->c_report_count)) {
			if ($this->session->twitter_primary_id == ADMIN_TWITTER_PRIMARY_ID || $thread->t_user_id == $this->session->user_id || $comment->c_user_id == $this->session->user_id) {
				$reports = $this->this_model->getCommentReports($comment_id, $comment->c_first_report_id, $comment->c_last_report_id);
				if (!empty($reports)) {
					$report_count = count($reports);
					$report_title = 'スパム報告（' . $report_count . '）';
				}
			} else {
				if ($posted == true) {
					$reports = $this->this_model->getCommentReport($this->session->user_id, $comment_id);
					$report_title = 'あなたのスパム報告';
				}
			}
		}

		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------

		$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
		$temp->directories[] = array('dir' => 'u/' . $comment->u_twitter_id, 'title' => '@' . $comment->u_twitter_id);
		$temp->directories[] = array('dir' => 'post/spmt/' . $comment_id, 'title' => 'レスをスパム報告 #' . $comment_id);
		$temp->dir_title = 'レスの問題を報告';

		$user_title_data = array();
		$user_title_data['method'] = 'default';
		$user_title_data['user'] = $comment;
		$user_title_data['disp_current_dir'] = true;
		$temp->content .= $this->load->view('user_title', $user_title_data, true);

		$comment_entry_data = array();
		$comment_entry_data['thread'] = $thread;
		$comment_entry_data['s_user'] = $temp->s_user;
		$comment_entry_data['disp_num'] = false;
		$comment_entry_data['disp_thread'] = true;
		$comment_entry_data['comments'] = array($comment);
		$temp->content .= $this->load->view('comment_entry', $comment_entry_data, true);

		$report_form = '';
		if ($posted == false) {
			$report_form_data = array();
			$report_form_data['method'] = 'res';
			$report_form_data['target_id'] = $comment_id;
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
