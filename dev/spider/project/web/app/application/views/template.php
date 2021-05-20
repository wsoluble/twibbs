<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<!DOCTYPE html>
<html lang="ja">
<head>
<?php echo empty($html->head) ? '' : $html->head; ?>
</head>
<body>
<header id="menu">
<button class="menu-toggle menu"><i class="fa fa-times" aria-hidden="true"></i></button>
<h1 id="logo"><a href="/"><?php echo SITE_NAME; ?></a></h1>
<div id="menu-top">
<ul class="site-menu">
<li class="twitter"><a href="https://twitter.com/<?php echo SITE_TWITTER_ID; ?>" target="_blank"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
<li class="rule"><a href="<?php echo RULE_URL; ?>" target="_blank"><i class="fa fa-flag" aria-hidden="true"></i></a></li>
<li class="help"><a href="<?php echo HELP_URL; ?>" target="_blank"><i class="fa fa-question" aria-hidden="true"></i></a></li>
<li class="term"><a href="<?php echo TERM_URL; ?>" target="_blank"><i class="fa fa-info" aria-hidden="true"></i></a></li>
</ul>
<ul class="method">
<li class="entry"><a href="/entry">NEW ENTRY</a></li>
</ul>
</div>
<div id="menu-body">
<?php echo empty($html->menu_body) ? '' : $html->menu_body; ?>
<h2><i class="fa fa-tags" aria-hidden="true"></i>TAG BOOK MARK<button id="truncate-menu-tags"><i class="fa fa-trash-o" aria-hidden="true"></i></button></h2>
<nav class="favorite" id="munu-body-tags">
<ul></ul>
<p class="status"></p>
<div class="input">
<input type="text" placeholder="#タグをぶくま">
<button class="add"><i class="fa fa-plus" aria-hidden="true"></i></button>
</div>
</nav>
<h2><i class="fa fa-twitter" aria-hidden="true"></i>USER BOOK MARK<button id="truncate-menu-users"><i class="fa fa-trash-o" aria-hidden="true"></i></button></h2>
<nav class="favorite" id="munu-body-users">
<ul></ul>
<p class="status"></p>
<div class="input">
<input type="text" placeholder="@twitterをぶくま">
<button class="add"><i class="fa fa-plus" aria-hidden="true"></i></button>
</div>
</nav>
</div>
<div id="menu-bottom">
<?php echo empty($html->menu_bottom) ? '' : $html->menu_bottom; ?>
</div>
</header>
<main>
<header>
<?php echo empty($html->main_header) ? '' : $html->main_header; ?>
</header>
<?php if (!empty($html->content)): ?>
<section id="content">
<?php echo $html->content; ?>
</section>
<?php endif; ?>
<?php if (!empty($html->sub)): ?>
<section id="sub">
<?php echo $html->sub; ?>
</section>
<?php endif; ?>
<footer>
<?php
if (empty($html->footer)) {
?>
<p>Copyright © 2016 copyrights <?php echo SITE_NAME; ?> All Rights Reserved.</p>
<?php
} else {
echo $html->footer;
}
?>
</footer>
</main>
<div id="overlay">
<div class="overlay-inner">
<div class="overlay-box">
<div class="overlay-text-box">
<em id="overlay-icon"><i class="fa fa-info" aria-hidden="true"></i></em>
<p id="overlay-text"></p>
<div id="overlay-body"></div>
</div>
<button id="overlay-close" type="button"><i class="fa fa-times" aria-hidden="true"></i>閉じる</p>
</div>
</div>
</div>
</body>
</html>
