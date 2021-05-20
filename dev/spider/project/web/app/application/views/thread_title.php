<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>

<?php
if (!empty($thread)) {
	$c_date = '';
	$now = new stdClass;
	$now->ts = time();
	$now->year = date('y', $now->ts);
	$now->month = date('n', $now->ts);
	$now->day = date('j', $now->ts);
	$now->hour = date('G', $now->ts);
	$now->minute = date('i', $now->ts);
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
			$c_date = date('n/j G:i', $date->ts);
		}
	} else {
		$c_date = date('Y/n/j G:i', $date->ts);
	}
?>
<?php
if ($thread->t_filled == 1 && $thread->t_privated == 0) {
?>
<div class="thread-filled">
<p>このスレッドはこれ以上書き込めません。</p>
</div>
<?php
}
?>
<div class="thread-header">
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
<div class="thread-info">
<div class="thread-category">
<i class="fa fa-folder-open" aria-hidden="true"></i>
<ul>
<?php
if (!empty($p_category)) {
?>
<li><span><a href="/entry/<?php echo $p_category->cat_url_name; ?>"><?php echo $p_category->cat_word; ?></a></span></li>
<?php
}
if (!empty($category)) {
?>
<li<?php echo (!empty($p_category)) ? ' class=" child"' : ''; ?>><i class="fa fa-angle-right" aria-hidden="true"></i><span><a href="/entry/<?php echo $category->cat_url_name; ?>"><?php echo $category->cat_word; ?></a></span></li>
<?php
}
?>
</ul>
</div>
<?php
if (!empty($tags)) {
?>
<div class="thread-tag">
<i class="fa fa-hashtag" aria-hidden="true"></i>
<ul>
<?php
	foreach ($tags as $tag) {
?>
<li>
<span><a href="/tag/<?php echo urlencode($tag->tg_word); ?>"><?php echo htmlspecialchars($tag->tg_word, ENT_QUOTES); ?></a></span>
<button class="bookmark-tag" value="<?php echo htmlspecialchars($tag->tg_word, ENT_QUOTES); ?>"><i class="fa fa-plus" aria-hidden="true"></i></button>
</li>
<?php
	}
?>
</ul>
</div>
<?php
}
?>
</div>
<div class="thread-title">
<h2><?php echo !empty($thread) ? $thread->t_title : ''; ?></h2>
<div class="thread-bookmarks">
<div class="bookmark-button" data-mode="<?php echo empty($thread->thread_favorite_id) ? 'add' : 'remove'; ?>" data-id="<?php echo $thread->thread_id; ?>">
<span class="bookmark-text"><i class="fa <?php echo empty($thread->thread_favorite_id) ? 'fa-star' : 'fa-check'; ?>" aria-hidden="true"></i>ぶくま！</span>
<span class="bookmark-count"><var><?php echo $thread->t_favorite_count; ?></var><img class="bookmark-loading" src="/svg/grid_l.svg"></span>
</div>
<a href="https://twitter.com/share" class="twitter-share-button">Tweet</a>
<a href="https://twitter.com/<?php echo $thread->u_twitter_id; ?>" class="twitter-follow-button" data-show-count="true" data-show-screen-name="false">Follow @<?php echo $thread->u_twitter_id; ?></a>
</div>
</div>
<div class="thread-first-comment">
<div class="comment thread-<?php echo $thread->thread_id; ?>">
<ul class="header">
<li class="thumb"><button class="ufav-button" type="button" value="<?php echo $thread->u_twitter_id; ?>"><img src="<?php echo $thread->u_twitter_profile_image; ?>"></button></li>
<li class="name"><a href="/u/<?php echo $thread->u_twitter_id; ?>">@<?php echo $thread->u_twitter_id; ?></a></li>
<li class="date"><time datetime="<?php echo $thread->t_datetime; ?>"><?php echo $c_date; ?></time></li>
</ul>
<div class="body"><p><?php echo $thread->t_body; ?></p></div>
<ul class="footer">
<li class="number"><span>#</span><var>0</var></li>
<?php
if (!empty($thread->t_report_count) && $extends['display_remove']) {
?>
<li class="spam"><i class="fa fa-frown-o" aria-hidden="true"></i><span>スパム報告</span><var><?php echo $thread->t_report_count; ?></var></li>
<?php
}
?>
</ul>
<?php
if ($extends['display'] == true) {
?>
<button class="extend-display" type="button" data-target="ellipsis-<?php echo $thread->thread_id; ?>"><i class="fa fa-ellipsis-v" aria-hidden="true"></i></button>
<ul class="extend-ellipsis ellipsis-<?php echo $thread->thread_id; ?>">
<?php
if ($extends['display_report'] == true) {
?>
<li><a href="/report/thread/<?php echo $thread->thread_id; ?>">スパム報告</a></li>
<?php
}
if ($extends['display_remove'] == true) {
?>
<li><button class="thread-remove" type="button" data-tid="<?php echo $thread->thread_id; ?>" data-redirect="1">スレッド削除</button></li>
<?php
}
?>
</ul>
<?php
}
?>
</div>
</div>
<?php
}
?>
</div>
<?php
}
?>
