<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Lib_user {
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
	}
	/**
	 * ユーザー情報を構成
	 * @param  [type] $user [description]
	 * @return [type]       [description]
	 */
	public function compose_user($user) {
		if (empty($user)) {
			return false;
		}
		$ui = new stdClass;
		$ui->twitter_primary_id = (is_numeric($user->id)) ? (int)$user->id : $user->id;
		$ui->twitter_id = $user->screen_name;
		$ui->twitter_name = htmlspecialchars(html_entity_decode($user->name, ENT_QUOTES), ENT_QUOTES);
		$ui->twitter_profile_image = $user->profile_image_url_https;
		// $ui->twitter_profile_image = preg_replace('/_normal\./', '.', $user->profile_image_url_https);
		$ui->twitter_profile_banner = $user->profile_banner_url;
		return $ui;
	}
	/**
	 * ログアウト
	 * @return [type] [description]
	 */
	public function logout() {
		// 読み込み
		$this->ci->load->library('session');
		$this->ci->load->helper('url');

		// リファラ
		$url = site_url();
		$s_purl = parse_url(site_url());
		$r_purl = !empty($_SERVER['HTTP_REFERER']) ? parse_url($_SERVER['HTTP_REFERER']) : null;
		if (!empty($r_purl) && $r_purl['host'] == $s_purl['host']) {
			$current_uri = '/' . uri_string();
			if ($r_purl['path'] != $current_uri && $r_purl['path'] != '/login') {
				$url = $_SERVER['HTTP_REFERER'];
			}
		}
		session_destroy();
		header('location:' . $url);
		exit();
	}
}
