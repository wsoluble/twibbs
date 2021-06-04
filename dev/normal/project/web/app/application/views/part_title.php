<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<div class="part-title">
<?php
if (!empty($root_thread)) {
?>
<div class="thread-title">
<h2><a href="/t/<?php echo $root_thread->thread_id; ?>"><?php echo $root_thread->t_title; ?></a></h2>
<div class="part-title-info">
<span><i class="fa fa-list-ul"></i>パートスレ</span>
<?php echo !empty($part_count) ? '<var>' . $part_count . '件</var>' : ''; ?>
</div>
</div>

<?php
}
?>
</div>
