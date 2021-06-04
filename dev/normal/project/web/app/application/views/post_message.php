<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (empty($title)) {
	$title = '投稿完了';
}
if (empty($message)) {
	$message = 'あなたの投稿を受け付けました。';
}
?>
<div class="common-page">
<h1 class="common-page-title"><?php echo $title; ?></h1>
<div class="common-page-message"><p><?php echo $message; ?></p></div>
<div class="common-page-menu">
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
