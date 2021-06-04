<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (!empty($adv)) {
?>
<div class="adv side"><?php echo $adv; ?></div>
<?php
}
?>
<div class="menu-title"><i class="fa fa-folder-open" aria-hidden="true"></i>カテゴリ</div>
<nav class="category">
<?php
if (!empty($categories)) {
?>
<ul class="main">
<?php
	foreach ($categories as $category) {
		$p_class = '';
		$p_selected = '';
		if (!empty($p_current)) {
			if (empty($current) && $p_current->category_id == $category->category_id) {
				$p_class = ' current';
			}
			if ($p_current->category_id == $category->category_id) {
				$p_selected = ' selected="selected"';
			}
		}
?>
<li class="tag-<?php echo $category->cat_url_name; ?><?php echo $p_class; ?>"<?php echo $p_selected; ?>>
<button><i class="fa fa-chevron-down" aria-hidden="true"></i></button>
<div>
<i class="fa fa-folder-o" aria-hidden="true"></i>
<a href="/<?php echo ($type == 'entry') ? 'entry' : 'ranking'; ?>/<?php echo urlencode($category->cat_url_name); ?>"><?php echo $category->cat_word; ?></a>
</div>
<?php
if (!empty($category->subs)) {
?>
<ul class="sub"<?php echo (!empty($p_current) && $p_current->category_id == $category->category_id) ? ' style="display:block;"' : ''; ?>>
<?php
	foreach ($category->subs as $sub) {
?>
<li class="tag-<?php echo $sub->cat_url_name; ?><?php echo (!empty($current) && $current->category_id == $sub->category_id) ? ' current' : ''; ?>">
<i class="fa fa-caret-right" aria-hidden="true"></i>
<a href="/<?php echo ($type == 'entry') ? 'entry' : 'ranking'; ?>/<?php echo urlencode($sub->cat_url_name); ?>"><?php echo $sub->cat_word; ?></a>
</li>
<?php
	}
?>
</ul>
<?php
}
?>
</li>
<?php
	}
?>
</ul>
<?php
}
?>
</nav>
