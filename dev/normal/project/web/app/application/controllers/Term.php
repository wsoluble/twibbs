<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Term extends CI_Controller {
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
		$temp->head_params = array('c_name' => 'top', 'title' => '利用規約');
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
		$temp->directories[] = array('dir' => 'term', 'title' => '利用規約');
		$temp->dir_title = '利用規約';

		$term_data = array();
		$temp->content .= $this->load->view('term', $term_data, true);

		//-------------------------------------------------------------------------
		// 描画
		//-------------------------------------------------------------------------
		$this->lib_base->output_template($temp);
	}
}
