<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (!empty($user)) {
?>
<div class="user-header">
<div class="user-header-thumb">
<button id="user-favorite" type="button" value="<?php echo $user->u_twitter_id; ?>"><img src="<?php echo $user->u_twitter_profile_image; ?>"></button>
<a href="<?php echo TWITTER_URL; ?><?php echo $user->u_twitter_id; ?>" rel="nofollow" target="_blank">@<?php echo $user->u_twitter_id; ?></a>
</div>
<nav>
<ul id="user-nav">
<li<?php echo ($method === '') ? ' class="current"' : ''; ?>><a href="/u/<?php echo $user->u_twitter_id; ?>"><span>レス</span><var><?php echo number_format($user->u_comment_count - $user->u_privated_comment_count); ?></var></a></li>
<li<?php echo ($method == 'thread') ? ' class="current"' : ''; ?>><a href="/u/<?php echo $user->u_twitter_id; ?>/thread"><span>スレッド</span><var><?php echo number_format($user->u_thread_count - $user->u_privated_thread_count); ?></var></a></li>
<?php
if ($method == 'bookmark' || !empty($user->u_thread_favorite_count)) {
?>
<li<?php echo ($method == 'bookmark') ? ' class="current"' : ''; ?>><a href="/u/<?php echo $user->u_twitter_id; ?>/bookmark"><span><i class="fa fa-star" aria-hidden="true"></i>ぶくま！</span><var><?php echo number_format($user->u_thread_favorite_count); ?></var></a></li>
<?php
}
if (!empty($_SESSION['twitter_primary_id']) && $_SESSION['twitter_primary_id'] === ADMIN_TWITTER_PRIMARY_ID) {
	if ($method == 'report_res' || !empty($user->u_comment_report_count)) {
?>
<li<?php echo ($method == 'report_res') ? ' class="current"' : ''; ?>><a href="/admin/u/<?php echo $user->u_twitter_id; ?>/report_res"><span><i class="fa fa-frown-o" aria-hidden="true"></i>レス</span><var><?php echo number_format($user->u_comment_report_count); ?></var></a></li>
<?php
	}
	if ($method == 'report_thread' || !empty($user->u_thread_report_count)) {
?>
<li<?php echo ($method == 'report_thread') ? ' class="current"' : ''; ?>><a href="/admin/u/<?php echo $user->u_twitter_id; ?>/report_thread"><span><i class="fa fa-frown-o" aria-hidden="true"></i>スレッド</span><var><?php echo number_format($user->u_thread_report_count); ?></var></a></li>
<?php
	}
}
?>
</ul>
</nav>
<button class="current-dir"><i class="fa fa-chevron-down" aria-hidden="true"></i><?php
if ($method == '') {
?><span>レス</span><var><?php echo number_format($user->u_comment_count - $user->u_privated_comment_count); ?></var><?php
} else if ($method == 'thread') {
?><span>スレッド</span><var><?php echo number_format($user->u_thread_count - $user->u_privated_thread_count); ?></var><?php
} else if ($method == 'bookmark') {
?><span><i class="fa fa-star" aria-hidden="true"></i>スレッド</span><var><?php echo number_format($user->u_thread_favorite_count); ?></var><?php
} else if ($method == 'report_res') {
	if (!empty($_SESSION['twitter_primary_id']) && $_SESSION['twitter_primary_id'] === ADMIN_TWITTER_PRIMARY_ID) {
?><span><i class="fa fa-frown-o" aria-hidden="true"></i>レス</span><var><?php echo number_format($user->u_comment_report_count); ?></var><?php
	}
} else if ($method == 'report_thread') {
	if (!empty($_SESSION['twitter_primary_id']) && $_SESSION['twitter_primary_id'] === ADMIN_TWITTER_PRIMARY_ID) {
?><span><i class="fa fa-frown-o" aria-hidden="true"></i>スレッド</span><var><?php echo number_format($user->u_thread_report_count); ?></var><?php
	}
} else {
?><span>メニュー</span><?php
}
?></button>
</div>
<?php
}
?>
