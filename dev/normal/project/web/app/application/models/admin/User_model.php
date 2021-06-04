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
	 * ユーザーのスパム報告スレッドを取得
	 * @param  [type] $user_id ユーザーID
	 * @param  [type] $index   ページ番号
	 */
	public function getThreadReportsFromUserID($user_id, $base_id, $td) {
		if (empty($user_id)) {
			return false;
		}
		if (empty($base_id) xor empty($td)) {
			return false;
		}
		$params = array();
		$sql_where = '';
		$sql_order = '';
		switch ($td) {
			case 'before':
				$sql_where = " WHERE thread_report_user.thread_report_id < ? AND thread_report_user.tru_user_id = ? ";
				$sql_order = " ORDER BY thread_report_user.thread_report_id DESC ";
				$params[] = $base_id;
				$params[] = $user_id;
				break;

			case 'after':
				$sql_where = " WHERE thread_report_user.thread_report_id > ? AND thread_report_user.tru_user_id = ? ";
				$sql_order = " ORDER BY thread_report_user.thread_report_id ";
				$params[] = $base_id;
				$params[] = $user_id;
				break;

			default:
				return false;
				break;
		}
		$params[] = THREAD_CONTENT_MAX;
		$sql =
<<<"EOD"
SELECT thread_report.*, thread.*, user.*, report_type.*
FROM {$this->def('SPIDER_DB')}.thread_report_user
INNER JOIN {$this->def('SPIDER_DB')}.thread_report ON thread_report.thread_report_id = thread_report_user.thread_report_id
INNER JOIN {$this->def('SPIDER_DB')}.thread ON thread.thread_id = thread_report.tr_thread_id
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = thread_report.tr_user_id
LEFT JOIN {$this->def('SPIDER_DB')}.report_type ON report_type.report_type_id = thread_report.tr_report_type
{$sql_where} {$sql_order} LIMIT ?;
EOD;
		$query = $this->db->query($sql, $params);
		return $query->result();
	}
	/**
	 * ユーザーのスパム報告レスを取得
	 * @param  [type] $user_id ユーザーID
	 * @param  [type] $index   ページ番号
	 */
	public function getCommentReportsFromUserID($user_id, $base_id, $td) {
		if (empty($user_id)) {
			return false;
		}
		if (empty($base_id) xor empty($td)) {
			return false;
		}
		$params = array();
		$sql_where = '';
		$sql_order = '';
		switch ($td) {
			case 'before':
				$sql_where = " WHERE comment_report_user.comment_report_id < ? AND comment_report_user.cru_user_id = ? ";
				$sql_order = " ORDER BY comment_report_user.comment_report_id DESC ";
				$params[] = $base_id;
				$params[] = $user_id;
				break;

			case 'after':
				$sql_where = " WHERE comment_report_user.comment_report_id > ? AND comment_report_user.cru_user_id = ? ";
				$sql_order = " ORDER BY comment_report_user.comment_report_id ";
				$params[] = $base_id;
				$params[] = $user_id;
				break;

			default:
				return false;
				break;
		}
		$params[] = THREAD_CONTENT_MAX;
		$sql =
<<<"EOD"
SELECT comment_report.*, comment.*, user.*, report_type.*
FROM {$this->def('SPIDER_DB')}.comment_report_user
INNER JOIN {$this->def('SPIDER_DB')}.comment_report ON comment_report.comment_report_id = comment_report_user.comment_report_id
INNER JOIN {$this->def('SPIDER_DB')}.comment ON comment.comment_id = comment_report.cr_comment_id
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = comment_report.cr_user_id
LEFT JOIN {$this->def('SPIDER_DB')}.report_type ON report_type.report_type_id = comment_report.cr_report_type
{$sql_where} {$sql_order} LIMIT ?;
EOD;
		$query = $this->db->query($sql, $params);
		return $query->result();
	}
}
