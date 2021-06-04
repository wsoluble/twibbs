<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Lib_admin {
	/**
	 * プロパティ
	 * @var [type]
	 */
	protected $ci = null;
	/**
	 * [__construct description]
	 */
	public function __construct() {
		$this->ci = &get_instance();
		// 管理者以外はトップへリダイレクト
		if (empty($_SESSION['twitter_primary_id']) || $_SESSION['twitter_primary_id'] !== ADMIN_TWITTER_PRIMARY_ID) {
			redirect('/', 'location', 303);
			exit();
		}
	}
}
