<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (!empty($title)) {
?>
<h2 class="threads-title"><?php echo $title; ?></h2>
<?php
}
if (!empty($threads)) {
	$now = new stdClass;
	$now->ts = time();
	$now->year = date('y', $now->ts);
	$now->month = date('n', $now->ts);
	$now->day = date('j', $now->ts);
	$now->hour = date('G', $now->ts);
	$now->minute = date('i', $now->ts);
?>
<div class="threads">
<?php
if (!empty($after_url)) {
?>
<div id="enq-thread-after" class="thread-after">
<a href="<?php echo $after_url; ?>"><i class="fa fa-repeat" aria-hidden="true"></i><span>新しいスレッドをチェック</span></a>
<p><span></span><img id="loading-after-img" src="/svg/oval_l.svg"></p>
</div>
<?php
}
?>
<?php
	foreach ($threads as $thread) {
		$c_date = '';
		$date = new stdClass;
		$date->ts = strtotime($thread->t_datetime);
		$date->year = date('y', $date->ts);
		$date->month = date('n', $date->ts);
		$date->day = date('j', $date->ts);
		$date->hour = date('G', $date->ts);
		$date->minute = date('i', $date->ts);
		if ($date->year == $now->year) {
			if ($date->month == $now->month && $date->day == $now->day) {
				$c_date = '<span>今日</span>' . date('G:i', $date->ts);
			} else {
				$c_date = date('n月j日 G:i', $date->ts);
			}
		} else {
			$c_date = date('Y年n月j日 G:i', $date->ts);
		}
?>
<article class="thread thread-<?php echo $thread->thread_id; ?>">
<?php
if ($thread->t_privated == 0) {
	$extends = array();
	$extends['display'] = false;
	$extends['display_report'] = (!empty($_SESSION['user_id'])) ? true : false;
	$extends['display_remove'] = (!empty($_SESSION['user_id']) && (ADMIN_TWITTER_PRIMARY_ID == $_SESSION['twitter_primary_id'] || $thread->t_user_id == $_SESSION['user_id'])) ? true : false;
	foreach ($extends as $ext) {
		if ($ext == true) {
			$extends['display'] = true;
		}
	}
?>
<ul class="header">
<li class="thumb"><button class="ufav-button" type="button" value="<?php echo $thread->u_twitter_id; ?>"><img src="<?php echo $thread->u_twitter_profile_image; ?>"></button></li>
<li class="name"><a href="/u/<?php echo $thread->u_twitter_id; ?>">@<?php echo $thread->u_twitter_id; ?></a></li>
<li class="date"><time datetime="<?php echo $thread->t_datetime; ?>"><?php echo $c_date; ?></time></li>
</ul>
<h2><a href="/t/<?php echo $thread->thread_id; ?>"><?php echo $thread->t_title; ?></a></h2>
<ul class="footer">
<li class="bookmark-button" data-mode="<?php echo empty($thread->thread_favorite_id) ? 'add' : 'remove'; ?>" data-id="<?php echo $thread->thread_id; ?>">
<span class="bookmark-text"><i class="fa <?php echo empty($thread->thread_favorite_id) ? 'fa-star' : 'fa-check'; ?>" aria-hidden="true"></i>ぶくま！</span>
<span class="bookmark-count"><var><?php echo $thread->t_favorite_count; ?></var><img class="bookmark-loading" src="/svg/grid_l.svg"></span>
</li>
<li class="res<?php echo ($thread->t_filled == 1) ? ' filled' : ''; ?>"><i class="fa fa-commenting"></i><span>レス</span><var><?php echo $thread->t_comment_count; ?></var></li>
<?php
if (!empty($thread->t_report_count) && $extends['display_remove']) {
?>
<li class="spam"><i class="fa fa-frown-o" aria-hidden="true"></i><span>スパム報告</span><var><?php echo $thread->t_report_count; ?></var></li>
<?php
}
if (!empty($thread->t_prev_thread_id) || !empty($thread->t_next_thread_id)) {
?>
<li class="part"><a href="/pt/<?php echo $thread->t_root_thread_id; ?>"><i class="fa fa-list-ul"></i>パート</a></li>
<?php
}
?>
</ul>
<?php
if ($extends['display'] == true) {
?>
<button class="extend-display" type="button" data-target="ellipsis-t<?php echo $thread->thread_id; ?>"><i class="fa fa-ellipsis-v" aria-hidden="true"></i></button>
<ul class="extend-ellipsis ellipsis-t<?php echo $thread->thread_id; ?>">
<?php
if ($extends['display_report'] == true) {
?>
<li><a href="/report/thread/<?php echo $thread->thread_id; ?>">スパム報告</a></li>
<?php
}
if ($extends['display_remove'] == true) {
?>
<li><button class="thread-remove" type="button" data-tid="<?php echo $thread->thread_id; ?>">スレッド削除</button></li>
<?php
}
?>
</ul>
<?php
}
?>
<?php
} else {
	$title = '';
	switch ($thread->t_privated) {
		case 1:
			$title = 'このスレッドは管理者が削除しました。';
			break;

		case 2:
			$title = 'このスレッドはスレ主が削除しました。';
			break;

		default:
			break;
	}
?>
<ul class="header">
<li class="thumb"><div class="noimage"><i class="fa fa-user-o" aria-hidden="true"></i></div></li>
<li class="name"><?php echo DELETED_NAME; ?></li>
</ul>
<h2 class="deleted"><?php echo $title; ?></h2>
<?php
}
?>
</article>
<?php
	}
?>
<?php
if (!empty($adv) && count($threads) >= ADV_DISPLAY_CONTENT_NUM) {
?>
<div class="adv entry"><?php echo $adv; ?></div>
<?php
}
?>
<?php
if (!empty($before_url)) {
?>
<div id="enq-thread-before" class="thread-before" data-url="<?php echo $before_url; ?>"><img id="loading-before-img" src="/svg/oval_l.svg"></p></div>
<?php
}
?>
</div>
<?php
} else {
?>
<div class="no-entry"><p>まだエントリがありません。</p></div>
<?php
}
?>
