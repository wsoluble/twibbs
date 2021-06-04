<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<nav class="main-menu">
<ul>
<li class="sidrmenu"><button class="menu-toggle main"><i class="fa fa-list-ul" aria-hidden="true"></i><?php echo SITE_NAME; ?></button></li>
<li class="breadcrumb">
<?php echo $breadcrumb; ?>
</li>
<?php
if (!empty($user)) {
?>
<li class="user">
<button class="logined sub-toggle" data-target="#menu-user"><img src="<?php echo $user->u_twitter_profile_image; ?>"></button>
</li>
<?php
} else {
?>
<li class="user">
<button class="login"><span><i class="fa fa-twitter" aria-hidden="true"></i></span></button>
</li>
<?php
}
?>
</ul>
</nav>
