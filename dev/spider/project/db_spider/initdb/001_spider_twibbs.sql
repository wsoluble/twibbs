-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- ホスト: db-server
-- 生成日時: 2021 年 5 月 17 日 08:12
-- サーバのバージョン： 10.4.19-MariaDB-1:10.4.19+maria~bionic-log
-- PHP のバージョン: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- データベース: `spider_twibbs`
--
CREATE DATABASE IF NOT EXISTS `spider_twibbs` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `spider_twibbs`;

-- --------------------------------------------------------

--
-- テーブルの構造 `category`
--

CREATE TABLE `category` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `cat_word` varchar(150) NOT NULL,
  `cat_url_name` varchar(50) DEFAULT NULL,
  `cat_parent` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `cat_sort` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `cat_description` text NOT NULL,
  `cat_hide` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `cat_thread_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `cat_comment_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `cat_first_thread_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cat_last_thread_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_site", table "category"';

-- --------------------------------------------------------

--
-- テーブルの構造 `comment`
--

CREATE TABLE `comment` (
  `comment_id` bigint(20) UNSIGNED NOT NULL,
  `c_user_id` bigint(20) UNSIGNED NOT NULL,
  `c_thread_id` bigint(20) UNSIGNED NOT NULL,
  `c_thread_user_id` bigint(20) UNSIGNED NOT NULL,
  `c_main_category` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `c_sub_category` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `c_body` text NOT NULL,
  `c_ip` text DEFAULT NULL,
  `c_privated` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `c_datetime` datetime NOT NULL,
  `c_report_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `c_first_report_id` bigint(20) UNSIGNED DEFAULT NULL,
  `c_last_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`comment_id`)
(
PARTITION p_comment_0001 VALUES LESS THAN (1000000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_comment", table "comment_0001"',
PARTITION p_comment_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_comment", table "comment_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_report`
--

CREATE TABLE `comment_report` (
  `comment_report_id` bigint(20) UNSIGNED NOT NULL,
  `cr_user_id` bigint(20) UNSIGNED NOT NULL,
  `cr_comment_id` bigint(20) UNSIGNED NOT NULL,
  `cr_comment_user_id` bigint(20) UNSIGNED NOT NULL,
  `cr_thread_id` bigint(20) UNSIGNED NOT NULL,
  `cr_thread_user_id` bigint(20) UNSIGNED NOT NULL,
  `cr_body` text NOT NULL,
  `cr_report_type` tinyint(4) UNSIGNED NOT NULL,
  `cr_privated` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `cr_datetime` datetime NOT NULL,
  `cr_ip` text DEFAULT NULL,
  `cr_host` text DEFAULT NULL,
  `cr_ua` text DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`comment_report_id`)
