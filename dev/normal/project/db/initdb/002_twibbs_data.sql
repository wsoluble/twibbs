-- phpMyAdmin SQL Dump
-- version 4.0.10.18
-- https://www.phpmyadmin.net
--
-- ホスト: localhost:3306
-- 生成日時: 2017 年 3 月 17 日 07:34
-- サーバのバージョン: 10.0.27-MariaDB-cll-lve
-- PHP のバージョン: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- データベース: `twibbs`
--
USE `twibbs`;

--
-- テーブルのデータのダンプ `admin_user`
--

INSERT INTO `admin_user` (`admin_user_id`, `au_hide`, `au_summary`) VALUES(2, 0, '');
INSERT INTO `admin_user` (`admin_user_id`, `au_hide`, `au_summary`) VALUES(3, 0, '');
INSERT INTO `admin_user` (`admin_user_id`, `au_hide`, `au_summary`) VALUES(4, 0, '');
INSERT INTO `admin_user` (`admin_user_id`, `au_hide`, `au_summary`) VALUES(5, 0, '');
INSERT INTO `admin_user` (`admin_user_id`, `au_hide`, `au_summary`) VALUES(6, 0, '');
INSERT INTO `admin_user` (`admin_user_id`, `au_hide`, `au_summary`) VALUES(7, 0, '');
INSERT INTO `admin_user` (`admin_user_id`, `au_hide`, `au_summary`) VALUES(8, 0, '');
INSERT INTO `admin_user` (`admin_user_id`, `au_hide`, `au_summary`) VALUES(9, 0, '');

--
-- テーブルのデータのダンプ `category`
--

INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(1, '雑談', 'chat', 0, 1, '', 0, 8, 70, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(2, 'AA・顔文字', 'chat_aa', 1, 1, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(3, '裏技', 'chat_trick', 1, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(4, '拾いもの', 'chat_pickup', 1, 3, '', 0, 2, 25, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(5, 'お絵かき', 'paint', 0, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(6, 'アニメキャラ', 'paint_achar', 5, 1, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(7, 'ゲームキャラ', 'paint_gchar', 5, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(8, 'オリジナル', 'paint_original', 5, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(9, '偉人', 'paint_gman', 5, 4, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(10, '自然・風景', 'paint_landscape', 5, 5, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(11, '歌ってみた', 'sing', 0, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(12, 'アニソン', 'sing_asong', 11, 1, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(13, 'ゲーソン', 'sing_gsong', 11, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(14, 'オリジナル', 'sing_original', 11, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(15, '二次創作', 'derived', 0, 4, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(16, '同人ゲーム', 'derived_game', 15, 1, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(17, '同人音楽', 'derived_music', 15, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(18, 'コスプレ', 'derived_cosplay', 15, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(19, 'アニメ', 'anime', 0, 5, '', 0, 2, 7, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(20, '新作', 'anime_new', 19, 1, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(21, 'TV放送中', 'anime_onair', 19, 2, '', 0, 1, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(22, 'OVA', 'anime_ova', 19, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(23, '劇場版', 'anime_movie', 19, 4, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(24, '声優', 'anime_vactor', 19, 5, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(25, '漫画', 'comic', 0, 6, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(26, '週刊', 'comic_magw', 25, 1, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(27, '月刊', 'comic_magm', 25, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(28, 'WEB漫画', 'comic_web', 25, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(29, '小説', 'novel', 0, 7, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(30, '現代', 'novel_modern', 29, 1, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(31, '推理', 'novel_mystery', 29, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(32, '歴史・時代', 'novel_history', 29, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(33, 'ライトノベル', 'novel_light', 29, 4, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(34, 'SF', 'novel_sfiction', 29, 5, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(35, 'ホラー', 'novel_horror', 29, 6, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(36, 'ノンフィクション', 'novel_nonfiction', 29, 7, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(37, '趣味', 'hobby', 0, 8, '', 0, 1, 1, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(38, '料理', 'hobby_cooking', 37, 1, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(39, '旅行', 'hobby_travel', 37, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(40, 'スポーツ', 'hobby_sports', 37, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(41, '動物', 'hobby_animal', 37, 4, '', 0, 1, 1, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(42, '植物', 'hobby_plant', 37, 5, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(43, 'ゲーム', 'game', 0, 9, '', 0, 1, 4, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(44, '新作', 'game_new', 43, 1, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(45, 'コンシューマ', 'game_consumer', 43, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(46, 'ソーシャル', 'game_social', 43, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(47, 'オンライン', 'game_online', 43, 4, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(48, 'ブラウザ・Flash', 'game_browser', 43, 5, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(49, 'レトロ', 'game_retro', 43, 6, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(50, '海外', 'game_foreign', 43, 7, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(51, 'インターネット', 'net', 0, 10, '', 0, 2, 16, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(52, 'ブログ', 'net_blog', 51, 1, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(53, 'SNS', 'net_sns', 51, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(54, '動画', 'net_movie', 51, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(55, '画像', 'net_picture', 51, 4, '', 0, 1, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(56, '映像・音声', 'vtech', 0, 11, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(57, '動画制作', 'vtech_pvideo', 56, 1, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(58, 'DTM', 'vtech_dtm', 56, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(59, 'ゲーム制作', 'vtech_pgame', 56, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(60, 'モバイル', 'mobile', 0, 12, '', 0, 1, 4, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(61, 'スマホ', 'mobile_sphone', 60, 1, '', 0, 1, 4, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(62, 'タブレット', 'mobile_tablet', 60, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(63, 'ガラケー', 'mobile_fphone', 60, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(64, 'パソコン', 'pc', 0, 13, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(65, 'ハードウェア', 'pc_hardware', 64, 1, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(66, 'OS', 'pc_os', 64, 2, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(67, 'アプリ', 'pc_app', 64, 3, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(68, 'ブラウザ', 'pc_browser', 64, 4, '', 0, 0, 0, NULL, NULL);
INSERT INTO `category` (`category_id`, `cat_word`, `cat_url_name`, `cat_parent`, `cat_sort`, `cat_description`, `cat_hide`, `cat_thread_count`, `cat_comment_count`, `cat_first_thread_id`, `cat_last_thread_id`) VALUES(69, 'プログラミング', 'pc_programming', 64, 5, '', 0, 0, 0, NULL, NULL);

--
-- テーブルのデータのダンプ `report_type`
--

INSERT INTO `report_type` (`report_type_id`, `rt_name`, `rt_body`, `rt_count_thread`, `rt_count_comment`, `rt_hide_thread`, `rt_hide_comment`) VALUES(1, 'その他', '<p>その他の利用規約に違反する行為、またはコンテンツの投稿</p>', 0, 0, 0, 0);
INSERT INTO `report_type` (`report_type_id`, `rt_name`, `rt_body`, `rt_count_thread`, `rt_count_comment`, `rt_hide_thread`, `rt_hide_comment`) VALUES(2, '荒らし', '<ol>\n<li>同じ内容の連続的な投稿</li>\n<li>カテゴリルールに沿わない投稿</li>\n<li>スレッドの趣旨とは関係のない投稿</li>\n</ol>', 0, 0, 0, 0);
INSERT INTO `report_type` (`report_type_id`, `rt_name`, `rt_body`, `rt_count_thread`, `rt_count_comment`, `rt_hide_thread`, `rt_hide_comment`) VALUES(3, '著作権', '<ol>\n<li>他サイトの記事の転載</li>\n<li>歌詞の転載</li>\n<li>書籍の転載</li>\n</ol>\n<p>画像や動画の埋め込みに関しては、埋め込みを提供するサイトにお問い合わせください。当サイトは画像や動画を投稿する機能は提供しておりません。</p>', 0, 0, 0, 0);
INSERT INTO `report_type` (`report_type_id`, `rt_name`, `rt_body`, `rt_count_thread`, `rt_count_comment`, `rt_hide_thread`, `rt_hide_comment`) VALUES(4, '児童ポルノ・アダルト・グロテスク', '<ol>\n<li>未成年の顔が写っている画像や映像</li>\n<li>過激で猥褻な文字表現</li>\n<li>過激で猥褻な画像・動画へのリンクや埋め込み</li>\n</ol>', 0, 0, 0, 0);
INSERT INTO `report_type` (`report_type_id`, `rt_name`, `rt_body`, `rt_count_thread`, `rt_count_comment`, `rt_hide_thread`, `rt_hide_comment`) VALUES(5, '個人情報・プライバシー', '<p>実在する個人に結びつく以下の情報を含むコンテンツ</p>\n<ol>\n<li>住所</li>\n<li>氏名</li>\n<li>電話番号</li>\n<li>メールアドレス</li>\n</ol>', 0, 0, 0, 0);
INSERT INTO `report_type` (`report_type_id`, `rt_name`, `rt_body`, `rt_count_thread`, `rt_count_comment`, `rt_hide_thread`, `rt_hide_comment`) VALUES(6, '出会い・待ち合わせ', '<p>出会いを目的とした利用</p>\n<ol>\n<li>待ち合わせ場所の掲示</li>\n<li>住所、電話番号、メールアドレスなどの個人を特定する情報の掲載</li>\n</ol>', 0, 0, 0, 0);
INSERT INTO `report_type` (`report_type_id`, `rt_name`, `rt_body`, `rt_count_thread`, `rt_count_comment`, `rt_hide_thread`, `rt_hide_comment`) VALUES(7, '罵倒・誹謗中傷', '<p>実在する個人・組織・民族への罵倒や誹謗中傷、または客観的な事実が示されない批判</p>', 0, 0, 0, 0);
INSERT INTO `report_type` (`report_type_id`, `rt_name`, `rt_body`, `rt_count_thread`, `rt_count_comment`, `rt_hide_thread`, `rt_hide_comment`) VALUES(8, '犯罪・自殺', '<p>犯罪や自殺の助長・賞賛・自慢</p>', 0, 0, 0, 0);

--
-- テーブルのデータのダンプ `site`
--

INSERT INTO `site` (`s_pv_count`, `s_user_count`, `s_thread_count`, `s_thread_favorite_count`, `s_thread_report_count`, `s_comment_count`, `s_comment_report_count`, `s_privated_thread_count`, `s_privated_comment_count`, `s_comment_max_per_thread`) VALUES(0, 9, 16, 3, 0, 102, 0, 1, 0, 100);

--
-- テーブルのデータのダンプ `site_ng_word`
--

INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('fuck', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('SEX', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('[0-9a-z_.?-]+@([0-9a-z-]+\\.)+[0-9a-z-]+', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('[0-9]{2,4}-[0-9]{2,4}-[0-9]{3,4}', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('[0-9]{3}-[0-9]{4}', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('いんもう', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('くたばれ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('ころせ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('ちんこ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('まんぐり', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('まんこ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('やりまん', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('イラマチオ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('オナニ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('オナ二', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('クリトリス', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('クンニ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('ザーメン', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('スカトロ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('セックス', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('デリヘル', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('バイブ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('パイズリ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('パイパン', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('ビッチ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('ファック', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('フェラ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('ヤリチン', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('ヤリマン', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('ローター', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('中出し', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('乱交', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('姦', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('手コキ', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('手マン', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('死ね', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('殺す', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('潮吹', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('爆乳', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('肉便器', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('肉棒', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('陰毛', '');
INSERT INTO `site_ng_word` (`snw_word`, `snw_summary`) VALUES('ＳＥＸ', '');

--
-- テーブルのデータのダンプ `thread`
--

INSERT INTO `thread` (`thread_id`, `t_user_id`, `t_title`, `t_body`, `t_main_category`, `t_sub_category`, `t_ip`, `t_privated`, `t_filled`, `t_datetime`, `t_master_twitter_posted`, `t_master_twitter_posted_datetime`, `t_comment_count`, `t_favorite_count`, `t_report_count`, `t_first_comment_id`, `t_last_comment_id`, `t_last_comment_datetime`, `t_first_favorite_id`, `t_last_favorite_id`, `t_first_report_id`, `t_last_report_id`) VALUES(1, 1, 'Welcome to textopia!', 'やあ、ようこそ。\n\nテキストルームはね、ツイッタラーなら誰でも使える掲示板だよ。\n\n自分のスレッドを立てられるし、だれかのスレッドにも参加できるから\nきっとね、いろんなお友達ができると思う。\nおもしろいスレッドを見つけたらブックマークもできるよ。', 1, 0, '126.126.187.27', 0, 0, '2017-02-19 20:21:06', 0, NULL, 5, 1, 0, 44, 91, '2017-03-13 06:10:06', 3, 3, NULL, NULL);

--
-- テーブルのデータのダンプ `user`
--

INSERT INTO `user` (`user_id`, `u_twitter_id`, `u_twitter_name`, `u_twitter_profile_image`, `u_twitter_profile_banner`, `u_pv_count`, `u_thread_filled_count`, `u_thread_count`, `u_comment_count`, `u_thread_favorite_count`, `u_thread_favorited_count`, `u_comment_favorite_count`, `u_comment_favorited_count`, `u_thread_report_count`, `u_thread_reported_count`, `u_comment_report_count`, `u_comment_reported_count`, `u_privated_thread_count`, `u_privated_comment_count`, `u_privilege_thread`, `u_privilege_comment`, `u_privilege_thread_favorite`, `u_privilege_thread_report`, `u_privilege_comment_report`, `u_ng_user_count`, `u_nged_user_count`, `u_ng_word_count`, `u_first_thread_id`, `u_last_thread_id`, `u_first_comment_id`, `u_last_comment_id`, `u_first_thread_favorite_id`, `u_last_thread_favorite_id`, `u_first_thread_report_id`, `u_last_thread_report_id`, `u_first_comment_report_id`, `u_last_comment_report_id`, `u_first_ng_user_id`, `u_last_ng_user_id`) VALUES(1, 'w_soluble_dev', '水溶性＠API開発用', 'https://pbs.twimg.com/profile_images/1395207662808100865/9Y0mD8Ho_normal.jpg', 'https://pbs.twimg.com/profile_banners/1395198975997714437/1621477572', 0, 0, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 88, 91, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` (`user_id`, `u_twitter_id`, `u_twitter_name`, `u_twitter_profile_image`, `u_twitter_profile_banner`, `u_pv_count`, `u_thread_filled_count`, `u_thread_count`, `u_comment_count`, `u_thread_favorite_count`, `u_thread_favorited_count`, `u_comment_favorite_count`, `u_comment_favorited_count`, `u_thread_report_count`, `u_thread_reported_count`, `u_comment_report_count`, `u_comment_reported_count`, `u_privated_thread_count`, `u_privated_comment_count`, `u_privilege_thread`, `u_privilege_comment`, `u_privilege_thread_favorite`, `u_privilege_thread_report`, `u_privilege_comment_report`, `u_ng_user_count`, `u_nged_user_count`, `u_ng_word_count`, `u_first_thread_id`, `u_last_thread_id`, `u_first_comment_id`, `u_last_comment_id`, `u_first_thread_favorite_id`, `u_last_thread_favorite_id`, `u_first_thread_report_id`, `u_last_thread_report_id`, `u_first_comment_report_id`, `u_last_comment_report_id`, `u_first_ng_user_id`, `u_last_ng_user_id`) VALUES(2, 'sushisuki555', 'ｇｄｇｄおむたま♨', 'https://pbs.twimg.com/profile_images/834189062290305024/QJfOfqqJ_normal.jpg', NULL, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` (`user_id`, `u_twitter_id`, `u_twitter_name`, `u_twitter_profile_image`, `u_twitter_profile_banner`, `u_pv_count`, `u_thread_filled_count`, `u_thread_count`, `u_comment_count`, `u_thread_favorite_count`, `u_thread_favorited_count`, `u_comment_favorite_count`, `u_comment_favorited_count`, `u_thread_report_count`, `u_thread_reported_count`, `u_comment_report_count`, `u_comment_reported_count`, `u_privated_thread_count`, `u_privated_comment_count`, `u_privilege_thread`, `u_privilege_comment`, `u_privilege_thread_favorite`, `u_privilege_thread_report`, `u_privilege_comment_report`, `u_ng_user_count`, `u_nged_user_count`, `u_ng_word_count`, `u_first_thread_id`, `u_last_thread_id`, `u_first_comment_id`, `u_last_comment_id`, `u_first_thread_favorite_id`, `u_last_thread_favorite_id`, `u_first_thread_report_id`, `u_last_thread_report_id`, `u_first_comment_report_id`, `u_last_comment_report_id`, `u_first_ng_user_id`, `u_last_ng_user_id`) VALUES(3, 'tarosu093', 'めりーちゃんฅ(ﾐ・ﻌ・ﾐ)ฅ', 'https://pbs.twimg.com/profile_images/834193059462074369/rVYGa28Z_normal.jpg', 'https://pbs.twimg.com/profile_banners/3507376045/1488037620', 0, 0, 1, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 32, 43, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` (`user_id`, `u_twitter_id`, `u_twitter_name`, `u_twitter_profile_image`, `u_twitter_profile_banner`, `u_pv_count`, `u_thread_filled_count`, `u_thread_count`, `u_comment_count`, `u_thread_favorite_count`, `u_thread_favorited_count`, `u_comment_favorite_count`, `u_comment_favorited_count`, `u_thread_report_count`, `u_thread_reported_count`, `u_comment_report_count`, `u_comment_reported_count`, `u_privated_thread_count`, `u_privated_comment_count`, `u_privilege_thread`, `u_privilege_comment`, `u_privilege_thread_favorite`, `u_privilege_thread_report`, `u_privilege_comment_report`, `u_ng_user_count`, `u_nged_user_count`, `u_ng_word_count`, `u_first_thread_id`, `u_last_thread_id`, `u_first_comment_id`, `u_last_comment_id`, `u_first_thread_favorite_id`, `u_last_thread_favorite_id`, `u_first_thread_report_id`, `u_last_thread_report_id`, `u_first_comment_report_id`, `u_last_comment_report_id`, `u_first_ng_user_id`, `u_last_ng_user_id`) VALUES(4, 'asaiko6', '南国', 'https://pbs.twimg.com/profile_images/664609365274423296/-ENTXJAp_normal.jpg', NULL, 0, 0, 2, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 14, 1, 102, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` (`user_id`, `u_twitter_id`, `u_twitter_name`, `u_twitter_profile_image`, `u_twitter_profile_banner`, `u_pv_count`, `u_thread_filled_count`, `u_thread_count`, `u_comment_count`, `u_thread_favorite_count`, `u_thread_favorited_count`, `u_comment_favorite_count`, `u_comment_favorited_count`, `u_thread_report_count`, `u_thread_reported_count`, `u_comment_report_count`, `u_comment_reported_count`, `u_privated_thread_count`, `u_privated_comment_count`, `u_privilege_thread`, `u_privilege_comment`, `u_privilege_thread_favorite`, `u_privilege_thread_report`, `u_privilege_comment_report`, `u_ng_user_count`, `u_nged_user_count`, `u_ng_word_count`, `u_first_thread_id`, `u_last_thread_id`, `u_first_comment_id`, `u_last_comment_id`, `u_first_thread_favorite_id`, `u_last_thread_favorite_id`, `u_first_thread_report_id`, `u_last_thread_report_id`, `u_first_comment_report_id`, `u_last_comment_report_id`, `u_first_ng_user_id`, `u_last_ng_user_id`) VALUES(5, 'seiyuchaso', '20001号', 'https://pbs.twimg.com/profile_images/832206075080241152/Rax3KGFJ_normal.jpg', 'https://pbs.twimg.com/profile_banners/4484306119/1487248411', 0, 0, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 4, 3, 69, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` (`user_id`, `u_twitter_id`, `u_twitter_name`, `u_twitter_profile_image`, `u_twitter_profile_banner`, `u_pv_count`, `u_thread_filled_count`, `u_thread_count`, `u_comment_count`, `u_thread_favorite_count`, `u_thread_favorited_count`, `u_comment_favorite_count`, `u_comment_favorited_count`, `u_thread_report_count`, `u_thread_reported_count`, `u_comment_report_count`, `u_comment_reported_count`, `u_privated_thread_count`, `u_privated_comment_count`, `u_privilege_thread`, `u_privilege_comment`, `u_privilege_thread_favorite`, `u_privilege_thread_report`, `u_privilege_comment_report`, `u_ng_user_count`, `u_nged_user_count`, `u_ng_word_count`, `u_first_thread_id`, `u_last_thread_id`, `u_first_comment_id`, `u_last_comment_id`, `u_first_thread_favorite_id`, `u_last_thread_favorite_id`, `u_first_thread_report_id`, `u_last_thread_report_id`, `u_first_comment_report_id`, `u_last_comment_report_id`, `u_first_ng_user_id`, `u_last_ng_user_id`) VALUES(6, 'kasshimashi0', '僕らはこの中の中で・・・？', 'https://pbs.twimg.com/profile_images/832028979921956865/djiVwj92_normal.jpg', NULL, 0, 0, 3, 28, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 16, 17, 101, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` (`user_id`, `u_twitter_id`, `u_twitter_name`, `u_twitter_profile_image`, `u_twitter_profile_banner`, `u_pv_count`, `u_thread_filled_count`, `u_thread_count`, `u_comment_count`, `u_thread_favorite_count`, `u_thread_favorited_count`, `u_comment_favorite_count`, `u_comment_favorited_count`, `u_thread_report_count`, `u_thread_reported_count`, `u_comment_report_count`, `u_comment_reported_count`, `u_privated_thread_count`, `u_privated_comment_count`, `u_privilege_thread`, `u_privilege_comment`, `u_privilege_thread_favorite`, `u_privilege_thread_report`, `u_privilege_comment_report`, `u_ng_user_count`, `u_nged_user_count`, `u_ng_word_count`, `u_first_thread_id`, `u_last_thread_id`, `u_first_comment_id`, `u_last_comment_id`, `u_first_thread_favorite_id`, `u_last_thread_favorite_id`, `u_first_thread_report_id`, `u_last_thread_report_id`, `u_first_comment_report_id`, `u_last_comment_report_id`, `u_first_ng_user_id`, `u_last_ng_user_id`) VALUES(7, 'sasugada0', 'ぺんぺん隊長?', 'https://pbs.twimg.com/profile_images/832103739880189952/fRKnXRoX_normal.jpg', NULL, 0, 0, 2, 7, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 13, 44, 63, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` (`user_id`, `u_twitter_id`, `u_twitter_name`, `u_twitter_profile_image`, `u_twitter_profile_banner`, `u_pv_count`, `u_thread_filled_count`, `u_thread_count`, `u_comment_count`, `u_thread_favorite_count`, `u_thread_favorited_count`, `u_comment_favorite_count`, `u_comment_favorited_count`, `u_thread_report_count`, `u_thread_reported_count`, `u_comment_report_count`, `u_comment_reported_count`, `u_privated_thread_count`, `u_privated_comment_count`, `u_privilege_thread`, `u_privilege_comment`, `u_privilege_thread_favorite`, `u_privilege_thread_report`, `u_privilege_comment_report`, `u_ng_user_count`, `u_nged_user_count`, `u_ng_word_count`, `u_first_thread_id`, `u_last_thread_id`, `u_first_comment_id`, `u_last_comment_id`, `u_first_thread_favorite_id`, `u_last_thread_favorite_id`, `u_first_thread_report_id`, `u_last_thread_report_id`, `u_first_comment_report_id`, `u_last_comment_report_id`, `u_first_ng_user_id`, `u_last_ng_user_id`) VALUES(8, 'marble332', 'どうしてマカロニ✨', 'https://pbs.twimg.com/profile_images/832064612723945472/WE5f6gW5_normal.jpg', 'https://pbs.twimg.com/profile_banners/3395525894/1440961071', 0, 0, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 15, 65, 87, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` (`user_id`, `u_twitter_id`, `u_twitter_name`, `u_twitter_profile_image`, `u_twitter_profile_banner`, `u_pv_count`, `u_thread_filled_count`, `u_thread_count`, `u_comment_count`, `u_thread_favorite_count`, `u_thread_favorited_count`, `u_comment_favorite_count`, `u_comment_favorited_count`, `u_thread_report_count`, `u_thread_reported_count`, `u_comment_report_count`, `u_comment_reported_count`, `u_privated_thread_count`, `u_privated_comment_count`, `u_privilege_thread`, `u_privilege_comment`, `u_privilege_thread_favorite`, `u_privilege_thread_report`, `u_privilege_comment_report`, `u_ng_user_count`, `u_nged_user_count`, `u_ng_word_count`, `u_first_thread_id`, `u_last_thread_id`, `u_first_comment_id`, `u_last_comment_id`, `u_first_thread_favorite_id`, `u_last_thread_favorite_id`, `u_first_thread_report_id`, `u_last_thread_report_id`, `u_first_comment_report_id`, `u_last_comment_report_id`, `u_first_ng_user_id`, `u_last_ng_user_id`) VALUES(9, 'mu86751', 'ムー@掃除当番', 'https://pbs.twimg.com/profile_images/839227335672913920/42uuD-5V_normal.jpg', NULL, 0, 0, 1, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 11, 71, 83, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- テーブルのデータのダンプ `user_key`
--

INSERT INTO `user_key` (`uk_twitter_primary_id`, `uk_user_id`) VALUES(1395198975997714437, 1);
INSERT INTO `user_key` (`uk_twitter_primary_id`, `uk_user_id`) VALUES(3526137920, 2);
INSERT INTO `user_key` (`uk_twitter_primary_id`, `uk_user_id`) VALUES(3507376045, 3);
INSERT INTO `user_key` (`uk_twitter_primary_id`, `uk_user_id`) VALUES(4206932834, 4);
INSERT INTO `user_key` (`uk_twitter_primary_id`, `uk_user_id`) VALUES(4484306119, 5);
INSERT INTO `user_key` (`uk_twitter_primary_id`, `uk_user_id`) VALUES(3412966700, 6);
INSERT INTO `user_key` (`uk_twitter_primary_id`, `uk_user_id`) VALUES(3921803473, 7);
INSERT INTO `user_key` (`uk_twitter_primary_id`, `uk_user_id`) VALUES(3395525894, 8);
INSERT INTO `user_key` (`uk_twitter_primary_id`, `uk_user_id`) VALUES(1556219948, 9);

--
-- テーブルのデータのダンプ `user_token`
--

INSERT INTO `user_token` (`utk_user_id`, `utk_access_token`, `utk_access_toke_secret`) VALUES(1, '1395198975997714437-WMYgIWoKo0XjWaBb2nBfoGnb19YEb4', 'dFbdih1pCwHimTDNYD1kEPa6SXX7QAvWQXjObWYM01adF');
INSERT INTO `user_token` (`utk_user_id`, `utk_access_token`, `utk_access_toke_secret`) VALUES(2, '3526137920-Jfd9zE7hR4obCKwpfIT83a2YEB9qeZ5wvvaJPHV', 'gwy2V2UAAjrNrrVKBfyqy1nsqTX0fFkoo5r5Caj9RV3Q0');
INSERT INTO `user_token` (`utk_user_id`, `utk_access_token`, `utk_access_toke_secret`) VALUES(3, '3507376045-12CpKFWBLYC7oD9FYJnt3UFbtyKRsjJoY62t0m9', 'zavlwwWJlQdDuJO8WbRfP0PkCqY6jGmnXNdDbKIM6Owrv');
INSERT INTO `user_token` (`utk_user_id`, `utk_access_token`, `utk_access_toke_secret`) VALUES(4, '4206932834-4ToKRHgd4LFsUZ6tAMCUEwT4oOeJHcGRFhlHxx7', '7xcs2QUgg8KsVt8RERYdXSDpvBk9hDufzv8sgmbA2IeyD');
INSERT INTO `user_token` (`utk_user_id`, `utk_access_token`, `utk_access_toke_secret`) VALUES(5, '4484306119-6zaJxVyBqfldtxrcIAgggDFDO2kyCQr5dTexPyg', 'qJtQ2PbIqb1BO342CwtPGmYbqQtVKkvAqFQPILPeeGYrh');
INSERT INTO `user_token` (`utk_user_id`, `utk_access_token`, `utk_access_toke_secret`) VALUES(6, '3412966700-XO5gQLksp5To4x4ROND2SQBtOIzxmm9Rbb9Kuy3', 'wt7HF2cPYi9ZiNx2ZVZvw9bGIUBspt8L3uPEeUb8BF6w6');
INSERT INTO `user_token` (`utk_user_id`, `utk_access_token`, `utk_access_toke_secret`) VALUES(7, '3921803473-cT8wdbEJOUBNVZ3YAqmF576QDe32a6nwhDfgj0a', 'nDxygvs1LO7XTh5XIZwG1UwvQnGtkRnUgsY6Rzt5POx97');
INSERT INTO `user_token` (`utk_user_id`, `utk_access_token`, `utk_access_toke_secret`) VALUES(8, '3395525894-JqAXwBEvVWBG9VWjW0LPK2gpqtNKmmEZaUQcKHy', 'Harbwlkg44cozKbivyj6jlFHg0B3u28keYlBnTcnRSbIb');
INSERT INTO `user_token` (`utk_user_id`, `utk_access_token`, `utk_access_toke_secret`) VALUES(9, '1556219948-4QOpAVJOGKFTOim61teKbG10aZ03RWnHJngOCX8', 'p4FUSVCJ8A9l79LrPt7iqgfUIOS0ZfKz6z7HNRYb458SF');

--
-- テーブルのデータのダンプ `user_tw`
--

INSERT INTO `user_tw` (`ut_twitter_id`, `ut_user_id`) VALUES('w_soluble_dev', 1);
INSERT INTO `user_tw` (`ut_twitter_id`, `ut_user_id`) VALUES('sushisuki555', 2);
INSERT INTO `user_tw` (`ut_twitter_id`, `ut_user_id`) VALUES('tarosu093', 3);
INSERT INTO `user_tw` (`ut_twitter_id`, `ut_user_id`) VALUES('asaiko6', 4);
INSERT INTO `user_tw` (`ut_twitter_id`, `ut_user_id`) VALUES('seiyuchaso', 5);
INSERT INTO `user_tw` (`ut_twitter_id`, `ut_user_id`) VALUES('kasshimashi0', 6);
INSERT INTO `user_tw` (`ut_twitter_id`, `ut_user_id`) VALUES('sasugada0', 7);
INSERT INTO `user_tw` (`ut_twitter_id`, `ut_user_id`) VALUES('marble332', 8);
INSERT INTO `user_tw` (`ut_twitter_id`, `ut_user_id`) VALUES('mu86751', 9);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
