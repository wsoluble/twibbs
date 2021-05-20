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
	 * スレッドを登録
	 * @param  [type] $thread [description]
	 * @return [type]         [description]
	 */
	public function registerThread($thread) {
		if (empty($thread)) {
			return false;
		}
		$params = array(
			$thread->user_id,
			$thread->title,
			$thread->body,
			$thread->category_id,
			$thread->ip
		);
		$sql = 'CALL ' . SPIDER_DB . '.register_thread(?, ?, ?, ?, ?);';
		$query = $this->db->query($sql, $params);
		$row = $query->row();
		return empty($row->successful) ? null : $row->successful;
	}
	/**
	 * タグを登録
	 * @param  [type] $word [description]
	 */
	public function registerTag($word) {
		$sql = 'CALL ' . SPIDER_DB . '.register_tag(?);';
		$query = $this->db->query($sql, array($word));
		$row = $query->row();
		return empty($row->successful) ? null : $row->successful;
	}
	/**
	 * スレッドタグを登録
	 * @param  [type] $thread_id [description]
	 * @param  [type] $number    [description]
	 * @param  [type] $tag_id    [description]
	 */
	public function registerThreadTag($thread_id, $number, $tag_id) {
		$sql = 'CALL ' . SPIDER_DB . '.register_thread_tag(?, ?, ?);';
		$query = $this->db->query($sql, array($thread_id, $number, $tag_id));
		$row = $query->row();
		return empty($row->successful) ? null : $row->successful;
	}
	/**
	 * 前回のスレッド投稿時間から十分に時間が経過しているか
	 */
	public function checkIntervalThread($thread_id) {
		if (empty($thread_id)) {
			return true;
		}
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.thread WHERE thread_id = ? LIMIT 1;';
		$query = $this->db->query($sql, array($thread_id));
		$row = $query->row();
		if (empty($row)) {
			return true;
		}
		$interval = time() - strtotime($row->t_datetime);
		return ($interval >= POST_THREAD_INTERVAL) ? true : false;
	}
	/**
	 * 前方一致のタグを5件取得
	 * @param  [type] $word [description]
	 */
	public function getTagForwardmatch($word) {
		$word = preg_replace('/(%|_)/', '\\\\${1}', $word);
		$word = $word . '%';
		$sql = 'SELECT * FROM ' . SPIDER_DB . '.tag WHERE tg_word LIKE ? AND tg_hide = 0 ORDER BY tg_thread_count DESC LIMIT 10;';
		$query = $this->db->query($sql, array($word));
		return $query->result();
	}
}
