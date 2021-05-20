<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<div class="entry-header">
<div class="title">
<?php if (!empty($category)): ?>
<h2>
<i class="fa fa-folder-open" aria-hidden="true"></i>
<span><?php echo $category->cat_word; ?></span>
</h2>
<?php if (empty($category->cat_parent)): ?>
<dl>
<dt>スレッド</dt>
<dd><var><?php echo number_format($category->cat_thread_count); ?></var>件</dd>
<dt>レス</dt>
<dd><var><?php echo number_format($category->cat_comment_count); ?></var>件</dd>
</dl>
<?php endif; ?>
<?php if (!empty($category->cat_parent)): ?>
<dl>
<dt>スレッド</dt>
<dd><var><?php echo number_format($category->cat_thread_count); ?></var>件</dd>
<dt>レス</dt>
<dd><var><?php echo number_format($category->cat_comment_count); ?></var>件</dd>
</dl>
<?php endif; ?>
<?php endif; ?>
<?php if (empty($category)): ?>
<h2>
<span>全てのスレッド</span>
</h2>
<dl>
<dt>スレッド</dt>
<dd><var><?php echo number_format($site->s_thread_count); ?></var></dd>
<dt>レス</dt>
<dd><var><?php echo number_format($site->s_comment_count); ?></var></dd>
</dl>
<?php endif; ?>
</div>
<?php
if (!empty($adv)) {
?>
<div class="adv entry"><?php echo $adv; ?></div>
<?php
}
?>
</div>
