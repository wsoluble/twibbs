<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH . 'models/www/Base_model.php');

class Tag_model extends Base_model {
	/**
	 * [__construct description]
	 */
	public function __construct() {
		parent::__construct();
	}
	/**
	 * スレッドを取得
	 * @param  [type] $tag_id [description]
	 * @param  [type] $index  [description]
	 */
	public function getThreadsWithTag($tag_id, $base_id, $td, $s_user_id = null) {
		if (empty($tag_id)) {
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
				$sql_where = " WHERE tt_thread_id < ? AND tt_tag_id = ? ";
				$sql_order = " ORDER BY tt_thread_id DESC ";
				$params[] = $base_id;
				$params[] = $tag_id;
				break;

			case 'after':
				$sql_where = " WHERE tt_thread_id > ? AND tt_tag_id = ? ";
				$sql_order = " ORDER BY tt_thread_id ";
				$params[] = $base_id;
				$params[] = $tag_id;
				break;

			default:
				return false;
				break;
		}
		$params[] = THREAD_CONTENT_MAX;
		// SQL
		$sql =
<<<EOD
SELECT thread_tag.*, thread.*, user.*{$sql_column}
FROM {$this->def('SPIDER_DB')}.thread_tag
INNER JOIN {$this->def('SPIDER_DB')}.thread ON thread.thread_id = thread_tag.tt_thread_id AND thread.t_privated = 0
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = thread.t_user_id
{$sql_suser}
{$sql_where} {$sql_order} LIMIT ?;
EOD;
		$query = $this->db->query($sql, $params);
		return $query->result();
	}
}
