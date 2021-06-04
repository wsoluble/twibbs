<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Req extends CI_Controller {
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
		$temp->head_params = array('c_name' => 'top', 'title' => 'ご要望');
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
		//-------------------------------------------------------------------------
		// content
		//-------------------------------------------------------------------------
		$temp->directories[] = array('dir' => '', 'title' => 'ホーム');
		$temp->directories[] = array('dir' => 'rule', 'title' => 'ご要望');
		$temp->dir_title = 'ご要望';

		$help_data = array();
		$help_data['user'] = $temp->s_user;
		$temp->content .= $this->load->view('req', $help_data, true);

		//-------------------------------------------------------------------------
		// 描画
		//-------------------------------------------------------------------------
		$this->lib_base->output_template($temp);
	}
}
