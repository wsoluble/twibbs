<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<div class="ng-entries">
<?php
if (!empty($err_msgs)) {
?>
<div class="errors">
<h2><i class="fa fa-info-circle" aria-hidden="true"></i>以下の内容を修正してください</h2>
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
<h2><i class="fa fa-user-o" aria-hidden="true"></i>NGユーザー設定（<?php echo $ng_count; ?>）</h2>
<ul class="exp">
<li>サイト内に存在するユーザーをNG登録できます</li>
<li>このページで設定したユーザーは、あなたの作成したスレッドでレス投稿できません</li>
<li><span>NGユーザーは<?php echo NG_USER_MAX; ?>件まで登録できます</span></li>
</ul>
<?php
if ($ng_count <= NG_USER_MAX) {
?>
<form class="add-ng-form" method="post" action="/prv/ng/user">
<div class="input-group">
<span>@</span>
<div class="ng-text"><input type="text" name="ngval"></div>
<button type="submit" name="submit_add" value="post"><i class="fa fa-plus" aria-hidden="true"></i></button>
</div>
</form>
<?php
}
?>
<form class="remove-ng-form" method="post" action="/prv/ng/user">
<ul>
<?php
if (!empty($ng_users)) {
	foreach ($ng_users as $ng) {
?>
<li>
<img src="<?php echo $ng->u_twitter_profile_image; ?>">
<a href="/u/<?php echo $ng->u_twitter_id; ?>" target="_blank">@<?php echo $ng->u_twitter_id; ?></a>
<button class="remove-ng-user" type="submit" name="submit_remove" value="<?php echo $ng->u_twitter_id; ?>"><i class="fa fa-times" aria-hidden="true"></i></button>
</li>
<?php
	}
}
?>
</ul>
</form>
</div>
