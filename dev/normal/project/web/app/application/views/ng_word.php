<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<div class="ng-entries">
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
<h1><i class="fa fa-ban" aria-hidden="true"></i>NGワード設定（<?php echo $ng_count; ?>）</h1>
<ul class="exp">
<li>このページで設定したNGワードは、あなたが作成したスレッドで書き込むことができません</li>
<li><span>NGワードは<?php echo NG_WORD_MAX; ?>件まで登録できます</span></li>
</ul>
<?php
if ($ng_count <= NG_WORD_MAX) {
?>
<form class="add-ng-form" method="post" action="/prv/ng/word">
<div class="input-group">
<span><i class="fa fa-commenting-o" aria-hidden="true"></i></span>
<div class="ng-text"><input type="text" name="ngval"></div>
<button type="submit" name="submit_add" value="post"><i class="fa fa-plus" aria-hidden="true"></i></button>
</div>
</form>
<?php
}
?>
<form class="remove-ng-form" method="post" action="/prv/ng/word">
<ul>
<?php
if (!empty($ng_words)) {
	foreach ($ng_words as $ng) {
?>
<li>
<span><i class="fa fa-ban" aria-hidden="true"></i><?php echo htmlspecialchars($ng, ENT_QUOTES); ?></span>
<button class="remove-ng-word" type="submit" name="submit_remove" value="<?php echo htmlspecialchars($ng, ENT_QUOTES); ?>"><i class="fa fa-times" aria-hidden="true"></i></button>
</li>
<?php
	}
}
?>
</ul>
</form>
</div>
