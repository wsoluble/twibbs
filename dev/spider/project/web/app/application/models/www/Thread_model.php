<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH . 'models/www/Base_model.php');

class Thread_model extends Base_model {
	/**
	 * [__construct description]
	 */
	public function __construct() {
		parent::__construct();
	}
	/**
	 * スレッドを削除
	 * @param  [type] $thread_id [description]
	 * @param  [type] $user_id   [description]
	 */
	public function removeThread($thread_id, $user_id) {
		if (empty($thread_id) || empty($user_id)) {
			return false;
		}
		$params = array();
		if ($_SESSION['twitter_primary_id'] === ADMIN_TWITTER_PRIMARY_ID) {
			$params[] = $thread_id;
			$sql = 'CALL ' . SPIDER_DB . '.admin_remove_thread(?);';
		} else {
			$params[] = $thread_id;
			$params[] = $user_id;
			$sql = 'CALL ' . SPIDER_DB . '.remove_thread(?, ?);';
		}
		$query = $this->db->query($sql, $params);
		return $query->row();
	}
	/**
	 * レスを削除（レコードは残る）
	 * @param  [type] $comment_id [description]
	 * @param  [type] $user_id    [description]
	 */
	public function removeComment($comment_id, $user_id) {
		if (empty($comment_id) || empty($user_id)) {
			return false;
		}
		$params = array();
		if ($_SESSION['twitter_primary_id'] === ADMIN_TWITTER_PRIMARY_ID) {
			$params[] = $comment_id;
			$sql = 'CALL ' . SPIDER_DB . '.admin_remove_comment(?);';
		} else {
			$params[] = $comment_id;
			$params[] = $user_id;
			$sql = 'CALL ' . SPIDER_DB . '.remove_comment(?, ?);';
		}
		$query = $this->db->query($sql, $params);
		return $query->row();
	}
	/**
	 * スレッドファボ登録
	 * @param  [type] $fav [description]
	 * @return [type]      [description]
	 */
	public function registerThreadFavorite($user_id, $thread_id) {
		if (empty($user_id) || empty($thread_id)) {
			return false;
		}
		$sql = 'CALL ' . SPIDER_DB . '.register_thread_favorite(?, ?);';
		$query = $this->db->query($sql, array($user_id, $thread_id));
		return $query->row();
	}
	/**
	 * スレッドファボ削除
	 * @param  [type] $fav [description]
	 * @return [type]      [description]
	 */
	public function deleteThreadFavorite($user_id, $thread_id) {
		if (empty($user_id) || empty($thread_id)) {
			return false;
		}
		$sql = 'CALL ' . SPIDER_DB . '.delete_thread_favorite(?, ?);';
		$query = $this->db->query($sql, array($user_id, $thread_id));
		return $query->row();
	}
	/**
	 * コメント登録
	 * @param  [type] $comment [description]
	 */
	public function registerComment($comment) {
		if (empty($comment)) {
			return false;
		}
		$params = array(
			$comment->thread_id,
			$comment->user_id,
			$comment->body,
			$comment->ip
		);
		$sql = 'CALL ' . SPIDER_DB . '.register_comment(?, ?, ?, ?);';
		$query = $this->db->query($sql, $params);
		return $query->row();
	}
	/**
	 * 前回のコメント投稿時間から十分に時間が経過しているか
	 * @param  [type] $user_id [description]
	 */
	public function checkIntervalComment($last_comment_id) {
		if (empty($last_comment_id)) {
			return true;
		}
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.comment WHERE comment_id = ? LIMIT 1;';
		$query = $this->db->query($sql, array($last_comment_id));
		$row = $query->row();
		if (empty($row)) {
			return true;
		}
		$interval = time() - strtotime($row->c_datetime);
		return ($interval >= POST_COMMENT_INTERVAL) ? true : false;
	}
	/**
	 * [getComments description]
	 * @param  [type] $thread_id [description]
	 * @return [type]            [description]
	 */
	public function getComments($thread_id, $base_id, $td, $s_user_id = null) {
		if (empty($thread_id)) {
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
				$sql_where = " WHERE comment_id < ? AND c_thread_id = ? ";
				$sql_order = " ORDER BY comment_id DESC ";
				$params[] = $base_id;
				$params[] = $thread_id;
				break;

			case 'after':
				$sql_where = " WHERE comment_id > ? AND c_thread_id = ? ";
				$sql_order = " ORDER BY comment_id ";
				$params[] = $base_id;
				$params[] = $thread_id;
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
	 * コメント一覧を取得（範囲指定）
	 * @param  [type] $thread_id [description]
	 * @param  [type] $start     [description]
	 * @param  [type] $end       [description]
	 * @param  [type] $s_user_id [description]
	 */
	public function getCommentsRange($thread_id, $start, $end, $s_user_id = null) {
		if (empty($thread_id) or empty($end)) {
			return false;
		}
		if (empty($start)) {
			$start = empty($end) ? 0 : $end - 1;
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
		$sql_where = " WHERE comment_id > ? AND comment_id <= ? AND c_thread_id = ? ";
		$sql_order = " ORDER BY comment_id DESC ";
		$params[] = $start;
		$params[] = $end;
		$params[] = $thread_id;
		$sql =
<<<"EOD"
SELECT comment.*, user.*{$sql_column}
FROM {$this->def('SPIDER_DB')}.comment
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = comment.c_user_id
{$sql_suser}
{$sql_where} {$sql_order};
EOD;
		$query = $this->db->query($sql, $params);
		return $query->result();
	}
}
