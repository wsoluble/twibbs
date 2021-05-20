<?php
mb_language('Japanese');
mb_internal_encoding('UTF-8');
date_default_timezone_set('Asia/Tokyo');

/**
 * Admin Account
 */
define('ADMIN_TWITTER_PRIMARY_ID', 2222164063);
define('SITE_TWITTER_ID', 'textopia_web');

/**
 * site parameters
 */
define('SITE_NAME', 'textopia');
define('SITE_SUBTITLE', 'for Twitterer');
define('THREAD_CONTENT_MAX', 20);
define('THREAD_COMMENT_MAX', 100);
define('COMMENT_CONTENT_MAX', 20);
define('SPAM_REPORT_MAX', 100);
define('PAGINATION_SEGMENTS', 2);
define('DELETED_NAME', '_(ˇωˇ」∠)_ ｽﾔｧ…');

/**
 * Adv
 */
define('ADV_DISPLAY_CONTENT_NUM', 10);

/**
 * NG
 */
define('NG_WORD_MAX', 200);
define('NG_WORD_LENGTH', 15);
define('NG_USER_MAX', 500);

/**
 * URL
 */
define('TERM_URL', '/term');
define('HELP_URL', '/help');
define('RULE_URL', '/rule');

/**
 * Thread
 */
define('THREAD_TITLE_LENGTH', 100);
define('SEQ_SPACE_MAX', 5);	// 連続スペース
define('POST_THREAD_INTERVAL', 1800);

/**
 * Comments
 */
define('COMMENT_LENGTH', 2000);
define('SEQ_NEW_LINE_MAX', 5);	// 連続改行
define('POST_COMMENT_INTERVAL', 30);
define('POST_COMMENT_FILLED_REDIRECT_SEC', 5);

/**
 * Tag
 */
define('THREAD_TAG_MAX', 10);
define('TAG_LENGTH', 30);

/**
 * TOP
 */
define('TOPPAGE_THREADS_RANGE', 1000);
define('TOPPAGE_COMMENTS_RANGE', 1000);

/**
 * Twitter
 */
define('TWITTER_URL', 'https://twitter.com/');
define('CONSUMER_KEY', 'xD9sYyOgrlClNOCo7kOgispRB');
define('CONSUMER_SECRET', 'Dfe05P0ambiqHp3D3Hq9H5mCs9dKiPm4BxCfTXFbf81R10BSRk');
define('WEBMASTER_ACCESS_TOKEN', '2222164063-R4ceDFGhsqlppUyO7rQiFUOy0S0QH4W897xKRQE');
define('WEBMASTER_ACCESS_TOKEN_SECRET', 'nTwQ5dlTJQJF8UmiRyWWuaFITB76Okox3IuBbDMGTwuIc');

/**
 * DATABASE
 */
# define('DB_USER', 'twibbs_master');
# define('DB_PASS', 'meteor');

define('SPIDER_DB', 'spider_twibbs');
# define('SESSION_DB', 'twibbs_session');
# define('SITE_DB', 'twibbs_site');

/**
 * 共通処理
 */
class SiteCommon {
	/**
	 * [__construct description]
	 */
	function __construct() {}
	/**
	 * [utf8mb4_encode_numericentity description]
	 * @param  [type] $str [description]
	 * @return [type]      [description]
	 */
	public function utf8mb4_encode_numericentity($str) {
		$re = '/[^\x{0}-\x{FFFF}]/u';
		return preg_replace_callback($re, function($m) {
			$char = $m[0];
			$x = ord($char[0]);
			$y = ord($char[1]);
			$z = ord($char[2]);
			$w = ord($char[3]);
			$cp = (($x & 0x7) << 18) | (($y & 0x3F) << 12) | (($z & 0x3F) << 6) | ($w & 0x3F);
			return sprintf("&#x%X;", $cp);
		}, $str);
	}
	/**
	 * 特殊文字をHTMLエンティティに変換（4バイト文字対応）
	 * @param  [type] $str [description]
	 */
	public function htmlspecialchars_utf8mb4($str) {
		return preg_replace('/&amp;#([0-9a-zA-Z]+);/', '&#${1};', htmlspecialchars($this->utf8mb4_encode_numericentity($str), ENT_QUOTES));
	}
}
