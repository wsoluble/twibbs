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
<button id="post-submit" type="button">投稿</button>
<button id="post-conv" type="button"><i class="fa fa-eye" aria-hidden="true"></i>プレビュー</button>
<button id="body-conversion-toggle" class="toggle-button" data-target=".body-conversion-toggle" type="button"><i class="fa fa-chevron-down" aria-hidden="true"></i>変換について</button>
<p id="post-count"><?php echo COMMENT_LENGTH; ?></p>
<label class="post-tweet"><span><i class="fa fa-twitter" aria-hidden="true"></i>ツイート</span><input id="post-tweet-res" type="checkbox"></label>
<ul class="post-links">
<li><a href="<?php echo RULE_URL; ?>" target="_blank"><i class="fa fa-flag" aria-hidden="true"></i>ルール</a></li>
<li><a href="<?php echo HELP_URL; ?>" target="_blank"><i class="fa fa-question-circle" aria-hidden="true"></i>ヘルプ</a></li>
<li><a href="<?php echo TERM_URL; ?>" target="_blank"><i class="fa fa-info-circle" aria-hidden="true"></i>利用規約</a></li>
</ul>
<div class="body-conversion-toggle">
	<h2>本文の自動変換</h2>
	<p>外部へのリンク、TwitterID（@twitter）、レス番号（&gt;&gt;[番号]）は、自動的に変換されます。
また、次のメディアのリンクは、埋め込みに変換されます。追加してほしいメディアがある場合は、<a href="<?php echo REQ_URL;?>">ご要望</a>へ。</p>
	<div class="conv-twitter">
		<h3><span>Twitter</span></h3>
		<ul>
			<li>https://twitter.com/[twitter_id]/status/[ツイート番号]</li>
		</ul>
	</div>
	<div class="conv-imgur">
		<h3><span>Imgur</span></h3>
		<ul>
			<li>http://imgur.com/[画像id]</li>
			<li>http://i.imgur.com/[画像id]</li>
		</ul>
	</div>
	<div class="conv-youtube">
		<h3><span>Youtube</span></h3>
		<ul>
			<li>https://www.youtube.com/watch?v=[動画id]</li>
			<li>https://youtu.be/[動画id]</li>
		</ul>
	</div>
	<div class="conv-niconico">
		<h3><span>niconico</span></h3>
		<ul>
			<li>http://www.nicovideo.jp/watch/[動画id]</li>
			<li>http://nico.ms/[動画id]</li>
		</ul>
	</div>
</div>
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
