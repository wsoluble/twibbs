<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
date_default_timezone_set('Asia/Tokyo');
mb_language('ja');
mb_internal_encoding('UTF-8');
require('twitter_config.php');
require('twitteroauth/autoload.php');
use Abraham\TwitterOAuth\TwitterOAuth;

function utf8mb4_encode_numericentity($str) {
    $re = '/[^\x{0}-\x{FFFF}]/u';
    return preg_replace_callback($re, function($m) {
        $char = $m[0];
        $x = ord($char[0]);
        $y = ord($char[1]);
        $z = ord($char[2]);
        $w = ord($char[3]);
        $cp = (($x & 0x7) << 18) | (($y & 0x3F) << 12) | (($z & 0x3F) << 6) | ($w & 0x3F);
        return sprintf("&#x%X;", $cp);
    }, $str);
}

/**
 * ユーザー情報を構成
 *
 * @param [type] $user
 * @return void
 */
function compose_user($user) {
    if (empty($user)) {
        return false;
    }
    $ui = new stdClass;
    $ui->twitter_primary_id = (is_numeric($user->id)) ? (int)$user->id : $user->id;
    $ui->twitter_id = $user->screen_name;
    $ui->twitter_name = htmlspecialchars(utf8mb4_encode_numericentity(html_entity_decode($user->name, ENT_QUOTES)), ENT_QUOTES);
    $ui->twitter_profile_image = $user->profile_image_url_https;
    // $ui->twitter_profile_image = preg_replace('/_normal\./', '.', $user->profile_image_url_https);
    $ui->twitter_profile_banner = $user->profile_banner_url;
    return $ui;
}

/**
 * main
 */

$con = new TwitterOAuth(CONSUMER_KEY, CONSUMER_SECRET, WEBMASTER_ACCESS_TOKEN, WEBMASTER_ACCESS_TOKEN_SECRET);

$q = array();
// $q['user_id'] = 470810798;
$q['screen_name'] = 'w_soluble_dev';
$user = $con->get('users/show', $q);

echo "get data: \n";
var_dump($user);
echo "\n";

$ui = compose_user($user);

// $json = json_encode($ui, JSON_PRETTY_PRINT);
$str = print_r($ui, true);

//echo "json: \n";
//var_dump($json);
file_put_contents('admin_user_info.json', $str);
?>