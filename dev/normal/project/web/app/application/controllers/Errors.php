<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Errors extends CI_Controller {
	/**
	 * 404ページ
	 * @param  [type] $thread_id [description]
	 * @return [type]            [description]
	 */
	public function index() {
		$this->load->library('lib_base');
		$this->load->model('www/base_model', 'this_model');
		$this->lib_base->output_404();
	}
}
