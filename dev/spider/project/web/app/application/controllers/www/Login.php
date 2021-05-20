<?php
defined('BASEPATH') OR exit('No direct script access allowed');

use Abraham\TwitterOAuth\TwitterOAuth;

class Login extends CI_Controller {
	/**
	 * TwitterOauthへリダイレクト
	 * @return [type] [description]
	 */
	public function index() {
		// 読み込み
		require_once APPPATH . '../twitteroauth/autoload.php';
		$this->load->library('session');
		$this->load->helper('url');

		// リファラ
		$s_purl = parse_url(site_url());
		$r_purl = !empty($_SERVER['HTTP_REFERER']) ? parse_url($_SERVER['HTTP_REFERER']) : null;
		$_SESSION['redirect'] = site_url();
		if (!empty($r_purl) && $r_purl['host'] == $s_purl['host']) {
			$current_uri = '/' . uri_string();
			if ($r_purl['path'] != $current_uri && $r_purl['path'] != '/logout') {
				$_SESSION['redirect'] = $_SERVER['HTTP_REFERER'];
			}
		}
		$this->session->mark_as_flash('redirect');

		// 認証画面へ
		try {
			$cb_url = base_url('/login/callback');
			$connect = new TwitterOAuth(CONSUMER_KEY, CONSUMER_SECRET);
			$token_r = $connect->oauth('oauth/request_token', array('oauth_callback' => $cb_url));
			$_SESSION['oauth_token'] = $token_r['oauth_token'];
			$_SESSION['oauth_token_secret'] = $token_r['oauth_token_secret'];
			$url = $connect->url('oauth/authenticate', array('oauth_token' => $token_r['oauth_token']));
		} catch (Exception $e) {
			echo '<p>' . $e->getMessage() . '</p>';
			exit();
		}
		header('location:' . $url);
		exit();
	}
	/**
	 * コールバック
	 * @return function [description]
	 */
	public function callback() {
		// 読み込み
		require_once APPPATH . '../twitteroauth/autoload.php';
		$this->load->library('session');
		$this->load->helper('url');
		$this->load->library('lib_user');

		$token_r = array();
		$token_r['oauth_token'] = $_SESSION['oauth_token'];
		$token_r['oauth_token_secret'] = $_SESSION['oauth_token_secret'];

		$get = $this->input->get(array('oauth_token', 'oauth_verifier'), false);
		if (!empty($get) && $token_r['oauth_token'] !== $get['oauth_token']) {
			header('location:' . $_SESSION['redirect']);
			exit();
		}

		$connect = new TwitterOAuth(CONSUMER_KEY, CONSUMER_SECRET, $token_r['oauth_token'], $token_r['oauth_token_secret']);
		$access_token = $connect->oauth('oauth/access_token', array('oauth_verifier' => $get['oauth_verifier']));

		if (!empty($access_token)) {
			$user_connect = new TwitterOAuth(CONSUMER_KEY, CONSUMER_SECRET, $access_token['oauth_token'], $access_token['oauth_token_secret']);
			$user = $user_connect->get('account/verify_credentials');
			if (!empty($user->errors)) {
				foreach ($user->errors as $e) {
					switch ($e->code) {
						// 存在しないアカウント
						case 34:
							// die('存在しない、または削除されたアカウントです...');
							break;

						default:
							break;
					}
				}
				// var_dump($user->errors);
				die('認証エラー');
			}
			$this->load->model('www/base_model', 'base_model');
			$ui = $this->lib_user->compose_user($user);
			$user_id = $this->base_model->registerUser($ui);
			// DB登録に失敗した場合はセッションを削除
			if (empty($user_id)) {
				session_destroy();
			} else {
				$this->session->set_userdata('access_token', $access_token);
				$this->session->set_userdata('user_id', $user_id);
				$this->session->set_userdata('twitter_primary_id', $ui->twitter_primary_id);
			}
			// var_dump($user);
			// var_dump($ui);
			// var_dump($_SESSION);
			// var_dump($user_id);
		}
		header('location:' . $_SESSION['redirect']);
		exit();
	}

}
