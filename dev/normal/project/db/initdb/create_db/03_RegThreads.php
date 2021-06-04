<?php
require_once(dirname(__FILE__) . '/dbconnect.php');
mb_language('Japanese');
mb_internal_encoding('UTF-8');
date_default_timezone_set('Asia/Tokyo');

function get_thread_title_samples(&$dbh) {
	$sql = 'SELECT * FROM ' . DB_NAME_SAMPLES . '._sample_thread_title;';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->execute();
		$rec = $stmt->fetchAll(PDO::FETCH_ASSOC);
		$stmt->closeCursor();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	return empty($rec) ? false : $rec;
}
function get_comment_text_samples(&$dbh) {
	$sql = 'SELECT * FROM ' . DB_NAME_SAMPLES . '._sample_comment_text;';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->execute();
		$rec = $stmt->fetchAll(PDO::FETCH_ASSOC);
		$stmt->closeCursor();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	return empty($rec) ? false : $rec;
}
function get_user_max(&$dbh) {
	$sql = 'SELECT user_id FROM ' . DB_NAME . '.user ORDER BY user_id DESC LIMIT 1;';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->execute();
		$rec = $stmt->fetch(PDO::FETCH_ASSOC);
		$stmt->closeCursor();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	return empty($rec['user_id']) ? false : $rec['user_id'];
}
function get_all_categories(&$dbh) {
	$sql = 'SELECT * FROM ' . DB_NAME . '.category;';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->execute();
		$rec = $stmt->fetchAll(PDO::FETCH_ASSOC);
		$stmt->closeCursor();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	return empty($rec) ? false : $rec;
}
function get_all_tags(&$dbh) {
	$sql = 'SELECT * FROM ' . DB_NAME . '.tag;';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->execute();
		$rec = $stmt->fetchAll(PDO::FETCH_ASSOC);
		$stmt->closeCursor();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	return empty($rec) ? false : $rec;
}
function insert_thread(&$dbh, $user_id, $title, $body, $category_id) {

	if (isset($_SERVER['REMOTE_ADDR'])) {
		$ip = htmlspecialchars($_SERVER['REMOTE_ADDR'], ENT_QUOTES);
	} else {
		$ip = '';
	}

	$sql = 'CALL ' . DB_NAME . '.register_thread(:user_id, :title, :body, :category_id, :ip);';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
		$stmt->bindParam(':title', $title, PDO::PARAM_STR);
		$stmt->bindParam(':body', $body, PDO::PARAM_STR);
		$stmt->bindParam(':category_id', $category_id, PDO::PARAM_INT);
		$stmt->bindParam(':ip', $ip, PDO::PARAM_STR);
		$stmt->execute();
		$rec = $stmt->fetch(PDO::FETCH_ASSOC);
		$stmt->closeCursor();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	// error
	if (empty($rec['successful'])) {
		echo "inputs: $user_id, $title, $body, $category_id" . PHP_EOL;
		echo "result:" . PHP_EOL;
		var_dump($rec);
	}
	return empty($rec['successful']) ? false : $rec['successful'];
}
function insert_thread_tag(&$dbh, $thread_id, $number, $tag_id) {
	$sql = 'CALL ' . DB_NAME . '.register_thread_tag(:thread_id, :number, :tag_id);';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':thread_id', $thread_id, PDO::PARAM_INT);
		$stmt->bindParam(':number', $number, PDO::PARAM_INT);
		if ($tag_id == null) {
			$stmt->bindParam(':tag_id', $tag_id, PDO::PARAM_NULL);
		} else {
			$stmt->bindParam(':tag_id', $tag_id, PDO::PARAM_INT);
		}
		$stmt->execute();
		$rec = $stmt->fetch(PDO::FETCH_ASSOC);
		$stmt->closeCursor();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	return empty($rec['successful']) ? false : $rec['successful'];
}
function insert_comment(&$dbh, $thread_id, $user_id, $body) {
	if (isset($_SERVER['REMOTE_ADDR'])) {
		$ip = htmlspecialchars($_SERVER['REMOTE_ADDR'], ENT_QUOTES);
	} else {
		$ip = '';
	}
	$sql = 'CALL ' . DB_NAME . '.register_comment(:thread_id, :user_id, :body, :ip);';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':thread_id', $thread_id, PDO::PARAM_INT);
		$stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
		$stmt->bindParam(':body', $body, PDO::PARAM_STR);
		$stmt->bindParam(':ip', $ip, PDO::PARAM_STR);
		$stmt->execute();
		$rec = $stmt->fetch(PDO::FETCH_ASSOC);
		$stmt->closeCursor();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	return empty($rec['successful']) ? false : $rec['successful'];
}
// --------------------------------
// オプション
// --------------------------------
define('MY_THREAD_RATE', 10); //自分のスレッドのレート 1/N
define('MY_COMMENT_RATE', 50); //自分のコメントのレート 1/N

