<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<div class="entry-header">
<div class="title">
<?php
if (empty($p_category) && empty($category)) {
?>
<h1>
<a href="/rss/all.xml"><i class="fa fa-rss" aria-hidden="true"></i></a>
<span>総合エントリ</span>
</h1>
<dl>
<dt>スレッド</dt>
<dd><var><?php echo number_format($site->s_thread_count); ?></var></dd>
<dt>レス</dt>
<dd><var><?php echo number_format($site->s_comment_count); ?></var></dd>
</dl>
<?php
} else {
?>
<h1>
<a href="/rss/<?php echo empty($category) ? $p_category->cat_url_name : $category->cat_url_name; ?>.xml"><i class="fa fa-rss" aria-hidden="true"></i></a>
<span><?php echo empty($category) ? $p_category->cat_word : $category->cat_word; ?></span>
</h1>
<?php
	if (empty($category)) {
?>
<dl>
<dt>スレッド</dt>
<dd><var><?php echo number_format($p_category->cat_thread_count); ?></var>件</dd>
<dt>レス</dt>
<dd><var><?php echo number_format($p_category->cat_comment_count); ?></var>件</dd>
</dl>
<?php
	} else {
?>
<dl>
<dt>スレッド</dt>
<dd><var><?php echo number_format($category->cat_thread_count); ?></var>件</dd>
<dt>レス</dt>
<dd><var><?php echo number_format($category->cat_comment_count); ?></var>件</dd>
</dl>
<?php
	}
}
?>
</div>
<?php
if (!empty($adv)) {
?>
<div class="adv entry"><?php echo $adv; ?></div>
<?php
}
?>
</div>
