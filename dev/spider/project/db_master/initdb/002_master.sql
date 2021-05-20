-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2017 年 2 月 12 日 23:27
-- サーバのバージョン： 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `master_twibbs_comment`
--
CREATE DATABASE IF NOT EXISTS `master_twibbs_comment` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `master_twibbs_comment`;

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_0001`
--

CREATE TABLE `comment_0001` (
  `comment_id` bigint(20) UNSIGNED NOT NULL COMMENT 'コメントID',
  `c_user_id` bigint(20) UNSIGNED NOT NULL,
  `c_thread_id` bigint(20) UNSIGNED NOT NULL,
  `c_thread_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレ主のユーザーID',
  `c_main_category` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '親カテゴリID',
  `c_sub_category` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'サブカテゴリID',
  `c_body` text NOT NULL COMMENT 'コメント本文',
  `c_ip` text COMMENT '投稿者のIP',
  `c_privated` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非公開 [0:公開][1:運営][2:スレ主][3:レス投稿者本人]',
  `c_datetime` datetime NOT NULL COMMENT '投稿日時',
  `c_report_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スパム報告数',
  `c_first_report_id` bigint(20) UNSIGNED DEFAULT NULL,
  `c_last_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッドコメント';

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_0002`
--

CREATE TABLE `comment_0002` (
  `comment_id` bigint(20) UNSIGNED NOT NULL COMMENT 'コメントID',
  `c_user_id` bigint(20) UNSIGNED NOT NULL,
  `c_thread_id` bigint(20) UNSIGNED NOT NULL,
  `c_thread_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレ主のユーザーID',
  `c_main_category` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '親カテゴリID',
  `c_sub_category` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'サブカテゴリID',
  `c_body` text NOT NULL COMMENT 'コメント本文',
  `c_ip` text COMMENT '投稿者のIP',
  `c_privated` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非公開 [0:公開][1:運営][2:スレ主][3:レス投稿者本人]',
  `c_datetime` datetime NOT NULL COMMENT '投稿日時',
  `c_report_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スパム報告数',
  `c_first_report_id` bigint(20) UNSIGNED DEFAULT NULL,
  `c_last_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッドコメント';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comment_0001`
--
ALTER TABLE `comment_0001`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `c_uid_cid_index` (`c_user_id`,`comment_id`) USING BTREE,
  ADD KEY `c_tid_cid_index` (`c_thread_id`,`comment_id`) USING BTREE;

