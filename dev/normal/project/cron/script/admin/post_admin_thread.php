<?php
require_once(dirname(__FILE__) . '/../lib/dbh.php');

mb_language('Japanese');
mb_internal_encoding('UTF-8');
date_default_timezone_set('Asia/Tokyo');

/**
 * スレッドを登録
 * @param  [type] $thread [description]
 * @return [type]         [description]
 */
function register_thread(&$dbh, $thread) {
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
	$sql = 'CALL register_thread(?, ?, ?, ?, ?);';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->execute($params);
		$row = $stmt->fetch(PDO::FETCH_ASSOC);
	} catch (PDOException $e) {
		return false;
	}
	return empty($row['successful']) ? null : $row['successful'];
}

/**
 * タグを登録
 * @param  [type] $word [description]
 */
function register_tag(&$dbh, $word) {
	$params = array(
		$word
	);
	$sql = 'CALL register_tag(?);';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->execute($params);
		$row = $stmt->fetch(PDO::FETCH_ASSOC);
	} catch (PDOException $e) {
		return false;
	}
	return empty($row['successful']) ? null : $row['successful'];
}

/**
 * スレッドタグを登録
 * @param  [type] $thread_id [description]
 * @param  [type] $number    [description]
 * @param  [type] $tag_id    [description]
 */
function register_thread_tag(&$dbh, $thread_id, $number, $tag_id) {
	$params = array(
		$thread_id,
		$number,
		$tag_id
	);
	$sql = 'CALL register_thread_tag(?, ?, ?);';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->execute($params);
		$row = $stmt->fetch(PDO::FETCH_ASSOC);
	} catch (PDOException $e) {
		return false;
	}
	return empty($row['successful']) ? null : $row['successful'];
}

/**
 * スレッドを投稿する処理
 * @param  [type] $admin_thread 管理スレッド
 */
function post_thread(&$dbh, $admin_thread) {
	if (empty($admin_thread)) {
		return 0;
	}
	$thread = new stdClass;
	$thread->user_id = $admin_thread['at_user_id'];
	$thread->title = $admin_thread['at_title'];
	$thread->body = $admin_thread['at_body'];
	$thread->category_id = $admin_thread['at_category'];
	$thread->ip = '66.249.82.126';
	$thread->tags = explode(' ', $admin_thread['at_tag']);
	// スレッドを登録
	$i_thread_id = register_thread($dbh, $thread);
	if (!empty($i_thread_id)) {
		$tag_num = 1;
		foreach ($thread->tags as $tag) {
			$i_tag_id = register_tag($dbh, $tag);
			register_thread_tag($dbh, $i_thread_id, $tag_num, $i_tag_id);
			$tag_num++;
		}
	}
	return empty($i_thread_id) ? 0 : $i_thread_id;
}

/**
 * 管理スレッドの状態を更新
 * @param  [type] $admin_thread_id 管理スレッドID
 * @param  [type] $thread_id       スレッドID
 */
function update_admin_thread(&$dbh, $admin_thread_id, $thread_id) {
	if (empty($admin_thread_id)) {
		return false;
	}
	$sql = 'UPDATE admin_thread SET at_thread_id = :at_thread_id, at_status = 2 WHERE admin_thread_id = :admin_thread_id;';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':at_thread_id', $thread_id, PDO::PARAM_INT);
		$stmt->bindParam(':admin_thread_id', $admin_thread_id, PDO::PARAM_INT);
		$stmt->execute();
	} catch (PDOException $e) {
		return false;
	}
	return true;
}

/**
 * コメント登録
 * @param  [type] $comment [description]
 */
function register_comment(&$dbh, $comment) {
	if (empty($comment)) {
		return false;
	}
	$params = array(
		$comment->thread_id,
		$comment->user_id,
		$comment->body,
		$comment->ip
	);
	$sql = 'CALL register_comment(?, ?, ?, ?);';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->execute($params);
		$row = $stmt->fetch(PDO::FETCH_ASSOC);
	} catch (PDOException $e) {
		return false;
	}
	return empty($row['successful']) ? 0 : $row['successful'];
}

/**
 * 管理コメントを更新
 * @param  [type] $admin_comment_id [description]
 * @param  [type] $comment_id       [description]
 */
