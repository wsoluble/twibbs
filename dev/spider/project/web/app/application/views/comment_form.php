<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (!empty($thread) && $thread->t_filled != 1) {
?>
<div class="post-comment">
<div id="post">
<?php
	if (!empty($_SESSION['user_id']) && !empty($s_user)) {
?>
<input id="post-thread-id" type="hidden" value="<?php echo $thread->thread_id; ?>">
<div class="post-thumb"><img src="<?php echo $s_user->u_twitter_profile_image; ?>"></div>
<div class="post-body">
<textarea id="comment-body" rows="1" placeholder="レスを書き込む"></textarea>
<p id="post-preview"></p>
</div>
<div class="post-bottom">
<button id="post-submit">投稿</button>
<button id="post-conv"><i class="fa fa-eye" aria-hidden="true"></i>プレビュー</button>
<p id="post-count"><?php echo COMMENT_LENGTH; ?></p>
<ul class="post-links">
<li><a href="<?php echo RULE_URL; ?>" target="_blank"><i class="fa fa-flag" aria-hidden="true"></i>ルール</a></li>
<li><a href="<?php echo HELP_URL; ?>" target="_blank"><i class="fa fa-question-circle" aria-hidden="true"></i>ヘルプ</a></li>
<li><a href="<?php echo TERM_URL; ?>" target="_blank"><i class="fa fa-info-circle" aria-hidden="true"></i>利用規約</a></li>
</ul>
<div id="post-status"></div>
</div>
<?php
	} else {
?>
<div class="post-thumb"><i class="fa fa-twitter" aria-hidden="true"></i></div>
<div class="post-body">
<div class="post-login"><a href="/login">ログインしてレスを書き込む。</a></div>
</div>
<div class="post-bottom">
<ul class="post-links">
<li><a href="<?php echo RULE_URL; ?>" target="_blank"><i class="fa fa-flag" aria-hidden="true"></i>ルール</a></li>
<li><a href="<?php echo HELP_URL; ?>" target="_blank"><i class="fa fa-question-circle" aria-hidden="true"></i>ヘルプ</a></li>
<li><a href="<?php echo TERM_URL; ?>" target="_blank"><i class="fa fa-info-circle" aria-hidden="true"></i>利用規約</a></li>
</ul>
</div>
<?php
	}
?>
</div>
</div>
<script>
var BODY_LENGTH = <?php echo COMMENT_LENGTH; ?>;
var POST_COMMENT_INTERVAL = <?php echo POST_COMMENT_INTERVAL; ?>;
</script>
<?php
}
?>
