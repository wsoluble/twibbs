<?php
require_once(dirname(__FILE__) . '/lib/dbh.php');
mb_language('Japanese');
mb_internal_encoding('UTF-8');
date_default_timezone_set('Asia/Tokyo');

function insert_category(&$dbh, $category) {
	$parent = 0;
	echo '[word]:' . $category['word'] . ' [url_name]:' . $category['url_name'] . ' [parent]:' . $parent . ' [sort]:' . $category['sort'] . PHP_EOL;
	$sql = 'CALL ' . DB_NAME . '.register_category(:cat_word, :cat_url_name, :cat_parent, :cat_sort, "");';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':cat_word', $category['word'], PDO::PARAM_STR);
		$stmt->bindParam(':cat_url_name', $category['url_name'], PDO::PARAM_STR);
		$stmt->bindParam(':cat_parent', $parent, PDO::PARAM_INT);
		$stmt->bindParam(':cat_sort', $category['sort'], PDO::PARAM_INT);
		$stmt->execute();
		$rec = $stmt->fetch(PDO::FETCH_ASSOC);
		$stmt->closeCursor();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	// 挿入されたカテゴリのIDを取得
	if (!empty($rec['successful'])) {
		$parent = $rec['successful'];
	}
	if (!empty($category['subs']) && !empty($parent)) {
		$subs = $category['subs'];
		$sort = 1;
		foreach ($subs as $sub) {
			echo '[word]:' . $sub['word'] . ' [url_name]:' . $sub['url_name'] . ' [parent]:' . $parent . ' [sort]:' . $sort . PHP_EOL;
			$sql = 'CALL ' . DB_NAME . '.register_category(:cat_word, :cat_url_name, :cat_parent, :cat_sort, "");';
			try {
				$stmt = $dbh->prepare($sql);
				$stmt->bindParam(':cat_word', $sub['word'], PDO::PARAM_STR);
				$stmt->bindParam(':cat_url_name', $sub['url_name'], PDO::PARAM_STR);
				$stmt->bindParam(':cat_parent', $parent, PDO::PARAM_INT);
				$stmt->bindParam(':cat_sort', $sort, PDO::PARAM_INT);
				$stmt->execute();
				$stmt->closeCursor();
			} catch (PDOException $e) {
				echo $e->getMessage() . PHP_EOL;
				return false;
			}
			$sort++;
		}
	}
}


$main = array();

$sub = array();
$sub[] = array('word' => 'AA・顔文字', 'url_name' => 'chat_aa');
$sub[] = array('word' => '裏ワザ', 'url_name' => 'chat_trick');
$sub[] = array('word' => '悩み', 'url_name' => 'chat_trouble');
$sub[] = array('word' => '日記', 'url_name' => 'chat_diary');
$sub[] = array('word' => '拾いもの', 'url_name' => 'chat_pickup');
$main[] = array('word' => '雑談', 'url_name' => 'chat', 'sort' => 1, 'subs' => $sub);

$sub = array();
$sub[] = array('word' => 'アニメキャラ', 'url_name' => 'paint_achar');
$sub[] = array('word' => 'ゲームキャラ', 'url_name' => 'paint_gchar');
$sub[] = array('word' => 'オリジナル', 'url_name' => 'paint_original');
$sub[] = array('word' => '偉人', 'url_name' => 'paint_gman');
$sub[] = array('word' => '自然・風景', 'url_name' => 'paint_landscape');
$main[] = array('word' => 'お絵かき', 'url_name' => 'paint', 'sort' => 2, 'subs' => $sub);

$sub = array();
$sub[] = array('word' => 'アニソン', 'url_name' => 'sing_asong');
$sub[] = array('word' => 'ゲーソン', 'url_name' => 'sing_gsong');
$sub[] = array('word' => 'オリジナル', 'url_name' => 'sing_original');
$main[] = array('word' => '歌ってみた', 'url_name' => 'sing', 'sort' => 3, 'subs' => $sub);

$sub = array();
$sub[] = array('word' => '同人ゲーム', 'url_name' => 'derived_game');
$sub[] = array('word' => '同人音楽', 'url_name' => 'derived_music');
$sub[] = array('word' => 'コスプレ', 'url_name' => 'derived_cosplay');
$main[] = array('word' => '二次創作', 'url_name' => 'derived', 'sort' => 4, 'subs' => $sub);

$sub = array();
$sub[] = array('word' => '新作', 'url_name' => 'anime_new');
$sub[] = array('word' => 'TV放送中', 'url_name' => 'anime_onair');
$sub[] = array('word' => 'OVA', 'url_name' => 'anime_ova');
$sub[] = array('word' => '劇場版', 'url_name' => 'anime_movie');
$sub[] = array('word' => '声優', 'url_name' => 'anime_vactor');
$main[] = array('word' => 'アニメ', 'url_name' => 'anime', 'sort' => 5, 'subs' => $sub);

