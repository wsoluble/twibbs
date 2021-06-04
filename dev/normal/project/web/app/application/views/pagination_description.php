<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
/**
 * $page_index, $record_max, $content_max, $segments, $url_directoriesは入力必須
 */
if (!empty($page_index) && isset($record_max) && isset($record_count) && !empty($content_max)) {
	$right_max_index = (int) ceil($record_max / $content_max);
	if ($record_max > 0) {
		$record_offset = ($page_index - 1) * $content_max + 1;
		$record_end = $record_offset + $record_count - 1;
	} else {
		$record_offset = $record_end = 0;
	}
?>
<div class="pagination-summary">
<span class="page">
<span class="page-index"><?php echo $page_index; ?></span>/<span class="page-max"><?php echo $right_max_index; ?></span>ページ</span>
<span class="record">(<span class="record-offset"><?php echo $record_offset; ?></span>-<span class="record-end"><?php echo $record_end; ?></span>/<span class="record-max"><?php echo $record_max; ?></span>件)</span>
</div>
<?php
}
?>