function update_admin_comment(&$dbh, $admin_comment_id, $comment_id) {
	if (empty($admin_comment_id)) {
		return false;
	}
	$sql = 'UPDATE admin_comment SET ac_comment_id = :ac_comment_id WHERE admin_comment_id = :admin_comment_id;';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':ac_comment_id', $comment_id, PDO::PARAM_INT);
		$stmt->bindParam(':admin_comment_id', $admin_comment_id, PDO::PARAM_INT);
		$stmt->execute();
	} catch (PDOException $e) {
		return false;
	}
	return true;
}

/**
 * メイン
 */

$now_dt = date('Y-m-d H:i:s', time());
echo '#----------------------------------------------------------------' . PHP_EOL;
echo '# 現在の時間' . $now_dt . PHP_EOL;
echo '#----------------------------------------------------------------' . PHP_EOL;

//-------------------------------------
// 管理スレッドの投稿
//-------------------------------------
// 現在時刻より過去で予約状態の管理スレッドを対象
$sql = <<<EOT
SELECT * FROM admin_thread WHERE at_status = 1 AND at_datetime <= :at_datetime ORDER BY at_datetime;
EOT;
try {
	$stmt = $dbh->prepare($sql);
	$stmt->bindParam(':at_datetime', $now_dt, PDO::PARAM_STR);
	$stmt->execute();
} catch (PDOException $e) {
	echo $e->getMessage() . PHP_EOL;
	exit();
}
echo '#----------------------------------------------------------------' . PHP_EOL;
echo '# 管理スレッド投稿' . PHP_EOL;
echo '#----------------------------------------------------------------' . PHP_EOL;
while ($admin_thread = $stmt->fetch(PDO::FETCH_ASSOC)) {
	$posted_thread_id = 0;
	$posted_thread_id = post_thread($dbh, $admin_thread);
	update_admin_thread($dbh, $admin_thread['admin_thread_id'], $posted_thread_id);
	echo 'atid[' . $admin_thread['admin_thread_id'] . '] dt:[' . $admin_thread['at_datetime'] . '] ' . PHP_EOL;
}

//-------------------------------------
// 管理コメントの投稿
//-------------------------------------
// 管理スレッドが投稿済み状態＆現在時刻より過去のコメントを対象
$sql = <<<EOT
SELECT admin_comment.*, admin_thread.*
FROM admin_comment
INNER JOIN admin_thread ON admin_thread.admin_thread_id = admin_comment.ac_admin_thread_id AND admin_thread.at_thread_id IS NOT NULL AND admin_thread.at_status = 2
INNER JOIN thread ON thread.thread_id = admin_thread.at_thread_id AND thread.t_filled = 0 AND thread.t_privated = 0
WHERE admin_comment.ac_datetime <= :ac_datetime AND admin_comment.ac_comment_id IS NULL
ORDER BY admin_comment.ac_datetime;
EOT;
try {
	$stmt = $dbh->prepare($sql);
	$stmt->bindParam(':ac_datetime', $now_dt, PDO::PARAM_STR);
	$stmt->execute();
} catch (PDOException $e) {
	echo $e->getMessage() . PHP_EOL;
	exit();
}
echo '#----------------------------------------------------------------' . PHP_EOL;
echo '# 管理コメント投稿' . PHP_EOL;
echo '#----------------------------------------------------------------' . PHP_EOL;
while ($admin_comment = $stmt->fetch(PDO::FETCH_ASSOC)) {
	echo 'atid[' . $admin_comment['admin_thread_id'] . '] acid[' . $admin_comment['admin_comment_id'] . '] dt:[' . $admin_comment['ac_datetime'] . '] ' . PHP_EOL;
	// 管理スレッドが投稿されている場合
	if (!empty($admin_comment['at_thread_id'])) {
		$posted_comment_id = 0;
		$comment = new stdClass;
		$comment->thread_id = $admin_comment['at_thread_id'];
		$comment->user_id = $admin_comment['ac_user_id'];
		$comment->body = $admin_comment['ac_body'];
		$comment->ip = '66.249.82.126';
		$posted_comment_id = register_comment($dbh, $comment);
		update_admin_comment($dbh, $admin_comment['admin_comment_id'], $posted_comment_id);
	}
}

?>
