<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (!empty($reports)) {
?>
<div class="comments">
<?php
if (!empty($after_url)) {
?>
<div id="enq-comment-after" class="comment-after"<?php echo empty($after_id) ? '' : ' data-after="' . $after_id . '"' ?>>
<a href="<?php echo $after_url; ?>"><i class="fa fa-repeat" aria-hidden="true"></i><span>新しい報告をチェック</span></a>
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
	$i = count($reports);
	foreach ($reports as $report) {
		$body = '';
		$dt = '';
		$type = '';
		$type_dir = '';
		$tid = null;
		$uid = null;
		$privated = 0;
		$t_privated = 0;
		$display_remove = false;
		if (!empty($report->tr_user_id)) {
			$type = 'spmt';
			$type_dir = 'thread';
			$dt = $report->tr_datetime;
			$body = $report->tr_body;
			$tid = $report->tr_thread_id;
			$uid = $report->tr_user_id;
			$privated = $report->tr_privated;
			$t_privated = $report->t_privated;
			$display_remove = (!empty($_SESSION['user_id']) && (ADMIN_TWITTER_PRIMARY_ID == $_SESSION['twitter_primary_id'] || $uid == $_SESSION['user_id'])) ? true : false;
		}
		if (!empty($report->cr_user_id)) {
			$type = 'spmr';
			$type_dir = 'res';
			$dt = $report->cr_datetime;
			$body = $report->cr_body;
			$tid = $report->cr_comment_id;
			$uid = $report->cr_user_id;
			$privated = $report->cr_privated;
			$t_privated = $report->c_privated;
			$display_remove = (!empty($_SESSION['user_id']) && (ADMIN_TWITTER_PRIMARY_ID == $_SESSION['twitter_primary_id'] || $report->cr_thread_user_id == $_SESSION['user_id'] || $uid == $_SESSION['user_id'])) ? true : false;
		}
		// var_dump($report);
		$c_date = '';
		$date = new stdClass;
		$date->ts = strtotime($dt);
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
		$t_status = '';
		switch ($t_privated) {
			case 1:
				$t_status = '管理者';
				break;

			case 2:
				$t_status = 'スレ主';
				break;

			case 3:
				$t_status = 'レス投稿者';
				break;

			default:
				break;
		}
?>
<div class="comment <?php echo $type; ?>-<?php echo $tid; ?>-<?php echo $uid; ?>">
<?php
if ($privated == 0) {
?>
<ul class="header">
<li class="thumb"><button type="button"><img src="<?php echo $report->u_twitter_profile_image; ?>"></button></li>
<li class="name"><a href="/u/<?php echo $report->u_twitter_id; ?>">@<?php echo $report->u_twitter_id; ?></a></li>
<li class="date"><time datetime="<?php echo $dt; ?>"><?php echo $c_date; ?></time></li>
</ul>
<div class="body"><p><?php echo $body; ?></p></div>
<ul class="footer">
<?php
if (!empty($report->srt_name)) {
?>
<li class="report"><i class="fa fa-frown-o" aria-hidden="true"></i><span><?php echo $report->srt_name; ?></span></li>
<?php
}
if (!empty($disp_link)) {
?>
<li class="target"><i class="fa fa-quote-right" aria-hidden="true"></i><a href="/report/<?php echo $type_dir; ?>/<?php echo $tid; ?>" target="_blank"><?php echo $tid; ?></a></li>
<?php
}
if (!empty($t_status)) {
?>
<li class="status"><i class="fa fa-trash" aria-hidden="true"></i><span><?php echo $t_status; ?></span></li>
<?php
}
?>
</ul>
<?php
if ($display_remove == true) {
?>
<button class="extend-display" type="button" data-target="ellipsis-<?php echo $tid; ?>-<?php echo $uid; ?>"><i class="fa fa-ellipsis-v" aria-hidden="true"></i></button>
<ul class="extend-ellipsis ellipsis-<?php echo $tid; ?>-<?php echo $uid; ?>">
<li><button class="report-remove" type="button" data-method="<?php echo $type_dir; ?>" data-tid="<?php echo $tid; ?>" data-uid="<?php echo $uid; ?>">スパム報告を削除</button></li>
</ul>
<?php
}
?>
<?php
} else {
	$body = '';
	switch ($privated) {
		case 1:
			$body = '管理者が削除しました。';
			break;

		case 2:
			$body = 'スレ主が削除しました。';
			break;

		case 3:
			$body = '投稿者が削除しました。';
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
		$i--;
	}
?>
<?php
if (!empty($adv) && count($reports) >= ADV_DISPLAY_CONTENT_NUM) {
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
}
?>