--
-- Indexes for table `comment_0002`
--
ALTER TABLE `comment_0002`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `c_uid_cid_index` (`c_user_id`,`comment_id`) USING BTREE,
  ADD KEY `c_tid_cid_index` (`c_thread_id`,`comment_id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comment_0001`
--
ALTER TABLE `comment_0001`
  MODIFY `comment_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'コメントID';
--
-- AUTO_INCREMENT for table `comment_0002`
--
ALTER TABLE `comment_0002`
  MODIFY `comment_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'コメントID';--
-- Database: `master_twibbs_comment_report`
--
CREATE DATABASE IF NOT EXISTS `master_twibbs_comment_report` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `master_twibbs_comment_report`;

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_report_0001`
--

CREATE TABLE `comment_report_0001` (
  `comment_report_id` bigint(20) UNSIGNED NOT NULL COMMENT 'プライマリ',
  `cr_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告者ID',
  `cr_comment_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告対象のコメントID',
  `cr_comment_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告対象のコメント投稿者ID',
  `cr_thread_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告対象のスレッドID',
  `cr_thread_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム投稿対象のスレッド投稿者',
  `cr_body` text NOT NULL COMMENT 'スパム報告本文',
  `cr_report_type` tinyint(4) UNSIGNED NOT NULL COMMENT 'スパム報告の種類',
  `cr_privated` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非公開 [0:表示][1:運営][2:スレ主][3:投稿者本人]',
  `cr_datetime` datetime NOT NULL COMMENT 'スパム報告日時',
  `cr_ip` text COMMENT '投稿者のIP',
  `cr_host` text COMMENT '投稿者のホスト',
  `cr_ua` text COMMENT '投稿者のUA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='コメントスパム報告';

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_report_0002`
--

CREATE TABLE `comment_report_0002` (
  `comment_report_id` bigint(20) UNSIGNED NOT NULL COMMENT 'プライマリ',
  `cr_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告者ID',
  `cr_comment_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告対象のコメントID',
  `cr_comment_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告対象のコメント投稿者ID',
  `cr_thread_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告対象のスレッドID',
  `cr_thread_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム投稿対象のスレッド投稿者',
  `cr_body` text NOT NULL COMMENT 'スパム報告本文',
  `cr_report_type` tinyint(4) UNSIGNED NOT NULL COMMENT 'スパム報告の種類',
  `cr_privated` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非公開 [0:表示][1:運営][2:スレ主][3:投稿者本人]',
  `cr_datetime` datetime NOT NULL COMMENT 'スパム報告日時',
  `cr_ip` text COMMENT '投稿者のIP',
  `cr_host` text COMMENT '投稿者のホスト',
  `cr_ua` text COMMENT '投稿者のUA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='コメントスパム報告';

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_report_comment_0001`
--

CREATE TABLE `comment_report_comment_0001` (
  `crc_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告者ID',
  `crc_comment_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告対象のコメントID',
  `comment_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='コメントスパム報告';

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_report_comment_0002`
--

CREATE TABLE `comment_report_comment_0002` (
  `crc_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告者ID',
  `crc_comment_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告対象のコメントID',
  `comment_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='コメントスパム報告';

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_report_user_0001`
--

CREATE TABLE `comment_report_user_0001` (
  `cru_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告者ID',
  `cru_comment_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告対象のコメントID',
  `comment_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='コメントスパム報告';

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_report_user_0002`
--

CREATE TABLE `comment_report_user_0002` (
  `cru_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告者ID',
  `cru_comment_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告対象のコメントID',
  `comment_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='コメントスパム報告';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comment_report_0001`
--
ALTER TABLE `comment_report_0001`
  ADD PRIMARY KEY (`comment_report_id`),
  ADD KEY `cr_tid_index` (`cr_thread_id`);

--
-- Indexes for table `comment_report_0002`
--
ALTER TABLE `comment_report_0002`
  ADD PRIMARY KEY (`comment_report_id`),
  ADD KEY `cr_tid_index` (`cr_thread_id`);

--
-- Indexes for table `comment_report_comment_0001`
--
ALTER TABLE `comment_report_comment_0001`
  ADD PRIMARY KEY (`crc_user_id`,`crc_comment_id`),
  ADD KEY `crc_cid_crid_index` (`crc_comment_id`,`comment_report_id`);

--
-- Indexes for table `comment_report_comment_0002`
--
ALTER TABLE `comment_report_comment_0002`
  ADD PRIMARY KEY (`crc_user_id`,`crc_comment_id`),
  ADD KEY `crc_cid_crid_index` (`crc_comment_id`,`comment_report_id`);

--
-- Indexes for table `comment_report_user_0001`
--
ALTER TABLE `comment_report_user_0001`
  ADD PRIMARY KEY (`cru_user_id`,`cru_comment_id`),
  ADD KEY `cru_uid_crid_index` (`cru_user_id`,`comment_report_id`) USING BTREE;

--
-- Indexes for table `comment_report_user_0002`
--
ALTER TABLE `comment_report_user_0002`
  ADD PRIMARY KEY (`cru_user_id`,`cru_comment_id`),
  ADD KEY `cru_uid_crid_index` (`cru_user_id`,`comment_report_id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comment_report_0001`
--
ALTER TABLE `comment_report_0001`
  MODIFY `comment_report_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'プライマリ';
--
-- AUTO_INCREMENT for table `comment_report_0002`
--
ALTER TABLE `comment_report_0002`
  MODIFY `comment_report_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'プライマリ';--
-- Database: `master_twibbs_session`
--
CREATE DATABASE IF NOT EXISTS `master_twibbs_session` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `master_twibbs_session`;

-- --------------------------------------------------------

--
-- テーブルの構造 `site_sessions`
--

CREATE TABLE `site_sessions` (
  `id` varchar(40) CHARACTER SET utf8 NOT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8 NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `site_sessions`
--
ALTER TABLE `site_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `site_sessions_timestamp` (`timestamp`);
--
-- Database: `master_twibbs_site`
--
CREATE DATABASE IF NOT EXISTS `master_twibbs_site` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `master_twibbs_site`;

-- --------------------------------------------------------

--
-- テーブルの構造 `category`
--

CREATE TABLE `category` (
  `category_id` int(10) UNSIGNED NOT NULL COMMENT 'カテゴリID',
  `cat_word` varchar(150) NOT NULL COMMENT 'カテゴリ名',
  `cat_url_name` varchar(50) DEFAULT NULL COMMENT 'URLで使用される文字',
  `cat_parent` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '親カテゴリ',
  `cat_sort` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '表示順序',
  `cat_description` text NOT NULL COMMENT 'カテゴリ説明文(HTML)',
  `cat_hide` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0:表示 1:非表示',
  `cat_thread_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドで使用された回数',
  `cat_comment_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメント数',
  `cat_first_thread_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cat_last_thread_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='カテゴリ';

-- --------------------------------------------------------

--
-- テーブルの構造 `guest_comment_report`
--

CREATE TABLE `guest_comment_report` (
  `guest_comment_report_id` bigint(20) UNSIGNED NOT NULL COMMENT 'プライマリ',
  `gcr_name` text NOT NULL,
  `gcr_email` text NOT NULL,
  `gcr_comment_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告対象のコメントID',
  `gcr_body` text NOT NULL COMMENT 'スパム報告本文',
  `gcr_report_type` tinyint(4) UNSIGNED NOT NULL COMMENT 'スパム報告の種類',
  `gcr_datetime` datetime NOT NULL COMMENT 'スパム報告日時',
  `gcr_ip` text COMMENT '投稿者のIP',
  `gcr_host` text COMMENT '投稿者のホスト',
  `gcr_ua` text COMMENT '投稿者のUA',
  `gcr_checked` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '管理者チェック済みフラグ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ゲスト用コメントスパム報告';

-- --------------------------------------------------------

--
-- テーブルの構造 `guest_thread_report`
--

CREATE TABLE `guest_thread_report` (
  `guest_thread_report_id` bigint(20) UNSIGNED NOT NULL COMMENT 'プライマリ',
  `gtr_name` text NOT NULL,
  `gtr_email` text NOT NULL,
  `gtr_thread_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム報告対象のスレッドID',
  `gtr_body` text NOT NULL COMMENT 'スパム報告本文',
  `gtr_report_type` tinyint(4) UNSIGNED NOT NULL COMMENT 'スパム報告の種類',
  `gtr_datetime` datetime NOT NULL COMMENT 'スパム報告日時',
  `gtr_ip` text COMMENT '投稿者のIP',
  `gtr_host` text COMMENT '投稿者のホスト',
  `gtr_ua` text COMMENT '投稿者のUA',
  `gtr_checked` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '管理者チェック済みフラグ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ゲスト用スレッドスパム報告';

-- --------------------------------------------------------

--
-- テーブルの構造 `report_type`
--

CREATE TABLE `report_type` (
  `report_type_id` tinyint(3) UNSIGNED NOT NULL COMMENT 'スパム報告の種類ID',
  `rt_name` text NOT NULL COMMENT '表示名',
  `rt_body` text NOT NULL COMMENT '本文',
  `rt_count_thread` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドでの使用回数',
  `rt_count_comment` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'レスでの使用回数',
  `rt_hide_thread` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドで非表示にするか 0:表示 1:非表示',
  `rt_hide_comment` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'レスで非表示にするか 0:表示 1:非表示'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スパム報告の種類';

-- --------------------------------------------------------

--
-- テーブルの構造 `site`
--

CREATE TABLE `site` (
  `s_pv_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '全PV数',
  `s_user_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '全ユーザー数',
  `s_thread_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '全スレッド数',
  `s_thread_favorite_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '総スレッドふぁぼ数',
  `s_thread_report_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '総スレッドスパム報告数',
  `s_comment_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '全コメント数',
  `s_comment_report_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '総コメントスパム報告数',
  `s_privated_thread_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非公開スレッド数',
  `s_privated_comment_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非公開コメント数',
  `s_comment_max_per_thread` int(10) UNSIGNED NOT NULL DEFAULT '100' COMMENT '１スレッドのコメント数の上限'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='サイト情報';

-- --------------------------------------------------------

--
-- テーブルの構造 `site_infomation`
--

CREATE TABLE `site_infomation` (
  `si_datetime` datetime NOT NULL,
  `si_body` text NOT NULL,
  `si_hide` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `site_ng_ip`
--

CREATE TABLE `site_ng_ip` (
  `sn_ip` varchar(100) NOT NULL COMMENT 'NGIPアドレス'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='NGIPアドレス';

-- --------------------------------------------------------

--
-- テーブルの構造 `site_ng_user`
--

CREATE TABLE `site_ng_user` (
  `snu_twitter_id` varchar(100) NOT NULL COMMENT 'ログイン禁止TwitterID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ログイン禁止TwitterID';

-- --------------------------------------------------------

--
-- テーブルの構造 `site_ng_word`
--

CREATE TABLE `site_ng_word` (
  `snw_word` varchar(50) NOT NULL COMMENT '単語',
  `snw_summary` text NOT NULL COMMENT '説明'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='NGワード';

-- --------------------------------------------------------

--
-- テーブルの構造 `site_various`
--

CREATE TABLE `site_various` (
  `various_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sv_body` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `tag`
--

CREATE TABLE `tag` (
  `tag_id` int(10) UNSIGNED NOT NULL COMMENT 'タグID',
  `tg_word` varchar(150) NOT NULL COMMENT 'ワード',
  `tg_hide` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0:表示 1:非表示',
  `tg_thread_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッド数',
  `tg_first_thread_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最初のスレッド',
  `tg_last_thread_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後のスレッド'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='タグ';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `cat_url_unique` (`cat_url_name`);

--
-- Indexes for table `guest_comment_report`
--
ALTER TABLE `guest_comment_report`
  ADD PRIMARY KEY (`guest_comment_report_id`);

--
-- Indexes for table `guest_thread_report`
--
ALTER TABLE `guest_thread_report`
  ADD PRIMARY KEY (`guest_thread_report_id`);

--
-- Indexes for table `report_type`
--
ALTER TABLE `report_type`
  ADD PRIMARY KEY (`report_type_id`);

--
-- Indexes for table `site_infomation`
--
ALTER TABLE `site_infomation`
  ADD PRIMARY KEY (`si_datetime`);

--
-- Indexes for table `site_ng_ip`
--
ALTER TABLE `site_ng_ip`
  ADD PRIMARY KEY (`sn_ip`);

--
-- Indexes for table `site_ng_word`
--
ALTER TABLE `site_ng_word`
  ADD PRIMARY KEY (`snw_word`);

--
-- Indexes for table `site_various`
--
ALTER TABLE `site_various`
  ADD PRIMARY KEY (`various_name`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`tag_id`),
  ADD UNIQUE KEY `tag_word_unique` (`tg_word`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'カテゴリID';
--
-- AUTO_INCREMENT for table `guest_comment_report`
--
ALTER TABLE `guest_comment_report`
  MODIFY `guest_comment_report_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'プライマリ';
--
-- AUTO_INCREMENT for table `guest_thread_report`
--
ALTER TABLE `guest_thread_report`
  MODIFY `guest_thread_report_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'プライマリ';
--
-- AUTO_INCREMENT for table `report_type`
--
ALTER TABLE `report_type`
  MODIFY `report_type_id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'スパム報告の種類ID';
--
-- AUTO_INCREMENT for table `tag`
--
ALTER TABLE `tag`
  MODIFY `tag_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'タグID';--
-- Database: `master_twibbs_thread`
--
CREATE DATABASE IF NOT EXISTS `master_twibbs_thread` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `master_twibbs_thread`;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_0001`
--

CREATE TABLE `thread_0001` (
  `thread_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレッドID',
  `t_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレ主のユーザーID',
  `t_title` text NOT NULL COMMENT 'スレッドタイトル',
  `t_body` text NOT NULL COMMENT 'スレッド本文',
  `t_main_category` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'メインカテゴリID',
  `t_sub_category` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'サブカテゴリID',
  `t_ip` text COMMENT 'スレッド作成者のIP',
  `t_privated` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非公開 [0:公開][1:運営][2:スレ主本人]',
  `t_filled` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメント満杯[0:空き有り][1:満杯]',
  `t_datetime` datetime NOT NULL COMMENT 'スレッド作成日',
  `t_comment_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '書き込み数',
  `t_favorite_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'お気に入りされた回数',
  `t_report_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スパム報告カウント',
  `t_first_comment_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最初のコメントID',
  `t_last_comment_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後のコメントID',
  `t_last_comment_datetime` datetime DEFAULT NULL,
  `t_first_favorite_id` bigint(20) UNSIGNED DEFAULT NULL,
  `t_last_favorite_id` bigint(20) UNSIGNED DEFAULT NULL,
  `t_first_report_id` bigint(20) UNSIGNED DEFAULT NULL,
  `t_last_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッド';

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_0002`
--

CREATE TABLE `thread_0002` (
  `thread_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレッドID',
  `t_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレ主のユーザーID',
  `t_title` text NOT NULL COMMENT 'スレッドタイトル',
  `t_body` text NOT NULL COMMENT 'スレッド本文',
  `t_main_category` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'メインカテゴリID',
  `t_sub_category` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'サブカテゴリID',
  `t_ip` text COMMENT 'スレッド作成者のIP',
  `t_privated` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非公開 [0:公開][1:運営][2:スレ主本人]',
  `t_filled` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメント満杯[0:空き有り][1:満杯]',
  `t_datetime` datetime NOT NULL COMMENT 'スレッド作成日',
  `t_comment_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '書き込み数',
  `t_favorite_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'お気に入りされた回数',
  `t_report_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スパム報告カウント',
  `t_first_comment_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最初のコメントID',
  `t_last_comment_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後のコメントID',
  `t_last_comment_datetime` datetime DEFAULT NULL,
  `t_first_favorite_id` bigint(20) UNSIGNED DEFAULT NULL,
  `t_last_favorite_id` bigint(20) UNSIGNED DEFAULT NULL,
  `t_first_report_id` bigint(20) UNSIGNED DEFAULT NULL,
  `t_last_report_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッド';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `thread_0001`
--
ALTER TABLE `thread_0001`
  ADD PRIMARY KEY (`thread_id`),
  ADD KEY `t_mcat_tid_index` (`t_main_category`,`thread_id`),
  ADD KEY `t_scat_tid_index` (`t_sub_category`,`thread_id`),
  ADD KEY `t_uid_tid_index` (`t_user_id`,`thread_id`) USING BTREE;

--
-- Indexes for table `thread_0002`
--
ALTER TABLE `thread_0002`
  ADD PRIMARY KEY (`thread_id`),
  ADD KEY `t_mcat_tid_index` (`t_main_category`,`thread_id`),
  ADD KEY `t_scat_tid_index` (`t_sub_category`,`thread_id`),
  ADD KEY `t_uid_tid_index` (`t_user_id`,`thread_id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `thread_0001`
--
ALTER TABLE `thread_0001`
  MODIFY `thread_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'スレッドID';
--
-- AUTO_INCREMENT for table `thread_0002`
--
ALTER TABLE `thread_0002`
  MODIFY `thread_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'スレッドID';--
-- Database: `master_twibbs_thread_favorite`
--
CREATE DATABASE IF NOT EXISTS `master_twibbs_thread_favorite` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `master_twibbs_thread_favorite`;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_favorite_0001`
--

CREATE TABLE `thread_favorite_0001` (
  `thread_favorite_id` bigint(20) UNSIGNED NOT NULL COMMENT 'プライマリ',
  `tf_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'お気に入りユーザーID',
  `tf_thread_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレッドID',
  `tf_thread_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレ主ユーザーID',
  `tf_datetime` datetime NOT NULL COMMENT 'お気に入りした日時'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッドお気に入り';

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_favorite_0002`
--

CREATE TABLE `thread_favorite_0002` (
  `thread_favorite_id` bigint(20) UNSIGNED NOT NULL COMMENT 'プライマリ',
  `tf_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'お気に入りユーザーID',
  `tf_thread_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレッドID',
  `tf_thread_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレ主ユーザーID',
  `tf_datetime` datetime NOT NULL COMMENT 'お気に入りした日時'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッドお気に入り';

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_favorite_thread_0001`
--

CREATE TABLE `thread_favorite_thread_0001` (
  `tft_user_id` bigint(20) UNSIGNED NOT NULL,
  `tft_thread_id` bigint(20) UNSIGNED NOT NULL,
  `thread_favorite_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_favorite_thread_0002`
--

CREATE TABLE `thread_favorite_thread_0002` (
  `tft_user_id` bigint(20) UNSIGNED NOT NULL,
  `tft_thread_id` bigint(20) UNSIGNED NOT NULL,
  `thread_favorite_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_favorite_user_0001`
--

CREATE TABLE `thread_favorite_user_0001` (
  `tfu_user_id` bigint(20) UNSIGNED NOT NULL,
  `tfu_thread_id` bigint(20) UNSIGNED NOT NULL,
  `thread_favorite_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_favorite_user_0002`
--

CREATE TABLE `thread_favorite_user_0002` (
  `tfu_user_id` bigint(20) UNSIGNED NOT NULL,
  `tfu_thread_id` bigint(20) UNSIGNED NOT NULL,
  `thread_favorite_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `thread_favorite_0001`
--
ALTER TABLE `thread_favorite_0001`
  ADD PRIMARY KEY (`thread_favorite_id`);

--
-- Indexes for table `thread_favorite_0002`
--
ALTER TABLE `thread_favorite_0002`
  ADD PRIMARY KEY (`thread_favorite_id`);

--
-- Indexes for table `thread_favorite_thread_0001`
--
ALTER TABLE `thread_favorite_thread_0001`
  ADD PRIMARY KEY (`tft_user_id`,`tft_thread_id`),
  ADD KEY `tft_tid_tfid_index` (`tft_thread_id`,`thread_favorite_id`);

--
-- Indexes for table `thread_favorite_thread_0002`
--
ALTER TABLE `thread_favorite_thread_0002`
  ADD PRIMARY KEY (`tft_user_id`,`tft_thread_id`),
  ADD KEY `tft_tid_tfid_index` (`tft_thread_id`,`thread_favorite_id`);

--
-- Indexes for table `thread_favorite_user_0001`
--
ALTER TABLE `thread_favorite_user_0001`
  ADD PRIMARY KEY (`tfu_user_id`,`tfu_thread_id`),
  ADD KEY `tfu_uid_tfid_index` (`tfu_user_id`,`thread_favorite_id`) USING BTREE;

--
-- Indexes for table `thread_favorite_user_0002`
--
ALTER TABLE `thread_favorite_user_0002`
  ADD PRIMARY KEY (`tfu_user_id`,`tfu_thread_id`),
  ADD KEY `tfu_uid_tfid_index` (`tfu_user_id`,`thread_favorite_id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `thread_favorite_0001`
--
ALTER TABLE `thread_favorite_0001`
  MODIFY `thread_favorite_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'プライマリ';
--
-- AUTO_INCREMENT for table `thread_favorite_0002`
--
ALTER TABLE `thread_favorite_0002`
  MODIFY `thread_favorite_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'プライマリ';--
-- Database: `master_twibbs_thread_report`
--
CREATE DATABASE IF NOT EXISTS `master_twibbs_thread_report` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `master_twibbs_thread_report`;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_report_0001`
--

CREATE TABLE `thread_report_0001` (
  `thread_report_id` bigint(20) UNSIGNED NOT NULL COMMENT 'プライマリ',
  `tr_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム告発者ID',
  `tr_thread_id` bigint(20) UNSIGNED NOT NULL,
  `tr_thread_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレ主ID',
  `tr_body` text NOT NULL COMMENT 'スレッドスパム報告本文',
  `tr_report_type` tinyint(4) UNSIGNED NOT NULL COMMENT 'スパム報告の種類',
  `tr_privated` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非表示 [0:表示][1:運営][2:スレ主][3:投稿者本人]',
  `tr_datetime` datetime NOT NULL COMMENT 'スパム報告日時',
  `tr_ip` text COMMENT '投稿者のIP',
  `tr_host` text COMMENT '投稿者のホスト',
  `tr_ua` text COMMENT '投稿者のUA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッドのスパム報告';

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_report_0002`
--

CREATE TABLE `thread_report_0002` (
  `thread_report_id` bigint(20) UNSIGNED NOT NULL COMMENT 'プライマリ',
  `tr_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム告発者ID',
  `tr_thread_id` bigint(20) UNSIGNED NOT NULL,
  `tr_thread_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレ主ID',
  `tr_body` text NOT NULL COMMENT 'スレッドスパム報告本文',
  `tr_report_type` tinyint(4) UNSIGNED NOT NULL COMMENT 'スパム報告の種類',
  `tr_privated` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非表示 [0:表示][1:運営][2:スレ主][3:投稿者本人]',
  `tr_datetime` datetime NOT NULL COMMENT 'スパム報告日時',
  `tr_ip` text COMMENT '投稿者のIP',
  `tr_host` text COMMENT '投稿者のホスト',
  `tr_ua` text COMMENT '投稿者のUA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッドのスパム報告';

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_report_thread_0001`
--

CREATE TABLE `thread_report_thread_0001` (
  `trt_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム告発者ID',
  `trt_thread_id` bigint(20) UNSIGNED NOT NULL,
  `thread_report_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッドのスパム報告';

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_report_thread_0002`
--

CREATE TABLE `thread_report_thread_0002` (
  `trt_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム告発者ID',
  `trt_thread_id` bigint(20) UNSIGNED NOT NULL,
  `thread_report_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッドのスパム報告';

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_report_user_0001`
--

CREATE TABLE `thread_report_user_0001` (
  `tru_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム告発者ID',
  `tru_thread_id` bigint(20) UNSIGNED NOT NULL,
  `thread_report_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッドのスパム報告';

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_report_user_0002`
--

CREATE TABLE `thread_report_user_0002` (
  `tru_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スパム告発者ID',
  `tru_thread_id` bigint(20) UNSIGNED NOT NULL,
  `thread_report_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッドのスパム報告';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `thread_report_0001`
--
ALTER TABLE `thread_report_0001`
  ADD PRIMARY KEY (`thread_report_id`);

--
-- Indexes for table `thread_report_0002`
--
ALTER TABLE `thread_report_0002`
  ADD PRIMARY KEY (`thread_report_id`);

--
-- Indexes for table `thread_report_thread_0001`
--
ALTER TABLE `thread_report_thread_0001`
  ADD PRIMARY KEY (`trt_user_id`,`trt_thread_id`),
  ADD KEY `trt_tid_trid_index` (`trt_thread_id`,`thread_report_id`);

--
-- Indexes for table `thread_report_thread_0002`
--
ALTER TABLE `thread_report_thread_0002`
  ADD PRIMARY KEY (`trt_user_id`,`trt_thread_id`),
  ADD KEY `trt_tid_trid_index` (`trt_thread_id`,`thread_report_id`);

--
-- Indexes for table `thread_report_user_0001`
--
ALTER TABLE `thread_report_user_0001`
  ADD PRIMARY KEY (`tru_user_id`,`tru_thread_id`),
  ADD KEY `tru_uid_trid_index` (`tru_user_id`,`thread_report_id`) USING BTREE;

--
-- Indexes for table `thread_report_user_0002`
--
ALTER TABLE `thread_report_user_0002`
  ADD PRIMARY KEY (`tru_user_id`,`tru_thread_id`),
  ADD KEY `tru_uid_trid_index` (`tru_user_id`,`thread_report_id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `thread_report_0001`
--
ALTER TABLE `thread_report_0001`
  MODIFY `thread_report_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'プライマリ';
--
-- AUTO_INCREMENT for table `thread_report_0002`
--
ALTER TABLE `thread_report_0002`
  MODIFY `thread_report_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'プライマリ';--
-- Database: `master_twibbs_thread_tag`
--
CREATE DATABASE IF NOT EXISTS `master_twibbs_thread_tag` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `master_twibbs_thread_tag`;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_tag_0001`
--

CREATE TABLE `thread_tag_0001` (
  `tt_thread_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレッドID',
  `tt_number` tinyint(3) UNSIGNED NOT NULL COMMENT '使用番号(1スレッドに10個まで)',
  `tt_tag_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'タグID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッド使用タグ';

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_tag_0002`
--

CREATE TABLE `thread_tag_0002` (
  `tt_thread_id` bigint(20) UNSIGNED NOT NULL COMMENT 'スレッドID',
  `tt_number` tinyint(3) UNSIGNED NOT NULL COMMENT '使用番号(1スレッドに10個まで)',
  `tt_tag_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'タグID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='スレッド使用タグ';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `thread_tag_0001`
--
ALTER TABLE `thread_tag_0001`
  ADD PRIMARY KEY (`tt_thread_id`,`tt_number`),
  ADD UNIQUE KEY `tt_tag_tid_unique` (`tt_tag_id`,`tt_thread_id`) USING BTREE;

--
-- Indexes for table `thread_tag_0002`
--
ALTER TABLE `thread_tag_0002`
  ADD PRIMARY KEY (`tt_thread_id`,`tt_number`),
  ADD UNIQUE KEY `tt_tag_tid_unique` (`tt_tag_id`,`tt_thread_id`) USING BTREE;
--
-- Database: `master_twibbs_user`
--
CREATE DATABASE IF NOT EXISTS `master_twibbs_user` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `master_twibbs_user`;

-- --------------------------------------------------------

--
-- テーブルの構造 `user_0001`
--

CREATE TABLE `user_0001` (
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'ユーザーID',
  `u_twitter_id` varchar(100) NOT NULL COMMENT 'ツイッターID',
  `u_twitter_name` text COMMENT 'ツイッター表示名',
  `u_twitter_profile_image` text COMMENT 'ツイッターサムネイル',
  `u_twitter_profile_banner` text COMMENT 'ツイッターバナー',
  `u_pv_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'PV数',
  `u_thread_filled_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '埋まったスレッド数',
  `u_thread_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッド作成回数',
  `u_comment_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '自分のコメント回数',
  `u_thread_favorite_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ふぁぼしたスレッド数',
  `u_thread_favorited_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドふぁぼられ回数',
  `u_comment_favorite_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ふぁぼしたコメント数',
  `u_comment_favorited_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメントふぁぼられ数',
  `u_thread_report_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドスパム報告した回数',
  `u_thread_reported_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドスパムレポート数',
  `u_comment_report_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメントスパム報告した回数',
  `u_comment_reported_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメントスパム報告数',
  `u_privated_thread_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非公開化スレッド数',
  `u_privated_comment_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非公開化コメント数',
  `u_privilege_thread` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッド作成権限[0:有][1:無]',
  `u_privilege_comment` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメント権限[0:有][1:無]',
  `u_privilege_thread_favorite` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドファボ権限[0:有][1:無]',
  `u_privilege_thread_report` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドスパム報告権限[0:有][1:無]',
  `u_privilege_comment_report` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメントスパム報告権限[0:有][1:無]',
  `u_ng_user_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ユーザーNG登録した回数',
  `u_nged_user_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ユーザーNG登録された回数',
  `u_ng_word_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'NGワード数',
  `u_first_thread_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '初めて作成したスレッド',
  `u_last_thread_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後に作成したスレッド',
  `u_first_comment_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '初めて投稿したコメント',
  `u_last_comment_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後に投稿したコメント',
  `u_first_thread_favorite_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最初のスレッドお気に入り',
  `u_last_thread_favorite_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後のスレッドお気に入り',
  `u_first_thread_report_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最初のスレッド報告',
  `u_last_thread_report_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後のスレッド報告',
  `u_first_comment_report_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最初のコメント報告',
  `u_last_comment_report_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後のコメント報告',
  `u_first_ng_user_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最初のNGユーザーID',
  `u_last_ng_user_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後のNGユーザーID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ユーザー';

-- --------------------------------------------------------

--
-- テーブルの構造 `user_0002`
--

CREATE TABLE `user_0002` (
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'ユーザーID',
  `u_twitter_id` varchar(100) NOT NULL COMMENT 'ツイッターID',
  `u_twitter_name` text COMMENT 'ツイッター表示名',
  `u_twitter_profile_image` text COMMENT 'ツイッターサムネイル',
  `u_twitter_profile_banner` text COMMENT 'ツイッターバナー',
  `u_pv_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'PV数',
  `u_thread_filled_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '埋まったスレッド数',
  `u_thread_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッド作成回数',
  `u_comment_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '自分のコメント回数',
  `u_thread_favorite_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ふぁぼしたスレッド数',
  `u_thread_favorited_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドふぁぼられ回数',
  `u_comment_favorite_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ふぁぼしたコメント数',
  `u_comment_favorited_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメントふぁぼられ数',
  `u_thread_report_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドスパム報告した回数',
  `u_thread_reported_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドスパムレポート数',
  `u_comment_report_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメントスパム報告した回数',
  `u_comment_reported_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメントスパム報告数',
  `u_privated_thread_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非公開化スレッド数',
  `u_privated_comment_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '非公開化コメント数',
  `u_privilege_thread` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッド作成権限[0:有][1:無]',
  `u_privilege_comment` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメント権限[0:有][1:無]',
  `u_privilege_thread_favorite` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドファボ権限[0:有][1:無]',
  `u_privilege_thread_report` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'スレッドスパム報告権限[0:有][1:無]',
  `u_privilege_comment_report` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'コメントスパム報告権限[0:有][1:無]',
  `u_ng_user_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ユーザーNG登録した回数',
  `u_nged_user_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ユーザーNG登録された回数',
  `u_ng_word_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'NGワード数',
  `u_first_thread_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '初めて作成したスレッド',
  `u_last_thread_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後に作成したスレッド',
  `u_first_comment_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '初めて投稿したコメント',
  `u_last_comment_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後に投稿したコメント',
  `u_first_thread_favorite_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最初のスレッドお気に入り',
  `u_last_thread_favorite_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後のスレッドお気に入り',
  `u_first_thread_report_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最初のスレッド報告',
  `u_last_thread_report_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後のスレッド報告',
  `u_first_comment_report_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最初のコメント報告',
  `u_last_comment_report_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後のコメント報告',
  `u_first_ng_user_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最初のNGユーザーID',
  `u_last_ng_user_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '最後のNGユーザーID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ユーザー';

-- --------------------------------------------------------

--
-- テーブルの構造 `user_key`
--

CREATE TABLE `user_key` (
  `uk_twitter_primary_id` bigint(20) UNSIGNED NOT NULL COMMENT 'ツイッタープライマリID',
  `uk_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'ユーザーID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ユーザー';

-- --------------------------------------------------------

--
-- テーブルの構造 `user_tw`
--

CREATE TABLE `user_tw` (
  `ut_twitter_id` varchar(100) NOT NULL COMMENT 'TwitterID',
  `ut_user_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'ユーザーID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `user_0001`
--
ALTER TABLE `user_0001`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_twitter_id_index` (`u_twitter_id`);

--
-- Indexes for table `user_0002`
--
ALTER TABLE `user_0002`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_twitter_id_index` (`u_twitter_id`);

--
-- Indexes for table `user_key`
--
ALTER TABLE `user_key`
  ADD PRIMARY KEY (`uk_twitter_primary_id`),
  ADD UNIQUE KEY `suk_uid_unique` (`uk_user_id`) USING BTREE;

--
-- Indexes for table `user_tw`
--
ALTER TABLE `user_tw`
  ADD PRIMARY KEY (`ut_twitter_id`),
  ADD KEY `sut_uid_index` (`ut_user_id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user_0001`
--
ALTER TABLE `user_0001`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ユーザーID';
--
-- AUTO_INCREMENT for table `user_0002`
--
ALTER TABLE `user_0002`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ユーザーID';--
-- Database: `master_twibbs_user_ng`
--
CREATE DATABASE IF NOT EXISTS `master_twibbs_user_ng` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `master_twibbs_user_ng`;

-- --------------------------------------------------------

--
-- テーブルの構造 `user_ng_0001`
--

CREATE TABLE `user_ng_0001` (
  `un_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'ユーザーID',
  `un_ng_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'NG対象ユーザーID',
  `un_datetime` datetime NOT NULL COMMENT 'NG登録した日時'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='NGユーザー';

-- --------------------------------------------------------

--
-- テーブルの構造 `user_ng_0002`
--

CREATE TABLE `user_ng_0002` (
  `un_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'ユーザーID',
  `un_ng_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'NG対象ユーザーID',
  `un_datetime` datetime NOT NULL COMMENT 'NG登録した日時'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='NGユーザー';

-- --------------------------------------------------------

--
-- テーブルの構造 `user_ng_word_0001`
--

CREATE TABLE `user_ng_word_0001` (
  `unw_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'ユーザーID',
  `unw_words` mediumtext NOT NULL COMMENT '単語一覧（半角スペース区切り）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ユーザーNGワード';

-- --------------------------------------------------------

--
-- テーブルの構造 `user_ng_word_0002`
--

CREATE TABLE `user_ng_word_0002` (
  `unw_user_id` bigint(20) UNSIGNED NOT NULL COMMENT 'ユーザーID',
  `unw_words` mediumtext NOT NULL COMMENT '単語一覧（半角スペース区切り）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ユーザーNGワード';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `user_ng_0001`
--
ALTER TABLE `user_ng_0001`
  ADD PRIMARY KEY (`un_user_id`,`un_ng_user_id`),
  ADD KEY `un_uid_dt_index` (`un_user_id`,`un_datetime`);

--
-- Indexes for table `user_ng_0002`
--
ALTER TABLE `user_ng_0002`
  ADD PRIMARY KEY (`un_user_id`,`un_ng_user_id`),
  ADD KEY `un_uid_dt_index` (`un_user_id`,`un_datetime`);

--
-- Indexes for table `user_ng_word_0001`
--
ALTER TABLE `user_ng_word_0001`
  ADD PRIMARY KEY (`unw_user_id`);

--
-- Indexes for table `user_ng_word_0002`
--
ALTER TABLE `user_ng_word_0002`
  ADD PRIMARY KEY (`unw_user_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
