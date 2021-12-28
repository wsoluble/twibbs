<?php
require_once(dirname(__FILE__) . '/lib/dbh.php');

mb_language('Japanese');
mb_internal_encoding('UTF-8');
date_default_timezone_set('Asia/Tokyo');

define('BASE_URL', 'http://example.com');
define('RSS_EXTENSION', 'xml');
define('RSS_DIR', '/output/rss/');
define('CONTENT_MAX', 100);

/**
 * 総合エントリ
 */
function generate_entry_item(&$dbh) {
	$limit_num = CONTENT_MAX;
	$sql = <<<EOT
SELECT thread.*, user.*
FROM thread
INNER JOIN user ON user.user_id = thread.t_user_id
WHERE thread.t_privated = 0
ORDER BY thread.thread_id DESC
LIMIT :limit_num;
EOT;
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':limit_num', $limit_num, PDO::PARAM_INT);
		$stmt->execute();
	} catch (PDOException $e) {
		// echo $e->getMessage() . PHP_EOL;
		return false;
	}
	$rss = '';
	while ($thread = $stmt->fetch(PDO::FETCH_ASSOC)) {
		$date_rss = date(DATE_RSS, strtotime($thread['t_datetime']));
		$body = <<<EOT
<div>
<h1>はじめの発言 by <a href="https://twitter.com/{$thread['u_twitter_id']}">@{$thread['u_twitter_id']}</a></h1>
<p>{$thread['t_body']}</p>
</div>
EOT;
		$rss .= '<item>' . PHP_EOL;
		$rss .= '<title>' . $thread['t_title'] . '</title>' . PHP_EOL;
		$rss .= '<link>' . BASE_URL . '/t/' . $thread['thread_id'] . '</link>' . PHP_EOL;
		$rss .= '<guid isPermaLink="true">' . BASE_URL . '/t/' . $thread['thread_id'] . '</guid>' . PHP_EOL;
		$rss .= '<pubDate>' . $date_rss . '</pubDate>' . PHP_EOL;
		$rss .= '<description><![CDATA[' . $body . ']]></description>' . PHP_EOL;
		$rss .= '</item>' . PHP_EOL;
	}
	return $rss;
}
/**
 * カテゴリを出力
 * @param  [type] $dbh [description]
 * @return [type]      [description]
 */
function generate_category_item(&$dbh, $category) {
	$limit_num = CONTENT_MAX;
	$sql_category = empty($category['cat_parent']) ? 't_main_category' : 't_sub_category';
	$sql = <<<EOT
SELECT thread.*, user.*
FROM thread
INNER JOIN user ON user.user_id = thread.t_user_id
WHERE thread.{$sql_category} = :category_id AND thread.t_privated = 0
ORDER BY thread.thread_id DESC
LIMIT :limit_num;
EOT;
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':category_id', $category['category_id'], PDO::PARAM_INT);
		$stmt->bindParam(':limit_num', $limit_num, PDO::PARAM_INT);
		$stmt->execute();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	$rss = '';
	while ($thread = $stmt->fetch(PDO::FETCH_ASSOC)) {
		$date_rss = date(DATE_RSS, strtotime($thread['t_datetime']));
		$body = <<<EOT
<div>
<h1>はじめの発言 by <a href="https://twitter.com/{$thread['u_twitter_id']}">@{$thread['u_twitter_id']}</a></h1>
<p>{$thread['t_body']}</p>
</div>
EOT;
		$rss .= '<item>' . PHP_EOL;
		$rss .= '<title>' . $thread['t_title'] . '</title>' . PHP_EOL;
		$rss .= '<link>' . BASE_URL . '/t/' . $thread['thread_id'] . '</link>' . PHP_EOL;
		$rss .= '<guid isPermaLink="true">' . BASE_URL . '/t/' . $thread['thread_id'] . '</guid>' . PHP_EOL;
		$rss .= '<pubDate>' . $date_rss . '</pubDate>' . PHP_EOL;
		$rss .= '<description><![CDATA[' . $body . ']]></description>' . PHP_EOL;
		$rss .= '</item>' . PHP_EOL;
	}
	return $rss;
}

/**
 * メイン
 */

$now = date('Y-m-d H:i:s');
$now_rss = date(DATE_RSS, strtotime($now));


// 総合エントリ
$rss = '';
$rss .= '<?xml version="1.0" encoding="UTF-8"?>' . PHP_EOL;
$rss .= '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">' . PHP_EOL;
$rss .= '<channel>' . PHP_EOL;
$rss .= '<title>総合エントリ</title>' . PHP_EOL;
$rss .= '<link>' . BASE_URL . '/entry</link>' . PHP_EOL;
$rss .= '<atom:link rel="self" type="application/rss+xml" href="' . BASE_URL . '/rss/all.' . RSS_EXTENSION . '"/>' . PHP_EOL;
$rss .= '<description>全てのカテゴリを含む新しいスレッド</description>' . PHP_EOL;
$rss .= '<pubDate>' . $now_rss . '</pubDate>' . PHP_EOL;
$rss .= '<lastBuildDate>' . $now_rss . '</lastBuildDate>' . PHP_EOL;
$rss .= '<generator>textroom</generator>' . PHP_EOL;
$rss .= '<language>ja-jp</language>' . PHP_EOL;
$rss .= generate_entry_item($dbh);
$rss .= '</channel>' . PHP_EOL;
$rss .= '</rss>' . PHP_EOL;
// 書き込み
$fp = fopen(RSS_DIR . 'all.' . RSS_EXTENSION, 'w+');
@fwrite($fp, $rss);
fclose($fp);

$sql = 'SELECT * FROM category WHERE cat_hide = 0 ORDER BY category_id;';
try {
	$stmt = $dbh->prepare($sql);
	$stmt->execute();
} catch (PDOException $e) {
	// echo $e->getMessage() . PHP_EOL;
	return false;
}

// カテゴリでループ
$rss = '';
while ($category = $stmt->fetch(PDO::FETCH_ASSOC)) {
	$cat_word = htmlspecialchars($category['cat_word'], ENT_QUOTES);
	$rss = '';
	$rss .= '<?xml version="1.0" encoding="UTF-8"?>' . PHP_EOL;
	$rss .= '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">' . PHP_EOL;
	$rss .= '<channel>' . PHP_EOL;
	$rss .= '<title>エントリ - カテゴリ：' . $cat_word . '</title>' . PHP_EOL;
	$rss .= '<link>' . BASE_URL . '/entry/' . $category['cat_url_name'] . '</link>' . PHP_EOL;
	$rss .= '<atom:link rel="self" type="application/rss+xml" href="' . BASE_URL . '/rss/' . $category['cat_url_name'] . '.' . RSS_EXTENSION . '"/>' . PHP_EOL;
	$rss .= '<description>「' . $cat_word . '」カテゴリの新しいスレッド</description>' . PHP_EOL;
	$rss .= '<pubDate>' . $now_rss . '</pubDate>' . PHP_EOL;
	$rss .= '<lastBuildDate>' . $now_rss . '</lastBuildDate>' . PHP_EOL;
	$rss .= '<generator>textroom</generator>' . PHP_EOL;
	$rss .= '<language>ja-jp</language>' . PHP_EOL;
	$rss .= generate_category_item($dbh, $category);
	$rss .= '</channel>' . PHP_EOL;
	$rss .= '</rss>' . PHP_EOL;
	// 書き込み
	$fp = fopen(RSS_DIR . $category['cat_url_name'] . '.' . RSS_EXTENSION, 'w+');
	@fwrite($fp, $rss);
	fclose($fp);
}
?>
