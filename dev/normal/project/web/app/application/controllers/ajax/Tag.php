<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Tag extends CI_Controller {
	/**
	 * オートコンプリートタグ
	 */
	public function index() {
		if ($this->input->is_ajax_request()) {
			// セッション読み込み
			$this->load->library('lib_ajax');
			// セッションがない場合は空を出力
			if (empty($_SESSION['user_id'])) {
				echo json_encode(0);
				exit();
			}
			$q = $this->input->post('q');
			$q = empty($q) ? '' : str_replace('\\', '', $q);
			if (empty($q)) {
				echo json_encode(0);
				exit();
			}
			$this->load->model('www/post_model', 'this_model');
			$tags = array();
			$m_tags = $this->this_model->getTagForwardmatch($q);
			if (!empty($m_tags)) {
				foreach ($m_tags as $mt) {
					$tags[] = $mt->tg_word;
				}
			}
			if (!empty($tags)) {
				echo json_encode($tags);
				exit();
			}
		}
		echo json_encode(0);
	}
}