(
PARTITION p_comment_report_0001 VALUES LESS THAN (1000000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_comment_report", table "comment_report_0001"',
PARTITION p_comment_report_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_comment_report", table "comment_report_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_report_comment`
--

CREATE TABLE `comment_report_comment` (
  `crc_user_id` bigint(20) UNSIGNED NOT NULL,
  `crc_comment_id` bigint(20) UNSIGNED NOT NULL,
  `comment_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`crc_comment_id`)
(
PARTITION p_comment_report_comment_0001 VALUES LESS THAN (100000000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_comment_report", table "comment_report_comment_0001"',
PARTITION p_comment_report_comment_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_comment_report", table "comment_report_comment_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_report_user`
--

CREATE TABLE `comment_report_user` (
  `cru_user_id` bigint(20) UNSIGNED NOT NULL,
  `cru_comment_id` bigint(20) UNSIGNED NOT NULL,
  `comment_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`cru_user_id`)
(
PARTITION p_comment_report_user_0001 VALUES LESS THAN (1000000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_comment_report", table "comment_report_user_0001"',
PARTITION p_comment_report_user_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_comment_report", table "comment_report_user_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `guest_comment_report`
--

CREATE TABLE `guest_comment_report` (
  `guest_comment_report_id` bigint(20) UNSIGNED NOT NULL,
  `gcr_name` text NOT NULL,
  `gcr_email` text NOT NULL,
  `gcr_comment_id` bigint(20) UNSIGNED NOT NULL,
  `gcr_body` text NOT NULL,
  `gcr_report_type` tinyint(4) UNSIGNED NOT NULL,
  `gcr_datetime` datetime NOT NULL,
  `gcr_ip` text DEFAULT NULL,
  `gcr_host` text DEFAULT NULL,
  `gcr_ua` text DEFAULT NULL,
  `gcr_checked` tinyint(1) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_site", table "guest_comment_report"';

-- --------------------------------------------------------

--
-- テーブルの構造 `guest_thread_report`
--

CREATE TABLE `guest_thread_report` (
  `guest_thread_report_id` bigint(20) UNSIGNED NOT NULL,
  `gtr_name` text NOT NULL,
  `gtr_email` text NOT NULL,
  `gtr_thread_id` bigint(20) UNSIGNED NOT NULL,
  `gtr_body` text NOT NULL,
  `gtr_report_type` tinyint(4) UNSIGNED NOT NULL,
  `gtr_datetime` datetime NOT NULL,
  `gtr_ip` text DEFAULT NULL,
  `gtr_host` text DEFAULT NULL,
  `gtr_ua` text DEFAULT NULL,
  `gtr_checked` tinyint(1) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_site", table "guest_thread_report"';

-- --------------------------------------------------------

--
-- テーブルの構造 `report_type`
--

CREATE TABLE `report_type` (
  `report_type_id` tinyint(3) UNSIGNED NOT NULL,
  `rt_name` text NOT NULL,
  `rt_body` text NOT NULL,
  `rt_count_thread` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `rt_count_comment` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `rt_hide_thread` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `rt_hide_comment` tinyint(1) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_site", table "report_type"';

-- --------------------------------------------------------

--
-- テーブルの構造 `site`
--

CREATE TABLE `site` (
  `s_pv_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `s_user_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `s_thread_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `s_thread_favorite_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `s_thread_report_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `s_comment_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `s_comment_report_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `s_privated_thread_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `s_privated_comment_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `s_comment_max_per_thread` int(10) UNSIGNED NOT NULL DEFAULT 100
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_site", table "site"';

-- --------------------------------------------------------

--
-- テーブルの構造 `site_infomation`
--

CREATE TABLE `site_infomation` (
  `si_datetime` datetime NOT NULL,
  `si_body` text NOT NULL,
  `si_hide` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_site", table "site_infomation"';

-- --------------------------------------------------------

--
-- テーブルの構造 `site_ng_ip`
--

CREATE TABLE `site_ng_ip` (
  `sn_ip` varchar(100) NOT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_site", table "site_ng_ip"';

-- --------------------------------------------------------

--
-- テーブルの構造 `site_ng_user`
--

CREATE TABLE `site_ng_user` (
  `snu_twitter_id` varchar(100) NOT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_site", table "site_ng_user"';

-- --------------------------------------------------------

--
-- テーブルの構造 `site_ng_word`
--

CREATE TABLE `site_ng_word` (
  `snw_word` varchar(50) NOT NULL,
  `snw_summary` text NOT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_site", table "site_ng_word"';

-- --------------------------------------------------------

--
-- テーブルの構造 `site_sessions`
--

CREATE TABLE `site_sessions` (
  `id` varchar(40) CHARACTER SET utf8 NOT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8 NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `data` blob NOT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_session", table "site_sessions"';

-- --------------------------------------------------------

--
-- テーブルの構造 `site_various`
--

CREATE TABLE `site_various` (
  `various_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sv_body` text NOT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_site", table "site_various"';

-- --------------------------------------------------------

--
-- テーブルの構造 `tag`
--

CREATE TABLE `tag` (
  `tag_id` int(10) UNSIGNED NOT NULL,
  `tg_word` varchar(150) NOT NULL,
  `tg_hide` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `tg_thread_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `tg_first_thread_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tg_last_thread_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_site", table "tag"';

-- --------------------------------------------------------

--
-- テーブルの構造 `thread`
--

CREATE TABLE `thread` (
  `thread_id` bigint(20) UNSIGNED NOT NULL,
  `t_user_id` bigint(20) UNSIGNED NOT NULL,
  `t_title` text NOT NULL,
  `t_body` text NOT NULL,
  `t_main_category` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `t_sub_category` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `t_ip` text DEFAULT NULL,
  `t_privated` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `t_filled` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `t_datetime` datetime NOT NULL,
  `t_comment_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `t_favorite_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `t_report_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `t_first_comment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `t_last_comment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `t_last_comment_datetime` datetime DEFAULT NULL,
  `t_first_favorite_id` bigint(20) UNSIGNED DEFAULT NULL,
  `t_last_favorite_id` bigint(20) UNSIGNED DEFAULT NULL,
  `t_first_report_id` bigint(20) UNSIGNED DEFAULT NULL,
  `t_last_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`thread_id`)
(
PARTITION p_thread_0001 VALUES LESS THAN (10000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread", table "thread_0001"',
PARTITION p_thread_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread", table "thread_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_favorite`
--

CREATE TABLE `thread_favorite` (
  `thread_favorite_id` bigint(20) UNSIGNED NOT NULL,
  `tf_user_id` bigint(20) UNSIGNED NOT NULL,
  `tf_thread_id` bigint(20) UNSIGNED NOT NULL,
  `tf_thread_user_id` bigint(20) UNSIGNED NOT NULL,
  `tf_datetime` datetime NOT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`thread_favorite_id`)
(
PARTITION p_thread_favorite_0001 VALUES LESS THAN (10000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_favorite", table "thread_favorite_0001"',
PARTITION p_thread_favorite_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_favorite", table "thread_favorite_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_favorite_thread`
--

CREATE TABLE `thread_favorite_thread` (
  `tft_user_id` bigint(20) UNSIGNED NOT NULL,
  `tft_thread_id` bigint(20) UNSIGNED NOT NULL,
  `thread_favorite_id` bigint(20) DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`tft_thread_id`)
(
PARTITION p_thread_favorite_thread_0001 VALUES LESS THAN (1000000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_favorite", table "thread_favorite_thread_0001"',
PARTITION p_thread_favorite_thread_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_favorite", table "thread_favorite_thread_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_favorite_user`
--

CREATE TABLE `thread_favorite_user` (
  `tfu_user_id` bigint(20) UNSIGNED NOT NULL,
  `tfu_thread_id` bigint(20) UNSIGNED NOT NULL,
  `thread_favorite_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`tfu_user_id`)
(
PARTITION p_thread_favorite_user_0001 VALUES LESS THAN (10000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_favorite", table "thread_favorite_user_0001"',
PARTITION p_thread_favorite_user_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_favorite", table "thread_favorite_user_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_report`
--

CREATE TABLE `thread_report` (
  `thread_report_id` bigint(20) UNSIGNED NOT NULL,
  `tr_user_id` bigint(20) UNSIGNED NOT NULL,
  `tr_thread_id` bigint(20) UNSIGNED NOT NULL,
  `tr_thread_user_id` bigint(20) UNSIGNED NOT NULL,
  `tr_body` text NOT NULL,
  `tr_report_type` tinyint(4) UNSIGNED NOT NULL,
  `tr_privated` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `tr_datetime` datetime NOT NULL,
  `tr_ip` text DEFAULT NULL,
  `tr_host` text DEFAULT NULL,
  `tr_ua` text DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`thread_report_id`)
(
PARTITION p_thread_report_0001 VALUES LESS THAN (10000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_report", table "thread_report_0001"',
PARTITION p_thread_report_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_report", table "thread_report_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_report_thread`
--

CREATE TABLE `thread_report_thread` (
  `trt_user_id` bigint(20) UNSIGNED NOT NULL,
  `trt_thread_id` bigint(20) UNSIGNED NOT NULL,
  `thread_report_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`trt_thread_id`)
(
PARTITION p_thread_report_thread_0001 VALUES LESS THAN (1000000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_report", table "thread_report_thread_0001"',
PARTITION p_thread_report_thread_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_report", table "thread_report_thread_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_report_user`
--

CREATE TABLE `thread_report_user` (
  `tru_user_id` bigint(20) UNSIGNED NOT NULL,
  `tru_thread_id` bigint(20) UNSIGNED NOT NULL,
  `thread_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`tru_user_id`)
(
PARTITION p_thread_report_user_0001 VALUES LESS THAN (10000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_report", table "thread_report_user_0001"',
PARTITION p_thread_report_user_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_report", table "thread_report_user_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_tag`
--

CREATE TABLE `thread_tag` (
  `tt_thread_id` bigint(20) UNSIGNED NOT NULL,
  `tt_number` tinyint(3) UNSIGNED NOT NULL,
  `tt_tag_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`tt_thread_id`)
(
PARTITION p_thread_tag_0001 VALUES LESS THAN (10000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_tag", table "thread_tag_0001"',
PARTITION p_thread_tag_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_thread_tag", table "thread_tag_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `user`
--

CREATE TABLE `user` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `u_twitter_id` varchar(100) NOT NULL,
  `u_twitter_name` text DEFAULT NULL,
  `u_twitter_profile_image` text DEFAULT NULL,
  `u_twitter_profile_banner` text DEFAULT NULL,
  `u_pv_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `u_thread_filled_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_thread_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_comment_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_thread_favorite_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_thread_favorited_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_comment_favorite_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_comment_favorited_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_thread_report_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_thread_reported_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_comment_report_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_comment_reported_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_privated_thread_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_privated_comment_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_privilege_thread` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `u_privilege_comment` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `u_privilege_thread_favorite` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `u_privilege_thread_report` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `u_privilege_comment_report` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `u_ng_user_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_nged_user_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_ng_word_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `u_first_thread_id` bigint(20) UNSIGNED DEFAULT NULL,
  `u_last_thread_id` bigint(20) UNSIGNED DEFAULT NULL,
  `u_first_comment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `u_last_comment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `u_first_thread_favorite_id` bigint(20) UNSIGNED DEFAULT NULL,
  `u_last_thread_favorite_id` bigint(20) UNSIGNED DEFAULT NULL,
  `u_first_thread_report_id` bigint(20) UNSIGNED DEFAULT NULL,
  `u_last_thread_report_id` bigint(20) UNSIGNED DEFAULT NULL,
  `u_first_comment_report_id` bigint(20) UNSIGNED DEFAULT NULL,
  `u_last_comment_report_id` bigint(20) UNSIGNED DEFAULT NULL,
  `u_first_ng_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `u_last_ng_user_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`user_id`)
(
PARTITION p_user_0001 VALUES LESS THAN (100000000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_user", table "user_0001"',
PARTITION p_user_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_user", table "user_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `user_key`
--

CREATE TABLE `user_key` (
  `uk_twitter_primary_id` bigint(20) UNSIGNED NOT NULL,
  `uk_user_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_user", table "user_key"';

-- --------------------------------------------------------

--
-- テーブルの構造 `user_ng`
--

CREATE TABLE `user_ng` (
  `un_user_id` bigint(20) UNSIGNED NOT NULL,
  `un_ng_user_id` bigint(20) UNSIGNED NOT NULL,
  `un_datetime` datetime NOT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`un_user_id`)
(
PARTITION p_user_ng_0001 VALUES LESS THAN (100000000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_user_ng", table "user_ng_0001"',
PARTITION p_user_ng_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_user_ng", table "user_ng_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `user_ng_word`
--

CREATE TABLE `user_ng_word` (
  `unw_user_id` bigint(20) UNSIGNED NOT NULL,
  `unw_words` mediumtext NOT NULL
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql"'
PARTITION BY RANGE (`unw_user_id`)
(
PARTITION p_user_ng_word_0001 VALUES LESS THAN (100000000) ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_user_ng", table "user_ng_word_0001"',
PARTITION p_user_ng_word_max VALUES LESS THAN MAXVALUE ENGINE=SPIDER COMMENT='srv "master", database "master_twibbs_user_ng", table "user_ng_word_0002"'
);

-- --------------------------------------------------------

--
-- テーブルの構造 `user_tw`
--

CREATE TABLE `user_tw` (
  `ut_twitter_id` varchar(100) NOT NULL COMMENT 'TwitterID',
  `ut_user_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'ユーザーID'
) ENGINE=SPIDER DEFAULT CHARSET=utf8mb4 COMMENT='wrapper "mysql", srv "master", database "master_twibbs_user", table "user_tw"';

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `cat_url_unique` (`cat_url_name`);

--
-- テーブルのインデックス `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `c_uid_cid_index` (`c_user_id`,`comment_id`) USING BTREE,
  ADD KEY `c_tid_cid_index` (`c_thread_id`,`comment_id`) USING BTREE;

--
-- テーブルのインデックス `comment_report`
--
ALTER TABLE `comment_report`
  ADD PRIMARY KEY (`comment_report_id`),
  ADD KEY `cr_tid_index` (`cr_thread_id`);

--
-- テーブルのインデックス `comment_report_comment`
--
ALTER TABLE `comment_report_comment`
  ADD PRIMARY KEY (`crc_user_id`,`crc_comment_id`),
  ADD KEY `crc_cid_crid_index` (`crc_comment_id`,`comment_report_id`);

--
-- テーブルのインデックス `comment_report_user`
--
ALTER TABLE `comment_report_user`
  ADD PRIMARY KEY (`cru_user_id`,`cru_comment_id`),
  ADD KEY `cru_uid_crid_index` (`cru_user_id`,`comment_report_id`) USING BTREE;

--
-- テーブルのインデックス `guest_comment_report`
--
ALTER TABLE `guest_comment_report`
  ADD PRIMARY KEY (`guest_comment_report_id`);

--
-- テーブルのインデックス `guest_thread_report`
--
ALTER TABLE `guest_thread_report`
  ADD PRIMARY KEY (`guest_thread_report_id`);

--
-- テーブルのインデックス `report_type`
--
ALTER TABLE `report_type`
  ADD PRIMARY KEY (`report_type_id`);

--
-- テーブルのインデックス `site_infomation`
--
ALTER TABLE `site_infomation`
  ADD PRIMARY KEY (`si_datetime`);

--
-- テーブルのインデックス `site_ng_ip`
--
ALTER TABLE `site_ng_ip`
  ADD PRIMARY KEY (`sn_ip`);

--
-- テーブルのインデックス `site_ng_word`
--
ALTER TABLE `site_ng_word`
  ADD PRIMARY KEY (`snw_word`);

--
-- テーブルのインデックス `site_sessions`
--
ALTER TABLE `site_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `site_sessions_timestamp` (`timestamp`);

--
-- テーブルのインデックス `site_various`
--
ALTER TABLE `site_various`
  ADD PRIMARY KEY (`various_name`);

--
-- テーブルのインデックス `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`tag_id`),
  ADD UNIQUE KEY `tag_word_unique` (`tg_word`);

--
-- テーブルのインデックス `thread`
--
ALTER TABLE `thread`
  ADD PRIMARY KEY (`thread_id`),
  ADD KEY `t_mcat_tid_index` (`t_main_category`,`thread_id`),
  ADD KEY `t_scat_tid_index` (`t_sub_category`,`thread_id`) USING BTREE,
  ADD KEY `t_uid_tid_index` (`t_user_id`,`thread_id`) USING BTREE;

--
-- テーブルのインデックス `thread_favorite`
--
ALTER TABLE `thread_favorite`
  ADD PRIMARY KEY (`thread_favorite_id`);

--
-- テーブルのインデックス `thread_favorite_thread`
--
ALTER TABLE `thread_favorite_thread`
  ADD PRIMARY KEY (`tft_user_id`,`tft_thread_id`),
  ADD KEY `tft_tid_tfid_index` (`tft_thread_id`,`thread_favorite_id`);

--
-- テーブルのインデックス `thread_favorite_user`
--
ALTER TABLE `thread_favorite_user`
  ADD PRIMARY KEY (`tfu_user_id`,`tfu_thread_id`),
  ADD KEY `tfu_uid_tfid_index` (`tfu_user_id`,`thread_favorite_id`);

--
-- テーブルのインデックス `thread_report`
--
ALTER TABLE `thread_report`
  ADD PRIMARY KEY (`thread_report_id`);

--
-- テーブルのインデックス `thread_report_thread`
--
ALTER TABLE `thread_report_thread`
  ADD PRIMARY KEY (`trt_user_id`,`trt_thread_id`),
  ADD KEY `trt_tid_trid_index` (`trt_thread_id`,`thread_report_id`);

--
-- テーブルのインデックス `thread_report_user`
--
ALTER TABLE `thread_report_user`
  ADD PRIMARY KEY (`tru_user_id`,`tru_thread_id`),
  ADD KEY `tru_uid_trid_index` (`tru_user_id`,`thread_report_id`) USING BTREE;

--
-- テーブルのインデックス `thread_tag`
--
ALTER TABLE `thread_tag`
  ADD PRIMARY KEY (`tt_thread_id`,`tt_number`),
  ADD UNIQUE KEY `tt_tag_tid_unique` (`tt_tag_id`,`tt_thread_id`);

--
-- テーブルのインデックス `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_twitter_id_index` (`u_twitter_id`);

--
-- テーブルのインデックス `user_key`
--
ALTER TABLE `user_key`
  ADD PRIMARY KEY (`uk_twitter_primary_id`),
  ADD UNIQUE KEY `suk_uid_unique` (`uk_user_id`) USING BTREE;

--
-- テーブルのインデックス `user_ng`
--
ALTER TABLE `user_ng`
  ADD PRIMARY KEY (`un_user_id`,`un_ng_user_id`),
  ADD KEY `un_uid_dt_index` (`un_user_id`,`un_datetime`);

--
-- テーブルのインデックス `user_ng_word`
--
ALTER TABLE `user_ng_word`
  ADD PRIMARY KEY (`unw_user_id`);

--
-- テーブルのインデックス `user_tw`
--
ALTER TABLE `user_tw`
  ADD PRIMARY KEY (`ut_twitter_id`),
  ADD KEY `sut_uid_index` (`ut_user_id`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `comment`
--
ALTER TABLE `comment`
  MODIFY `comment_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `comment_report`
--
ALTER TABLE `comment_report`
  MODIFY `comment_report_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `guest_comment_report`
--
ALTER TABLE `guest_comment_report`
  MODIFY `guest_comment_report_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `guest_thread_report`
--
ALTER TABLE `guest_thread_report`
  MODIFY `guest_thread_report_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `report_type`
--
ALTER TABLE `report_type`
  MODIFY `report_type_id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `tag`
--
ALTER TABLE `tag`
  MODIFY `tag_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `thread`
--
ALTER TABLE `thread`
  MODIFY `thread_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `thread_favorite`
--
ALTER TABLE `thread_favorite`
  MODIFY `thread_favorite_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `thread_report`
--
ALTER TABLE `thread_report`
  MODIFY `thread_report_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;
