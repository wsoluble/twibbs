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
<div class="common-page">
<h1 class="common-page-title"><?php echo $title; ?></h1>
<div class="common-page-message"><p><?php echo $message; ?></p></div>
<div class="common-page-menu">
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
