<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<div class="form-common form-report">
<script>
if (window.history.replaceState) {
	history.replaceState(null, null, '/post/report');
}
var BODY_LENGTH = <?php echo COMMENT_LENGTH; ?>;
</script>
<?php
if (!empty($err_msgs)) {
?>
<div class="errors">
<h1><i class="fa fa-info-circle" aria-hidden="true"></i>以下の内容を修正してください</h1>
<ul>
<?php
	foreach ($err_msgs as $msg) {
?>
<li><?php echo $msg; ?></li>
<?php
	}
?>
</ul>
</div>
<?php
}
?>
<h1><i class="fa fa-pencil" aria-hidden="true"></i>問題のコンテンツを報告</h1>
<form id="form-report" method="post" action="/post/report">
<h2><var>1</var>名前（必須）</h2>
<div class="text-group name-group">
<input id="name-text" type="text" name="name" value="<?php echo $input->name; ?>" placeholder="あなたのお名前">
</div>
<h2><var>2</var>メールアドレス（必須）</h2>
<div class="text-group email-group">
<input id="email-text" type="text" name="email" value="<?php echo $input->email; ?>" placeholder="メールアドレス">
</div>
<h2><var>3</var>問題のスレッドURL（必須）</h2>
<div class="text-group thread-group">
<span><?php echo base_url(); ?>t/</span><input id="thread-text" type="text" name="thread" value="<?php echo $input->thread_id; ?>" placeholder="スレッドID">
</div>
<h2><var>4</var>問題のレスID</h2>
<div class="text-group res-group">
<input id="res-text" type="text" name="res" value="<?php echo $input->comment_id; ?>" placeholder="レスID">
</div>
<h2><var>5</var>問題の種類</h2>
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
<h2><var>6</var>問題の内容（必須）</h2>
<div class="body-group">
<div class="post-body">
<textarea id="comment-body" name="body" rows="1" placeholder="問題の内容を記述してください。"><?php echo $input->body; ?></textarea>
<p id="post-preview"></p>
</div>
<div class="post-bottom">
<p id="post-count"><?php echo COMMENT_LENGTH; ?></p>
</div>
</div>
<div class="submit_group"><button id="submit" type="submit" name="submit" value="post"><i class="fa fa-commenting" aria-hidden="true"></i>問題を報告する</button></div>
</form>
</div>
