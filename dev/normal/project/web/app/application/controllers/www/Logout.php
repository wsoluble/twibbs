<?php
defined('BASEPATH') OR exit('No direct script access allowed');

use Abraham\TwitterOAuth\TwitterOAuth;

class Logout extends CI_Controller {
	/**
	 * ログアウト
	 * @return [type] [description]
	 */
	public function index() {
		// 読み込み
		$this->load->library('lib_user');
		$this->lib_user->logout();
	}

}
