<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH . 'models/www/Base_model.php');

class Prv_model extends Base_model {
	/**
	 * [__construct description]
	 */
	public function __construct() {
		parent::__construct();
	}
	/**
	 * NGユーザーを取得
	 * @param  [type] $user_id [description]
	 * @param  [type] $index   [description]
	 */
	public function getNgUsers($user_id, $index) {
		if ($index < 1) {
			return false;
		}
		$offset = ($index - 1) * THREAD_CONTENT_MAX;
		$sql =
<<<"EOD"
SELECT user_ng.*, user.*
FROM {$this->def('SPIDER_DB')}.user_ng
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = user_ng.un_ng_user_id
WHERE user_ng.un_user_id = ? ORDER BY un_datetime DESC LIMIT ?, ?;
EOD;
		$query = $this->db->query($sql, array($user_id, $offset, THREAD_CONTENT_MAX));
		return $query->result();
	}
	/**
	 * NGユーザーを登録
	 * @param  [type] $user_id       [description]
	 * @param  [type] $ng_twitter_id [description]
	 */
	public function registerNgUser($user_id, $ng_twitter_id) {
		if (empty($user_id) || empty($ng_twitter_id)) {
			return false;
		}
		$sql = 'CALL ' . SPIDER_DB . '.register_user_ng(?, ?);';
		$query = $this->db->query($sql, array($user_id, $ng_twitter_id));
		return empty($query) ? false : $query->row();
	}
	/**
	 * NGユーザーを削除
	 * @param  [type] $user_id       [description]
	 * @param  [type] $ng_twitter_id [description]
	 */
	public function deleteNgUser($user_id, $ng_twitter_id) {
		if (empty($user_id) || empty($ng_twitter_id)) {
			return false;
		}
		$sql = 'CALL ' . SPIDER_DB . '.delete_user_ng(?, ?);';
		$query = $this->db->query($sql, array($user_id, $ng_twitter_id));
		return empty($query) ? false : $query->row();
	}
	/**
	 * NGワードを登録
	 * @param  [type] $user_id  [description]
	 * @param  [type] $ng_words [description]
	 */
	public function registerNgWord($user_id, $ng_words) {
		if (empty($user_id)) {
			return false;
		}
		$ng_count = count($ng_words);
		$ng_text = empty($ng_words) ? '' : implode(' ', $ng_words);
		$sql = 'CALL ' . SPIDER_DB . '.register_user_ng_word(?, ?, ?);';
		$query = $this->db->query($sql, array($user_id, $ng_text, $ng_count));
		return empty($query) ? false : $query->row();
	}
}
