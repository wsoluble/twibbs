<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

use Abraham\TwitterOAuth\TwitterOAuth;

class Lib_ajax {
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
		$this->ci->load->database();
		if (!empty($_COOKIE)) {
			$sess_name = $this->ci->config->item('sess_cookie_name');
			$sess_id = empty($_COOKIE[$sess_name]) ? null : $_COOKIE[$sess_name];
			if (!empty($sess_id)) {
				// セッションクッキーが存在する場合はセッション読み込み
				$this->ci->load->library('session');
			}
		}
	}
	/**
	 * レスをツイート
	 * @param  [type] $thread [description]
	 * @param  [type] $body   [description]
	 */
	public function post_tweet_res($thread, $body) {
		// セッションにトークンが存在する場合にツイート
		if (!empty($_SESSION['access_token']) && !empty($_SESSION['access_token']['oauth_token']) && !empty($_SESSION['access_token']['oauth_token_secret'])) {
			$link_pattern =
			'\bhttps?+:(?://(?:(?:[-.0-9_a-z~]|%[0-9a-f][0-9a-f]' .
			'|[!$&-,:;=])*+@)?+(?:\[(?:(?:[0-9a-f]{1,4}:){6}(?:' .
			'[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:\d|[1-9]\d|1\d{2}|2' .
			'[0-4]\d|25[0-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25' .
			'[0-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.(?' .
			':\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5]))|::(?:[0-9a-f' .
			']{1,4}:){5}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:\d|[1' .
			'-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.(?:\d|[1-9]\d|1\d{' .
			'2}|2[0-4]\d|25[0-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\\' .
			'd|25[0-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])' .
			')|(?:[0-9a-f]{1,4})?+::(?:[0-9a-f]{1,4}:){4}(?:[0-' .
			'9a-f]{1,4}:[0-9a-f]{1,4}|(?:\d|[1-9]\d|1\d{2}|2[0-' .
			'4]\d|25[0-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-' .
			'5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.(?:\d' .
			'|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5]))|(?:(?:[0-9a-f]{' .
			'1,4}:)?+[0-9a-f]{1,4})?+::(?:[0-9a-f]{1,4}:){3}(?:' .
			'[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:\d|[1-9]\d|1\d{2}|2' .
			'[0-4]\d|25[0-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25' .
			'[0-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.(?' .
			':\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5]))|(?:(?:[0-9a-' .
			'f]{1,4}:){0,2}[0-9a-f]{1,4})?+::(?:[0-9a-f]{1,4}:)' .
			'{2}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:\d|[1-9]\d|1\\' .
			'd{2}|2[0-4]\d|25[0-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4' .
			']\d|25[0-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5' .
			'])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5]))|(?:(?:' .
			'[0-9a-f]{1,4}:){0,3}[0-9a-f]{1,4})?+::[0-9a-f]{1,4' .
			'}:(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:\d|[1-9]\d|1\d' .
			'{2}|2[0-4]\d|25[0-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]' .
			'\d|25[0-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5]' .
			')\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5]))|(?:(?:[' .
			'0-9a-f]{1,4}:){0,4}[0-9a-f]{1,4})?+::(?:[0-9a-f]{1' .
			',4}:[0-9a-f]{1,4}|(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25' .
			'[0-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.(?' .
			':\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.(?:\d|[1-9]\\' .
			'd|1\d{2}|2[0-4]\d|25[0-5]))|(?:(?:[0-9a-f]{1,4}:){' .
			'0,5}[0-9a-f]{1,4})?+::[0-9a-f]{1,4}|(?:(?:[0-9a-f]' .
			'{1,4}:){0,6}[0-9a-f]{1,4})?+::|v[0-9a-f]++\.[!$&-.' .
			'0-;=_a-z~]++)\]|(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0' .
			'-5])\.(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.(?:\\' .
			'd|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])\.(?:\d|[1-9]\d|' .
			'1\d{2}|2[0-4]\d|25[0-5])|(?:[-.0-9_a-z~]|%[0-9a-f]' .
			'[0-9a-f]|[!$&-,;=])*+)(?::\d*+)?+(?:/(?:[-.0-9_a-z' .
			'~]|%[0-9a-f][0-9a-f]|[!$&-,:;=@])*+)*+|/(?:(?:[-.0' .
			'-9_a-z~]|%[0-9a-f][0-9a-f]|[!$&-,:;=@])++(?:/(?:[-' .
			'.0-9_a-z~]|%[0-9a-f][0-9a-f]|[!$&-,:;=@])*+)*+)?+|' .
			'(?:[-.0-9_a-z~]|%[0-9a-f][0-9a-f]|[!$&-,:;=@])++(?' .
			':/(?:[-.0-9_a-z~]|%[0-9a-f][0-9a-f]|[!$&-,:;=@])*+' .
			')*+)?+(?:\?+(?:[-.0-9_a-z~]|%[0-9a-f][0-9a-f]|[!$&' .
			'-,/:;=?+@])*+)?+(?:#(?:[-.0-9_a-z~]|%[0-9a-f][0-9a' .
			'-f]|[!$&-,/:;=?+@])*+)?+';

			$tweet_body = htmlspecialchars_decode($body, ENT_QUOTES);
			$tweet_thread_url = "\n" . TWEET_THREAD_URL . $thread->thread_id;

			// リプライを抽出
			$replies = array();
			$twid_match_count = preg_match_all('/@[a-zA-Z0-9_]{1,15}/', $tweet_body, $twid_matches, PREG_PATTERN_ORDER);
			if (!empty($twid_match_count)) {
				foreach ($twid_matches[0] as $key => $twid) {
					$replies[] = '@' . $twid;
				}
			}

			// URLを抽出
			$links = array();
			$link_match_count = preg_match_all('`' . $link_pattern . '`i', $tweet_body, $link_matches, PREG_PATTERN_ORDER);
			if (!empty($link_match_count)) {
				foreach ($link_matches[0] as $key => $link) {
					$links[] = $link;
				}
			}

			// ツイートの文字数に切る
			$tweet_body = trim($tweet_body);
			$tweet_body_count = mb_strlen($tweet_body);
			$tweet_body_max = TWEET_BODY_MAX - mb_strlen($tweet_thread_url);
			if ($tweet_body_count > $tweet_body_max) {
				$tweet_body = mb_substr($tweet_body, 0, $tweet_body_max - 1);
				// リプライのtwitteridが途切れている場合は削除
				if (preg_match('/@[a-zA-Z0-9_]{1,15}$/', $tweet_body, $last_twid_match)) {
					if (!in_array($last_twid_match[0], $replies)) {
						$tweet_body = preg_replace('/@[a-zA-Z0-9_]{1,15}$/', '', $tweet_body);
					}
				}
				// URLが途切れている場合は削除
				if (preg_match("/https?:\/\/[-_.!~*'()a-zA-Z0-9;\/?:\@&=+\$,%#]*$/i", $tweet_body, $last_link_match)) {
					var_dump($last_link_match);
					if (!in_array($last_link_match[0], $links)) {
						$tweet_body = preg_replace("/https?:\/\/[-_.!~*'()a-zA-Z0-9;\/?:\@&=+\$,%#]*$/i", '', $tweet_body);
					}
				}
				$tweet_body .= '…';
			}
			$tweet_body .= $tweet_thread_url;

			require_once APPPATH . '../twitteroauth/autoload.php';
			$connect = new TwitterOAuth(CONSUMER_KEY, CONSUMER_SECRET, $_SESSION['access_token']['oauth_token'], $_SESSION['access_token']['oauth_token_secret']);
			if (!empty($connect)) {
				$connect->post('statuses/update', array('status' => $tweet_body));
			}
		}
	}
}