define('COMMENT_UNDER_10_RATE', 20);  //コメント10以内のレート N[%]
define('COMMENT_UNDER_50_RATE', 30);  //コメント11~50のレート N[%]
define('COMMENT_UNDER_100_RATE', 50);  //コメント51~100以内のレート N[%]
	// --------------------------------------
	// class
	// --------------------------------------
class RegThreads{
	private $add_base_thread_count = 0;
	private $user_max = null;
	private $main_tags = null;
	private $normal_tags = null;
	private $thread_title_samples = null;
	private $comment_text_samples = null;
	private $db = null;
	private $dbh = null;
	/**
	 * コンストラクラ
	 */
	function __construct(&$dbh, $Count) {
		$this->dbh = $dbh;
		$this->add_base_thread_count = $Count;
		// $this->db = new RegThreadsDB();
		// 全ユーザー数
		$this->user_max = get_user_max($this->dbh);
		if (empty($this->user_max)) {
			echo 'ユーザーが0人です...' . PHP_EOL;
			exit();
		}
		echo '全ユーザー数:' . $this->user_max . PHP_EOL;
		// メインタグ
		$this->main_tags = get_all_categories($this->dbh);
		if (empty($this->main_tags)) {
			echo 'メインタグの取得に失敗しました...' . PHP_EOL;
			exit();
		}
		echo 'メインタグ[' . count($this->main_tags) . ']を取得しました...' . PHP_EOL;
		// タグ辞書
		$this->normal_tags = get_all_tags($this->dbh);
		if (empty($this->normal_tags)) {
			echo '普通タグの取得に失敗しました...' . PHP_EOL;
			exit();
		}
		echo '普通タグ[' . count($this->normal_tags) . ']を取得しました...' . PHP_EOL;
		// スレタイサンプル
		$this->thread_title_samples = get_thread_title_samples($this->dbh);
		if (empty($this->thread_title_samples)) {
			echo 'スレタイサンプルの取得に失敗しました...' . PHP_EOL;
			exit();
		}
		echo 'スレタイサンプル[' . count($this->thread_title_samples) . ']を取得しました...' . PHP_EOL;
		// コメントサンプル
		$this->comment_text_samples = get_comment_text_samples($this->dbh);
		if (empty($this->comment_text_samples)) {
			echo 'コメントサンプルの取得に失敗しました...' . PHP_EOL;
			exit();
		}
		echo 'コメントサンプル[' . count($this->comment_text_samples) . ']を取得しました...' . PHP_EOL;
	}
	/**
	 * [addThread description]
	 */
	public function doAdd(){
		for ($i=0; $i < $this->add_base_thread_count; $i++) {
			echo '[roop:' . $i . '] ';
			$thread_user_id = $this->getRandomUserID('thread');
			$prev_thread_id = $this->addThread($thread_user_id);
		}
	}
	private function addThread($ThreadUserID){
		$title = $this->getRandomThreadTitle();
		$body = $this->getRandomCommentTexts(1);
		$category = $this->getThreadCategory();
		$tags = $this->getThreadTags();

		$new_thread_id = insert_thread($this->dbh, $ThreadUserID, $title['thread_title'], $body[0]['comment_text'], $category['category_id']);
		if (empty($new_thread_id)) {
			echo 'スレッドの追加に失敗しました...' . PHP_EOL;
			exit();
		}
		echo 'スレッドID[' . $new_thread_id . ']';

		echo ' タグ[' . count($tags) . ']...';
		for ($i=0; $i < THREAD_USING_TAG_MAX; $i++) {
			$tag_num = $i + 1;
			$result = null;
			if (isset($tags[$i])) {
				$result = insert_thread_tag($this->dbh, $new_thread_id, $tag_num, $tags[$i]['tag_id']);
			} else {
				$result = insert_thread_tag($this->dbh, $new_thread_id, $tag_num, null);
			}
			if (empty($result)) {
				echo '[' . $new_thread_id . '][' . $tag_num . '][' . $tags[$i]['tag_id'] . '] スレッド使用タグの登録に失敗しました...' . PHP_EOL;
				exit();
			}
		}
		echo 'OK';

		$this->addComments($new_thread_id);

		return $new_thread_id;
	}
	public function addComments($ThreadID){
		$comments = null;
		$c_rand = rand(1, 100);
		$comment_count = 1;
		if (0 < $c_rand && $c_rand <= COMMENT_UNDER_10_RATE) {
			$comment_count = rand(1, 10);
		} else if(COMMENT_UNDER_10_RATE < $c_rand && $c_rand <= COMMENT_UNDER_10_RATE + COMMENT_UNDER_50_RATE) {
			$comment_count = rand(11, 50);
		} else if(COMMENT_UNDER_10_RATE + COMMENT_UNDER_50_RATE < $c_rand && $c_rand <= COMMENT_UNDER_10_RATE + COMMENT_UNDER_50_RATE + COMMENT_UNDER_100_RATE) {
			$comment_count = rand(51, 100);
		}
		$comments = $this->getRandomCommentTexts($comment_count);
		echo ' コメント[' . count($comments) . ']...';
		if (!empty($comments)) {
			foreach ($comments as $c) {
				$c_user_id = $this->getRandomUserID('comment');
				$result = insert_comment($this->dbh, $ThreadID, $c_user_id, $c['comment_text']);
				if (empty($result)) {
					echo '[' . $ThreadID . '][' . $c_user_id . '] コメントの登録に失敗しました...' . PHP_EOL;
					exit();
				}
			}
		}
		echo 'OK' . PHP_EOL;
	}
	public function getRandomUserID($Type){
		$user_id = null;
		$rand = 0;
		switch ($Type) {
			case 'thread':
				$rand = rand(1, MY_THREAD_RATE);
				break;

			case 'comment':
				$rand = rand(1, MY_COMMENT_RATE);
				break;

			default:
				$rand = rand(1, MY_COMMENT_RATE);
				break;
		}
		if ($rand == 1) {
			$user_id = MY_USER_ID;
		} else {
			$user_id = rand(1, $this->user_max);
		}
		return $user_id;
	}
	public function getThreadCategory(){
		$category = null;
		//メインタグ
		$m_tag_key = array_rand($this->main_tags, 1);
		$category = $this->main_tags[$m_tag_key];
		return $category;
	}
	public function getThreadTags(){
		$tags = array();
		//メインタグ
		// $m_tag_key = array_rand($this->main_tags, 1);
		// $tags[] = $this->main_tags[$m_tag_key];
		// 普通タグ
		$n_tags = array();
		$n_tag_rand = rand(0, 10);
		for ($i=0; $i < $n_tag_rand; $i++) {
			$n_tag_key = array_rand($this->normal_tags, 1);
			$n_tag = $this->normal_tags[$n_tag_key];
			$d = true;
			foreach ($n_tags as $t) {
				if ($n_tag['tag_id'] == $t['tag_id']) {
					$d = false;
				}
			}
			if ($d == true) {
				$n_tags[] = $n_tag;
			}
		}
		foreach ($n_tags as $tag) {
			$tags[] = $tag;
		}
		return $tags;
	}
	public function getRandomThreadTitle(){
		$t_key = array_rand($this->thread_title_samples, 1);
		return $this->thread_title_samples[$t_key];
	}
	public function getRandomCommentTexts($Count){
		$comments = array();
		if ($Count > 1) {
			$t_keys = array_rand($this->comment_text_samples, $Count);
			foreach ($t_keys as $key) {
				$comments[] = $this->comment_text_samples[$key];
			}
		} else {
			$t_key = array_rand($this->comment_text_samples, $Count);
			$comments[] = $this->comment_text_samples[$t_key];
		}
		return $comments;
	}
}

// --------------------------------
// メイン
// --------------------------------
$o = new RegThreads($dbh, 1000);
$o->doAdd();
//print_r($o->getRandomUserID('thread'));
//print_r($o->getThreadTags());
//print_r($o->getRandomThreadTitle());
//print_r($o->getRandomCommentTexts(1));
//print_r($o->getRandomCommentTexts(THREAD_COMMENT_MAX));

?>
