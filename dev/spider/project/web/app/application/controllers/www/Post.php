<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Post extends CI_Controller {
	/**
	 * スレッド投稿
	 */
	public function thread() {

		//-------------------------------------------------------------------------
		// ロード
		//-------------------------------------------------------------------------

		$this->load->library('session');

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
		$temp->head_params = array('c_name' => 'post', 'title' => '新しいスレッド', 'nofollow' => true);
		$temp->categories = null;
		$temp->category = null;
		$temp->p_category = null;
		$temp->dir_title = '';
		$temp->directories = array();

		//-------------------------------------------------------------------------
		// Input
		//-------------------------------------------------------------------------

		$input = new stdClass;
		$input->user_id = $_SESSION['user_id'];
		$input->title = '';
		$input->body = '';
		$input->category_id = null;
		$input->tags = array();
		$input->ip = $this->input->ip_address();

		//-------------------------------------------------------------------------
		// Model
		//-------------------------------------------------------------------------
		$this->load->library('lib_base');
		$this->load->model('www/post_model', 'this_model');

		if (!empty($_SESSION['user_id'])) {
			$temp->s_user = $this->this_model->getUser($_SESSION['user_id']);
		}
		$temp->categories = $this->this_model->getAllCategories();

		/**
		 * POST
		 */
		$this->load->library('lib_valid', array('user' => $temp->s_user));
		$err_msgs = array();
		$submit = $this->input->post('submit');
		$confirm = $this->input->post('confirm');
		if ($submit == 'post') {
			if (empty($confirm)) {
				$err_msgs[] = '利用規約とルールを読み、これらを遵守することに同意してください。';
			}
			// IPチェック
			if ($this->this_model->isNgIp($this->input->ip_address())) {
				$err_msgs[] = 'このIPアドレスはスレッドを作成できません';
			}
			// 権限チェック
			if (!empty($temp->s_user->u_privilege_thread)) {
				$err_msgs[] = 'スレッドを作成できませんでした';
			}
			// 前回の投稿から時間が経過しているか
			$check_interval = $this->this_model->checkIntervalThread($temp->s_user->u_last_thread_id);
			if (empty($check_interval)) {
				$err_msgs[] = '前回のスレッド作成から' . intval(POST_THREAD_INTERVAL / 60) . '分経過してから投稿してください';
			}
			// 入力取得
			$input->title = $this->lib_valid->valid_title($this->input->post('title'), $err_msgs);
			$input->body = $this->lib_valid->valid_body($this->input->post('body'), $err_msgs);
			$input->category_id = $this->lib_valid->valid_category($this->input->post('category'), $err_msgs);
			$input->tags = $this->lib_valid->valid_tags($this->input->post('tags'), $err_msgs);
			$input->ip = $this->input->ip_address();
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				$i_thread_id = $this->this_model->registerThread($input);
				if (!empty($i_thread_id)) {
					$tag_num = 1;
					foreach ($input->tags as $tag) {
						$i_tag_id = $this->this_model->registerTag($tag);
						$this->this_model->registerThreadTag($i_thread_id, $tag_num, $i_tag_id);
						$tag_num++;
					}
				}
				// リダイレクト
				redirect('/t/' . $i_thread_id, 'location', 303);
				exit();
			}
		/**
		 * GET
		 */
		}

		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------

		$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
		$temp->directories[] = array('dir' => 'u/' . $temp->s_user->u_twitter_id, 'title' => '@' . $temp->s_user->u_twitter_id);
		$temp->directories[] = array('dir' => 'post/thread', 'title' => '新規スレッド');
		$temp->dir_title = '新規スレッド';

		$user_title_data = array();
		$user_title_data['method'] = 'default';
		$user_title_data['user'] = $temp->s_user;
		$user_title_data['disp_current_dir'] = true;
		$temp->content .= $this->load->view('user_title', $user_title_data, true);

		$edit_thread_data = array();
		$edit_thread_data['user'] = $temp->s_user;
		$edit_thread_data['input'] = $input;
		$edit_thread_data['categories'] = $temp->categories;
		$edit_thread_data['err_msgs'] = $err_msgs;
		$temp->content .= $this->load->view('edit_thread', $edit_thread_data, true);

		//-------------------------------------------------------------------------
		// 描画
		//-------------------------------------------------------------------------

		$this->lib_base->output_template($temp);

	}
}
