<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH . 'models/www/Base_model.php');

class User_model extends Base_model {
	/**
	 * [__construct description]
	 */
	public function __construct() {
		parent::__construct();
	}
	/**
	 * ユーザーのスレッドを取得
	 * @param  [type] $user_id   [description]
	 * @param  [type] $base_id   [description]
	 * @param  [type] $td        [description]
	 * @param  [type] $s_user_id [description]
	 */
	public function getThreadsFromUserID($user_id, $base_id, $td, $s_user_id = null) {
		if (empty($user_id)) {
			return false;
		}
		if (empty($base_id) xor empty($td)) {
			return false;
		}
		$params = array();
		$sql_column = "";
		$sql_suser = "";
		if (!empty($s_user_id)) {
			$sql_column = ", thread_favorite.*, thread_report.*";
			$sql_suser = <<<EOD
LEFT JOIN {$this->def('SPIDER_DB')}.thread_favorite_user ON thread_favorite_user.tfu_user_id = ? AND thread_favorite_user.tfu_thread_id = thread.thread_id
LEFT JOIN {$this->def('SPIDER_DB')}.thread_favorite ON thread_favorite.thread_favorite_id = thread_favorite_user.thread_favorite_id
LEFT JOIN {$this->def('SPIDER_DB')}.thread_report_user ON thread_report_user.tru_user_id = ? AND thread_report_user.tru_thread_id = thread.thread_id
LEFT JOIN {$this->def('SPIDER_DB')}.thread_report ON thread_report.thread_report_id = thread_report_user.thread_report_id
EOD;
			$params[] = $s_user_id;
			$params[] = $s_user_id;
		}
		$sql_where = "";
		$sql_order = "";
		switch ($td) {
			case 'before':
				$sql_where = " WHERE thread_id < ? AND t_user_id = ? AND t_privated = 0 ";
				$sql_order = " ORDER BY thread_id DESC ";
				$params[] = $base_id;
				$params[] = $user_id;
				break;

			case 'after':
				$sql_where = " WHERE thread_id > ? AND t_user_id = ? AND t_privated = 0 ";
				$sql_order = " ORDER BY thread_id ";
				$params[] = $base_id;
				$params[] = $user_id;
				break;

			default:
				return false;
				break;
		}
		$params[] = THREAD_CONTENT_MAX;
		// SQL
		$sql =
<<<EOD
SELECT thread.*, user.*{$sql_column}
FROM {$this->def('SPIDER_DB')}.thread
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = thread.t_user_id
{$sql_suser}
{$sql_where} {$sql_order} LIMIT ?;
EOD;
		$query = $this->db->query($sql, $params);
		return $query->result();
	}
	/**
	 * ユーザーのスレッドを取得
	 * @param  [type] $user_id ユーザーID
	 * @param  [type] $index   ページ番号
	 */
	public function getCommentsFromUserID($user_id, $base_id, $td, $s_user_id = null) {
		if (empty($user_id)) {
			return false;
		}
		if (empty($base_id) xor empty($td)) {
			return false;
		}
		$params = array();
		$sql_column = "";
		$sql_suser = "";
		if (!empty($s_user_id)) {
			$sql_column = ", comment_report.*";
			$sql_suser = <<<EOD
LEFT JOIN {$this->def('SPIDER_DB')}.comment_report_user ON comment_report_user.cru_user_id = ? AND comment_report_user.cru_comment_id = comment.comment_id
LEFT JOIN {$this->def('SPIDER_DB')}.comment_report ON comment_report.comment_report_id = comment_report_user.comment_report_id
EOD;
			$params[] = $s_user_id;
		}
		$sql_where = "";
		$sql_order = "";
		switch ($td) {
			case 'before':
				$sql_where = " WHERE comment_id < ? AND c_user_id = ? AND c_privated = 0 ";
				$sql_order = " ORDER BY comment_id DESC ";
				$params[] = $base_id;
				$params[] = $user_id;
				break;

			case 'after':
				$sql_where = " WHERE comment_id > ? AND c_user_id = ? AND c_privated = 0 ";
				$sql_order = " ORDER BY comment_id ";
				$params[] = $base_id;
				$params[] = $user_id;
				break;

			default:
				return false;
				break;
		}
		$params[] = COMMENT_CONTENT_MAX;
		$sql =
<<<"EOD"
SELECT comment.*, user.*{$sql_column}
FROM {$this->def('SPIDER_DB')}.comment
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = comment.c_user_id
{$sql_suser}
{$sql_where} {$sql_order} LIMIT ?;
EOD;
		$query = $this->db->query($sql, $params);
		return $query->result();
	}
	/**
	 * ユーザーのfavスレッドを取得
	 * @param  [type] $user_id   [description]
	 * @param  [type] $base_id   [description]
	 * @param  [type] $td        [description]
	 * @param  [type] $s_user_id [description]
	 */
	public function getFavoriteThreadsFromUserID($user_id, $base_id, $td, $s_user_id = null) {
		if (empty($user_id)) {
			return false;
		}
		if (empty($base_id) xor empty($td)) {
			return false;
		}
		$params = array();
		$sql_column = "";
		$sql_suser = "";
		if (!empty($s_user_id)) {
			$sql_column = ", thread_favorite.*, thread_report.*";
			$sql_suser = <<<EOD
LEFT JOIN {$this->def('SPIDER_DB')}.thread_favorite_user ON thread_favorite_user.tfu_user_id = ? AND thread_favorite_user.tfu_thread_id = thread.thread_id
LEFT JOIN {$this->def('SPIDER_DB')}.thread_favorite ON thread_favorite.thread_favorite_id = thread_favorite_user.thread_favorite_id
LEFT JOIN {$this->def('SPIDER_DB')}.thread_report_user ON thread_report_user.tru_user_id = ? AND thread_report_user.tru_thread_id = thread.thread_id
LEFT JOIN {$this->def('SPIDER_DB')}.thread_report ON thread_report.thread_report_id = thread_report_user.thread_report_id
EOD;
			$params[] = $s_user_id;
			$params[] = $s_user_id;
		}
		$sql_where = "";
		$sql_order = "";
		switch ($td) {
			case 'before':
				$sql_where = " WHERE u_thread_favorite_user.thread_favorite_id < ? AND u_thread_favorite_user.tfu_user_id = ? ";
				$sql_order = " ORDER BY u_thread_favorite_user.thread_favorite_id DESC ";
				$params[] = $base_id;
				$params[] = $user_id;
				break;

			case 'after':
				$sql_where = " WHERE u_thread_favorite_user.thread_favorite_id > ? AND u_thread_favorite_user.tfu_user_id = ? ";
				$sql_order = " ORDER BY u_thread_favorite_user.thread_favorite_id ";
				$params[] = $base_id;
				$params[] = $user_id;
				break;

			default:
				return false;
				break;
		}
		$params[] = THREAD_CONTENT_MAX;
		// SQL
		$sql =
<<<EOD
SELECT u_thread_favorite_user.thread_favorite_id AS bookmark_id, thread.*, user.*{$sql_column}
FROM {$this->def('SPIDER_DB')}.thread_favorite_user AS u_thread_favorite_user
INNER JOIN {$this->def('SPIDER_DB')}.thread ON thread.thread_id = u_thread_favorite_user.tfu_thread_id AND thread.t_privated = 0
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = thread.t_user_id
{$sql_suser}
{$sql_where} {$sql_order} LIMIT ?;
EOD;
		$query = $this->db->query($sql, $params);
		return $query->result();
	}
}
