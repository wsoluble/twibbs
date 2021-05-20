<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<?php
/**
 * $base_url, $directoriesは入力必須
 */
if (!empty($directories)) {
	$d_count = count($directories);
	$d_i = 1;
	if (!empty($dir_title)) {
?>
<button data-target="#breadcrumb"><i class="fa fa-chevron-down" aria-hidden="true"></i><?php echo $dir_title; ?></button>
<?php
	}
?>
<ul id="breadcrumb">
<?php
		foreach ($directories as $dir) {
			if ($d_i != $d_count) {
?>
<li itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
<a href="<?php echo $base_url . $dir['dir']; ?>" itemprop="url"><span itemprop="title"><?php echo $dir['title']; ?></span></a>
</li>
<?php
			} else {
?>
<li class="active" itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
<span itemprop="title"><?php echo $dir['title']; ?></span>
</li>
<?php
			}
			$d_i++;
		}
?>
</ul>
<?php
}
?>
