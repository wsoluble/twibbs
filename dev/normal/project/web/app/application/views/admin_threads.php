<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (!empty($_SESSION['twitter_primary_id']) && $_SESSION['twitter_primary_id'] === ADMIN_TWITTER_PRIMARY_ID) {
if (!empty($admin_threads)) {
?>
<div class="threads">
<?php
	foreach ($admin_threads as $thread) {
		$at_status = '';
		switch ($thread->at_status) {
			case 0:
				$at_status = '下書き';
				break;

			case 1:
				$at_status = '予約';
				break;

			case 2:
				$at_status = '投稿済み';
				break;

			default:
				break;
		}
		$thread_link = '-';
		if (!empty($thread->thread_id)) {
			$thread_link = '/t/' . $thread->thread_id;
		}
		$comment_count = empty($thread->t_comment_count) ? 0 : $thread->t_comment_count;
?>
<article class="thread thread-<?php echo $thread->admin_thread_id; ?>">
<ul class="header">
<li class="thumb"><button class="ufav-button" type="button" value="<?php echo $thread->u_twitter_id; ?>"><img src="<?php echo $thread->u_twitter_profile_image; ?>"></button></li>
<li class="name"><a href="/u/<?php echo $thread->u_twitter_id; ?>">@<?php echo $thread->u_twitter_id; ?></a></li>
<li class="date"><time datetime="<?php echo $thread->at_datetime; ?>"><?php echo $thread->at_datetime; ?></time></li>
</ul>
<h2><a href="/admin/post/thread/<?php echo $thread->admin_thread_id; ?>"><?php echo $thread->at_title; ?></a></h2>
<ul class="footer">
<li><?php echo $at_status; ?></li>
<?php
if (!empty($thread->thread_id)) {
?>
<li><a href="<?php echo '/t/' . $thread->thread_id; ?>"></a></li>
<li class="res<?php echo ($thread->t_filled == 1) ? ' filled' : ''; ?>"><i class="fa fa-commenting"></i><span>レス</span><var><?php echo $thread->t_comment_count; ?></var></li>
<?php
}
?>
</ul>
</article>
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
}
?>
