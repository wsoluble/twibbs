<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH . 'models/www/Base_model.php');

class Report_model extends Base_model {
	/**
	 * [__construct description]
	 */
	public function __construct() {
		parent::__construct();
	}
	/**
	 * スレッドスパム報告を登録
	 * @param  [type] $input [description]
	 */
	public function registerThreadReport($input) {
		if (empty($input)) {
			return false;
		}
		$params = array(
			$input->user_id,
			$input->thread_id,
			$input->body,
			$input->report_type,
			$input->ip,
			$input->host,
			$input->ua
		);
		$sql = 'CALL ' . SPIDER_DB . '.register_thread_report(?, ?, ?, ?, ?, ?, ?);';
		$query = $this->db->query($sql, $params);
		return $query->row();
	}
	/**
	 * スレッドスパム報告を削除
	 * @param  [type] $report_user_id [description]
	 * @param  [type] $thread_id      [description]
	 * @param  [type] $s_user_id      [description]
	 */
	public function deleteThreadReport($report_user_id, $thread_id, $s_user_id) {
		if (empty($report_user_id) || empty($thread_id) || empty($s_user_id)) {
			return false;
		}
		$params = array();
		if ($_SESSION['twitter_primary_id'] === ADMIN_TWITTER_PRIMARY_ID) {
			$params[] = $report_user_id;
			$params[] = $thread_id;
			$sql = 'CALL ' . SPIDER_DB . '.admin_delete_thread_report(?, ?);';
		} else {
			$params[] = $report_user_id;
			$params[] = $thread_id;
			$params[] = $s_user_id;
			$sql = 'CALL ' . SPIDER_DB . '.delete_thread_report(?, ?, ?);';
		}
		$query = $this->db->query($sql, $params);
		return $query->row();
	}
	/**
	 * レススパム報告を登録
	 * @param  [type] $input [description]
	 * @return [type]        [description]
	 */
	public function registerCommentReport($input) {
		if (empty($input)) {
			return false;
		}
		$params = array(
			$input->user_id,
			$input->comment_id,
			$input->body,
			$input->report_type,
			$input->ip,
			$input->host,
			$input->ua
		);
		$sql = 'CALL ' . SPIDER_DB . '.register_comment_report(?, ?, ?, ?, ?, ?, ?);';
		$query = $this->db->query($sql, $params);
		return $query->row();
	}
	/**
	 * レススパム報告を削除
	 * @param  [type] $report_user_id [description]
	 * @param  [type] $comment_id     [description]
	 * @param  [type] $s_user_id      [description]
	 */
	public function deleteCommentReport($report_user_id, $comment_id, $s_user_id) {
		if (empty($report_user_id) || empty($comment_id) || empty($s_user_id)) {
			return false;
		}
		$params = array();
		if ($_SESSION['twitter_primary_id'] === ADMIN_TWITTER_PRIMARY_ID) {
			$params[] = $report_user_id;
			$params[] = $comment_id;
			$sql = 'CALL ' . SPIDER_DB . '.admin_delete_comment_report(?, ?);';
		} else {
			$params[] = $report_user_id;
			$params[] = $comment_id;
			$params[] = $s_user_id;
			$sql = 'CALL ' . SPIDER_DB . '.delete_comment_report(?, ?, ?);';
		}
		$query = $this->db->query($sql, $params);
		return $query->row();
	}
	/**
	 * ゲストのレススパム報告
	 * @param  [type] $input [description]
	 * @return [type]        [description]
	 */
	public function registerGuestCommentReport($input) {
		if (empty($input)) {
			return false;
		}
		$params = array(
			$input->name,
			$input->email,
			$input->comment_id,
			$input->body,
			$input->report_type,
			$input->ip,
			$input->host,
			$input->ua
		);
		$sql = <<<EOT
INSERT INTO {$this->def('SPIDER_DB')}.guest_comment_report
(gcr_name, gcr_email, gcr_comment_id, gcr_body, gcr_report_type, gcr_datetime, gcr_ip, gcr_host, gcr_ua)
VALUES(?, ?, ?, ?, ?, NOW(), ?, ?, ?);
EOT;
		$result = $this->db->query($sql, $params);
		return $result;
	}
	/**
	 * ゲストのスレッドスパム報告
	 * @param  [type] $input [description]
	 * @return [type]        [description]
	 */
	public function registerGuestThreadReport($input) {
		if (empty($input)) {
			return false;
		}
		$params = array(
			$input->name,
			$input->email,
			$input->thread_id,
			$input->body,
			$input->report_type,
			$input->ip,
			$input->host,
			$input->ua
		);
		$sql = <<<EOT
INSERT INTO {$this->def('SPIDER_DB')}.guest_thread_report
(gtr_name, gtr_email, gtr_thread_id, gtr_body, gtr_report_type, gtr_datetime, gtr_ip, gtr_host, gtr_ua)
VALUES(?, ?, ?, ?, ?, NOW(), ?, ?, ?);
EOT;
		$result = $this->db->query($sql, $params);
		return $result;
	}
	/**
	 * スレッドスパム報告一覧を取得
	 * @param  [type] $thread_id [description]
	 * @param  [type] $first_id  [description]
	 * @param  [type] $last_id   [description]
	 */
	public function getThreadReports($thread_id, $first_id, $last_id) {
		if (empty($thread_id) || empty($first_id) || empty($last_id)) {
			return false;
		}
		$params = array();
		$params[] = $thread_id;
		$params[] = $first_id;
		$params[] = $last_id;
		$params[] = SPAM_REPORT_MAX;
		$sql =
<<<"EOD"
SELECT thread_report.*, thread.*, user.*, report_type.*
FROM {$this->def('SPIDER_DB')}.thread_report_thread
INNER JOIN {$this->def('SPIDER_DB')}.thread_report ON thread_report.thread_report_id = thread_report_thread.thread_report_id
INNER JOIN {$this->def('SPIDER_DB')}.thread ON thread.thread_id = thread_report.tr_thread_id
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = thread_report.tr_user_id
LEFT JOIN {$this->def('SPIDER_DB')}.report_type ON report_type.report_type_id = thread_report.tr_report_type
WHERE
	thread_report_thread.trt_thread_id = ?
	AND thread_report_thread.thread_report_id >= ?
	AND thread_report_thread.thread_report_id <= ?
ORDER BY
	thread_report_thread.thread_report_id DESC
LIMIT ?;
EOD;
		$query = $this->db->query($sql, $params);
		return $query->result();
	}
	/**
	 * スレッドスパム報告を取得
	 * @param  [type] $thread_id [description]
	 * @param  [type] $user_id   [description]
	 */
	public function getThreadReport($user_id, $thread_id) {
		if (empty($thread_id) || empty($user_id)) {
			return false;
		}
		$params = array();
		$params[] = $thread_id;
		$params[] = $user_id;
		$sql =
<<<"EOD"
SELECT thread_report.*, thread.*, user.*, report_type.*
FROM {$this->def('SPIDER_DB')}.thread_report_thread
INNER JOIN {$this->def('SPIDER_DB')}.thread_report ON thread_report.thread_report_id = thread_report_thread.thread_report_id
INNER JOIN {$this->def('SPIDER_DB')}.thread ON thread.thread_id = thread_report.tr_thread_id
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = thread_report.tr_user_id
LEFT JOIN {$this->def('SPIDER_DB')}.report_type ON report_type.report_type_id = thread_report.tr_report_type
WHERE thread_report_thread.trt_thread_id = ? AND thread_report_thread.trt_user_id = ? LIMIT 1;
EOD;
		$query = $this->db->query($sql, $params);
		return $query->result();
	}
	/**
	 * レススパム報告一覧を取得
	 * @param  [type] $comment_id [description]
	 * @param  [type] $user_id    [description]
	 */
	public function getCommentReports($comment_id, $first_id, $last_id) {
		if (empty($comment_id) || empty($first_id) || empty($last_id)) {
			return false;
		}
		$params = array();
		$params[] = $comment_id;
		$params[] = $first_id;
		$params[] = $last_id;
		$params[] = SPAM_REPORT_MAX;
		$sql =
<<<"EOD"
SELECT comment_report.*, comment.*, user.*, report_type.*
FROM {$this->def('SPIDER_DB')}.comment_report_comment
INNER JOIN {$this->def('SPIDER_DB')}.comment_report ON comment_report.comment_report_id = comment_report_comment.comment_report_id
INNER JOIN {$this->def('SPIDER_DB')}.comment ON comment.comment_id = comment_report.cr_comment_id
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = comment_report.cr_user_id
LEFT JOIN {$this->def('SPIDER_DB')}.report_type ON report_type.report_type_id = comment_report.cr_report_type
WHERE
	comment_report_comment.crc_comment_id = ?
	AND comment_report_comment.comment_report_id >= ?
	AND comment_report_comment.comment_report_id <= ?
ORDER BY
	comment_report_comment.comment_report_id DESC
LIMIT ?;
EOD;
		$query = $this->db->query($sql, $params);
		return $query->result();
	}
	/**
	 * レススパム報告を取得
	 * @param  [type] $comment_id [description]
	 * @param  [type] $user_id    [description]
	 */
	public function getCommentReport($user_id, $comment_id) {
		if (empty($comment_id) || empty($user_id)) {
			return false;
		}
		$params = array();
		$params[] = $comment_id;
		$params[] = $user_id;
		$sql =
<<<"EOD"
SELECT comment_report.*, comment.*, user.*, report_type.*
FROM {$this->def('SPIDER_DB')}.comment_report_comment
INNER JOIN {$this->def('SPIDER_DB')}.comment_report ON comment_report.comment_report_id = comment_report_comment.comment_report_id
INNER JOIN {$this->def('SPIDER_DB')}.comment ON comment.comment_id = comment_report.cr_comment_id
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = comment_report.cr_user_id
LEFT JOIN {$this->def('SPIDER_DB')}.report_type ON report_type.report_type_id = comment_report.cr_report_type
WHERE comment_report_comment.crc_comment_id = ? AND comment_report_comment.crc_user_id = ? LIMIT 1;
EOD;
		$query = $this->db->query($sql, $params);
		return $query->result();
	}
	/**
	 * スレッドスパム報告を投稿済みか
	 * @param  [type] $user_id [description]
	 */
	public function postedReportThread($user_id, $thread_id) {
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.thread_report_user WHERE tru_user_id = ? AND tru_thread_id = ?;';
		$query = $this->db->query($sql, array($user_id, $thread_id));
		return $query->row();
	}
	/**
	 * レススパム報告を投稿済みか
	 * @param  [type] $user_id    [description]
	 * @param  [type] $comment_id [description]
	 */
	public function postedReportComment($user_id, $comment_id) {
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.comment_report_user WHERE cru_user_id = ? AND cru_comment_id = ?;';
		$query = $this->db->query($sql, array($user_id, $comment_id));
		return $query->row();
	}
	/**
	 * 報告の種類を取得
	 * @return [type] [description]
	 */
	public function getThreadReportTypes() {
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.report_type WHERE rt_hide_thread = 0 ORDER BY report_type_id;';
		$query = $this->db->query($sql);
		return $query->result();
	}
	/**
	 * 報告の種類を取得
	 * @return [type] [description]
	 */
	public function getCommentReportTypes() {
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.report_type WHERE rt_hide_comment = 0 ORDER BY report_type_id;';
		$query = $this->db->query($sql);
		return $query->result();
	}
	/**
	 * 報告の種類を取得
	 * @return [type] [description]
	 */
	public function getReportTypes() {
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.report_type ORDER BY report_type_id;';
		$query = $this->db->query($sql);
		return $query->result();
	}
}
