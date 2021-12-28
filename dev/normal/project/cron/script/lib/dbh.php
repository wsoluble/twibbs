<?php
define('DB_NAME', 'twibbs');

$envs = getenv();
if (empty($envs['MYSQL_HOST_NAME'])) {
	error_log('MYSQL_HOST_NAME環境変数が指定されていません');
	exit();
}

$dbh = null;
$db_user = 'root';
$db_pass = $envs['MYSQL_ROOT_PASSWORD'];
$db_host = $envs['MYSQL_HOST_NAME'];
try {
	$dbh = new PDO('mysql:host=' . $db_host . ';charset=utf8mb4;port=3306;dbname=' . DB_NAME, $db_user, $db_pass);
} catch (PDOException $e) {
	echo $e->getMessage() . PHP_EOL;
	exit();
}
if (empty($dbh)) {
	exit();
}
?>
