<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (empty($title)) {
	$title = '404 Not Found.';
}
if (empty($message)) {
	$message = 'このページは存在しないか、すでに削除されています。';
}
?>
<div class="site-error">
<h1 class="site-error-title"><?php echo $title; ?></h1>
<div class="site-error-message"><p><?php echo $message; ?></p></div>
<div class="site-error-menu">
<button type="button" onclick="history.back()"><i class="fa fa-arrow-left" aria-hidden="true"></i>戻る</button>
<a href="/"><i class="fa fa-home" aria-hidden="true"></i>トップへ</a>
</div>
</div>
<?php
if (!empty($adv)) {
?>
<div class="adv error"><?php echo $adv; ?></div>
<?php
}
?>
