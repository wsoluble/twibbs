<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (!empty($comments) || !empty($empty_display)) {
?>
<script>var COMMENT_USE_PUSH_STATE = <?php echo empty($use_push_state) ? 'false' : 'true'; ?>;</script>
<div class="comments">
<?php
if (!empty($after_url)) {
?>
<div id="enq-comment-after" class="comment-after"<?php echo empty($after_id) ? '' : ' data-after="' . $after_id . '"' ?>>
<a href="<?php echo $after_url; ?>"><i class="fa fa-repeat" aria-hidden="true"></i><span>新しいレスをチェック</span></a>
<p><span></span><img id="loading-after-img" src="/svg/oval_l.svg"></p>
</div>
<?php
}
?>
<?php
	$now = new stdClass;
	$now->ts = time();
	$now->year = date('Y', $now->ts);
	$now->month = date('n', $now->ts);
	$now->day = date('j', $now->ts);
	$now->hour = date('G', $now->ts);
	$now->minute = date('i', $now->ts);
	foreach ($comments as $comment) {
		$c_date = '';
		$date = new stdClass;
		$date->ts = strtotime($comment->c_datetime);
		$date->year = date('Y', $date->ts);
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
<div class="comment comment-<?php echo $comment->comment_id; ?>">
<?php
if ($comment->c_privated == 0) {
	$extends = array();
	$extends['display'] = false;
	$extends['display_report'] = (!empty($_SESSION['user_id'])) ? true : false;
	$extends['display_remove'] = (!empty($_SESSION['user_id']) && (ADMIN_TWITTER_PRIMARY_ID == $_SESSION['twitter_primary_id'] || $comment->c_thread_user_id == $_SESSION['user_id'] || $comment->c_user_id == $_SESSION['user_id'])) ? true : false;
	foreach ($extends as $ext) {
		if ($ext == true) {
			$extends['display'] = true;
		}
	}
?>
<ul class="header">
<li class="thumb"><button class="ufav-button" type="button" value="<?php echo $comment->u_twitter_id; ?>"><img src="<?php echo $comment->u_twitter_profile_image; ?>"></button></li>
<li class="name"><a href="/u/<?php echo $comment->u_twitter_id; ?>">@<?php echo $comment->u_twitter_id; ?></a></li>
<li class="date"><time datetime="<?php echo $comment->c_datetime; ?>"><?php echo $c_date; ?></time></li>
</ul>
<div class="body"><p><?php echo $comment->c_body; ?></p></div>
<ul class="footer">
<li class="number"><span>#</span><em><?php echo $comment->comment_id; ?></em></li>
<?php
if (!empty($comment->c_report_count) && $extends['display_remove']) {
?>
<li class="spam"><i class="fa fa-frown-o" aria-hidden="true"></i><span>スパム報告</span><var><?php echo $comment->c_report_count; ?></var></li>
<?php
}
if (!empty($disp_thread)) {
?>
<li class="link"><a href="/t/<?php echo $comment->c_thread_id; ?>"><i class="fa fa-th-list" aria-hidden="true"></i>スレッド</a></li>
<?php
}
?>
</ul>
<?php
if ($extends['display'] == true) {
?>
<button class="extend-display" type="button" data-target="ellipsis-c<?php echo $comment->comment_id; ?>"><i class="fa fa-ellipsis-v" aria-hidden="true"></i></button>
<ul class="extend-ellipsis ellipsis-c<?php echo $comment->comment_id; ?>">
<?php
if ($extends['display_report'] == true) {
?>
<li><a href="/report/res/<?php echo $comment->comment_id; ?>">スパム報告</a></li>
<?php
}
if ($extends['display_remove'] == true) {
?>
<li><button class="comment-remove" type="button" data-cid="<?php echo $comment->comment_id; ?>">レス削除</button></li>
<?php
}
?>
</ul>
<?php
}
?>
<?php
} else {
	$body = '';
	switch ($comment->c_privated) {
		case 1:
			$body = 'このレスは管理者が削除しました。';
			break;

		case 2:
			$body = 'このレスはスレ主が削除しました。';
			break;

		case 3:
			$body = 'このレスは投稿者が削除しました。';
			break;

		default:
			break;
	}
?>
<ul class="header">
<li class="thumb"><div class="noimage"><i class="fa fa-user-o" aria-hidden="true"></i></div></li>
<li class="name"><?php echo DELETED_NAME; ?></li>
</ul>
<div class="body"><p class="deleted"><?php echo $body; ?></p></div>
<?php
}
?>
</div>
<?php
	}
?>
<?php
if (!empty($adv) && count($comments) >= ADV_DISPLAY_CONTENT_NUM) {
?>
<div class="adv entry"><?php echo $adv; ?></div>
<?php
}
?>
<?php
if (!empty($before_url)) {
?>
<div id="enq-comment-before" class="comment-before" data-url="<?php echo $before_url; ?>"><img id="loading-before-img" src="/svg/oval_l.svg"></p></div>
<?php
}
?>
</div>
<?php
} else {
	if (!empty($disp_no_entry)) {
?>
<div class="no-entry"><p>まだエントリがありません。</p></div>
<?php
	}
}
?>
