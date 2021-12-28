<?php
require_once('dbh.php');

mb_language('Japanese');
mb_internal_encoding('UTF-8');
date_default_timezone_set('Asia/Tokyo');

/**
 * サイトNGワードを登録
 * @param  [type] $word [description]
 */
function insert_site_ngword(&$dbh, $word) {
	echo '[word]:' . $word . PHP_EOL;
	$sql = 'INSERT INTO site_ng_word (snw_word, snw_summary) VALUES (:snw_word, "");';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':snw_word', $word, PDO::PARAM_STR);
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

$ng_words = array(
'陰毛',
'いんもう',
'まんこ',
'クリトリス',
'ちんこ',
'肉棒',
'ザーメン',
'セックス',
'SEX',
'ＳＥＸ',
'オナニ',
'オナ二',
'クンニ',
'フェラ',
'まんぐり',
'パイズリ',
'デリヘル',
'姦',
'やりまん',
'ヤリマン',
'乱交',
'バイブ',
'ローター',
'パイパン',
'中出し',
'スカトロ',
'手コキ',
'手マン',
'潮吹',
'fuck',
'くたばれ',
'死ね',
'殺す',
'ころせ',
'[0-9]{3}-[0-9]{4}',
'[0-9]{2,4}-[0-9]{2,4}-[0-9]{3,4}',
'[0-9a-z_.?-]+@([0-9a-z-]+\.)+[0-9a-z-]+',
'ビッチ',
'ヤリチン',
'肉便器',
'爆乳',
'イラマチオ',
'ファック'
);
foreach ($ng_words as $word) {
	if (!empty($word)) {
		insert_site_ngword($dbh, $word);
	}
}
?>