$sub = array();
$sub[] = array('word' => '週刊', 'url_name' => 'comic_magw');
$sub[] = array('word' => '月刊', 'url_name' => 'comic_magm');
$sub[] = array('word' => 'WEB漫画', 'url_name' => 'comic_web');
$main[] = array('word' => '漫画', 'url_name' => 'comic', 'sort' => 6, 'subs' => $sub);

$sub = array();
$sub[] = array('word' => '現代', 'url_name' => 'novel_modern');
$sub[] = array('word' => '推理', 'url_name' => 'novel_mystery');
$sub[] = array('word' => '歴史・時代', 'url_name' => 'novel_history');
$sub[] = array('word' => 'ライトノベル', 'url_name' => 'novel_light');
$sub[] = array('word' => 'SF', 'url_name' => 'novel_sfiction');
$sub[] = array('word' => 'ホラー', 'url_name' => 'novel_horror');
$sub[] = array('word' => 'ノンフィクション', 'url_name' => 'novel_nonfiction');
$main[] = array('word' => '小説', 'url_name' => 'novel', 'sort' => 7, 'subs' => $sub);

$sub = array();
$sub[] = array('word' => '料理', 'url_name' => 'hobby_cooking');
$sub[] = array('word' => '旅行', 'url_name' => 'hobby_travel');
$sub[] = array('word' => 'スポーツ', 'url_name' => 'hobby_sports');
$sub[] = array('word' => '動物', 'url_name' => 'hobby_animal');
$sub[] = array('word' => '植物', 'url_name' => 'hobby_plant');
$main[] = array('word' => '趣味', 'url_name' => 'hobby', 'sort' => 8, 'subs' => $sub);

$sub = array();
$sub[] = array('word' => '新作', 'url_name' => 'game_new');
$sub[] = array('word' => 'コンシューマ', 'url_name' => 'game_consumer');
$sub[] = array('word' => 'ソーシャル', 'url_name' => 'game_social');
$sub[] = array('word' => 'オンライン', 'url_name' => 'game_online');
$sub[] = array('word' => 'ブラウザ・Flash', 'url_name' => 'game_browser');
$sub[] = array('word' => 'レトロ', 'url_name' => 'game_retro');
$sub[] = array('word' => '海外', 'url_name' => 'game_foreign');
$main[] = array('word' => 'ゲーム', 'url_name' => 'game', 'sort' => 9, 'subs' => $sub);

$sub = array();
$sub[] = array('word' => 'ブログ', 'url_name' => 'net_blog');
$sub[] = array('word' => 'SNS', 'url_name' => 'net_sns');
$sub[] = array('word' => '動画', 'url_name' => 'net_movie');
$sub[] = array('word' => '画像', 'url_name' => 'net_picture');
$main[] = array('word' => 'インターネット', 'url_name' => 'net', 'sort' => 10, 'subs' => $sub);

$sub = array();
$sub[] = array('word' => '動画制作', 'url_name' => 'vtech_pvideo');
$sub[] = array('word' => 'DTM', 'url_name' => 'vtech_dtm');
$sub[] = array('word' => 'ゲーム制作', 'url_name' => 'vtech_pgame');
$main[] = array('word' => '映像・音声', 'url_name' => 'vtech', 'sort' => 11, 'subs' => $sub);

$sub = array();
$sub[] = array('word' => 'スマホ', 'url_name' => 'mobile_sphone');
$sub[] = array('word' => 'タブレット', 'url_name' => 'mobile_tablet');
$sub[] = array('word' => 'ガラケー', 'url_name' => 'mobile_fphone');
$main[] = array('word' => 'モバイル', 'url_name' => 'mobile', 'sort' => 12, 'subs' => $sub);

$sub = array();
$sub[] = array('word' => 'ハードウェア', 'url_name' => 'pc_hardware');
$sub[] = array('word' => 'OS', 'url_name' => 'pc_os');
$sub[] = array('word' => 'アプリ', 'url_name' => 'pc_app');
$sub[] = array('word' => 'ブラウザ', 'url_name' => 'pc_browser');
$sub[] = array('word' => 'プログラミング', 'url_name' => 'pc_programming');
$main[] = array('word' => 'パソコン', 'url_name' => 'pc', 'sort' => 13, 'subs' => $sub);

foreach ($main as $cate) {
	insert_category($dbh, $cate);
}

?>
