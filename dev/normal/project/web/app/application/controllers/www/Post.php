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

		$this->load->library('lib_base');
		$this->load->model('www/post_model', 'this_model');

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
	/**
	 * ゲストのスパム報告
	 * @return [type] [description]
	 */
	public function report() {

		//-------------------------------------------------------------------------
		// ロード
		//-------------------------------------------------------------------------

		$this->load->library('lib_base');
		$this->load->model('www/report_model', 'this_model');

		//-------------------------------------------------------------------------
		// template変数
		//-------------------------------------------------------------------------

		$temp = new stdClass;
		$temp->content = '';
		$temp->s_user = null;
		$temp->head_params = array('c_name' => 'report', 'title' => 'スパム報告（ゲスト）', 'nofollow' => true);
		$temp->categories = null;
		$temp->category = null;
		$temp->p_category = null;
		$temp->dir_title = '';
		$temp->directories = array();

		//-------------------------------------------------------------------------
		// Input
		//-------------------------------------------------------------------------

		$input = new stdClass;
		$input->name = htmlspecialchars($this->input->post('name'), ENT_QUOTES);
		$input->email = htmlspecialchars($this->input->post('email'), ENT_QUOTES);
		$input->thread_id = $this->input->post('thread');
		$input->comment_id = $this->input->post('res');
		$input->report_type = $this->input->post('report-type');
		$input->body = htmlspecialchars($this->input->post('body'), ENT_QUOTES);
		$input->ip = $this->input->ip_address();
		$input->host = '';
		$input->ua = $this->input->user_agent();

		//-------------------------------------------------------------------------
		// Model
		//-------------------------------------------------------------------------

		if (!empty($_SESSION['user_id'])) {
			$temp->s_user = $this->this_model->getUser($_SESSION['user_id']);
		}
		$temp->categories = $this->this_model->getAllCategories();
		$report_types = $this->this_model->getReportTypes();

		$submit = $this->input->post('submit');
		$err_msgs = array();
		$posted = false;
		if ($submit == 'post') {
			// 名前
			if (empty($input->name)) {
				$err_msgs[] = '名前を入力してください。';
			} else {
				if (mb_strlen($input->name) > 100) {
					$err_msgs[] = '名前の文字数が多すぎます';
				}
			}
			// メール
			if (empty($input->email)) {
				$err_msgs[] = 'メールアドレスを入力してください。';
			} else {
				if (!preg_match('/^[^0-9][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*@\[?([\d\w\.-]+)]?$/', $input->email)) {
					$err_msgs[] = 'メールアドレスの形式が正しくありません。';
				}
			}
			// スレッドID
			if (!preg_match('/^[0-9]+$/', $input->thread_id)) {
				$err_msgs[] = 'スレッドIDは半角数字を指定してください。';
			} else {
				$thread = $this->this_model->getThread($input->thread_id);
				if (empty($thread)) {
					$err_msgs[] = '存在しないスレッドが指定されました。';
				} else {
					if ($thread->t_privated != 0) {
						$err_msgs[] = '無効なスレッドIDが指定されました。';
					}
				}
			}
			// レスID
			if (!empty($input->comment_id)) {
				if (!preg_match('/^[0-9]+$/', $input->comment_id)) {
					$err_msgs[] = 'レスIDは半角数字を指定してください。';
				} else {
					$comment = $this->this_model->getComment($input->comment_id);
					if (empty($comment)) {
						$err_msgs[] = '存在しないレスが指定されました。';
					} else {
						if ($comment->c_thread_id != $input->thread_id) {
							$err_msgs[] = 'スレッドに存在しないレスが指定されました。';
						}
						if ($comment->c_privated != 0) {
							$err_msgs[] = '無効なレスIDが指定されました。';
						}
					}
				}
			}
			// 報告の種類
			if (!preg_match('/^[0-9]+$/', $input->report_type)) {
				$err_msgs[] = '報告の種類が不正です。';
			} else {
				$rt_exist = false;
				foreach ($report_types as $rt) {
					if ($input->report_type == $rt->report_type_id) {
						$rt_exist = true;
					}
				}
				if ($rt_exist == false) {
					$err_msgs[] = '存在しない報告の種類が指定されました。';
				}
			}
			// 本文
			if (empty($input->body)) {
				$err_msgs[] = '問題の内容を記述してください。';
			}
			// エラーがない場合はDB登録
			if (empty($err_msgs)) {
				$err_msgs[] = 'DB登録します。';
				// スレッドの報告
				if (empty($input->comment_id)) {
					if ($this->this_model->registerGuestThreadReport($input)) {
						$posted = true;
					} else {
						$err_msgs[] = '問題報告の登録に失敗しました。';
					}
				// レスの報告
				} else {
					if ($this->this_model->registerGuestCommentReport($input)) {
						$posted = true;
					} else {
						$err_msgs[] = '問題報告の登録に失敗しました。';
					}
				}
			}
		}

		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------

		$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
		$temp->directories[] = array('dir' => 'guest/report', 'title' => 'スパム報告（ゲスト）');
		$temp->dir_title = 'スパム報告（ゲスト）';

		if ($posted == false) {
			$guest_report_form_data = array();
			$guest_report_form_data['input'] = $input;
			$guest_report_form_data['report_types'] = $report_types;
			$guest_report_form_data['err_msgs'] = $err_msgs;
			$temp->content .= $this->load->view('guest_report_form', $guest_report_form_data, true);
		} else {
			$post_message_data['title'] = '投稿完了';
			$post_message_data['message'] = 'ご報告ありがとうございます。あなたの投稿を受け付けました。';
			$post_message_data['adv'] = $this->lib_base->get_adv('side');
			$temp->content .= $this->load->view('post_message', $post_message_data, true);
		}

		//-------------------------------------------------------------------------
		// 描画
		//-------------------------------------------------------------------------

		$this->lib_base->output_template($temp);
	}
}
