<?php
//ini_set('mysql.default_socket', '/Applications/MAMP/tmp/mysql/mysql.sock');
//ini_set('pdo_mysql.default_socket', '/Applications/MAMP/tmp/mysql/mysql.sock');

define('DEBUG_DISPLAY_SQL_EXEC_TIME', false);

define('MY_USER_ID', 1);
define('THREAD_COMMENT_MAX', 100);
define('THREAD_USING_TAG_MAX', 10);

define('DB_NAME', 'spider_twibbs');
define('DB_NAME_SAMPLES', 'twibbs_samples');

$envs = getenv();
if (empty($envs['MYSQL_ROOT_PASSWORD'])) {
	error_log('MYSQL_ROOT_PASSWORD環境変数が指定されていません');
	exit();
}

$dbh = null;
$db_user = 'root';
$db_pass = $envs['MYSQL_ROOT_PASSWORD'];
$db_host = 'localhost';
try {
	$dbh = new PDO('mysql:host=' . $db_host . ';charset=utf8mb4;port=3306;dbname=' . DB_NAME, $db_user, $db_pass);
} catch (PDOException $e) {
	echo $e->getMessage() . PHP_EOL;
	exit();
}
if (empty($dbh)) {
	exit();
}