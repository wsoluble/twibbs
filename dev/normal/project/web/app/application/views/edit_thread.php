<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (!empty($user)) {
?>
<div class="form-common form-thread">
<script>
if (window.history.replaceState) {
	history.replaceState(null, null, '/post/thread');
}
var TAG_MAX = <?php echo THREAD_TAG_MAX; ?>;
var TAG_LENGTH = <?php echo TAG_LENGTH; ?>;
var TITLE_LENGTH = <?php echo THREAD_TITLE_LENGTH; ?>;
var BODY_LENGTH = <?php echo COMMENT_LENGTH; ?>;
</script>
<?php
if (!empty($err_msgs)) {
?>
<div class="errors">
<h1><i class="fa fa-info-circle" aria-hidden="true"></i>以下の内容を修正してください</h1>
<ul>
<?php
	foreach ($err_msgs as $msg) {
?>
<li><?php echo $msg; ?></li>
<?php
	}
?>
</ul>
</div>
<?php
}
?>
<h1><i class="fa fa-pencil" aria-hidden="true"></i>新規スレッド</h1>
<form id="form-thread" method="post" action="/post/thread">
<h2><var>1</var>タイトル</h2>
<div class="text-group title-group">
<p id="title-count"><?php echo THREAD_TITLE_LENGTH; ?></p>
<input id="title-text" type="text" name="title" value="<?php echo $input->title; ?>" placeholder="スレッドのタイトル">
</div>
<h2><var>2</var>本文</h2>
<div class="body-group">
<div class="post-body">
<textarea id="comment-body" name="body" rows="1" placeholder="スレッドの本文"><?php echo $input->body; ?></textarea>
<p id="post-preview"></p>
</div>
<div class="post-bottom">
<button id="post-conv" type="button"><i class="fa fa-eye" aria-hidden="true"></i>プレビュー</button>
<button id="body-conversion-toggle" class="toggle-button" data-target=".body-conversion-toggle" type="button"><i class="fa fa-chevron-down" aria-hidden="true"></i>変換について</button>
<p id="post-count"><?php echo COMMENT_LENGTH; ?></p>
<div class="body-conversion-toggle">
	<h3>本文の自動変換</h3>
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
</div>
</div>
<h2><var>3</var>カテゴリ</h2>
<div class="category-group">
<?php
$default_category_id = null;
if (!empty($categories)) {
?>
<select id="category-select" name="category">
<?php
	foreach ($categories as $category) {
		if (empty($default_category_id)) {
			$default_category_id = $category->category_id;
		}
?>
<optgroup label="<?php echo $category->cat_word; ?>">
<option class="main" value="<?php echo $category->category_id; ?>"<?php echo ($category->category_id == $input->category_id) ? ' selected' : ''; ?>><?php echo $category->cat_word; ?></option>
<?php
		if (!empty($category->subs)) {
			foreach ($category->subs as $sub) {
?>
<option value="<?php echo $sub->category_id; ?>"<?php echo ($sub->category_id == $input->category_id) ? ' selected' : ''; ?>><?php echo $sub->cat_word; ?></option>
<?php
			}
		}
?>
</optgroup>
<?php
	}
?>
</select>
<?php
}
?>
<?php
if (!empty($categories)) {
?>
<div class="category-rules">
<h3><i class="fa fa-folder-open" aria-hidden="true"></i>カテゴリルール</h3>
<?php
	foreach ($categories as $category) {
?>
<div class="category-rule" id="category-rule-<?php echo $category->category_id; ?>"<?php echo ($category->category_id == $default_category_id) ? ' style="display:block;"' : ''; ?>>
<?php echo empty($category->cat_description) ? '<p>このカテゴリにはまだルールがありません。</p>' : $category->cat_description; ?>
</div>
<?php
		if (!empty($category->subs)) {
			foreach ($category->subs as $sub) {
?>
<div class="category-rule" id="category-rule-<?php echo $sub->category_id; ?>">
<?php echo empty($sub->cat_description) ? '<p>このカテゴリにはまだルールがありません。</p>' : $sub->cat_description; ?>
</div>
<?php
			}
		}
	}
?>
</div>
<?php
}
?>
</div>
<h2><var>4</var>タグ</h2>
<div class="tag-group">
<div class="tag-add">
<i class="fa fa-hashtag" aria-hidden="true"></i>
<div class="tag-text">
<p id="tag-count"><?php echo TAG_LENGTH; ?></p>
<input type="text" id="tag-text" value="" placeholder="タグ（10個まで）">
</div>
<button id="tag-add" type="button"><i class="fa fa-plus" aria-hidden="true"></i></button>
</div>
<div class="tags" id="tags">
<?php
if (!empty($input->tags)) {
	foreach ($input->tags as $tag) {
?>
<div class="tag">
<input type="hidden" name="tags[]" value="<?php echo $tag; ?>" readonly>
<span class="tag-word"><?php echo $tag; ?></span>
<button class="tag-delete" type="button"><i class="fa fa-times" aria-hidden="true"></i></button>
</div>
<?php
	}
}
?>
</div>
<p id="tag-status"></p>
</div>
<h2><var>5</var>利用規約・ルールの確認</h2>
<div class="confirm-group">
<label>
<input type="checkbox" name="confirm" value="1">
<a href="<?php echo TERM_URL; ?>" target="_blank">「利用規約」</a>及び<a href="<?php echo RULE_URL; ?>" target="_blank">「ルール」</a>及び「カテゴリルール」を理解し、遵守することに同意します。
</label>
</div>
<div class="submit_group"><button id="submit" type="submit" name="submit" value="post"><i class="fa fa-commenting" aria-hidden="true"></i>スレッドを作成</button></div>
</form>
</div>
<?php
}
?>
