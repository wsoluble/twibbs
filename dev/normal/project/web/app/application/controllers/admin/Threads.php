<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Threads extends CI_Controller {
	/**
	 * スレッド一覧を取得
	 * @return [type] [description]
	 */
	public function get() {
		//-------------------------------------------------------------------------
		// ロード
		//-------------------------------------------------------------------------
		$this->load->library('lib_base');
		$this->load->library('lib_admin');
		$this->load->helper('url');
		$this->load->model('admin/post_model', 'this_model');
		//-------------------------------------------------------------------------
		// リダイレクト
		//-------------------------------------------------------------------------
		if (empty($_SESSION['user_id'])) {
			redirect('/', 'location', 303);
			exit();
		}
		//-------------------------------------------------------------------------
		// template変数
		//-------------------------------------------------------------------------
		$temp = new stdClass;
		$temp->content = '';
		$temp->s_user = null;
		$temp->head_params = array('c_name' => 'admin_post', 'title' => 'admin スレッド一覧', 'nofollow' => true);
		$temp->categories = null;
		$temp->category = null;
		$temp->p_category = null;
		$temp->dir_title = '';
		$temp->directories = array();
		//-------------------------------------------------------------------------
		// Input
		//-------------------------------------------------------------------------
		// ページ番号
		$index = $this->input->get('i');
		if (empty($index)) {
			$index = 1;
		}
		if (!preg_match('/^[0-9]+$/', $index)) {
			redirect('/admin/threads', 'location', 303);
			exit();
		}
		$index = intval($index);
		// 状態
		$status = $this->input->get('s');
		if (isset($status) && !preg_match('/^0|1|2$/', $status)) {
			redirect('/admin/threads', 'location', 303);
			exit();
		}
		$status = !isset($status) ? null : intval($status);
		//-------------------------------------------------------------------------
		// Model
		//-------------------------------------------------------------------------
		if (!empty($_SESSION['user_id'])) {
			$temp->s_user = $this->this_model->getUser($_SESSION['user_id']);
		}
		$temp->categories = $this->this_model->getAllCategories();
		// レコードを取得
		$record_max = $this->this_model->getAdminThreadsCount($status);
		$records = $this->this_model->getAdminThreads($index, $status);
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
		$temp->directories[] = array('dir' => 'u/' . $temp->s_user->u_twitter_id, 'title' => '@' . $temp->s_user->u_twitter_id);
		$temp->directories[] = array('dir' => 'admin/threads', 'title' => '管理スレッド一覧');
		$temp->dir_title = '管理スレッド一覧';

		// ヘッダ
		$admin_threads_header_data = array();
		$admin_threads_header_data['status'] = $status;
		$admin_threads_header_data['record_max'] = $record_max;
		$admin_threads_header_data['err_msgs'] = null;
		$temp->content .= $this->load->view('admin_threads_header', $admin_threads_header_data, true);

		$pagination_description_data = array();
		$pagination_description_data['page_index'] = intval($index);
		$pagination_description_data['record_max'] = $record_max;
		$pagination_description_data['record_count'] = count($records);
		$pagination_description_data['content_max'] = THREAD_CONTENT_MAX;
		$temp->content .= $this->load->view('pagination_description', $pagination_description_data, true);

		$pagination_data = array();
		$pagination_data['page_index'] = intval($index);
		$pagination_data['record_max'] = $record_max;
		$pagination_data['content_max'] = THREAD_CONTENT_MAX;
		$pagination_data['segments'] = PAGINATION_SEGMENTS;
		$pagination_data['jump_max'] = true;
		$pagination_data['directory'] = 'admin/threads';
		$pagination_data['query'] = empty($status) ? '' : '?s=' . $status;
		$pagination = $this->load->view('pagination', $pagination_data, true);
		$temp->content .= $pagination;

		// スレッドエントリ
		$admin_threads_data = array();
		$admin_threads_data['admin_threads'] = $records;
		$admin_threads_data['admin_threads_count'] = $record_max;
		$temp->content .= $this->load->view('admin_threads', $admin_threads_data, true);

		$temp->content .= $pagination;

		//-------------------------------------------------------------------------
		// 描画
		//-------------------------------------------------------------------------

		$this->lib_base->output_template($temp);

	}
}
