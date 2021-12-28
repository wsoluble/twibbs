<?php
require_once(dirname(__FILE__) . '/lib/dbh.php');
mb_language('Japanese');
mb_internal_encoding('UTF-8');
date_default_timezone_set('Asia/Tokyo');

function insert_tag(&$dbh, $tag) {
	$parent = 0;
	echo '[word]:' . $tag['word'] . PHP_EOL;
	$sql = 'CALL ' . DB_NAME . '.register_tag(:word);';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':word', $tag['word'], PDO::PARAM_STR);
		$stmt->execute();
		$rec = $stmt->fetch(PDO::FETCH_ASSOC);
		$stmt->closeCursor();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	return empty($rec['successful']) ? false : $rec['successful'];
}
function get_tag_words(){
	$rows = array();
	if (($csv_handle = fopen('Noun.adjv.csv', 'r')) !== FALSE) {
		while (($csv_data = fgetcsv($csv_handle, 0, ',')) !== FALSE) {
			if (!empty($csv_data[0])) {
				$rows[] = $csv_data[0];
			}
		}
	} else {
		echo '単語データcsvファイルの読み込みに失敗しました...' . PHP_EOL;
		return false;
	}
	fclose($csv_handle);
	return $rows;
}
//// --------------------------------
//// タグ登録（IPA単語辞書より）
//// --------------------------------
$n_tags = get_tag_words();
foreach ($n_tags as $t) {
	$tag = array('word' => $t);
	echo '辞書タグ「' . $tag['word'] . '」 ... ';
	if (!insert_tag($dbh, $tag)) {
		echo '登録失敗' . PHP_EOL;
	} else {
		echo '登録しました' . PHP_EOL;
	}
}
	/*
	$csv_RowMax = 0;
	$csv_Records = array();
	if (($csv_handle = fopen('Noun.adjv.csv', 'r')) !== FALSE) {
		while (($csv_data = fgetcsv($csv_handle, 0, ',')) !== FALSE) {
			$csv_Records[] = $csv_data[0];
			//echo '[' . $csv_row . ']' . $csv_data[0] . PHP_EOL;
			$prepare = 'INSERT IGNORE INTO ' . $db_table_Tags_Tag .
					   ' (RegDate, Word, TagType, UrlName)' .
					   ' VALUES(?, ?, 0, NULL);';
			if ($stmt = $mysqli->prepare($prepare)) {
				$stmt->bind_param('ss', $RegDate, $csv_data[0]);
				$result = $stmt->execute();
				if(!$result){
					error_log('[' . $mysqli->errno . '] ... ' . $mysqli->error, 0);
				}
			} else {
				error_log('[' . $mysqli->errno . '] ... ' . $mysqli->error, 0);
			}
			$stmt->close();
			$csv_RowMax++;
		}
	} else {
		echo '単語データcsvファイルの読み込みに失敗しました...' . PHP_EOL;
		exit();
	}
	fclose($csv_handle);
	*/
	// --------------------------------------
	// DBコネクション（閉じ）
	// --------------------------------------
	unset($db);
?>
