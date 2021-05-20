<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (!empty($user)) {
?>
<nav class="user-info">
<div class="user-info-top">
<h2>@<?php echo $user->u_twitter_id; ?></h2>
<button class="sub-close sub-toggle"><i class="fa fa-times" aria-hidden="true"></i></button>
<div class="thumb"><a href="<?php echo TWITTER_URL . $user->u_twitter_id; ?>" target="_blank"><img src="<?php echo $user->u_twitter_profile_image; ?>"></a></div>
</div>
<div class="user-info-body">
<div class="post-thread" id="post-thread"><a href="/post/thread"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>新規スレッド</a></div>
<h3><i class="fa fa-comments-o" aria-hidden="true"></i>投稿</h3>
<ul class="user-link user-post">
<li><a href="/u/<?php echo $user->u_twitter_id; ?>"><span>レス</span><var><?php echo number_format($user->u_comment_count - $user->u_privated_comment_count); ?></var></a></li>
<li><a href="/u/<?php echo $user->u_twitter_id; ?>/thread"><span>スレッド</span><var><?php echo number_format($user->u_thread_count - $user->u_privated_thread_count); ?></var></a></li>
</ul>
<h3><i class="fa fa-star" aria-hidden="true"></i>ぶくま</h3>
<ul class="user-link user-fav">
<li><a href="/u/<?php echo $user->u_twitter_id; ?>/bookmark"><span>スレッド</span><var><?php echo number_format($user->u_thread_favorite_count); ?></var></a></li>
</ul>
<h3><i class="fa fa-ban" aria-hidden="true"></i>NG</h3>
<ul class="user-link user-ng">
<li><a href="/prv/ng/user"><span>ユーザー</span><var><?php echo number_format($user->u_ng_user_count); ?></var></a></li>
<li><a href="/prv/ng/word"><span>ワード</span><var><?php echo number_format($user->u_ng_word_count); ?></var></a></li>
</ul>
<?php
if (!empty($_SESSION['twitter_primary_id']) && $_SESSION['twitter_primary_id'] === ADMIN_TWITTER_PRIMARY_ID) {
?>
<h3>ぶくられ</h3>
<ul class="user-nolink">
<li><div><span><i class="fa fa-star" aria-hidden="true"></i>スレッド</span><var><?php echo number_format($user->u_thread_favorited_count); ?></var></div></li>
</ul>
<h3>削除</h3>
<ul class="user-nolink">
<li><div><span>レス</span><var><?php echo number_format($user->u_privated_comment_count); ?></var></div></li>
<li><div><span>スレッド</span><var><?php echo number_format($user->u_privated_thread_count); ?></var></div></li>
</ul>
<h3><i class="fa fa-frown-o" aria-hidden="true"></i>スパム報告</h3>
<ul class="user-nolink user-report">
<li><div><span>レス</span><var><?php echo number_format($user->u_comment_report_count); ?></var></div></li>
<li><div><span>スレッド</span><var><?php echo number_format($user->u_thread_report_count); ?></var></div></li>
</ul>
<h3>権限</h3>
<ul class="user-nolink">
<li><div><span>レス投稿</span><var><?php echo empty($user->u_privilege_comment) ? '◯' : '×'; ?></var></div></li>
<li><div><span>スレッド投稿</span><var><?php echo empty($user->u_privilege_thread) ? '◯' : '×'; ?></var></div></li>
<li><div><span><i class="fa fa-frown-o" aria-hidden="true"></i>レス</span><var><?php echo empty($user->u_privilege_comment_report) ? '◯' : '×'; ?></var></div></li>
<li><div><span><i class="fa fa-frown-o" aria-hidden="true"></i>スレッド</span><var><?php echo empty($user->u_privilege_thread_report) ? '◯' : '×'; ?></var></div></li>
<li><div><span><i class="fa fa-star" aria-hidden="true"></i>スレッド</span><var><?php echo empty($user->u_privilege_thread_favorite) ? '◯' : '×'; ?></var></div></li>
</ul>
<?php
}
?>
<?php
if (!empty($adv)) {
?>
<div class="adv side ui"><?php echo $adv; ?></div>
<?php
}
?>
</div>
<div class="user-info-bottom">
<div class="logout"><a href="/logout"><i class="fa fa-sign-out" aria-hidden="true"></i>ログアウト</a></div>
</div>
</nav>
<?php
}
?>
