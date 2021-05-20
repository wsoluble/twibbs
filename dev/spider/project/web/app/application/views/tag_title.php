<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<div class="tag-title">
<?php
if (isset($tag) && isset($thread_count)) {
?>
<h2>
<i class="fa fa-hashtag" aria-hidden="true"></i>
<span class="tag"><em><?php echo htmlspecialchars($tag, ENT_QUOTES); ?></em><button id="tag-favorite" type="button" value="<?php echo htmlspecialchars($tag, ENT_QUOTES); ?>"><i class="fa fa-plus" aria-hidden="true"></i></button></span>
<span>タグがついたスレッド</span>
<var><?php echo $thread_count; ?>件</var>
</h2>
<?php
}
?>
</div>
