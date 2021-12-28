<?php
require_once(dirname(__FILE__) . '/lib/dbh.php');
mb_language('Japanese');
mb_internal_encoding('UTF-8');
date_default_timezone_set('Asia/Tokyo');

function random_str($length = 8) {
	return substr(str_shuffle('1234567890abcdefghijklmnopqrstuvwxyz'), 0, $length);
}

function get_user_sample_max(&$dbh) {
	$sql = 'SELECT user_id AS cnt FROM ' . DB_NAME_SITE . '.' . TB_USER . ' ORDER BY user_id DESC LIMIT 1;';
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->execute();
		$rec = $stmt->fetch(PDO::FETCH_ASSOC);
		$stmt->closeCursor();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	return empty($rec['cnt']) ? false : $rec['cnt'];
}
function insert_user(&$dbh, $user) {
	$db_name = DB_NAME;
	$parent = 0;
	$a_token = random_str(18);
	$a_token_secret = random_str(36);
	$sql = <<<EOT
	CALL {$db_name}.register_user(:twitter_primary_id, :twitter_id, :twitter_name, :twitter_profile_image, :twitter_profile_banner, :access_token, :access_token_secret);
EOT;
	try {
		$stmt = $dbh->prepare($sql);
		$stmt->bindParam(':twitter_primary_id', $user['twitter_primary_id'], PDO::PARAM_STR);
		$stmt->bindParam(':twitter_id', $user['twitter_id'], PDO::PARAM_STR);
		$stmt->bindParam(':twitter_name', $user['twitter_name'], PDO::PARAM_STR);
		$stmt->bindParam(':twitter_profile_image', $user['twitter_profile_image'], PDO::PARAM_STR);
		$stmt->bindParam(':twitter_profile_banner', $user['twitter_profile_banner'], PDO::PARAM_STR);
		$stmt->bindParam(':access_token', $a_token, PDO::PARAM_STR);
		$stmt->bindParam(':access_token_secret', $a_token_secret, PDO::PARAM_STR);
		$stmt->execute();
		$rec = $stmt->fetch(PDO::FETCH_ASSOC);
		$stmt->closeCursor();
	} catch (PDOException $e) {
		echo $e->getMessage() . PHP_EOL;
		return false;
	}
	return empty($rec['successful']) ? false : $rec['successful'];
}
// --------------------------------------
// ユーザー情報サンプル
// --------------------------------------
$twitter_profile_image_samples = array(
	'http://pbs.twimg.com/profile_images/664272281586143232/eTjj3rWK_normal.jpg',
	'http://pbs.twimg.com/profile_images/638642502178729984/LzhXqUmb_normal.png',
	'http://pbs.twimg.com/profile_images/637220282868994048/gBw3Lv4r_normal.jpg',
	'http://pbs.twimg.com/profile_images/667258854497906688/OcHFe7MN_normal.jpg',
	'http://pbs.twimg.com/profile_images/641647520779603968/fwpK3C6F_normal.jpg',
	'http://pbs.twimg.com/profile_images/642020703265427456/c42QmgEV_normal.jpg',
	'http://pbs.twimg.com/profile_images/637603699880169472/6iI7oYta_normal.jpg',
	'http://pbs.twimg.com/profile_images/667287810269773825/lEXJ-wJk_normal.jpg',
	'http://pbs.twimg.com/profile_images/637889652397989889/we-nzo-b_normal.jpg',
	'http://pbs.twimg.com/profile_images/642305027680284672/YOuPYehs_normal.jpg',
	'http://pbs.twimg.com/profile_images/637912792461258753/EOfv5WJR_normal.jpg',
	'http://pbs.twimg.com/profile_images/637239316582825985/apDvOfFE_normal.jpg',
	'http://pbs.twimg.com/profile_images/638624263071621120/jvDJoMiV_normal.png',
	'http://pbs.twimg.com/profile_images/636467075003736064/jHJzETz4_normal.png',
	'http://pbs.twimg.com/profile_images/673787535269621760/egrXDU7w_normal.jpg',
	'http://pbs.twimg.com/profile_images/673738730310471680/VOREaFFf_normal.jpg',
	'http://pbs.twimg.com/profile_images/663612362600026112/1aUmGaNp_normal.jpg',
	'http://pbs.twimg.com/profile_images/638235830016839680/Ky0ueMUT_normal.jpg',
	'http://pbs.twimg.com/profile_images/650340506128351233/J7sFXzZJ_normal.jpg',
	'http://pbs.twimg.com/profile_images/655309685701017600/tUx32CyI_normal.jpg',
	'http://pbs.twimg.com/profile_images/649226527947644928/3c5S2Nv3_normal.png',
	'http://pbs.twimg.com/profile_images/662738478656978944/lLd2oEcK_normal.png',
	'http://pbs.twimg.com/profile_images/664280842345148416/WTN1hh8R_normal.png',
	'http://pbs.twimg.com/profile_images/643502027595776001/8kfJbMNb_normal.jpg',
	'http://pbs.twimg.com/profile_images/655260616492318720/B7WOFT8A_normal.jpg',
	'http://pbs.twimg.com/profile_images/653561790333259777/jRzdUGLg_normal.jpg',
	'http://pbs.twimg.com/profile_images/638198326718939136/ZcMRLxN-_normal.jpg',
	'http://pbs.twimg.com/profile_images/634197367604969472/jjsuNpBO_normal.png',
	'http://pbs.twimg.com/profile_images/655682440430641152/quskpR5I_normal.jpg',
	'http://pbs.twimg.com/profile_images/642292980519276544/5O5pEhJP_normal.jpg',
	'http://pbs.twimg.com/profile_images/638633932771057664/EukbhKsT_normal.png',
	'http://pbs.twimg.com/profile_images/666920629745004545/GpVx5nQB_normal.jpg',
	'http://pbs.twimg.com/profile_images/642298790431494144/3RFEZrWe_normal.jpg',
	'http://pbs.twimg.com/profile_images/638062247521091584/eSrMAXNR_normal.jpg',
	'http://pbs.twimg.com/profile_images/642287647877042176/uwAQZh9i_normal.jpg',
	'http://pbs.twimg.com/profile_images/662745907767603200/-48ODA_q_normal.jpg'
);
$twitter_profile_banner_samples = array(
	'https://pbs.twimg.com/profile_banners/4484306119/1449478633',
	'https://pbs.twimg.com/profile_banners/4482835939/1449468465',
	'https://pbs.twimg.com/profile_banners/3400720460/1443944439',
	'https://pbs.twimg.com/profile_banners/3369766818/1443765824',
	'https://pbs.twimg.com/profile_banners/3505956013/1441816148',
	'https://pbs.twimg.com/profile_banners/2989350124/1431523640',
	'https://pbs.twimg.com/profile_banners/2904414552/1450868555',
	'https://pbs.twimg.com/profile_banners/4503254052/1452687266',
	'https://pbs.twimg.com/profile_banners/2469924054/1451447666',
	'https://pbs.twimg.com/profile_banners/2560011715/1443877188',
	'https://pbs.twimg.com/profile_banners/2392209300/1454332181',
	'https://pbs.twimg.com/profile_banners/4862360533/1454657516',
	'https://pbs.twimg.com/profile_banners/3192216596/1455048119',
	'https://pbs.twimg.com/profile_banners/3814614493/1454228359',
	'https://pbs.twimg.com/profile_banners/3308528462/1451145286',
	'https://pbs.twimg.com/profile_banners/4604234352/1453531198',
	'https://pbs.twimg.com/profile_banners/4574217373/1454629451',
	'https://pbs.twimg.com/profile_banners/3799098080/1454421807',
	'https://pbs.twimg.com/profile_banners/349022521/1454930989',
	'https://pbs.twimg.com/profile_banners/3381563011/1443690436',
	'https://pbs.twimg.com/profile_banners/3049685952/1450493185',
	'https://pbs.twimg.com/profile_banners/4401077772/1448820982',
	'https://pbs.twimg.com/profile_banners/2833224325/1455430858',
	'https://pbs.twimg.com/profile_banners/2238956431/1453987304',
	'https://pbs.twimg.com/profile_banners/2989401472/1454748446',
	'https://pbs.twimg.com/profile_banners/3337698734/1450284130',
	'https://pbs.twimg.com/profile_banners/3295227037/1455552443',
	'https://pbs.twimg.com/profile_banners/313824583/1452994967',
	'https://pbs.twimg.com/profile_banners/101894718/1453216288',
	'https://pbs.twimg.com/profile_banners/180991353/1401338241',
	'https://pbs.twimg.com/profile_banners/97189322/1442994205'
);
$twitter_profile_background_image_samples = array(
	'http://abs.twimg.com/images/themes/theme1/bg.png',
	'http://abs.twimg.com/images/themes/theme2/bg.gif',
	'http://abs.twimg.com/images/themes/theme3/bg.gif',
	'http://abs.twimg.com/images/themes/theme4/bg.gif',
	'http://abs.twimg.com/images/themes/theme5/bg.gif',
	'http://abs.twimg.com/images/themes/theme6/bg.gif',
	'http://abs.twimg.com/images/themes/theme7/bg.gif',
	'http://abs.twimg.com/images/themes/theme8/bg.gif',
	'http://abs.twimg.com/images/themes/theme9/bg.gif',
	'http://abs.twimg.com/images/themes/theme10/bg.gif',
	'http://abs.twimg.com/images/themes/theme11/bg.gif',
	'http://abs.twimg.com/images/themes/theme12/bg.gif',
	'http://abs.twimg.com/images/themes/theme13/bg.gif',
	'http://abs.twimg.com/images/themes/theme14/bg.gif',
	'http://abs.twimg.com/images/themes/theme15/bg.png',
	'http://abs.twimg.com/images/themes/theme16/bg.gif',
	'http://abs.twimg.com/images/themes/theme17/bg.gif',
	'http://abs.twimg.com/images/themes/theme18/bg.gif',
	'http://abs.twimg.com/images/themes/theme19/bg.gif'
);
$twitter_color_info_samples = array(
	array('profile_background_tile' => null, 'profile_background_color' => 'C0DEED', 'profile_use_background_image' => 1, 'profile_link_color' => '0084B4', 'profile_sidebar_border_color' => 'C0DEED', 'profile_sidebar_fill_color' => 'DDEEF6', 'profile_text_color' => '333333'),
	array('profile_background_tile' => null, 'profile_background_color' => 'C6E2EE', 'profile_use_background_image' => 1, 'profile_link_color' => '1F98C7', 'profile_sidebar_border_color' => 'C6E2EE', 'profile_sidebar_fill_color' => 'DAECF4', 'profile_text_color' => '663B12'),
	array('profile_background_tile' => null, 'profile_background_color' => 'EDECE9', 'profile_use_background_image' => 1, 'profile_link_color' => '088253', 'profile_sidebar_border_color' => 'D3D2CF', 'profile_sidebar_fill_color' => 'E3E2DE', 'profile_text_color' => '634047'),
	array('profile_background_tile' => null, 'profile_background_color' => '0099B9', 'profile_use_background_image' => 1, 'profile_link_color' => '0099B9', 'profile_sidebar_border_color' => '5ED4DC', 'profile_sidebar_fill_color' => '95E8EC', 'profile_text_color' => '3C3940'),
	array('profile_background_tile' => null, 'profile_background_color' => '352726', 'profile_use_background_image' => 1, 'profile_link_color' => 'D02B55', 'profile_sidebar_border_color' => '829D5E', 'profile_sidebar_fill_color' => '99CC33', 'profile_text_color' => '3E4415'),
	array('profile_background_tile' => null, 'profile_background_color' => '709397', 'profile_use_background_image' => 1, 'profile_link_color' => 'FF3300', 'profile_sidebar_border_color' => '86A4A6', 'profile_sidebar_fill_color' => 'A0C5C7', 'profile_text_color' => '333333'),
	array('profile_background_tile' => null, 'profile_background_color' => 'EBEBEB', 'profile_use_background_image' => 1, 'profile_link_color' => '990000', 'profile_sidebar_border_color' => 'DFDFDF', 'profile_sidebar_fill_color' => 'F3F3F3', 'profile_text_color' => '333333'),
	array('profile_background_tile' => null, 'profile_background_color' => '8B542B', 'profile_use_background_image' => 1, 'profile_link_color' => '9D582E', 'profile_sidebar_border_color' => 'D9B17E', 'profile_sidebar_fill_color' => 'EADEAA', 'profile_text_color' => '333333'),
	array('profile_background_tile' => null, 'profile_background_color' => '1A1B1F', 'profile_use_background_image' => 1, 'profile_link_color' => '2FC2EF', 'profile_sidebar_border_color' => '181A1E', 'profile_sidebar_fill_color' => '252429', 'profile_text_color' => '666666'),
	array('profile_background_tile' => null, 'profile_background_color' => '642D8B', 'profile_use_background_image' => 1, 'profile_link_color' => 'FF0000', 'profile_sidebar_border_color' => '65B0DA', 'profile_sidebar_fill_color' => '7AC3EE', 'profile_text_color' => '3D1957'),
	array('profile_background_tile' => 1,    'profile_background_color' => 'FF6699', 'profile_use_background_image' => 1, 'profile_link_color' => 'B40B43', 'profile_sidebar_border_color' => 'CC3366', 'profile_sidebar_fill_color' => 'E5507E', 'profile_text_color' => '362720'),
	array('profile_background_tile' => null, 'profile_background_color' => 'BADFCD', 'profile_use_background_image' => 1, 'profile_link_color' => 'FF0000', 'profile_sidebar_border_color' => 'F2E195', 'profile_sidebar_fill_color' => 'FFF7CC', 'profile_text_color' => '0C3E53'),
	array('profile_background_tile' => null, 'profile_background_color' => 'B2DFDA', 'profile_use_background_image' => 1, 'profile_link_color' => '93A644', 'profile_sidebar_border_color' => 'EEEEEE', 'profile_sidebar_fill_color' => 'FFFFFF', 'profile_text_color' => '333333'),
	array('profile_background_tile' => 1   , 'profile_background_color' => '131516', 'profile_use_background_image' => 1, 'profile_link_color' => '009999', 'profile_sidebar_border_color' => 'EEEEEE', 'profile_sidebar_fill_color' => 'EFEFEF', 'profile_text_color' => '333333'),
	array('profile_background_tile' => null, 'profile_background_color' => '022330', 'profile_use_background_image' => 1, 'profile_link_color' => '0084B4', 'profile_sidebar_border_color' => 'A8C7F7', 'profile_sidebar_fill_color' => 'C0DFEC', 'profile_text_color' => '333333'),
	array('profile_background_tile' => null, 'profile_background_color' => '9AE4E8', 'profile_use_background_image' => 1, 'profile_link_color' => '0084B4', 'profile_sidebar_border_color' => 'BDDCAD', 'profile_sidebar_fill_color' => 'DDFFCC', 'profile_text_color' => '333333'),
	array('profile_background_tile' => null, 'profile_background_color' => 'DBE9ED', 'profile_use_background_image' => 1, 'profile_link_color' => 'CC3366', 'profile_sidebar_border_color' => 'DBE9ED', 'profile_sidebar_fill_color' => 'E6F6F9', 'profile_text_color' => '333333'),
	array('profile_background_tile' => null, 'profile_background_color' => 'ACDED6', 'profile_use_background_image' => 1, 'profile_link_color' => '038543', 'profile_sidebar_border_color' => 'EEEEEE', 'profile_sidebar_fill_color' => 'F6F6F6', 'profile_text_color' => '333333'),
	array('profile_background_tile' => null, 'profile_background_color' => 'FFF04D', 'profile_use_background_image' => 1, 'profile_link_color' => '0099CC', 'profile_sidebar_border_color' => 'FFF8AD', 'profile_sidebar_fill_color' => 'F6FFD1', 'profile_text_color' => '333333')
);
// --------------------------------
// オプション
// --------------------------------
define('USER_COUNT', 1000); //10000000
define('TWITTER_ID_MAX_LENGTH', 15);
//define('TWITTER_ID_CHARS', 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_');
define('TWITTER_ID_CHARS', 'abcdefghijklmnopqrstuvwxyz0123456789_');
// --------------------------------
// メイン
// --------------------------------
// TwitterID
$add_user_count = USER_COUNT;
$twitter_id_maxlen = TWITTER_ID_MAX_LENGTH;
$words = TWITTER_ID_CHARS;

