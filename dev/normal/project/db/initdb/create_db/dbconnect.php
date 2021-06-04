<?php
//ini_set('mysql.default_socket', '/Applications/MAMP/tmp/mysql/mysql.sock');
//ini_set('pdo_mysql.default_socket', '/Applications/MAMP/tmp/mysql/mysql.sock');

define('DEBUG_DISPLAY_SQL_EXEC_TIME', false);

define('MY_TWITTER_PRIMARY_ID', 2222164063);
define('MY_USER_ID', 1);
define('THREAD_COMMENT_MAX', 100);
define('THREAD_USING_TAG_MAX', 10);

define('DB_HOST', 'localhost'); // $_SERVER['MYSQL_HOST_NAME_SPIDER']
define('DB_SOCKET_PORT', '3306');
define('DB_USER_ROOT', 'root');
define('DB_PASS_ROOT', $_SERVER['MYSQL_ROOT_PASSWORD']);

define('DB_NAME', 'twibbs');
define('DB_NAME_SAMPLES', 'twibbs_samples');

$dsn = 'mysql:host=' . DB_HOST . ';charset=utf8mb4;dbname=' . DB_NAME;
$dbh = null;

echo 'dsn: ' . $dsn . PHP_EOL;
echo 'DB_PASS_ROOT: ' . DB_USER_ROOT . PHP_EOL;
echo 'DB_PASS_ROOT: ' . DB_PASS_ROOT . PHP_EOL;

try {
  $dbh = new PDO($dsn, DB_USER_ROOT, DB_PASS_ROOT);
} catch (PDOException $e) {
  echo '接続に失敗しました: ' . $e->getMessage();
  exit();
}
