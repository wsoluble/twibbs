<?php
//ini_set('mysql.default_socket', '/Applications/MAMP/tmp/mysql/mysql.sock');
//ini_set('pdo_mysql.default_socket', '/Applications/MAMP/tmp/mysql/mysql.sock');

define('DEBUG_DISPLAY_SQL_EXEC_TIME', false);

define('MY_TWITTER_PRIMARY_ID', 2222164063);
define('MY_USER_ID', 100000);
define('THREAD_COMMENT_MAX', 100);
define('THREAD_USING_TAG_MAX', 10);

define('DB_HOST', '127.0.0.1');
define('DB_SOCKET_PORT', '3306');
define('DB_USER_ROOT', 'root');
define('DB_PASS_ROOT', 'kusang');

define('DB_NAME', 'spider_twibbs');
define('DB_NAME_SAMPLES', 'twibbs_samples');

$dsn = 'mysql:host=127.0.0.1;charset=utf8;dbname=' . DB_NAME;
$dbh = null;
try {
  $dbh = new PDO($dsn, DB_USER_ROOT, DB_PASS_ROOT);
} catch (PDOException $e) {
  echo '接続に失敗しました: ' . $e->getMessage();
  exit();
}
