<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
/**
 * $page_index, $record_max, $content_max, $segments, $url_directories, $jump_maxは入力必須
 */
if (!empty($page_index) && isset($record_max) && !empty($content_max) && !empty($segments) && !empty($directory)) {
	// ページ
	if ($page_index < 1 || !is_int($page_index)) {
		$page_index = 1;
	}
	$right_max_index = (int) ceil($record_max / $content_max);
	$index_left_num = $page_index - 1;
	if ($page_index - 1 > $segments) {
		$index_left_num = $segments;
	}
	$index_right_num = ((int) ceil($record_max / $content_max)) - $page_index;
	if ($index_right_num > $segments) {
		$index_right_num = $segments;
	}
	// URL
	$directory = !empty($directory) ? $directory : '';
	$query = !empty($query) ? $query : '';
	$uri = $directory . $query;
	$qi = empty($query) ? '?i=' : '&i=';
	// HTML出力
	if ($record_max > $content_max) {
?>
<div class="pagination-o">
<ul class="pagination">
<?php
		if ($index_left_num >= $segments) {
?>
<li class="latest btn-success"><a href="<?php echo $uri; ?>"><i class="fa fa-angle-double-left"></i></a></li>
<?php
		}
		if ($page_index > 1) {
?>
<li><a href="<?php echo $uri . $qi . intval($page_index - 1); ?>"><i class="fa fa-angle-left"></i></a></li>
<?php
		}
		for ($i=$page_index-$index_left_num; $i<$page_index; $i++){
			if ($i == 1) {
?>
<li><a href="<?php echo $uri; ?>"><?php echo $i; ?></a></li>
<?php
			} else {
?>
<li><a href="<?php echo $uri . $qi . $i; ?>"><?php echo $i; ?></a></li>
<?php
			}
		}
?>
<li class="current active"><a><?php echo $page_index; ?></a></li>
<?php
		for ($i = $page_index + 1; $i <= $page_index + $index_right_num; $i++){
?>
<li><a href="<?php echo $uri . $qi . $i; ?>"><?php echo $i; ?></a></li>
<?php
		}
		if ($right_max_index > $page_index) {
?>
<li><a href="<?php echo $uri . $qi . intval($page_index + 1); ?>"><i class="fa fa-angle-right"></i></a></li>
<?php
		}
		if (!empty($jump_max)) {
			if ($index_right_num >= $segments) {
?>
<li><a href="<?php echo $uri . $qi . $right_max_index; ?>"><i class="fa fa-angle-double-right"></i></a></li>
<?php
			}
		}
?>
</ul>
</div>
<?php
	}
}
?>
