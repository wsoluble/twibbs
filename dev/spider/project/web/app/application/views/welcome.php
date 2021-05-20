<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<div class="welcome">
	<div class="welcome-header">
		<h2><em class="site-name"><?php echo SITE_NAME . ' ' . SITE_SUBTITLE; ?></em></h2>
		<p>ちょっと長い文字でお話できるパーソナル掲示板。</p>
	</div>
	<div class="welcome-body">
		<div class="functions">
			<div class="func func-thread">
				<div class="func-inner">
					<h3><i class="fa fa-comments" aria-hidden="true"></i>スレッド作成</h3>
					<p>スレッドオーナーになって楽しい会話の場を作りましょう。</p>
				</div>
			</div>
			<div class="func func-res">
				<div class="func-inner">
					<h3><i class="fa fa-commenting-o" aria-hidden="true"></i>レス投稿</h3>
					<p>興味のある話題のスレッドに参加してみましょう。</p>
				</div>
			</div>
			<div class="func func-bookmark">
				<div class="func-inner">
					<h3><i class="fa fa-star-o" aria-hidden="true"></i>ぶくま！</h3>
					<p>気になるスレッドをブックマークできます。</p>
				</div>
			</div>
			<div class="func func-user">
				<div class="func-inner">
					<h3><i class="fa fa-list-ul" aria-hidden="true"></i>投稿履歴</h3>
					<p>全てのユーザーの投稿履歴を時系列に閲覧できます。</p>
				</div>
			</div>
		</div>
	</div>
	<div class="welcome-footer">
<?php
if (empty($_SESSION['user_id'])) {
?>
		<div class="welcome-login"><a href="/login"><i class="fa fa-twitter" aria-hidden="true"></i>Twitterアカウントでログイン</a></div>
<?php
} else {
?>
		<div class="welcome-post"><a href="/post/thread"><i class="fa fa-pencil" aria-hidden="true"></i>あなたのスレッドを作成</a></div>
<?php
}
?>
		<ul class="welcome-more">
			<li class="more-rule"><a href="/rule"><i class="fa fa-flag" aria-hidden="true"></i>ルール</a></li>
			<li class="more-help"><a href="/help"><i class="fa fa-question" aria-hidden="true"></i>使い方</a></li>
			<li class="more-term"><a href="/term"><i class="fa fa-info" aria-hidden="true"></i>利用規約</a></li>
		</ul>
	</div>
</div>
<?php
if (!empty($notices)) {
?>
<div class="site-notice">
	<ul>
<?php
	foreach ($notices as $notice) {
?>
		<li><em><?php echo date('n月j日 G:i', strtotime($notice->si_datetime)); ?></em><span><?php echo $notice->si_body; ?></span></li>
<?php
	}
?>
	</ul>
</div>
<?php
}
?>
