<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Post extends CI_Controller {
	/**
	 * スレッド投稿
	 */
	public function thread($admin_thread_id) {
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
		if (!empty($admin_thread_id) && (!preg_match('/^[0-9]+$/', $admin_thread_id))) {
			$this->lib_base->output_404();
		}
		//-------------------------------------------------------------------------
		// template変数
		//-------------------------------------------------------------------------

		$temp = new stdClass;
		$temp->content = '';
		$temp->s_user = null;
		$temp->head_params = array('c_name' => 'admin_post', 'title' => 'admin スレッドを編集', 'nofollow' => true);
		$temp->categories = null;
		$temp->category = null;
		$temp->p_category = null;
		$temp->dir_title = '';
		$temp->directories = array();

		//-------------------------------------------------------------------------
		// Input
		//-------------------------------------------------------------------------

		$admin_thread = null;
		$admin_comments = null;
		$admin_users = $this->this_model->getAdminUsers();

		if (!empty($admin_thread_id)) {
			$admin_thread = $this->this_model->getAdminThread($admin_thread_id);
			if (empty($admin_thread)) {
				echo '<p>スレッドを取得できませんでした。</p>';
				exit();
			}
			$admin_comments = $this->this_model->getAdminComments($admin_thread_id);
		}

		$input_thread = new stdClass;
		$input_thread->user_id = null;
		$input_thread->title = '';
		$input_thread->body = '';
		$input_thread->category_id = null;
		$input_thread->tags = array();
		$input_thread->status = 0;
		$input_thread->datetime = date('Y-m-d H:i:s', time() + 3600);
		$input_thread->admin_thread_id = null;
		// 更新の場合
		if (!empty($admin_thread)) {
			$input_thread->user_id = $admin_thread->at_user_id;
			$input_thread->title = $admin_thread->at_title;
			$input_thread->body = $admin_thread->at_body;
			$input_thread->category_id = $admin_thread->at_category;
			$input_thread->tags = explode(' ', $admin_thread->at_tag);
			$input_thread->status = $admin_thread->at_status;
			$input_thread->datetime = $admin_thread->at_datetime;
			$input_thread->admin_thread_id = $admin_thread->admin_thread_id;
		}

		$input_comment = new stdClass;
		$input_comment->ac_admin_thread_id = $input_thread->admin_thread_id;
		$input_comment->user_id = null;
		$input_comment->body = '';
		$input_comment->datetime = '';
		$input_comment->ac_rel_second = 600;

		//-------------------------------------------------------------------------
		// Model
		//-------------------------------------------------------------------------

		if (!empty($_SESSION['user_id'])) {
			$temp->s_user = $this->this_model->getUser($_SESSION['user_id']);
		}
		$temp->categories = $this->this_model->getAllCategories();

		/**
		 * POST
		 */
		$this->load->library('lib_valid', array('user' => $admin_thread));
		$err_msgs = array();
		$submit = $this->input->post('admin_submit');
		// -----------------------------------------------------
		// スレッド投稿
		// -----------------------------------------------------
		if ($submit == 'thread_post') {
			$input_thread->user_id = $this->input->post('user');
			if (empty($input_thread->user_id)) {
				$err_msgs[] = 'ユーザーを指定してください';
			}
			$input_thread->title = $this->lib_valid->valid_title($this->input->post('title'), $err_msgs);
			$input_thread->body = $this->lib_valid->valid_body($this->input->post('body'), $err_msgs);
			$input_thread->category_id = $this->lib_valid->valid_category($this->input->post('category'), $err_msgs);
			$input_thread->tags = $this->lib_valid->valid_tags($this->input->post('tags'), $err_msgs);
			$input_thread->datetime = $this->input->post('date');
			if ($input_thread->datetime !== date("Y-m-d H:i:s", strtotime($input_thread->datetime))) {
				$err_msgs[] = '日付の形式が不正です';
			}
			// var_dump($input_thread);
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				$i_thread_id = $this->this_model->registerAdminThread($input_thread);
				// リダイレクト
				redirect('/admin/post/thread/' . $i_thread_id, 'location', 303);
				exit();
			}
		}
		// -----------------------------------------------------
		// スレッド更新
		// -----------------------------------------------------
		if ($submit == 'thread_update') {
			$input_thread->user_id = $this->input->post('user');
			if (empty($input_thread->user_id)) {
				$err_msgs[] = 'ユーザーを指定してください';
			}
			$input_thread->title = $this->lib_valid->valid_title($this->input->post('title'), $err_msgs);
			$input_thread->body = $this->lib_valid->valid_body($this->input->post('body'), $err_msgs);
			$input_thread->category_id = $this->lib_valid->valid_category($this->input->post('category'), $err_msgs);
			$input_thread->tags = $this->lib_valid->valid_tags($this->input->post('tags'), $err_msgs);
			$input_thread->datetime = $this->input->post('date');
			if ($input_thread->datetime !== date("Y-m-d H:i:s", strtotime($input_thread->datetime))) {
				$err_msgs[] = '日付の形式が不正です';
			}
			$input_thread->status = $this->input->post('status');
			if (!preg_match('/^0|1$/', $input_thread->status)) {
				$err_msgs[] = '状態が不正です';
			}
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				$i_thread_id = $this->this_model->updateAdminThread($input_thread);
				// レスの時間を更新
				foreach ($admin_comments as $comment) {
					$c_dt = date("Y-m-d H:i:s", strtotime($input_thread->datetime) + $comment->ac_rel_second);
					$this->this_model->updateAdminComment_Datetime($comment->admin_comment_id, $c_dt, $comment->ac_rel_second);
				}
				// リダイレクト
				redirect('/admin/post/thread/' . $input_thread->admin_thread_id, 'location', 303);
				exit();
			}
		}
		// -----------------------------------------------------
		// スレッド削除
		// -----------------------------------------------------
		if ($submit == 'thread_delete') {
			$this->this_model->deleteAdminThread($input_thread->admin_thread_id);
			// リダイレクト
			redirect('/admin/threads', 'location', 303);
			exit();
		}
		// -----------------------------------------------------
		// レス追加
		// -----------------------------------------------------
		if ($submit == 'add_comment') {
			$input_comment->user_id = $this->input->post('user');
			if (empty($input_comment->user_id)) {
				$err_msgs[] = 'ユーザーを指定してください';
			}
			$input_comment->body = $this->lib_valid->valid_body($this->input->post('comment_body'), $err_msgs);
			$i_hour = $this->input->post('admin_comment_rel_hour');
			$i_min = $this->input->post('admin_comment_rel_min');
			$i_sec = $this->input->post('admin_comment_rel_sec');
			if (!is_numeric($i_hour) || $i_hour < 0) {
				$err_msgs[] = '時間が不正です';
			}
			if (!is_numeric($i_min) || $i_min < 0 || $i_min >= 60) {
				$err_msgs[] = '分が不正です';
			}
			if (!is_numeric($i_sec) || $i_sec < 0 || $i_sec >= 60) {
				$err_msgs[] = '秒が不正です';
			}
			$input_comment->ac_rel_second = $i_hour * 3600;
			$input_comment->ac_rel_second += $i_min * 60;
			$input_comment->ac_rel_second += $i_sec;
			$input_comment->datetime = date('Y-m-d H:i:s', strtotime($input_thread->datetime) + $input_comment->ac_rel_second);
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				$i_comment_id = $this->this_model->registerAdminComment($input_comment);
				// リダイレクト
				redirect('/admin/post/thread/' . $input_comment->ac_admin_thread_id, 'location', 303);
				exit();
			}
		}
		// -----------------------------------------------------
		// レス更新
		// -----------------------------------------------------
		if ($submit == 'update_comment') {
			$input_comment->admin_comment_id = $this->input->post('admin_comment_id');
			if (!is_numeric($input_comment->admin_comment_id)) {
				$err_msgs[] = 'レスIDが不正です。';
			}
			$i_hour = $this->input->post('admin_comment_rel_hour');
			$i_min = $this->input->post('admin_comment_rel_min');
			$i_sec = $this->input->post('admin_comment_rel_sec');
			if (!is_numeric($i_hour) || $i_hour < 0) {
				$err_msgs[] = '時間が不正です';
			}
			if (!is_numeric($i_min) || $i_min < 0 || $i_min >= 60) {
				$err_msgs[] = '分が不正です';
			}
			if (!is_numeric($i_sec) || $i_sec < 0 || $i_sec >= 60) {
				$err_msgs[] = '秒が不正です';
			}
			$input_comment->ac_rel_second = $i_hour * 3600;
			$input_comment->ac_rel_second += $i_min * 60;
			$input_comment->ac_rel_second += $i_sec;
			$input_comment->datetime = date('Y-m-d H:i:s', strtotime($input_thread->datetime) + $input_comment->ac_rel_second);
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				$this->this_model->updateAdminComment_Datetime($input_comment->admin_comment_id, $input_comment->datetime, $input_comment->ac_rel_second);
				// リダイレクト
				redirect('/admin/post/thread/' . $input_comment->ac_admin_thread_id, 'location', 303);
				exit();
			}
		}
		// -----------------------------------------------------
		// レス削除
		// -----------------------------------------------------
		if ($submit == 'delete_comment') {
			$input_comment->admin_comment_id = $this->input->post('admin_comment_id');
			if (!is_numeric($input_comment->admin_comment_id)) {
				$err_msgs[] = 'レスIDが不正です。';
			}
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				$this->this_model->deleteAdminComment($input_comment->admin_comment_id);
				// リダイレクト
				redirect('/admin/post/thread/' . $input_comment->ac_admin_thread_id, 'location', 303);
				exit();
			}
		}

		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------

		$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
		$temp->directories[] = array('dir' => 'u/' . $temp->s_user->u_twitter_id, 'title' => '@' . $temp->s_user->u_twitter_id);
		$temp->directories[] = array('dir' => 'admin/threads', 'title' => '管理スレッド一覧');
		$temp->directories[] = array('dir' => 'admin/post/thread', 'title' => '管理新規スレッド');
		$temp->dir_title = '管理新規スレッド';

		$user_title_data = array();
		$user_title_data['method'] = 'default';
		$user_title_data['user'] = $temp->s_user;
		$user_title_data['disp_current_dir'] = true;
		$temp->content .= $this->load->view('user_title', $user_title_data, true);

		$edit_thread_data = array();
		$edit_thread_data['admin_users'] = $admin_users;
		$edit_thread_data['input_thread'] = $input_thread;
		$edit_thread_data['input_comment'] = $input_comment;
		$edit_thread_data['admin_thread'] = $admin_thread;
		$edit_thread_data['admin_comments'] = $admin_comments;
		$edit_thread_data['categories'] = $temp->categories;
		$edit_thread_data['err_msgs'] = $err_msgs;
		$temp->content .= $this->load->view('admin_edit_thread', $edit_thread_data, true);

		//-------------------------------------------------------------------------
		// 描画
		//-------------------------------------------------------------------------

		$this->lib_base->output_template($temp);

	}
}
