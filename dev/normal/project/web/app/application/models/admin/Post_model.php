<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH . 'models/www/Base_model.php');

class Post_model extends Base_model {
	/**
	 * [__construct description]
	 */
	public function __construct() {
		parent::__construct();
	}
	/**
	 * [getAdminUsers description]
	 * @return [type] [description]
	 */
	public function getAdminUsers() {
		$sql =
<<<"EOD"
SELECT admin_user.*, user.*
FROM {$this->def('SPIDER_DB')}.admin_user
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = admin_user.admin_user_id
WHERE admin_user.au_hide = 0
ORDER BY admin_user.admin_user_id DESC;
EOD;
		$query = $this->db->query($sql);
		return $query->result();
	}
	/**
	 * [getAdminThreadsCount description]
	 * @param  [type] $status [description]
	 * @return [type]         [description]
	 */
	public function getAdminThreadsCount($status) {
		$params = array();
		$sql_where = '';
		if (isset($status)) {
			switch ($status) {
				case 0:
				case 1:
				case 2:
					$sql_where = 'WHERE admin_thread.at_status = ?';
					$params[] = $status;
					break;

				default:
					break;
			}
		}
		$sql =
<<<"EOD"
SELECT COUNT(*) AS cnt
FROM {$this->def('SPIDER_DB')}.admin_thread
{$sql_where};
EOD;
		$query = $this->db->query($sql, $params);
		$row = $query->row();
		return empty($row) ? 0 : $row->cnt;
	}
	/**
	 * [getAdminThreads description]
	 * @param  [type] $index  [description]
	 * @param  [type] $status [description]
	 * @return [type]         [description]
	 */
	public function getAdminThreads($index, $status) {
		if ($index < 1) {
			return false;
		}
		$params = array();
		$offset = ($index - 1) * THREAD_CONTENT_MAX;
		$sql_where = '';
		if (isset($status)) {
			switch ($status) {
				case 0:
				case 1:
				case 2:
					$sql_where = 'WHERE admin_thread.at_status = ?';
					$params[] = $status;
					break;

				default:
					break;
			}
		}
		$params[] = $offset;
		$params[] = THREAD_CONTENT_MAX;
		$sql =
<<<"EOD"
SELECT admin_thread.*, user.*, thread.*
FROM {$this->def('SPIDER_DB')}.admin_thread
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = admin_thread.at_user_id
LEFT JOIN {$this->def('SPIDER_DB')}.thread ON thread.thread_id = admin_thread.at_thread_id
{$sql_where}
ORDER BY at_datetime DESC LIMIT ?, ?;
EOD;
		$query = $this->db->query($sql, $params);
		return $query->result();
	}
	/**
	 * adminスレッドを取得
	 * @param  [type] $admin_thread_id [description]
	 * @return [type]                  [description]
	 */
	public function getAdminThread($admin_thread_id) {
		if (empty($admin_thread_id)) {
			return false;
		}
		$sql =
<<<"EOD"
SELECT admin_thread.*, user.*
FROM {$this->def('SPIDER_DB')}.admin_thread
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = admin_thread.at_user_id
LEFT JOIN {$this->def('SPIDER_DB')}.thread ON thread.thread_id = admin_thread.at_thread_id
WHERE admin_thread.admin_thread_id = ?;
EOD;
		$query = $this->db->query($sql, array($admin_thread_id));
		return $query->row();
	}
	/**
	 * [getAdminComments description]
	 * @param  [type] $admin_thread_id [description]
	 * @return [type]                  [description]
	 */
	public function getAdminComments($admin_thread_id) {
		if (empty($admin_thread_id)) {
			return false;
		}
		$sql =
<<<"EOD"
SELECT admin_comment.*, user.*
FROM {$this->def('SPIDER_DB')}.admin_comment
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = admin_comment.ac_user_id
WHERE admin_comment.ac_admin_thread_id = ?
ORDER BY admin_comment.ac_rel_second DESC;
EOD;
		$query = $this->db->query($sql, array($admin_thread_id));
		return $query->result();
	}
	/**
	 * adminスレッドを登録
	 * @param  [type] $thread [description]
	 * @return [type]         [description]
	 */
	public function registerAdminThread($thread) {
		if (empty($thread)) {
			return false;
		}
		$params = array(
			$thread->user_id,
			$thread->title,
			$thread->body,
			$thread->category_id,
			implode(' ', $thread->tags),
			$thread->datetime
		);
		$sql = <<<EOT
INSERT INTO {$this->def('SPIDER_DB')}.admin_thread
(at_user_id, at_title, at_body, at_category, at_tag, at_datetime)
VALUES (?, ?, ?, ?, ?, ?);
EOT;
		$result = $this->db->query($sql, $params);
		$insert_id = empty($result) ? null : $this->db->insert_id();
		return $insert_id;
	}
	/**
	 * [updateAdminThread description]
	 * @param  [type] $thread [description]
	 * @return [type]         [description]
	 */
	public function updateAdminThread($thread) {
		if (empty($thread)) {
			return false;
		}
		$params = array(
			$thread->user_id,
			$thread->title,
			$thread->body,
			$thread->category_id,
			implode(' ', $thread->tags),
			$thread->status,
			$thread->datetime,
			$thread->admin_thread_id
		);
		$sql = <<<EOT
UPDATE {$this->def('SPIDER_DB')}.admin_thread SET
at_user_id = ?,
at_title = ?,
at_body = ?,
at_category = ?,
at_tag = ?,
at_status = ?,
at_datetime = ?
WHERE admin_thread_id = ?;
EOT;
		$result = $this->db->query($sql, $params);
		return $result;
	}
	/**
	 * [deleteAdminThread description]
	 * @param  [type] $admin_thread_id [description]
	 * @return [type]                  [description]
	 */
	public function deleteAdminThread($admin_thread_id) {
		if (empty($admin_thread_id)) {
			return false;
		}
		$params = array(
			$admin_thread_id
		);
		$sql = <<<EOT
DELETE admin_thread, admin_comment
FROM {$this->def('SPIDER_DB')}.admin_thread
LEFT JOIN {$this->def('SPIDER_DB')}.admin_comment ON admin_comment.ac_admin_thread_id = admin_thread.admin_thread_id
WHERE admin_thread.admin_thread_id = ?;
EOT;
		$result = $this->db->query($sql, $params);
		return $result;
	}
	/**
	 * [registerAdminComment description]
	 * @param  [type] $comment [description]
	 * @return [type]          [description]
	 */
	public function registerAdminComment($comment) {
		if (empty($comment)) {
			return false;
		}
		$params = array(
			$comment->ac_admin_thread_id,
			$comment->user_id,
			$comment->body,
			$comment->datetime,
			$comment->ac_rel_second
		);
		$sql = <<<EOT
INSERT INTO {$this->def('SPIDER_DB')}.admin_comment
(ac_admin_thread_id, ac_user_id, ac_body, ac_datetime, ac_rel_second)
VALUES (?, ?, ?, ?, ?);
EOT;
		$result = $this->db->query($sql, $params);
		$insert_id = empty($result) ? null : $this->db->insert_id();
		return $insert_id;
	}
	/**
	 * [updateAdminComment_Datetime description]
	 * @param  [type] $admin_comment_id [description]
	 * @param  [type] $datetime         [description]
	 * @return [type]                   [description]
	 */
	public function updateAdminComment_Datetime($admin_comment_id, $datetime, $second) {
		if (empty($admin_comment_id) || empty($datetime) || empty($second)) {
			return false;
		}
		$params = array(
			$datetime,
			$second,
			$admin_comment_id
		);
		$sql = <<<EOT
UPDATE {$this->def('SPIDER_DB')}.admin_comment
SET ac_datetime = ?, ac_rel_second = ?
WHERE admin_comment_id = ?;
EOT;
		$result = $this->db->query($sql, $params);
		return $result;
	}
	/**
	 * [deleteAdminComment description]
	 * @param  [type] $admin_comment_id [description]
	 * @return [type]                   [description]
	 */
	public function deleteAdminComment($admin_comment_id) {
		if (empty($admin_comment_id)) {
			return false;
		}
		$params = array(
			$admin_comment_id
		);
		$sql = <<<EOT
DELETE FROM {$this->def('SPIDER_DB')}.admin_comment WHERE admin_comment_id = ?;
EOT;
		$result = $this->db->query($sql, $params);
		return $result;
	}
}
