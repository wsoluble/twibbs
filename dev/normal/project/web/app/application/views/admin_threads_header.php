<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (!empty($_SESSION['twitter_primary_id']) && $_SESSION['twitter_primary_id'] === ADMIN_TWITTER_PRIMARY_ID) {
?>
<div class="admin-threads-header">
<h1>管理スレッド一覧 （<span><?php echo empty($record_max) ? 0 : $record_max; ?></span>）</h1>
<div class="create-admin-thread"><a href="/admin/post/thread"><i class="fa fa-pencil" aria-hidden="true"></i>管理スレッドを作成</a></div>
<nav>
<ul>
<li<?php echo !isset($status) ? ' class="current"' : ''; ?>><a href="/admin/threads">すべて</a></li>
<li<?php echo ($status === 0) ? ' class="current"' : ''; ?>><a href="/admin/threads?s=0">下書き</a></li>
<li<?php echo ($status === 1) ? ' class="current"' : ''; ?>><a href="/admin/threads?s=1">予約</a></li>
<li<?php echo ($status === 2) ? ' class="current"' : ''; ?>><a href="/admin/threads?s=2">投稿済み</a></li>
</ul>
</nav>
</div>
<?php
}
?>
