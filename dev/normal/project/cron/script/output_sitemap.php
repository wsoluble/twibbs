<?php
require_once(dirname(__FILE__) . '/lib/dbh.php');

mb_language('Japanese');
mb_internal_encoding('UTF-8');
date_default_timezone_set('Asia/Tokyo');

define('XML_FILE', '/output/sitemap.xml');
define('BASE_URL', 'http://example.com');
define('URL_MAX', 50000);

/**
 * カテゴリを出力
 * @param  [type] $dbh [description]
 * @return [type]      [description]
 */
function generate_category(&$dbh, &$count) {
	$map = '';
	$sql = 'SELECT * FROM category WHERE cat_hide = 0 ORDER BY category_id;';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->execute();
	} catch (PDOException $e) {
		// echo $e->getMessage() . PHP_EOL;
		return false;
	}
	while ($category = $stmt->fetch(PDO::FETCH_ASSOC)) {
		$map .= '<url><loc>' . BASE_URL . '/entry/' . $category['cat_url_name'] . '</loc></url>' . PHP_EOL;
		$count--;
	}
	return $map;
}
/**
 * スレッドを出力
 * @param  [type] $count [description]
 */
function generate_thread(&$dbh, &$count) {
	if (empty($count) || $count < 1) {
		return false;
	}
	$map = '';
	$sql = 'SELECT * FROM thread WHERE t_privated = 0 ORDER BY thread_id DESC LIMIT :limit_num;';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':limit_num', $count, PDO::PARAM_INT);
		$stmt->execute();
	} catch (PDOException $e) {
		// echo $e->getMessage() . PHP_EOL;
		return false;
	}
	while ($thread = $stmt->fetch(PDO::FETCH_ASSOC)) {
		$map .= '<url><loc>' . BASE_URL . '/t/' . $thread['thread_id'] . '</loc></url>' . PHP_EOL;
		$count--;
	}
	return $map;
}

/**
 * メイン
 */
$url_count = URL_MAX;

$basic_urls = array(
	BASE_URL,
	BASE_URL . '/term',
	BASE_URL . '/help',
	BASE_URL . '/rule',
	BASE_URL . '/req',
	BASE_URL . '/entry'
);

$url_count -= count($basic_urls);

$map = '<?xml version="1.0" encoding="UTF-8"?>';
$map .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . PHP_EOL;
foreach ($basic_urls as $url) {
	$map .= '<url><loc>' . $url . '</loc></url>' . PHP_EOL;
}
echo '基本URL...残り: ' . $url_count . PHP_EOL;
$map .= generate_category($dbh, $url_count);
echo 'カテゴリを出力...残り: ' . $url_count . PHP_EOL;
$map .= generate_thread($dbh, $url_count);
echo 'スレッドを...残り: ' . $url_count . PHP_EOL;
$map .= '</urlset>' . PHP_EOL;

// 書き込み
$fp = fopen(XML_FILE, 'w+');
@fwrite($fp, $map);
fclose($fp);
?>