$words_length = strlen($words) - 1;
$end_char = '';
for ($i=0; $i<$twitter_id_maxlen; $i++){
	$end_char .= $words[$words_length];
}
echo '終了文字：' . $end_char . PHP_EOL;

$indexes = array();
array_push($indexes, 0);
// ユーザーサンプル
$user_sample_max = get_user_sample_max($dbh);
echo 'ユーザーサンプル数:' . $user_sample_max . PHP_EOL;
// --------------------------------
// ループ
// --------------------------------
$twitter_primary_id = 100000000000;
$twitter_id = '';

for ($i=$user_sample_max + 1; $i < USER_COUNT; $i++) {
	$twitter_id = '';
	foreach($indexes as &$index){
		// 文字を構成
		$twitter_id .= $words[$index];
	}
	echo '[' . $i . '] twp[' . $twitter_primary_id . '] tw[' . $twitter_id . '] ... ';

	$new_user_info = array();
	$new_user_info['twitter_primary_id'] = $twitter_primary_id;
	$new_user_info['twitter_id'] = $twitter_id;
	$new_user_info['twitter_name'] = $twitter_id;

	$new_user_info['twitter_request_token'] = null;
	$new_user_info['twitter_accsess_token'] = null;
	$new_user_info['twitter_accsess_token_secret'] = null;

	$tpi_rand_key = array_rand($twitter_profile_image_samples, 1);
	$new_user_info['twitter_profile_image'] = $twitter_profile_image_samples[$tpi_rand_key];

	$tpb_rand_key = array_rand($twitter_profile_banner_samples, 1);
	$new_user_info['twitter_profile_banner'] = $twitter_profile_banner_samples[$tpb_rand_key];

/*
	$tpbi_rand_key = array_rand($twitter_profile_background_image_samples, 1);
	$new_user_info['twitter_profile_background_image'] = $twitter_profile_background_image_samples[$tpbi_rand_key];

	$tci_rand_key = array_rand($twitter_color_info_samples, 1);
	$tci = $twitter_color_info_samples[$tci_rand_key];
	$new_user_info['twitter_profile_background_tile'] = $tci['profile_background_tile'];
	$new_user_info['twitter_profile_background_color'] = $tci['profile_background_color'];
	$new_user_info['twitter_profile_use_background_image'] = $tci['profile_use_background_image'];
	$new_user_info['twitter_profile_link_color'] = $tci['profile_link_color'];
	$new_user_info['twitter_profile_sidebar_border_color'] = $tci['profile_sidebar_border_color'];
	$new_user_info['twitter_profile_sidebar_fill_color'] = $tci['profile_sidebar_fill_color'];
	$new_user_info['twitter_profile_text_color'] = $tci['profile_text_color'];
*/

	//print_r($new_user_info);
	if (!insert_user($dbh, $new_user_info)) {
		echo 'NG' . PHP_EOL;
	} else {
		echo 'OK' . PHP_EOL;
	}

	$overflow = 1;
	foreach($indexes as &$index){
		$index++;
		// 桁があふれた場合は初期化
		if($index > $words_length){
			$index = 0;
		} else {
			$overflow = 0;
			break;
		}
	}
	// オーバーフローの場合、桁を増やす
	if ($overflow == 1){
		array_push($indexes, 0);
	}
	// 終了文字の場合
	if (strcmp($twitter_id, $end_char) == 0) {
		echo '終了文字に到達しました' . PHP_EOL;
		break;
	}
	$twitter_primary_id++;
}
?>
