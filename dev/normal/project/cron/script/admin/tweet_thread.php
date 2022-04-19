<?php
mb_language('Japanese');
mb_internal_encoding('UTF-8');
date_default_timezone_set('Asia/Tokyo');

require_once(dirname(__FILE__) . '/../lib/dbh.php');
require_once(dirname(__FILE__) . '/../lib/site.php');
require_once(dirname(__FILE__) . '/../lib/twitteroauth/autoload.php');
use Abraham\TwitterOAuth\TwitterOAuth;

define('TWEET_COMMENT_COUNT_MIN', 3);
define('TWEET_REPORT_COUNT_MAX', 3);
if (!defined('TWEET_BODY_MAX')) {
	define('TWEET_BODY_MAX', 135);
}
define('BASE_URL', 'http://example.com/t/');
define('TWEET_PREFIX', '');
define('TWEET_SUFFIX', 'by');

/**
 * ツイート対象スレッドを1件取得
 */
function get_tweet_thread(&$dbh, $c_min, $r_max) {
	$sql = <<<EOT
SELECT * FROM thread
INNER JOIN user ON user.user_id = thread.t_user_id AND u_privilege_thread = 0
WHERE
	t_privated = 0 AND
	t_filled = 0 AND
	t_comment_count >= :t_comment_count AND
	t_report_count <= :t_report_count AND
	t_master_twitter_posted = 0
ORDER BY t_favorite_count DESC
LIMIT 1;
EOT;
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':t_comment_count', $c_min, PDO::PARAM_INT);
		$stmt->bindParam(':t_report_count', $r_max, PDO::PARAM_INT);
		$stmt->execute();
		$rec = $stmt->fetch(PDO::FETCH_ASSOC);
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	return $rec;
}
/**
 * ツイート済みスレッドを更新
 * @param  [type] $thread_id [description]
 */
function update_tweet_thread(&$dbh, $thread_id) {
	$sql = <<<EOT
UPDATE thread SET t_master_twitter_posted = 1, t_master_twitter_posted_datetime = NOW() WHERE thread_id = :thread_id;
EOT;
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':thread_id', $thread_id, PDO::PARAM_INT);
		$stmt->execute();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	return true;
}

/**
 * メイン
 */

$thread = get_tweet_thread($dbh, TWEET_COMMENT_COUNT_MIN, TWEET_REPORT_COUNT_MAX);
if (!empty($thread)) {
	echo '[対象スレッド]: ' . $thread['thread_id'] . PHP_EOL;
	print_r($thread);
	$main_count = 0;
	$tw_body = '';
	$tw_prefix = TWEET_PREFIX;
	// リプライ付きの自動投稿はTwitterルールに違反なので削除
	// $tw_suffix = ' ' . TWEET_SUFFIX . ' @' . $thread['u_twitter_id'] . "\n";
	$t_url = BASE_URL . $thread['thread_id'] . ' ';
	$t_title = htmlspecialchars_decode($thread['t_title'], ENT_QUOTES);
	$title_count = mb_strlen($t_title);
	// 文字数カウント
	$main_count += mb_strlen($tw_prefix);
	$main_count += mb_strlen($tw_suffix);
	$main_count += mb_strlen($t_url);
	$diff_num = TWEET_BODY_MAX - $main_count;
	if ($title_count > $diff_num) {
		$t_title = mb_substr($t_title, 0, $diff_num - 1);
		$t_title .= '...';
	}
	$t_title .= ' ';
	// ツイート本文
	$tw_body = $tw_prefix . $t_title . $tw_suffix . $t_url;
	echo $tw_body . PHP_EOL;
	echo '文字数: ' . mb_strlen($tw_body) . PHP_EOL;
	$connect = new TwitterOAuth(CONSUMER_KEY, CONSUMER_SECRET, WEBMASTER_ACCESS_TOKEN, WEBMASTER_ACCESS_TOKEN_SECRET);
	if (!empty($connect)) {
		$result = $connect->post('statuses/update', array('status' => $tw_body));
		var_dump($result);
		// ツイート成功
		if (!empty($result->id)) {
			echo '投稿成功！' . PHP_EOL;
			update_tweet_thread($dbh, $thread['thread_id']);
		}
	}
} else {
	echo 'ツイート対象のスレッドを取得しませんでした。' . PHP_EOL;
}

?>
