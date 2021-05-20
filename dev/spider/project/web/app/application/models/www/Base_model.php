<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Base_model extends CI_Model {
	/**
	 * construct
	 */
	public function __construct() {
		parent::__construct();
		// $this->db->query('SET SESSION time_zone = "Asia/Tokyo";');
		$this->db->query('SET SESSION time_zone = "Asia/Tokyo";');
		$this->db->query('SET NAMES utf8mb4;');
	}
	/**
	 * 定数取得
	 * @param  [type] $name [description]
	 * @return [type]       [description]
	 */
	public function def($name) {
		return constant($name);
	}
	/**
	 * ユーザーを登録
	 * @param  [type] $user [description]
	 * @return [type]       [description]
	 */
	public function registerUser($user) {
		if (empty($user)) {
			return false;
		}
		$params = array(
			$user->twitter_primary_id,
			$user->twitter_id,
			$user->twitter_name,
			$user->twitter_profile_image,
			$user->twitter_profile_banner
		);
		$sql = 'CALL ' . SPIDER_DB . '.register_user(?, ?, ?, ?, ?);';
		$query = $this->db->query($sql, $params);
		$row = $query->row();
		$user_id = !empty($row->successful) ? $row->successful : false;
		return $user_id;
	}
	/**
	 * ユーザー取得
	 * @param  [type] $user_id [description]
	 * @return [type]          [description]
	 */
	public function getUser($user_id) {
		if (empty($user_id)) {
			return false;
		}
		$sql =
<<<"EOD"
	SELECT * FROM {$this->def('SPIDER_DB')}.user WHERE user_id = ?;
EOD;
		$query = $this->db->query($sql, array($user_id));
		return $query->row();
	}
	/**
	 * TwitterIDからユーザーを取得
	 * @param  [type] $twitter_id [description]
	 * @return [type]             [description]
	 */
	public function getUserFromTwitterID($twitter_id) {
		if (empty($twitter_id)) {
			return false;
		}
		$sql =
<<<"EOD"
SELECT user.*
FROM {$this->def('SPIDER_DB')}.user_tw
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = user_tw.ut_user_id
WHERE user_tw.ut_twitter_id = ?;
EOD;
		$query = $this->db->query($sql, array($twitter_id));
		return $query->row();
	}
	/**
	 * NGのIPアドレスかチェック
	 * @param  [type] $ip [description]
	 */
	public function isNgIp($ip) {
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.site_ng_ip WHERE sn_ip = ?;';
		$query = $this->db->query($sql, array($ip));
		return $query->row();
	}
	/**
	 * サイトNGワードを取得
	 */
	public function getNgWordsSite() {
		$words = array();
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.site_ng_word;';
		$query = $this->db->query($sql);
		foreach ($query->result() as $rec) {
			$words[] = $rec->snw_word;
		}
		return empty($words) ? array() : array_values(array_unique(array_filter($words, 'strlen')));
	}
	/**
	 * ユーザーNGワードを取得
	 * @param  [type] $user_id [description]
	 */
	public function getNgWords($user_id) {
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.user_ng_word WHERE unw_user_id = ?;';
		$query = $this->db->query($sql, array($user_id));
		$row = $query->row();
		return empty($row) ? array() : array_values(array_unique(array_filter(explode(' ', $row->unw_words), 'strlen')));
	}
	/**
	 * NGユーザーを取得
	 * @param  [type] $user_id    [description]
	 * @param  [type] $ng_user_id [description]
	 */
	public function isNgUser($user_id, $ng_user_id) {
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.user_ng WHERE un_user_id = ? AND un_ng_user_id = ?;';
		$query = $this->db->query($sql, array($user_id, $ng_user_id));
		return $query->row();
	}
	/**
	 * BBSテーブルを取得
	 */
	public function getSite() {
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.site LIMIT 1;';
		$query = $this->db->query($sql);
		return $query->row();
	}
	/**
	 * お知らせを取得
	 * @return [type] [description]
	 */
	public function getSiteInfomations() {
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.site_infomation WHERE si_hide = 0 ORDER BY si_datetime DESC;';
		$query = $this->db->query($sql);
		return $query->result();
	}
	/**
	 * サイト備品を取得
	 * @param  [type] $name [description]
	 */
	public function getSiteVarious($name) {
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.site_various WHERE various_name = ?;';
		$query = $this->db->query($sql, array($name));
		$row = $query->row();
		return empty($row) ? '' : $row->sv_body;
	}
	/**
	 * すべてのカテゴリを取得
	 */
	public function getAllCategories() {
		// 親を取得
		$sql = <<<EOD
SELECT * FROM category WHERE cat_parent = 0 AND cat_hide = 0 ORDER BY cat_sort;
EOD;
		$query = $this->db->query($sql);
		$categories = $query->result();
		// 子を取得
		$sql = <<<EOD
SELECT * FROM category WHERE cat_parent > 0 AND cat_hide = 0 ORDER BY cat_parent, cat_sort;
EOD;
		$query = $this->db->query($sql);
		$subs = $query->result();
		// 親と子をマージ
		if (!empty($categories) && !empty($subs)) {
			foreach ($categories as $key_c => $category) {
				$categories[$key_c]->subs = array();
				foreach ($subs as $key_s => $sub) {
					if ($category->category_id == $sub->cat_parent) {
						$categories[$key_c]->subs[] = $sub;
					}
				}
			}
		}
		return $categories;
	}
	/**
	 * すべてのメインカテゴリを取得
	 */
	public function getCategories() {
		$sql = <<<EOD
SELECT * FROM {$this->def('SPIDER_DB')}.category WHERE cat_parent = 0 AND cat_hide = 0 ORDER BY cat_sort;
EOD;
		$query = $this->db->query($sql);
		return $query->result();
	}
	/**
	 * 指定の親カテゴリに属するサブカテゴリ一覧を取得
	 * @param	[type] $parent_id [description]
	 */
	public function getSubCategories($parent_id) {
		$sql = <<<EOD
SELECT * FROM {$this->def('SPIDER_DB')}.category WHERE cat_parent = ? AND cat_hide = 0 ORDER BY cat_sort;
EOD;
		$query = $this->db->query($sql, array($parent_id));
		return $query->result();
	}
	/**
	 * 指定のURL名のカテゴリを取得
	 * @param	[type] $url_name [description]
	 */
	public function getCategoryFromUrlName($url_name) {
		$sql = <<<EOD
SELECT * FROM {$this->def('SPIDER_DB')}.category WHERE cat_url_name = ? AND cat_hide = 0;
EOD;
		$query = $this->db->query($sql, array($url_name));
		return $query->row();
	}
	/**
	 * 指定のIDのカテゴリを取得
	 * @param	[type] $category_id [description]
	 */
	public function getCategory($category_id) {
		$sql = <<<EOD
SELECT * FROM {$this->def('SPIDER_DB')}.category WHERE category_id = ? AND cat_hide = 0 ;
EOD;
		$query = $this->db->query($sql, array($category_id));
		return $query->row();
	}
	/**
	 * タグ名からタグを取得
	 * @param  [type] $word [description]
	 */
	public function getTagFromWord($word) {
		$sql =
<<<"EOD"
SELECT * FROM {$this->def('SPIDER_DB')}.tag WHERE tg_word = ? AND tg_hide = 0;
EOD;
		$query = $this->db->query($sql, array($word));
		return $query->row();
	}
	/**
	 * 非表示設定されたタグかチェック
	 * @param  [type]  $word [description]
	 */
	public function isHideTag($word) {
		$sql =
<<<"EOD"
SELECT * FROM {$this->def('SPIDER_DB')}.tag WHERE tg_word = ? AND tg_hide = 1;
EOD;
		$query = $this->db->query($sql, array($word));
		$row = $query->row();
		return empty($row) ? false : true;
	}
	/**
	 * スレッドを取得
	 * @param  [type] $thread_id [description]
	 * @return [type]            [description]
	 */
	public function getThread($thread_id, $s_user_id = null) {
		if (empty($thread_id)) {
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
		$sql =
<<<"EOD"
SELECT thread.*, user.*{$sql_column}
FROM {$this->def('SPIDER_DB')}.thread
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = thread.t_user_id
{$sql_suser}
WHERE thread.thread_id = ?;
EOD;
		$params[] = $thread_id;
		$query = $this->db->query($sql, $params);
		return $query->row();
	}
	/**
	 * スレッドを取得（ユーザー認証込み）
	 * @param  [type] $thread_id [description]
	 * @param  [type] $user_id   [description]
	 */
	public function getThreadWithUserID($thread_id, $user_id) {
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.thread WHERE thread_id = ? AND t_user_id = ?;';
		$query = $this->db->query($sql, array($thread_id, $user_id));
		return $query->row();
	}
	/**
	 * スレッド一覧を取得
	 * @param  [type] $base_id   基準ID
	 * @param  [type] $td        時間の方向
	 * @param  [type] $s_user_id セッションユーザー
	 */
	public function getThreads($base_id, $td, $s_user_id = null) {
		// 片方の値しかない場合はfalse
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
				$params[] = $base_id;
				$sql_where = " WHERE thread_id < ? AND t_privated = 0 ";
				$sql_order = " ORDER BY thread_id DESC ";
				break;

			case 'after':
				$params[] = $base_id;
				$sql_where = " WHERE thread_id > ? AND t_privated = 0 ";
				$sql_order = " ORDER BY thread_id ";
				break;

			default:
				$sql_order = " ORDER BY thread_id DESC ";
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
	 * スレッドタグを取得
	 * @param  [type] $thread_id [description]
	 * @return [type]            [description]
	 */
	public function getThreadTag($thread_id) {
		$sql =
<<<EOD
SELECT thread_tag.*, tag.*
FROM {$this->def('SPIDER_DB')}.thread_tag
INNER JOIN {$this->def('SPIDER_DB')}.tag ON tag.tag_id = thread_tag.tt_tag_id AND tag.tg_hide = 0
WHERE thread_tag.tt_thread_id = ?;
EOD;
		$query = $this->db->query($sql, array($thread_id));
		return $query->result();
	}
	/**
	 * 指定カテゴリのスレッドを取得
	 */
	public function getThreadsWithCategory($base_id, $td, $category, $s_user_id = null) {
		if (empty($category)) {
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
		$sql_where = '';
		$sql_order = '';
		$sql_category = empty($category->cat_parent) ? 't_main_category' : 't_sub_category';
		switch ($td) {
			case 'before':
				$sql_where = " WHERE thread_id < ? AND {$sql_category} = ? AND t_privated = 0 ";
				$sql_order = " ORDER BY thread_id DESC ";
				$params[] = $base_id;
				$params[] = $category->category_id;
				break;

			case 'after':
				$sql_where = " WHERE thread_id > ? AND {$sql_category} = ? AND t_privated = 0 ";
				$sql_order = " ORDER BY thread_id ";
				$params[] = $base_id;
				$params[] = $category->category_id;
				break;

			default:
				$sql_where = " WHERE {$sql_category} = ? AND t_privated = 0 ";
				$sql_order = " ORDER BY thread_id DESC ";
				$params[] = $category->category_id;
				break;
		}
		$params[] = THREAD_CONTENT_MAX;
		$sql =
<<<"EOD"
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
	 * 指定IDのコメントを取得
	 * @param  [type] $comment_id [description]
	 * @param  [type] $s_user_id  [description]
	 */
	public function getComment($comment_id, $s_user_id = null) {
		$params = array();
		if (empty($s_user_id)) {
			$params[] = $comment_id;
			$sql =
<<<"EOD"
SELECT comment.*, user.*
FROM {$this->def('SPIDER_DB')}.comment
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = comment.c_user_id
WHERE comment_id = ?;
EOD;
		} else {
			$params[] = $s_user_id;
			$params[] = $comment_id;
			$sql =
<<<"EOD"
SELECT comment.*, user.*, comment_report.*
FROM {$this->def('SPIDER_DB')}.comment
INNER JOIN {$this->def('SPIDER_DB')}.user ON user.user_id = comment.c_user_id
LEFT JOIN {$this->def('SPIDER_DB')}.comment_report ON comment_report.cr_user_id = ? AND comment_report.cr_comment_id = comment.comment_id
WHERE comment_id = ?;
EOD;
		}
		$query = $this->db->query($sql, $params);
		return $query->row();
	}
}
