<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
if (!empty($_SESSION['twitter_primary_id']) && $_SESSION['twitter_primary_id'] === ADMIN_TWITTER_PRIMARY_ID) {
?>
<div class="comment-form-area">
<?php
// ---------------------------------------------------
// コメント追加
// ---------------------------------------------------
if (!empty($input_thread->admin_thread_id)) {
	$c_ts = strtotime($input_thread->datetime);
	$c_date = date('Y-m-d H:i:s', $c_ts);
	$c_date_jp = date('Y年n月j日 G:i', $c_ts);
	$c_rem = $input_comment->ac_rel_second % 3600;
	$c_hour = floor($input_comment->ac_rel_second / 3600);
	$c_min = floor($c_rem / 60);
	$c_sec = $c_rem % 60;
	if (!empty($admin_comments)) {
		$c_ts = strtotime($input_thread->datetime) + $admin_comments[0]->ac_rel_second + 600;
		$c_date = date('Y-m-d H:i:s', $c_ts);
		$c_date_jp = date('Y年n月j日 G:i', $c_ts);
		$c_rem = ($admin_comments[0]->ac_rel_second + 600) % 3600;
		$c_hour = floor($admin_comments[0]->ac_rel_second / 3600);
		$c_min = floor($c_rem / 60);
		$c_sec = $c_rem % 60;
	}
?>
<form class="comment post-comment-form" method="post" action="/admin/post/thread<?php echo empty($input_thread->admin_thread_id) ? '' : '/' . $input_thread->admin_thread_id; ?>">
<ul class="header">
<li class="select-user">
<select id="admin-comment-user-select" name="user">
<option value="">選択してください</option>
<?php
foreach ($admin_users as $user) {
?>
<option value="<?php echo $user->user_id; ?>"<?php echo ($input_comment->user_id == $user->user_id) ? ' selected' : ''; ?>>@<?php echo $user->u_twitter_id; ?></option>
<?php
}
?>
</select>
</li>
<li class="thumb"><button class="ufav-button" type="button"><img id="admin-comment-user-thumb" src=""></button></li>
<li class="name"><a id="admin-comment-user-name" href=""></a></li>
</ul>
<ul class="header">
<li class="date"><time datetime="<?php echo $c_date; ?>"><?php echo $c_date_jp; ?></time></li>
<li class="rel-hour">時間：<input type="number" name="admin_comment_rel_hour" value="<?php echo $c_hour; ?>" min="0"></li>
<li class="rel-min">分：<input type="number" name="admin_comment_rel_min" value="<?php echo $c_min; ?>" min="0" max="59"></li>
<li class="rel-sec">秒：<input type="number" name="admin_comment_rel_sec" value="<?php echo $c_sec; ?>" min="0" max="59"></li>
</ul>
<div class="body-group">
<div class="post-body">
<textarea name="comment_body" rows="5" placeholder="コメントの本文"><?php echo $input_comment->body; ?></textarea>
</div>
</div>
<button class="admin-comment-post" type="submit" name="admin_submit" value="add_comment">レスを追加</button>
</form>
<?php
// ---------------------------------------------------
// 追加済みコメント
// ---------------------------------------------------
if (!empty($admin_comments)) {
?>
<div class="comments">
<?php
	foreach ($admin_comments as $comment) {
		$c_ts = strtotime($comment->ac_datetime);
		$c_date = date('Y-m-d H:i:s', $c_ts);
		$c_date_jp = date('Y年n月j日 G:i', $c_ts);
		$c_rem = $comment->ac_rel_second % 3600;
		$c_hour = floor($comment->ac_rel_second / 3600);
		$c_min = floor($c_rem / 60);
		$c_sec = $c_rem % 60;
?>
<form class="comment comment-<?php echo $comment->admin_comment_id; ?>" method="post" action="/admin/post/thread<?php echo empty($input_thread->admin_thread_id) ? '' : '/' . $input_thread->admin_thread_id; ?>">
<input type="hidden" name="admin_comment_id" value="<?php echo $comment->admin_comment_id; ?>">
<ul class="header">
<li class="thumb"><button class="ufav-button" type="button" value="<?php echo $comment->u_twitter_id; ?>"><img src="<?php echo $comment->u_twitter_profile_image; ?>"></button></li>
<li class="name"><a href="/u/<?php echo $comment->u_twitter_id; ?>">@<?php echo $comment->u_twitter_id; ?></a></li>
</ul>
<ul class="header">
<li class="date"><time datetime="<?php echo $c_date; ?>"><?php echo $c_date_jp; ?></time></li>
<li class="rel-hour">時間：<input type="number" name="admin_comment_rel_hour" value="<?php echo $c_hour; ?>" min="0"></li>
<li class="rel-min">分：<input type="number" name="admin_comment_rel_min" value="<?php echo $c_min; ?>" min="0" max="59"></li>
<li class="rel-sec">秒：<input type="number" name="admin_comment_rel_sec" value="<?php echo $c_sec; ?>" min="0" max="59"></li>
</ul>
<div class="body"><p><?php echo $comment->ac_body; ?></p></div>
<ul class="footer">
<?php
if (empty($comment->ac_comment_id)) {
?>
<li><button type="submit" name="admin_submit" value="update_comment">更新</button></li>
<li><button type="submit" name="admin_submit" value="delete_comment">削除</button></li>
<?php
} else {
?>
<li>投稿済み</li>
<?php
}
?>
</ul>
</form>
<?php
	}
?>
</div>
<?php
}
?>
<?php
}
?>
</div>
<?php
// ---------------------------------------------------
// スレッド編集
// ---------------------------------------------------
?>
<div class="form-common form-thread">
<script>
if (window.history.replaceState) {
	history.replaceState(null, null, '/admin/post/thread<?php echo empty($input_thread->admin_thread_id) ? '' : '/' . $input_thread->admin_thread_id; ?>');
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
<h1><i class="fa fa-pencil" aria-hidden="true"></i><?php echo empty($input_thread->admin_thread_id) ? '新規スレッド' : 'スレッド編集：' . $input_thread->admin_thread_id; ?></h1>
<form id="form-thread" method="post" action="/admin/post/thread<?php echo empty($input_thread->admin_thread_id) ? '' : '/' . $input_thread->admin_thread_id; ?>">
<h2><var>1</var>ユーザー</h2>
<div class="user-group">
<select id="admin-thread-user-select" name="user">
<option value="">選択してください</option>
<?php
foreach ($admin_users as $user) {
?>
<option value="<?php echo $user->user_id; ?>"<?php echo ($user->user_id == $input_thread->user_id) ? ' selected' : ''; ?>>@<?php echo $user->u_twitter_id ?></option>
<?php
}
?>
</select>
<a id="admin-thread-user-name" href="<?php echo empty($admin_thread) ? '' : 'https://twitter.com/' . $admin_thread->u_twitter_id; ?>" target="_blank"><img src="<?php echo empty($admin_thread) ? '' : $admin_thread->u_twitter_profile_image; ?>"></a>
</div>
<h2><var>2</var>タイトル</h2>
<div class="text-group title-group">
<p id="title-count"><?php echo THREAD_TITLE_LENGTH; ?></p>
<input id="title-text" type="text" name="title" value="<?php echo $input_thread->title; ?>" placeholder="スレッドのタイトル">
</div>
<h2><var>3</var>本文</h2>
<div class="body-group">
<div class="post-body">
<textarea id="comment-body" name="body" rows="1" placeholder="スレッドの本文"><?php echo $input_thread->body; ?></textarea>
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
<h2><var>4</var>カテゴリ</h2>
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
<option class="main" value="<?php echo $category->category_id; ?>"<?php echo ($category->category_id == $input_thread->category_id) ? ' selected' : ''; ?>><?php echo $category->cat_word; ?></option>
<?php
		if (!empty($category->subs)) {
			foreach ($category->subs as $sub) {
?>
<option value="<?php echo $sub->category_id; ?>"<?php echo ($sub->category_id == $input_thread->category_id) ? ' selected' : ''; ?>><?php echo $sub->cat_word; ?></option>
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
<h2><var>5</var>タグ</h2>
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
if (!empty($input_thread->tags)) {
	foreach ($input_thread->tags as $tag) {
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
<h2><var>6</var>投稿日付</h2>
<div class="date-group">
<input type="text" name="date" value="<?php echo $input_thread->datetime; ?>">
</div>
<?php
if (!empty($input_thread->admin_thread_id)) {
?>
<h2><var>7</var>状態</h2>
<div class="status-group">
<?php
if ($input_thread->status == 2) {
?>
<span>投稿済み</span>
<input type="hidden" name="status" value="2">
<?php
} else {
?>
<label><input type="radio" name="status" value="0"<?php echo ($input_thread->status == 0) ? 'checked' : ''; ?>> 非公開</label>
<label><input type="radio" name="status" value="1"<?php echo ($input_thread->status == 1) ? 'checked' : ''; ?>> 予約</label>
<?php
}
?>
</div>
<?php
}
?>
<div class="submit_group">
<button id="submit" type="submit" name="admin_submit" value="thread_<?php echo empty($input_thread->admin_thread_id) ? 'post' : 'update'; ?>"><i class="fa fa-commenting" aria-hidden="true"></i>スレッドを<?php echo empty($input_thread->admin_thread_id) ? '作成' : '更新'; ?></button>
<?php
if (!empty($input_thread->admin_thread_id)) {
?>
<button class="admin-thread-delete" type="submit" name="admin_submit" value="thread_delete"><i class="fa fa-times" aria-hidden="true"></i>スレッドを削除</button>
<?php
}
?>
</div>
</form>
</div>
<script>
var xyz_users = <?php echo json_encode($admin_users, JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT); ?>;
</script>
<?php
}
?>
