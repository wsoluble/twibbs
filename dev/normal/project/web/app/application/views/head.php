<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<meta charset="utf-8">
<?php
if (!empty($params['nofollow'])) {
?>
<meta name="robots" content="noindex,nofollow,noarchive">
<?php
}
?>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" type="image/x-icon" href="/img/favicon.ico">
<link rel="apple-touch-icon" href="/img/touch.png">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
<?php
if (!empty($params['canonical'])) {
?>
<link rel="canonical" href="<?php echo (empty($_SERVER['HTTPS']) ? 'http://' : 'https://') . $_SERVER['HTTP_HOST'] . $params['canonical']; ?>">
<?php
}
?>
<?php
if (!empty($params['rss'])) {
?>
<link rel="alternate" type="application/rss+xml" title="RSS" href="<?php echo (empty($_SERVER['HTTPS']) ? 'http://' : 'https://') . $_SERVER['HTTP_HOST'] . $params['rss']; ?>">
<?php
}
?>
<base href="<?php echo base_url(); ?>"></base>
<title><?php
if (!empty($params['title'])) {
	echo $params['title'] . ' - ' . SITE_NAME;
} else {
	echo SITE_NAME . ' | ' . SITE_SUBTITLE;
}?></title>
<?php
if (!empty($params['description'])) {
?>
<meta name="description" content="<?php echo $params['description']; ?>">
<?php
}
?>
<?php
if (!empty($params['keywords'])) {
?>
<meta name="keywords" content="<?php echo htmlspecialchars(implode(',', $params['keywords']), ENT_QUOTES); ?>">
<?php
}
?>
<link rel="stylesheet" href="/css/sanitize.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0-rc.2/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/css/template.css">
<?php
if (!empty($params['c_name'])) {
	switch ($params['c_name']) {
		case 'post':
?>
<link href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
<?php
			break;

		case 'admin_post':
?>
<link href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
<link rel="stylesheet" href="/css/xyz_admin.css">
<?php
			break;

		default:
			break;
	}
}
?>
<link href="/css/foundation-icons.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<!--[if lt IE 9]>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<!--<![endif]-->
<script src="https://code.jquery.com/ui/1.12.0-rc.2/jquery-ui.min.js" integrity="sha256-55Jz3pBCF8z9jBO1qQ7cIf0L+neuPTD1u7Ytzrp2dqo=" crossorigin="anonymous"></script>
<script src="//cdn.jsdelivr.net/jquery.sidr/2.2.1/jquery.sidr.min.js"></script>
<script src="/js/headroom.min.js"></script>
<script src="/js/jQuery.headroom.js"></script>
<script src="/js/jquery.inview.min.js"></script>
<script src="/js/template.js"></script>
<?php
if (!empty($params['c_name'])) {
	switch ($params['c_name']) {
		case 'top':
?>

<?php
			break;

		case 'entry':
			break;

		case 'thread':
?>
<script src="/js/thread.js"></script>
<?php
			break;

		case 'tag':
?>
<script src="/js/tag.js"></script>
<?php
			break;

		case 'post':
?>
<script src="http://code.jquery.com/ui/1.12.0/jquery-ui.js" integrity="sha256-0YPKAwZP7Mp3ALMRVB2i8GXeEndvCq3eSl/WsAl1Ryk=" crossorigin="anonymous"></script>
<script src="/js/post.js"></script>
<?php
			break;

		case 'report':
?>
<script src="/js/report.js"></script>
<?php
			break;

		case 'admin_post':
?>
<script src="http://code.jquery.com/ui/1.12.0/jquery-ui.js" integrity="sha256-0YPKAwZP7Mp3ALMRVB2i8GXeEndvCq3eSl/WsAl1Ryk=" crossorigin="anonymous"></script>
<script src="/js/xyz_admin.js"></script>
<?php
			break;

		default:
			break;
	}
}
?>
<script src="//twemoji.maxcdn.com/2/twemoji.min.js?2.2"></script>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<?php
if (!empty($params['og'])) {
?>
<meta property="og:title" content="<?php echo $params['og']['title']; ?>" />
<meta property="og:type" content="<?php echo $params['og']['type']; ?>" />
<meta property="og:url" content="<?php echo (empty($_SERVER['HTTPS']) ? 'http://' : 'https://') . $_SERVER['HTTP_HOST'] . $params['og']['url']; ?>" />
<meta property="og:site_name"  content="<?php echo SITE_NAME; ?>" />
<meta property="og:description" content="<?php echo $params['og']['description']; ?>" />
<?php
	if (!empty($params['og']['image'])) {
?>
<meta property="og:image" content="<?php echo $params['og']['image']; ?>" />
<?php
	}
}
?>
<?php
if (!empty($params['twitter'])) {
?>
<meta name="twitter:card" content="<?php echo $params['twitter']['card']; ?>">
<meta name="twitter:site" content="@<?php echo SITE_TWITTER_ID; ?>">
<?php
	if (!empty($params['twitter']['image'])) {
?>
<meta name="twitter:image" content="<?php echo $params['twitter']['image']; ?>" />
<?php
	}
}
?>
<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
	ga('create', 'UA-91966519-1', 'auto');
	ga('send', 'pageview');
</script>
<script>window.twttr = (function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0],
		t = window.twttr || {};
	if (d.getElementById(id)) return t;
	js = d.createElement(s);
	js.id = id;
	js.src = "https://platform.twitter.com/widgets.js";
	fjs.parentNode.insertBefore(js, fjs);

	t._e = [];
	t.ready = function(f) {
		t._e.push(f);
	};

	return t;
}(document, "script", "twitter-wjs"));</script>
