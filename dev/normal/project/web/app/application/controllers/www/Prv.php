<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Prv extends CI_Controller {
	/**
	 * NG設定
	 * @param  [type] $method [description]
	 * @return [type]         [description]
	 */
	public function ng($method) {

		//-------------------------------------------------------------------------
		// ロード
		//-------------------------------------------------------------------------

		$this->load->library('lib_base');
		$this->load->model('www/prv_model', 'this_model');

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
		$temp->c_name = 'user';
		$temp->head_params = array('c_name' => 'user', 'nofollow' => true);
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
			redirect('404', 'location', 303);
			exit();
		}
		$index = intval($index);

		// メソッド
		switch ($method) {
			case 'user':
			case 'word':
				break;

			default:
				redirect('404', 'location', 303);
				exit();
				break;
		}

		//-------------------------------------------------------------------------
		// Model
		//-------------------------------------------------------------------------

		if (!empty($_SESSION['user_id'])) {
			$temp->s_user = $this->this_model->getUser($_SESSION['user_id']);
		}
		$temp->categories = $this->this_model->getAllCategories();

		// レコードを取得
		$record_max = 0;
		$records = null;
		if (!empty($temp->s_user)) {
			switch ($method) {
				case 'user':
					$record_max = $temp->s_user->u_ng_user_count;
					if (!empty($record_max)) {
						$records = $this->this_model->getNgUsers($temp->s_user->user_id, $index);
					}
					break;

				case 'word':
					$records = $this->this_model->getNgWords($temp->s_user->user_id);
					if (!empty($records)) {
						$record_max = count($records);
					}
					break;

				default:
					break;
			}
		}

		//-------------------------------------------------------------------------
		// POST
		//-------------------------------------------------------------------------
		// add
		$err_msgs = array();
		$submit_add = $this->input->post('submit_add');
		if ($submit_add == 'post') {
			$ng_val = $this->input->post('ngval');
			if (empty($ng_val)) {
				$err_msgs[] = 'NGの値が空です';
			}
			switch ($method) {
				case 'user':
					if (!empty($ng_val) && !preg_match('/^[a-zA-Z0-9_]{1,15}$/', $ng_val)) {
						$err_msgs[] = '有効なTwitterIDを指定してください';
					}
					break;

				case 'word':
					if(!empty($ng_val) && strpos($ng_val, ' ') !== false) {
						$err_msgs[] = '空白を含めることはできません';
					}
					if (mb_strlen($ng_val) > NG_WORD_LENGTH) {
						$err_msgs[] = '単語は' . NG_WORD_LENGTH . '文字以内で記述してください';
					}
					if ($record_max >= NG_WORD_MAX) {
						$err_msgs[] = 'NGワードが' . NG_WORD_MAX . '件に達しました';
					}
					break;

				default:
					$err_msgs[] = '無効なメソッドが指定されました';
					break;
			}
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				switch ($method) {
					case 'user':
						$this->this_model->registerNgUser($temp->s_user->user_id, $ng_val);
						break;

					case 'word':
						array_unshift($records, $ng_val);
						$records = array_values(array_unique(array_filter($records, 'strlen')));
						$this->this_model->registerNgWord($temp->s_user->user_id, $records);
						break;

					default:
						break;
				}
				redirect('/prv/ng/' . $method, 'location', 303);
				exit();
			}
		}

		// remove
		$submit_remove = $this->input->post('submit_remove');
		if (!empty($submit_remove)) {
			switch ($method) {
				case 'user':
					if (!empty($submit_remove) && !preg_match('/^[a-zA-Z0-9_]{1,15}$/', $submit_remove)) {
						$err_msgs[] = '有効なTwitterIDを指定してください';
					}
					break;

				case 'word':
					if(!empty($submit_remove) && strpos($submit_remove, ' ') !== false) {
						$err_msgs[] = '空白を含めることはできません';
					}
					break;

				default:
					$err_msgs[] = '無効なメソッドが指定されました';
					break;
			}
			// エラーがない場合は登録
			if (empty($err_msgs)) {
				switch ($method) {
					case 'user':
						$this->this_model->deleteNgUser($temp->s_user->user_id, $submit_remove);
						break;

					case 'word':
						foreach ($records as $key => $record) {
							if ($record == $submit_remove) {
								$records[$key] = '';
							}
						}
						$records = array_values(array_unique(array_filter($records, 'strlen')));
						$this->this_model->registerNgWord($temp->s_user->user_id, $records);
						break;

					default:
						break;
				}
				redirect('/prv/ng/' . $method, 'location', 303);
				exit();
			}
		}

		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------

		if (empty($temp->s_user)) {
			$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
			$temp->directories[] = array('dir' => 'p/', 'title' => '見つかりません。');
			$temp->dir_title = 'Not Found.';
			$temp->head_params['title'] = 'Not Found.';
		} else {
			$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
			$temp->directories[] = array('dir' => 'u/' . $temp->s_user->u_twitter_id, 'title' => '@' . $temp->s_user->u_twitter_id);
			switch ($method) {
				case '':
					break;

				case 'user':
					$temp->head_params['title'] = 'NGユーザー設定';
					$temp->directories[] = array('dir' => '/prv/ng/user', 'title' => 'NGユーザー');
					break;

				case 'word':
					$temp->head_params['title'] = 'NGワード設定';
					$temp->directories[] = array('dir' => '/prv/ng/word', 'title' => 'NGワード');
					break;

				default:
					break;
			}
			$temp->dir_title = '@' . $temp->s_user->u_twitter_id;
		}

		if (!empty($temp->s_user)) {
			$user_title_data = array();
			$user_title_data['method'] = $method;
			$user_title_data['user'] = $temp->s_user;
			$user_title_data['disp_current_dir'] = true;
			$user_title_data['record_count'] = $record_max;
			$temp->content .= $this->load->view('user_title', $user_title_data, true);
		}

		$pagination_data = array();
		$pagination_data['page_index'] = intval($index);
		$pagination_data['record_max'] = $record_max;
		$pagination_data['content_max'] = THREAD_CONTENT_MAX;
		$pagination_data['segments'] = PAGINATION_SEGMENTS;
		$pagination_data['jump_max'] = false;
		$pagination_data['directory'] = 'prv/ng/' . $method;
		$pagination = $this->load->view('pagination', $pagination_data, true);

		// スレッドエントリ
		if (!empty($temp->s_user)) {
			switch ($method) {
				case '':
				case 'user':
					$ng_user_data = array();
					$ng_user_data['ng_users'] = $records;
					$ng_user_data['ng_count'] = $record_max;
					$ng_user_data['err_msgs'] = $err_msgs;
					$temp->content .= $this->load->view('ng_user', $ng_user_data, true);
					$temp->content .= $pagination;
					break;

				case 'word':
					$ng_word_data = array();
					$ng_word_data['ng_words'] = $records;
					$ng_word_data['ng_count'] = $record_max;
					$ng_word_data['err_msgs'] = $err_msgs;
					$temp->content .= $this->load->view('ng_word', $ng_word_data, true);
					break;

				default:
					break;
			}
		} else {
			$temp->content .= '<p class="no-entry">指定のユーザーは見つかりませんでした。</p>';
		}

		//-------------------------------------------------------------------------
		// 描画
		//-------------------------------------------------------------------------

		$this->lib_base->output_template($temp);

	}
}
