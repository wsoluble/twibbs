<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<div class="post-comment">
<script>
var BODY_LENGTH = <?php echo COMMENT_LENGTH; ?>;
</script>
<div id="post">
<?php
	if (!empty($_SESSION['user_id']) && !empty($s_user)) {
		$ph = 'ここに問題の内容を記述してください。';
		switch ($method) {
			case 'spmt':
				$ph .= '投稿した内容は、スレ主とあなたが確認できます。';
				break;

			case 'spmr':
				$ph .= '投稿した内容は、スレ主とレス投稿者とあなたが閲覧できます。';
				break;

			default:
				break;
		}
?>
<input id="post-target-id" type="hidden" value="<?php echo $target_id; ?>">
<div class="post-thumb"><img src="<?php echo $s_user->u_twitter_profile_image; ?>"></div>
<div class="post-body">
<textarea id="comment-body" rows="1" placeholder="<?php echo $ph; ?>"></textarea>
</div>
<div class="post-bottom">
<?php
if (!empty($report_types)) {
?>
<div class="select-group">
<select id="select-report-type" name="report-type">
<?php
	foreach ($report_types as $key => $type) {
?>
<option value="<?php echo $type->report_type_id; ?>" data-desc="report-desc-<?php echo $key; ?>"><?php echo $type->rt_name; ?></option>
<?php
	}
?>
</select>
<span><i class="fa fa-arrow-left" aria-hidden="true"></i>スパムの種類を選択してください</span>
</div>
<ul class="report-desc">
<?php
	foreach ($report_types as $key => $type) {
?>
<li id="report-desc-<?php echo $key; ?>"<?php echo ($key == 0) ? ' class="current"' : ''; ?>><div><?php echo $type->rt_body; ?></div></li>
<?php
	}
?>
</ul>
<?php
}
?>
<button id="post-submit" data-method="<?php echo $method; ?>">投稿</button>
<p id="post-count"><?php echo COMMENT_LENGTH; ?></p>
<ul class="post-links">
<li><a href="<?php echo RULE_URL; ?>" target="_blank"><i class="fa fa-flag" aria-hidden="true"></i>ルール</a></li>
<li><a href="<?php echo HELP_URL; ?>" target="_blank"><i class="fa fa-question-circle" aria-hidden="true"></i>ヘルプ</a></li>
<li><a href="<?php echo TERM_URL; ?>" target="_blank"><i class="fa fa-info-circle" aria-hidden="true"></i>利用規約</a></li>
</ul>
<div id="post-status"></div>
</div>
<?php
	}
?>
</div>
</div>
