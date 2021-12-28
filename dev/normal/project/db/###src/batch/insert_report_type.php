<?php
require_once('dbh.php');

mb_language('Japanese');
mb_internal_encoding('UTF-8');
date_default_timezone_set('Asia/Tokyo');

/**
 * サイトNGワードを登録
 * @param  [type] $word [description]
 */
function insert_report_type(&$dbh, $report_type) {
	var_dump($report_type);
	if (empty($report_type['rt_name'])) {
		return false;
	}
	$sql = 'INSERT INTO report_type (rt_name, rt_body) VALUES (:rt_name, :rt_body);';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':rt_name', $report_type['rt_name'], PDO::PARAM_STR);
		$stmt->bindParam(':rt_body', $report_type['rt_body'], PDO::PARAM_STR);
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

$report_types = array();

$rt = array();
$rt['rt_name'] = 'その他';
$rt['rt_body'] = <<<EOT
<p>その他の利用規約に違反する行為、またはコンテンツの投稿</p>
EOT;
$report_types[] = $rt;

$rt = array();
$rt['rt_name'] = '荒らし';
$rt['rt_body'] = <<<EOT
<ol>
<li>同じ内容の連続的な投稿</li>
<li>カテゴリルールに沿わない投稿</li>
<li>スレッドの趣旨とは関係のない投稿</li>
</ol>
EOT;
$report_types[] = $rt;

$rt = array();
$rt['rt_name'] = '著作権';
$rt['rt_body'] = <<<EOT
<ol>
<li>他サイトの記事の転載</li>
<li>歌詞の転載</li>
<li>書籍の転載</li>
</ol>
<p>画像や動画の埋め込みに関しては、埋め込みを提供するサイトにお問い合わせください。当サイトは画像や動画を投稿する機能は提供しておりません。</p>
EOT;
$report_types[] = $rt;

$rt = array();
$rt['rt_name'] = '児童ポルノ・アダルト・グロテスク';
$rt['rt_body'] = <<<EOT
<ol>
<li>未成年の顔が写っている画像や映像</li>
<li>過激で猥褻な文字表現</li>
<li>過激で猥褻な画像・動画へのリンクや埋め込み</li>
</ol>
EOT;
$report_types[] = $rt;

$rt = array();
$rt['rt_name'] = '個人情報・プライバシー';
$rt['rt_body'] = <<<EOT
<p>実在する個人に結びつく以下の情報を含むコンテンツ</p>
<ol>
<li>住所</li>
<li>氏名</li>
<li>電話番号</li>
<li>メールアドレス</li>
</ol>
EOT;
$report_types[] = $rt;

$rt = array();
$rt['rt_name'] = '出会い・待ち合わせ';
$rt['rt_body'] = <<<EOT
<p>出会いを目的とした利用</p>
<ol>
<li>待ち合わせ場所の掲示</li>
<li>住所、電話番号、メールアドレスなどの個人を特定する情報の掲載</li>
</ol>
EOT;
$report_types[] = $rt;

$rt = array();
$rt['rt_name'] = '罵倒・誹謗中傷';
$rt['rt_body'] = <<<EOT
<p>実在する個人・組織・民族への罵倒や誹謗中傷、または客観的な事実が示されない批判</p>
EOT;
$report_types[] = $rt;

$rt = array();
$rt['rt_name'] = '犯罪・自殺';
$rt['rt_body'] = <<<EOT
<p>犯罪や自殺の助長・賞賛・自慢</p>
EOT;
$report_types[] = $rt;

foreach ($report_types as $rt) {
	insert_report_type($dbh, $rt);
}
?>
