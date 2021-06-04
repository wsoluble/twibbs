-- phpMyAdmin SQL Dump
-- version 4.0.10.18
-- https://www.phpmyadmin.net
--
-- ホスト: localhost:3306
-- 生成日時: 2017 年 3 月 17 日 07:33
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
CREATE DATABASE IF NOT EXISTS `twibbs` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `twibbs`;

DELIMITER $$
--
-- プロシージャ
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_delete_comment_report`(IN `fa_report_user_id` BIGINT, IN `fa_comment_id` BIGINT)
main:BEGIN
	
	IF fa_report_user_id IS NULL OR fa_comment_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	UPDATE comment_report SET cr_body = '', cr_privated = 1, cr_ip = '', cr_host = '', cr_ua = '' WHERE cr_user_id = fa_report_user_id AND cr_comment_id = fa_comment_id;
	COMMIT;
	SELECT 1 AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_delete_thread_report`(IN `fa_report_user_id` BIGINT, IN `fa_thread_id` BIGINT)
main:BEGIN
	
	IF fa_report_user_id IS NULL OR fa_thread_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	START TRANSACTION;
	UPDATE thread_report SET tr_body = '', tr_privated = 1, tr_ip = '', tr_host = '', tr_ua = '' WHERE tr_user_id = fa_report_user_id AND tr_thread_id = fa_thread_id;
	COMMIT;
	SELECT 1 AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_remove_comment`(IN `fa_comment_id` BIGINT)
main:BEGIN
	
	IF fa_comment_id IS NULL OR fa_comment_id = 0 THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	UPDATE comment SET c_main_category = 0, c_sub_category = 0, c_body = '', c_ip = '', c_privated = 1 WHERE comment_id = fa_comment_id;
	DELETE comment_report, comment_report_user, comment_report_comment
		FROM comment_report_comment
		INNER JOIN comment_report ON comment_report.comment_report_id = comment_report_comment.comment_report_id
		INNER JOIN comment_report_user ON comment_report_user.cru_user_id = comment_report_comment.crc_user_id AND comment_report_user.cru_comment_id = comment_report_comment.crc_comment_id
	WHERE comment_report_comment.crc_comment_id = fa_comment_id;
	COMMIT;
	SELECT 1 AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_remove_thread`(IN `fa_thread_id` BIGINT)
main:BEGIN

	DECLARE fv_thread_id BIGINT;

	
	IF fa_thread_id IS NULL OR fa_thread_id = 0 THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;

	
	SELECT thread_id INTO fv_thread_id FROM thread WHERE thread_id = fa_thread_id LIMIT 1;
	IF fv_thread_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;

	
	START TRANSACTION;
	UPDATE thread SET t_title = '', t_body = '', t_main_category = 0, t_sub_category = 0, t_ip = '', t_privated = 1 WHERE thread_id = fa_thread_id;
	DELETE thread_favorite, thread_favorite_user, thread_favorite_thread
		FROM thread_favorite_thread
		INNER JOIN thread_favorite ON thread_favorite.thread_favorite_id = thread_favorite_thread.thread_favorite_id
		INNER JOIN thread_favorite_user ON thread_favorite_user.tfu_user_id = thread_favorite_thread.tft_user_id AND thread_favorite_user.tfu_thread_id = thread_favorite_thread.tft_thread_id
	WHERE thread_favorite_thread.tft_thread_id = fa_thread_id;
	DELETE thread_report, thread_report_user, thread_report_thread
		FROM thread_report_thread
		INNER JOIN thread_report ON thread_report.thread_report_id = thread_report_thread.thread_report_id
		INNER JOIN thread_report_user ON thread_report_user.tru_user_id = thread_report_thread.trt_user_id AND thread_report_user.tru_thread_id = thread_report_thread.trt_thread_id
	WHERE thread_report_thread.trt_thread_id = fa_thread_id;
	DELETE FROM thread_tag WHERE tt_thread_id = fa_thread_id;
	DELETE FROM comment WHERE c_thread_id = fa_thread_id;
	DELETE comment_report, comment_report_user, comment_report_comment
		FROM comment_report
		INNER JOIN comment_report_user ON comment_report_user.cru_user_id = comment_report.cr_user_id AND comment_report_user.cru_comment_id = comment_report.cr_comment_id
		INNER JOIN comment_report_comment ON comment_report_comment.crc_user_id = comment_report.cr_user_id AND comment_report_comment.crc_comment_id = comment_report.cr_comment_id
	WHERE comment_report.cr_thread_id = fa_thread_id;
	COMMIT;

	SELECT fv_thread_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_comment_report`(IN `fa_report_user_id` BIGINT, IN `fa_comment_id` BIGINT, IN `fa_sess_user_id` BIGINT)
main:BEGIN
	DECLARE fv_comment_report_id BIGINT;
	DECLARE fv_report_user_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	
	IF fa_report_user_id IS NULL OR fa_comment_id IS NULL OR fa_sess_user_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	SELECT comment_report.comment_report_id, cr_user_id, cr_thread_user_id INTO fv_comment_report_id, fv_report_user_id, fv_thread_user_id FROM comment_report_user INNER JOIN comment_report ON comment_report.comment_report_id = comment_report_user.comment_report_id WHERE cru_user_id = fa_report_user_id AND cru_comment_id = fa_comment_id LIMIT 1;
	IF fv_comment_report_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	
	IF fa_sess_user_id = fv_report_user_id THEN
		START TRANSACTION;
		DELETE comment_report, comment_report_user, comment_report_comment
			FROM comment_report_comment
			INNER JOIN comment_report ON comment_report.comment_report_id = comment_report_comment.comment_report_id
			INNER JOIN comment_report_user ON comment_report_user.cru_user_id = comment_report_comment.crc_user_id AND comment_report_user.cru_comment_id = comment_report_comment.crc_comment_id
		WHERE comment_report_comment.crc_user_id = fa_report_user_id AND comment_report_comment.crc_comment_id = fa_comment_id;
		COMMIT;
	ELSEIF fa_sess_user_id = fv_thread_user_id THEN
		START TRANSACTION;
		UPDATE comment_report SET cr_body = '', cr_privated = 2, cr_ip = '', cr_host = '', cr_ua = '' WHERE cr_user_id = fa_report_user_id AND cr_comment_id = fa_comment_id;
		COMMIT;
	ELSE
		SELECT 'invalid_user' AS error;
		LEAVE main;
	END IF;
	SELECT fv_comment_report_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_thread_favorite`(IN `fa_favorite_user_id` BIGINT, IN `fa_thread_id` BIGINT)
main:BEGIN
	
	IF fa_favorite_user_id IS NULL OR fa_thread_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	DELETE thread_favorite, thread_favorite_user, thread_favorite_thread
		FROM thread_favorite_thread
		INNER JOIN thread_favorite ON thread_favorite.thread_favorite_id = thread_favorite_thread.thread_favorite_id
		INNER JOIN thread_favorite_user ON thread_favorite_user.tfu_user_id = thread_favorite_thread.tft_user_id AND thread_favorite_user.tfu_thread_id = thread_favorite_thread.tft_thread_id
	WHERE thread_favorite_thread.tft_user_id = fa_favorite_user_id AND thread_favorite_thread.tft_thread_id = fa_thread_id;
	COMMIT;
	SELECT 1 AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_thread_report`(IN `fa_report_user_id` BIGINT, IN `fa_thread_id` BIGINT, IN `fa_sess_user_id` BIGINT)
main:BEGIN
	DECLARE fv_thread_report_id BIGINT;
	DECLARE fv_report_user_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	
	IF fa_report_user_id IS NULL OR fa_thread_id IS NULL OR fa_sess_user_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	SELECT thread_report.thread_report_id, tr_user_id, tr_thread_user_id INTO fv_thread_report_id, fv_report_user_id, fv_thread_user_id FROM thread_report_user INNER JOIN thread_report ON thread_report.thread_report_id = thread_report_user.thread_report_id WHERE tru_user_id = fa_report_user_id AND tru_thread_id = fa_thread_id LIMIT 1;
	IF fv_thread_report_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	
	IF fa_sess_user_id = fv_report_user_id THEN
		START TRANSACTION;
		DELETE thread_report, thread_report_user, thread_report_thread
			FROM thread_report_thread
			INNER JOIN thread_report ON thread_report.thread_report_id = thread_report_thread.thread_report_id
			INNER JOIN thread_report_user ON thread_report_user.tru_user_id = thread_report_thread.trt_user_id AND thread_report_user.tru_thread_id = thread_report_thread.trt_thread_id
		WHERE thread_report_thread.trt_user_id = fa_report_user_id AND thread_report_thread.trt_thread_id = fa_thread_id;
		COMMIT;
	ELSEIF fa_sess_user_id = fv_thread_user_id THEN
		START TRANSACTION;
		UPDATE thread_report SET tr_body = '', tr_privated = 2, tr_ip = '', tr_host = '', tr_ua = '' WHERE tr_user_id = fa_report_user_id AND tr_thread_id = fa_thread_id;
		COMMIT;
	ELSE
		SELECT 'invalid_user' AS error;
		LEAVE main;
	END IF;
	SELECT fv_thread_report_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user_ng`(IN `fa_user_id` BIGINT, IN `fa_ng_twitter_id` VARCHAR(100))
main:BEGIN
	DECLARE fv_user_id BIGINT;
	DECLARE fv_ng_user_id BIGINT;
	
	IF fa_user_id IS NULL OR fa_ng_twitter_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	SELECT user_id INTO fv_user_id FROM user WHERE user_id = fa_user_id;
	IF fv_user_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	SELECT user_id INTO fv_ng_user_id FROM user WHERE u_twitter_id = fa_ng_twitter_id;
	IF fv_ng_user_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	DELETE FROM user_ng WHERE un_user_id = fv_user_id AND un_ng_user_id = fv_ng_user_id;
	COMMIT;
	SELECT fv_user_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_category`(IN `fa_word` VARCHAR(150), IN `fa_url_name` VARCHAR(50), IN `fa_parent` INT, IN `fa_sort` INT, IN `fa_description` TEXT)
main:BEGIN
	
	IF fa_word IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	INSERT IGNORE INTO category
		(cat_word, cat_url_name, cat_parent, cat_sort, cat_description)
		VALUES(fa_word, fa_url_name, fa_parent, fa_sort, fa_description)
		ON DUPLICATE KEY UPDATE
		cat_url_name = VALUES(cat_url_name), cat_parent = VALUES(cat_parent), cat_sort = VALUES(cat_sort), cat_description = VALUES(cat_description);
	COMMIT;
	SELECT category_id AS successful FROM category WHERE cat_word = fa_word LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_comment`(IN `fa_thread_id` BIGINT, IN `fa_user_id` BIGINT, IN `fa_body` TEXT, IN `fa_ip` TEXT)
main:BEGIN
	DECLARE fv_thread_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	DECLARE fv_main_category_id INT;
	DECLARE fv_sub_category_id INT;
	DECLARE fv_privated TINYINT;
	DECLARE fv_filled TINYINT;
	DECLARE fv_insert_id BIGINT;
	
	IF fa_thread_id IS NULL OR fa_user_id IS NULL OR fa_body IS NULL OR fa_body = '' THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	SELECT thread_id, t_user_id, t_main_category, t_sub_category, t_privated, t_filled INTO fv_thread_id, fv_thread_user_id, fv_main_category_id, fv_sub_category_id, fv_privated, fv_filled FROM thread WHERE thread_id = fa_thread_id LIMIT 1;
	IF fv_thread_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	IF fv_privated = 1 THEN
		SELECT 'privated' AS error;
		LEAVE main;
	END IF;
	IF fv_filled = 1 THEN
		SELECT 'filled' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	INSERT INTO comment
		(c_user_id, c_thread_id, c_thread_user_id, c_body, c_main_category, c_sub_category, c_ip, c_datetime)
		VALUES(fa_user_id, fa_thread_id, fv_thread_user_id, fa_body, fv_main_category_id, fv_sub_category_id, fa_ip, NOW());
	SELECT LAST_INSERT_ID() INTO fv_insert_id;
	COMMIT;
	SELECT fv_insert_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_comment_report`(IN `fa_report_user_id` BIGINT, IN `fa_comment_id` BIGINT, IN `fa_body` TEXT, IN `fa_report_type` TINYINT, IN `fa_ip` TEXT, IN `fa_host` TEXT, IN `fa_ua` TEXT)
main:BEGIN
	DECLARE fv_user_id BIGINT;
	DECLARE fv_privilege TINYINT;
	DECLARE fv_comment_id BIGINT;
	DECLARE fv_thread_id BIGINT;
	DECLARE fv_comment_user_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	DECLARE fv_report_count INT;
	DECLARE fv_privated TINYINT;
	DECLARE fv_report_type_id TINYINT;
	DECLARE fv_insert_id BIGINT;
	
	IF fa_report_user_id IS NULL OR fa_comment_id IS NULL OR fa_body = '' OR fa_report_type IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	SELECT user_id, u_privilege_thread_report INTO fv_user_id, fv_privilege FROM user WHERE user_id = fa_report_user_id LIMIT 1;
	IF fv_user_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	IF fv_privilege = 1 THEN
		SELECT 'no_privilege' AS error;
		LEAVE main;
	END IF;

	SELECT comment_id, c_user_id, c_thread_id, c_thread_user_id, c_report_count, c_privated INTO fv_comment_id, fv_comment_user_id, fv_thread_id, fv_thread_user_id, fv_report_count, fv_privated FROM comment WHERE comment_id = fa_comment_id LIMIT 1;
	IF fv_comment_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	IF fv_report_count >= 100 THEN
		SELECT 'filled' AS error;
		LEAVE main;
	END IF;
	IF fv_privated = 1 THEN
		SELECT 'privated' AS error;
		LEAVE main;
	END IF;
	SELECT report_type_id INTO fv_report_type_id FROM report_type WHERE report_type_id = fa_report_type AND rt_hide_comment = 0 LIMIT 1;
	IF fv_report_type_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	INSERT INTO comment_report_user (cru_user_id, cru_comment_id) VALUES (fa_report_user_id, fa_comment_id);
	INSERT INTO comment_report_comment (crc_user_id, crc_comment_id) VALUES (fa_report_user_id, fa_comment_id);
	INSERT INTO comment_report
		(cr_user_id, cr_comment_id, cr_comment_user_id, cr_thread_id, cr_thread_user_id, cr_body, cr_report_type, cr_datetime, cr_ip, cr_host, cr_ua)
		VALUES(fa_report_user_id, fa_comment_id, fv_comment_user_id, fv_thread_id, fv_thread_user_id, fa_body, fa_report_type, NOW(), fa_ip, fa_host, fa_ua);
	SELECT LAST_INSERT_ID() INTO fv_insert_id;
	UPDATE comment_report_user SET comment_report_id = fv_insert_id WHERE cru_user_id = fa_report_user_id AND cru_comment_id = fa_comment_id;
	UPDATE comment_report_comment SET comment_report_id = fv_insert_id WHERE crc_user_id = fa_report_user_id AND crc_comment_id = fa_comment_id;
	COMMIT;
	SELECT fv_insert_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_tag`(IN `fa_word` VARCHAR(150))
main:BEGIN
	
	IF fa_word IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	INSERT IGNORE INTO tag (tg_word) VALUES (fa_word);
	COMMIT;
	SELECT tag_id AS successful FROM tag WHERE tg_word = fa_word LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_thread`(IN `fa_user_id` BIGINT, IN `fa_title` TEXT, IN `fa_body` TEXT, IN `fa_category_id` INT, IN `fa_ip` TEXT)
main:BEGIN
	DECLARE fv_user_id BIGINT;
	DECLARE fv_parent INT;
	DECLARE fv_main_category_id INT;
	DECLARE fv_sub_category_id INT DEFAULT 0;
	DECLARE fv_insert_id BIGINT;
	
	IF fa_user_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	SELECT user_id INTO fv_user_id FROM user WHERE user_id = fa_user_id LIMIT 1;
	IF fv_user_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	IF fa_category_id != 0 THEN
		SELECT category_id, cat_parent INTO fv_main_category_id, fv_parent FROM category WHERE category_id = fa_category_id LIMIT 1;
		IF fv_main_category_id IS NULL THEN
			SELECT 'record_not_found' AS error;
			LEAVE main;
		END IF;
		IF fv_parent != 0 THEN
			SELECT category_id INTO fv_sub_category_id FROM category WHERE category_id = fv_parent LIMIT 1;
			IF fv_sub_category_id != 0 THEN
				SET fv_main_category_id = fv_parent;
				SET fv_sub_category_id = fa_category_id;
			END IF;
		END IF;
	END IF;
	
	START TRANSACTION;
	INSERT IGNORE INTO thread
		(t_user_id, t_title, t_body, t_main_category, t_sub_category, t_ip, t_datetime)
		VALUES(fa_user_id, fa_title, fa_body, fv_main_category_id, fv_sub_category_id, fa_ip, NOW());
	SELECT LAST_INSERT_ID() INTO fv_insert_id;
	COMMIT;
	SELECT fv_insert_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_thread_favorite`(IN `fa_favorite_user_id` BIGINT, IN `fa_thread_id` BIGINT)
main:BEGIN
	DECLARE fv_thread_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	DECLARE fv_insert_id BIGINT;
	
	IF fa_favorite_user_id IS NULL OR fa_thread_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	SELECT thread_id, t_user_id INTO fv_thread_id, fv_thread_user_id FROM thread WHERE thread_id = fa_thread_id LIMIT 1;
	IF fv_thread_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	INSERT INTO thread_favorite_user (tfu_user_id, tfu_thread_id) VALUES (fa_favorite_user_id, fa_thread_id);
	INSERT INTO thread_favorite_thread (tft_user_id, tft_thread_id) VALUES (fa_favorite_user_id, fa_thread_id);
	INSERT INTO thread_favorite (tf_user_id, tf_thread_id, tf_thread_user_id, tf_datetime) VALUES (fa_favorite_user_id, fa_thread_id, fv_thread_user_id, NOW());
	SELECT LAST_INSERT_ID() INTO fv_insert_id;
	UPDATE thread_favorite_user SET thread_favorite_id = fv_insert_id WHERE tfu_user_id = fa_favorite_user_id AND tfu_thread_id = fa_thread_id;
	UPDATE thread_favorite_thread SET thread_favorite_id = fv_insert_id WHERE tft_user_id = fa_favorite_user_id AND tft_thread_id = fa_thread_id;
	COMMIT;
	SELECT fv_insert_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_thread_report`(IN `fa_report_user_id` BIGINT, IN `fa_thread_id` BIGINT, IN `fa_body` TEXT, IN `fa_report_type` TINYINT, IN `fa_ip` TEXT, IN `fa_host` TEXT, IN `fa_ua` TEXT)
main:BEGIN
	DECLARE fv_user_id BIGINT;
	DECLARE fv_privilege TINYINT;
	DECLARE fv_thread_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	DECLARE fv_report_count INT;
	DECLARE fv_privated TINYINT;
	DECLARE fv_report_type_id TINYINT;
	DECLARE fv_insert_id BIGINT;
	
	IF fa_report_user_id IS NULL OR fa_thread_id IS NULL OR fa_body = '' OR fa_report_type IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	SELECT user_id, u_privilege_thread_report INTO fv_user_id, fv_privilege FROM user WHERE user_id = fa_report_user_id LIMIT 1;
	IF fv_user_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	IF fv_privilege = 1 THEN
		SELECT 'no_privilege' AS error;
		LEAVE main;
	END IF;
	SELECT thread_id, t_user_id, t_report_count, t_privated INTO fv_thread_id, fv_thread_user_id, fv_report_count, fv_privated FROM thread WHERE thread_id = fa_thread_id LIMIT 1;
	IF fv_thread_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	IF fv_report_count >= 100 THEN
		SELECT 'filled' AS error;
		LEAVE main;
	END IF;
	IF fv_privated = 1 THEN
		SELECT 'privated' AS error;
		LEAVE main;
	END IF;
	SELECT report_type_id INTO fv_report_type_id FROM report_type WHERE report_type_id = fa_report_type AND rt_hide_thread = 0 LIMIT 1;
	IF fv_report_type_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	INSERT INTO thread_report_user (tru_user_id, tru_thread_id) VALUES (fa_report_user_id, fa_thread_id);
	INSERT INTO thread_report_thread (trt_user_id, trt_thread_id) VALUES (fa_report_user_id, fa_thread_id);
	INSERT INTO thread_report
		(tr_user_id, tr_thread_id, tr_thread_user_id, tr_body, tr_report_type, tr_datetime, tr_ip, tr_host, tr_ua)
		VALUES (fa_report_user_id, fa_thread_id, fv_thread_user_id, fa_body, fa_report_type, NOW(), fa_ip, fa_host, fa_ua);
	SELECT LAST_INSERT_ID() INTO fv_insert_id;
	UPDATE thread_report_user SET thread_report_id = fv_insert_id WHERE tru_user_id = fa_report_user_id AND tru_thread_id = fa_thread_id;
	UPDATE thread_report_thread SET thread_report_id = fv_insert_id WHERE trt_user_id = fa_report_user_id AND trt_thread_id = fa_thread_id;
	COMMIT;
	SELECT fv_insert_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_thread_tag`(IN `fa_thread_id` BIGINT, IN `fa_number` TINYINT, IN `fa_tag_id` INT)
main:BEGIN
	
	IF fa_thread_id IS NULL OR fa_number IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	INSERT IGNORE INTO thread_tag (tt_thread_id, tt_number, tt_tag_id) VALUES (fa_thread_id, fa_number, fa_tag_id) ON DUPLICATE KEY UPDATE tt_tag_id = VALUES(tt_tag_id);
	COMMIT;
	SELECT 1 AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_user`(IN `fa_twitter_primary_id` BIGINT UNSIGNED, IN `fa_twitter_id` VARCHAR(100), IN `fa_twitter_name` TEXT, IN `fa_twitter_profile_image` TEXT, IN `fa_twitter_profile_banner` TEXT, IN `fa_access_token` TEXT, IN `fa_access_token_secret` TEXT)
main:BEGIN
	DECLARE fv_user_id BIGINT;
	-- check parameter
	IF fa_twitter_primary_id IS NULL OR fa_twitter_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- register
	SELECT uk_user_id INTO fv_user_id FROM user_key WHERE uk_twitter_primary_id = fa_twitter_primary_id LIMIT 1;
	START TRANSACTION;
	IF fv_user_id IS NOT NULL AND fv_user_id != 0 THEN
		UPDATE user SET u_twitter_id = fa_twitter_id, u_twitter_name = fa_twitter_name, u_twitter_profile_image = fa_twitter_profile_image, u_twitter_profile_banner = fa_twitter_profile_banner WHERE user_id = fv_user_id;
		UPDATE user_tw SET ut_user_id = fv_user_id WHERE ut_twitter_id = fa_twitter_id;
	ELSE
		INSERT IGNORE INTO user
			(u_twitter_id, u_twitter_name, u_twitter_profile_image, u_twitter_profile_banner)
			VALUES(fa_twitter_id, fa_twitter_name, fa_twitter_profile_image, fa_twitter_profile_banner);
		SELECT LAST_INSERT_ID() INTO fv_user_id;
		INSERT IGNORE INTO user_key (uk_twitter_primary_id, uk_user_id) VALUES(fa_twitter_primary_id, fv_user_id);
		INSERT IGNORE INTO user_tw (ut_twitter_id, ut_user_id) VALUES(fa_twitter_id, fv_user_id);
	END IF;
	INSERT IGNORE INTO user_token (utk_user_id, utk_access_token, utk_access_toke_secret) VALUES(fv_user_id, fa_access_token, fa_access_token_secret)
		ON DUPLICATE KEY UPDATE
		utk_access_token = VALUES(utk_access_token), utk_access_toke_secret = VALUES(utk_access_toke_secret);
	COMMIT;
	SELECT fv_user_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_user_ng`(IN `fa_user_id` BIGINT, IN `fa_ng_twitter_id` VARCHAR(100))
main:BEGIN
	DECLARE fv_user_id BIGINT;
	DECLARE fv_ng_user_id BIGINT;
	
	IF fa_user_id IS NULL OR fa_ng_twitter_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	SELECT user_id INTO fv_user_id FROM user WHERE user_id = fa_user_id;
	IF fv_user_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	SELECT user_id INTO fv_ng_user_id FROM user WHERE u_twitter_id = fa_ng_twitter_id;
	IF fv_ng_user_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	INSERT INTO user_ng (un_user_id, un_ng_user_id, un_datetime) VALUES (fv_user_id, fv_ng_user_id, NOW());
	COMMIT;
	SELECT fv_user_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_user_ng_word`(IN `fa_user_id` BIGINT, IN `fa_words` MEDIUMTEXT, IN `fa_word_count` INT)
main:BEGIN
	DECLARE fv_user_id BIGINT;
	
	IF fa_user_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	SELECT user_id INTO fv_user_id FROM user WHERE user_id = fa_user_id;
	IF fv_user_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	
	START TRANSACTION;
	INSERT INTO user_ng_word (unw_user_id, unw_words) VALUES (fv_user_id, fa_words) ON DUPLICATE KEY UPDATE unw_words = VALUES(unw_words);
	UPDATE user SET u_ng_word_count = fa_word_count WHERE user_id = fv_user_id;
	COMMIT;
	SELECT fv_user_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_comment`(IN `fa_comment_id` BIGINT, IN `fa_user_id` BIGINT)
main:BEGIN
	DECLARE fv_comment_id BIGINT;
	DECLARE fv_user_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	DECLARE fv_privated TINYINT DEFAULT 0;
	
	IF fa_comment_id IS NULL OR fa_comment_id = 0 OR fa_user_id IS NULL OR fa_user_id = 0 THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	
	SELECT comment_id, c_user_id, c_thread_user_id INTO fv_comment_id, fv_user_id, fv_thread_user_id FROM comment WHERE comment_id = fa_comment_id AND c_privated = 0 LIMIT 1;
	IF fv_comment_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	IF fa_user_id = fv_thread_user_id THEN
		SET fv_privated = 2;
	END IF;
	IF fa_user_id = fv_user_id THEN
		SET fv_privated = 3;
	END IF;
	
	IF fv_privated > 0 THEN
		START TRANSACTION;
		UPDATE comment SET c_main_category = 0, c_sub_category = 0, c_body = '', c_ip = '', c_privated = fv_privated WHERE comment_id = fa_comment_id;
		DELETE comment_report, comment_report_user, comment_report_comment
			FROM comment_report_comment
			INNER JOIN comment_report ON comment_report.comment_report_id = comment_report_comment.comment_report_id
			INNER JOIN comment_report_user ON comment_report_user.cru_user_id = comment_report_comment.crc_user_id AND comment_report_user.cru_comment_id = comment_report_comment.crc_comment_id
		WHERE comment_report_comment.crc_comment_id = fa_comment_id;
		COMMIT;
	ELSE
		SELECT 'invalid_user' AS error;
		LEAVE main;
	END IF;
	SELECT fv_comment_id AS successful;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_thread`(IN `fa_thread_id` BIGINT, IN `fa_user_id` BIGINT)
main:BEGIN

	DECLARE fv_thread_id BIGINT;
	DECLARE fv_user_id BIGINT;
	DECLARE fv_privated TINYINT DEFAULT 0;

	
	IF fa_thread_id IS NULL OR fa_thread_id = 0 OR fa_user_id IS NULL OR fa_user_id = 0 THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;

	
	SELECT thread_id, t_user_id INTO fv_thread_id, fv_user_id FROM thread WHERE thread_id = fa_thread_id AND t_privated = 0 LIMIT 1;
	IF fv_thread_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;

	IF fa_user_id = fv_user_id THEN
		SET fv_privated = 2;
	END IF;

	
	IF fv_privated > 0 THEN
		START TRANSACTION;
		UPDATE thread SET t_title = '', t_body = '', t_main_category = 0, t_sub_category = 0, t_ip = '', t_privated = fv_privated WHERE thread_id = fa_thread_id;
		DELETE thread_favorite, thread_favorite_user, thread_favorite_thread
			FROM thread_favorite_thread
			INNER JOIN thread_favorite ON thread_favorite.thread_favorite_id = thread_favorite_thread.thread_favorite_id
			INNER JOIN thread_favorite_user ON thread_favorite_user.tfu_user_id = thread_favorite_thread.tft_user_id AND thread_favorite_user.tfu_thread_id = thread_favorite_thread.tft_thread_id
		WHERE thread_favorite_thread.tft_thread_id = fa_thread_id;
		DELETE thread_report, thread_report_user, thread_report_thread
			FROM thread_report_thread
			INNER JOIN thread_report ON thread_report.thread_report_id = thread_report_thread.thread_report_id
			INNER JOIN thread_report_user ON thread_report_user.tru_user_id = thread_report_thread.trt_user_id AND thread_report_user.tru_thread_id = thread_report_thread.trt_thread_id
		WHERE thread_report_thread.trt_thread_id = fa_thread_id;
		DELETE FROM thread_tag WHERE tt_thread_id = fa_thread_id;
		DELETE FROM comment WHERE c_thread_id = fa_thread_id;
		DELETE comment_report, comment_report_user, comment_report_comment
			FROM comment_report
			INNER JOIN comment_report_user ON comment_report_user.cru_user_id = comment_report.cr_user_id AND comment_report_user.cru_comment_id = comment_report.cr_comment_id
			INNER JOIN comment_report_comment ON comment_report_comment.crc_user_id = comment_report.cr_user_id AND comment_report_comment.crc_comment_id = comment_report.cr_comment_id
		WHERE comment_report.cr_thread_id = fa_thread_id;
		COMMIT;
	ELSE
		SELECT 'invalid_user' AS error;
		LEAVE main;
	END IF;

	SELECT fv_thread_id AS successful;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- テーブルの構造 `admin_comment`
--

CREATE TABLE IF NOT EXISTS `admin_comment` (
  `admin_comment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ac_admin_thread_id` bigint(20) unsigned NOT NULL,
  `ac_comment_id` bigint(20) unsigned DEFAULT NULL,
  `ac_user_id` bigint(20) unsigned NOT NULL,
  `ac_body` text NOT NULL,
  `ac_datetime` datetime NOT NULL,
  `ac_rel_second` int(10) unsigned NOT NULL,
  PRIMARY KEY (`admin_comment_id`),
  KEY `ac_dt_index` (`ac_datetime`),
  KEY `at_atid_dt_index` (`ac_admin_thread_id`,`ac_datetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `admin_thread`
--

CREATE TABLE IF NOT EXISTS `admin_thread` (
  `admin_thread_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `at_thread_id` bigint(20) unsigned DEFAULT NULL,
  `at_user_id` bigint(20) unsigned NOT NULL,
  `at_title` text NOT NULL,
  `at_body` text NOT NULL,
  `at_category` int(10) unsigned NOT NULL DEFAULT '0',
  `at_tag` text NOT NULL COMMENT 'スペース区切り',
  `at_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0:未投稿 1:予約 2:投稿済み',
  `at_datetime` datetime NOT NULL,
  PRIMARY KEY (`admin_thread_id`),
  KEY `at_datetime_index` (`at_datetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `admin_user`
--

CREATE TABLE IF NOT EXISTS `admin_user` (
  `admin_user_id` bigint(20) unsigned NOT NULL,
  `au_hide` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `au_summary` text NOT NULL,
  PRIMARY KEY (`admin_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_word` varchar(150) NOT NULL,
  `cat_url_name` varchar(50) DEFAULT NULL,
  `cat_parent` int(10) unsigned NOT NULL DEFAULT '0',
  `cat_sort` int(10) unsigned NOT NULL DEFAULT '0',
  `cat_description` text NOT NULL,
  `cat_hide` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `cat_thread_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `cat_comment_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `cat_first_thread_id` bigint(20) unsigned DEFAULT NULL,
  `cat_last_thread_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `cat_url_unique` (`cat_url_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `comment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `c_user_id` bigint(20) unsigned NOT NULL,
  `c_thread_id` bigint(20) unsigned NOT NULL,
  `c_thread_user_id` bigint(20) unsigned NOT NULL,
  `c_main_category` int(10) unsigned NOT NULL DEFAULT '0',
  `c_sub_category` int(10) unsigned NOT NULL DEFAULT '0',
  `c_body` text NOT NULL,
  `c_ip` text,
  `c_privated` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `c_datetime` datetime NOT NULL,
  `c_report_count` int(10) unsigned NOT NULL DEFAULT '0',
  `c_first_report_id` bigint(20) unsigned DEFAULT NULL,
  `c_last_report_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `c_uid_cid_index` (`c_user_id`,`comment_id`) USING BTREE,
  KEY `c_tid_cid_index` (`c_thread_id`,`comment_id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

--
-- トリガ `comment`
--
DROP TRIGGER IF EXISTS `after_insert_comment`;
DELIMITER //
CREATE TRIGGER `after_insert_comment` AFTER INSERT ON `comment`
 FOR EACH ROW main:BEGIN
	UPDATE thread SET
		t_filled = (CASE WHEN t_comment_count >= (100 - 1) THEN 1 ELSE t_filled END),
		t_comment_count = t_comment_count + 1,
		t_first_comment_id = (CASE WHEN t_first_comment_id IS NULL THEN NEW.comment_id ELSE t_first_comment_id END),
		t_last_comment_id = NEW.comment_id,
		t_last_comment_datetime = NEW.c_datetime
	WHERE thread_id = NEW.c_thread_id;
	UPDATE user SET
		u_first_comment_id = (CASE WHEN u_first_comment_id IS NULL THEN NEW.comment_id ELSE u_first_comment_id END),
		u_last_comment_id = NEW.comment_id,
		u_comment_count = u_comment_count + 1
	WHERE user_id = NEW.c_user_id;
	IF NEW.c_main_category != 0 THEN
		UPDATE category SET cat_comment_count = cat_comment_count + 1 WHERE category_id = NEW.c_main_category;
	END IF;
	IF NEW.c_sub_category != 0 THEN
		UPDATE category SET cat_comment_count = cat_comment_count + 1 WHERE category_id = NEW.c_sub_category;
	END IF;
	UPDATE site SET s_comment_count = s_comment_count + 1;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `after_update_comment`;
DELIMITER //
CREATE TRIGGER `after_update_comment` AFTER UPDATE ON `comment`
 FOR EACH ROW main:BEGIN
	IF OLD.c_privated IS NOT NULL AND NEW.c_privated IS NOT NULL AND OLD.c_privated != NEW.c_privated THEN
		IF OLD.c_privated = 0 AND NEW.c_privated > 0 THEN
			UPDATE user SET u_privated_comment_count = u_privated_comment_count + 1 WHERE user_id = NEW.c_user_id;
			UPDATE site SET s_privated_comment_count = s_privated_comment_count + 1;
		END IF;
		IF OLD.c_privated > 0 AND NEW.c_privated = 0 THEN
			UPDATE user SET u_privated_comment_count = u_privated_comment_count - 1 WHERE user_id = NEW.c_user_id;
			UPDATE site SET s_privated_comment_count = s_privated_comment_count - 1;
		END IF;
	END IF;
	IF OLD.c_main_category != NEW.c_main_category THEN
		UPDATE category SET cat_comment_count = cat_comment_count - 1 WHERE category_id = OLD.c_main_category;
		UPDATE category SET cat_comment_count = cat_comment_count + 1 WHERE category_id = NEW.c_main_category;
	END IF;
	IF OLD.c_sub_category != NEW.c_sub_category THEN
		UPDATE category SET cat_comment_count = cat_comment_count - 1 WHERE category_id = OLD.c_sub_category;
		UPDATE category SET cat_comment_count = cat_comment_count + 1 WHERE category_id = NEW.c_sub_category;
	END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_report`
--

CREATE TABLE IF NOT EXISTS `comment_report` (
  `comment_report_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cr_user_id` bigint(20) unsigned NOT NULL,
  `cr_comment_id` bigint(20) unsigned NOT NULL,
  `cr_comment_user_id` bigint(20) unsigned NOT NULL,
  `cr_thread_id` bigint(20) unsigned NOT NULL,
  `cr_thread_user_id` bigint(20) unsigned NOT NULL,
  `cr_body` text NOT NULL,
  `cr_report_type` tinyint(4) unsigned NOT NULL,
  `cr_privated` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `cr_datetime` datetime NOT NULL,
  `cr_ip` text,
  `cr_host` text,
  `cr_ua` text,
  PRIMARY KEY (`comment_report_id`),
  KEY `cr_tid_index` (`cr_thread_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- トリガ `comment_report`
--
DROP TRIGGER IF EXISTS `after_delete_comment_report`;
DELIMITER //
CREATE TRIGGER `after_delete_comment_report` AFTER DELETE ON `comment_report`
 FOR EACH ROW main:BEGIN
	UPDATE comment SET
		c_first_report_id = (CASE WHEN c_report_count = 1 THEN NULL ELSE c_first_report_id END),
		c_last_report_id = (SELECT comment_report_id FROM comment_report_comment WHERE crc_comment_id = OLD.cr_comment_id ORDER BY comment_report_id DESC LIMIT 1),
		c_report_count = c_report_count - 1
	WHERE comment_id = OLD.cr_comment_id;
	UPDATE user SET
		u_first_comment_report_id = (CASE WHEN u_comment_report_count = 1 THEN NULL ELSE u_first_comment_report_id END),
		u_last_comment_report_id = (SELECT comment_report_id FROM comment_report_user WHERE cru_user_id = OLD.cr_user_id ORDER BY comment_report_id DESC LIMIT 1),
		u_comment_report_count = u_comment_report_count - 1
	WHERE user_id = OLD.cr_user_id;
	UPDATE user SET u_comment_reported_count = u_comment_reported_count - 1 WHERE user_id = OLD.cr_comment_user_id;
	UPDATE site SET s_comment_report_count = s_comment_report_count - 1;
	UPDATE report_type SET rt_count_comment = rt_count_comment - 1 WHERE report_type_id = OLD.cr_report_type;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `after_insert_comment_report`;
DELIMITER //
CREATE TRIGGER `after_insert_comment_report` AFTER INSERT ON `comment_report`
 FOR EACH ROW main:BEGIN
	UPDATE comment SET
		c_first_report_id = (CASE WHEN c_first_report_id IS NULL THEN NEW.comment_report_id ELSE c_first_report_id END),
		c_last_report_id = NEW.comment_report_id,
		c_report_count = c_report_count + 1
	WHERE comment_id = NEW.cr_comment_id;
	UPDATE user SET
		u_first_comment_report_id = (CASE WHEN u_first_comment_report_id IS NULL THEN NEW.comment_report_id ELSE u_first_comment_report_id END),
		u_last_comment_report_id = NEW.comment_report_id,
		u_comment_report_count = u_comment_report_count + 1
	WHERE user_id = NEW.cr_user_id;
	UPDATE user SET u_comment_reported_count = u_comment_reported_count + 1 WHERE user_id = NEW.cr_comment_user_id;
	UPDATE site SET s_comment_report_count = s_comment_report_count + 1;
	UPDATE report_type SET rt_count_comment = rt_count_comment + 1 WHERE report_type_id = NEW.cr_report_type;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_report_comment`
--

CREATE TABLE IF NOT EXISTS `comment_report_comment` (
  `crc_user_id` bigint(20) unsigned NOT NULL,
  `crc_comment_id` bigint(20) unsigned NOT NULL,
  `comment_report_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`crc_user_id`,`crc_comment_id`),
  KEY `crc_cid_crid_index` (`crc_comment_id`,`comment_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `comment_report_user`
--

CREATE TABLE IF NOT EXISTS `comment_report_user` (
  `cru_user_id` bigint(20) unsigned NOT NULL,
  `cru_comment_id` bigint(20) unsigned NOT NULL,
  `comment_report_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`cru_user_id`,`cru_comment_id`),
  KEY `cru_uid_crid_index` (`cru_user_id`,`comment_report_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `guest_comment_report`
--

CREATE TABLE IF NOT EXISTS `guest_comment_report` (
  `guest_comment_report_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gcr_name` text NOT NULL,
  `gcr_email` text NOT NULL,
  `gcr_comment_id` bigint(20) unsigned NOT NULL,
  `gcr_body` text NOT NULL,
  `gcr_report_type` tinyint(4) unsigned NOT NULL,
  `gcr_datetime` datetime NOT NULL,
  `gcr_ip` text,
  `gcr_host` text,
  `gcr_ua` text,
  `gcr_checked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guest_comment_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `guest_thread_report`
--

CREATE TABLE IF NOT EXISTS `guest_thread_report` (
  `guest_thread_report_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gtr_name` text NOT NULL,
  `gtr_email` text NOT NULL,
  `gtr_thread_id` bigint(20) unsigned NOT NULL,
  `gtr_body` text NOT NULL,
  `gtr_report_type` tinyint(4) unsigned NOT NULL,
  `gtr_datetime` datetime NOT NULL,
  `gtr_ip` text,
  `gtr_host` text,
  `gtr_ua` text,
  `gtr_checked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guest_thread_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `report_type`
--

CREATE TABLE IF NOT EXISTS `report_type` (
  `report_type_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `rt_name` text NOT NULL,
  `rt_body` text NOT NULL,
  `rt_count_thread` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rt_count_comment` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rt_hide_thread` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `rt_hide_comment` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`report_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `site`
--

CREATE TABLE IF NOT EXISTS `site` (
  `s_pv_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `s_user_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `s_thread_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `s_thread_favorite_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `s_thread_report_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `s_comment_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `s_comment_report_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `s_privated_thread_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `s_privated_comment_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `s_comment_max_per_thread` int(10) unsigned NOT NULL DEFAULT '100'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `site_infomation`
--

CREATE TABLE IF NOT EXISTS `site_infomation` (
  `si_datetime` datetime NOT NULL,
  `si_body` text NOT NULL,
  `si_hide` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`si_datetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `site_ng_ip`
--

CREATE TABLE IF NOT EXISTS `site_ng_ip` (
  `sn_ip` varchar(100) NOT NULL,
  PRIMARY KEY (`sn_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `site_ng_user`
--

CREATE TABLE IF NOT EXISTS `site_ng_user` (
  `snu_twitter_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `site_ng_word`
--

CREATE TABLE IF NOT EXISTS `site_ng_word` (
  `snw_word` varchar(50) NOT NULL,
  `snw_summary` text NOT NULL,
  PRIMARY KEY (`snw_word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `site_sessions`
--

CREATE TABLE IF NOT EXISTS `site_sessions` (
  `id` varchar(40) CHARACTER SET utf8 NOT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8 NOT NULL,
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `data` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_sessions_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `site_various`
--

CREATE TABLE IF NOT EXISTS `site_various` (
  `various_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sv_body` text NOT NULL,
  PRIMARY KEY (`various_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `tag`
--

CREATE TABLE IF NOT EXISTS `tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tg_word` varchar(150) NOT NULL,
  `tg_hide` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `tg_thread_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `tg_first_thread_id` bigint(20) unsigned DEFAULT NULL,
  `tg_last_thread_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `tag_word_unique` (`tg_word`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread`
--

CREATE TABLE IF NOT EXISTS `thread` (
  `thread_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `t_user_id` bigint(20) unsigned NOT NULL,
  `t_title` text NOT NULL,
  `t_body` text NOT NULL,
  `t_main_category` int(10) unsigned NOT NULL DEFAULT '0',
  `t_sub_category` int(10) unsigned NOT NULL DEFAULT '0',
  `t_ip` text,
  `t_privated` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `t_filled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `t_datetime` datetime NOT NULL,
  `t_master_twitter_posted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `t_master_twitter_posted_datetime` datetime DEFAULT NULL,
  `t_comment_count` int(10) unsigned NOT NULL DEFAULT '0',
  `t_favorite_count` int(10) unsigned NOT NULL DEFAULT '0',
  `t_report_count` int(10) unsigned NOT NULL DEFAULT '0',
  `t_first_comment_id` bigint(20) unsigned DEFAULT NULL,
  `t_last_comment_id` bigint(20) unsigned DEFAULT NULL,
  `t_last_comment_datetime` datetime DEFAULT NULL,
  `t_first_favorite_id` bigint(20) unsigned DEFAULT NULL,
  `t_last_favorite_id` bigint(20) unsigned DEFAULT NULL,
  `t_first_report_id` bigint(20) unsigned DEFAULT NULL,
  `t_last_report_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`thread_id`),
  KEY `t_mcat_tid_index` (`t_main_category`,`thread_id`),
  KEY `t_scat_tid_index` (`t_sub_category`,`thread_id`) USING BTREE,
  KEY `t_uid_tid_index` (`t_user_id`,`thread_id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

--
-- トリガ `thread`
--
DROP TRIGGER IF EXISTS `after_insert_thread`;
DELIMITER //
CREATE TRIGGER `after_insert_thread` AFTER INSERT ON `thread`
 FOR EACH ROW main:BEGIN
	UPDATE user SET
		u_first_thread_id = (CASE WHEN u_first_thread_id IS NULL THEN NEW.thread_id ELSE u_first_thread_id END),
		u_last_thread_id = NEW.thread_id,
		u_thread_count = u_thread_count + 1
	WHERE user_id = NEW.t_user_id;
	IF NEW.t_main_category != 0 THEN
		UPDATE category SET
			cat_first_thread_id = (CASE WHEN cat_first_thread_id IS NULL THEN NEW.thread_id ELSE cat_first_thread_id END),
			cat_last_thread_id = NEW.thread_id,
			cat_thread_count = cat_thread_count + 1
		WHERE category_id = NEW.t_main_category;
	END IF;
	IF NEW.t_sub_category != 0 THEN
		UPDATE category SET
			cat_first_thread_id = (CASE WHEN cat_first_thread_id IS NULL THEN NEW.thread_id ELSE cat_first_thread_id END),
			cat_last_thread_id = NEW.thread_id,
			cat_thread_count = cat_thread_count + 1
		WHERE category_id = NEW.t_sub_category;
	END IF;
	UPDATE site SET s_thread_count = s_thread_count + 1;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `after_update_thread`;
DELIMITER //
CREATE TRIGGER `after_update_thread` AFTER UPDATE ON `thread`
 FOR EACH ROW main:BEGIN
	IF OLD.t_privated IS NOT NULL AND NEW.t_privated IS NOT NULL AND OLD.t_privated != NEW.t_privated THEN
		IF OLD.t_privated = 0 AND NEW.t_privated > 0 THEN
			UPDATE user SET u_privated_thread_count = u_privated_thread_count + 1 WHERE user_id = NEW.t_user_id;
			UPDATE site SET s_privated_thread_count = s_privated_thread_count + 1;
		END IF;
		IF OLD.t_privated > 0 AND NEW.t_privated = 0 THEN
			UPDATE user SET u_privated_thread_count = u_privated_thread_count - 1 WHERE user_id = NEW.t_user_id;
			UPDATE site SET s_privated_thread_count = s_privated_thread_count - 1;
		END IF;
	END IF;
	IF OLD.t_filled IS NOT NULL AND NEW.t_filled IS NOT NULL AND OLD.t_filled != NEW.t_filled THEN
		IF OLD.t_filled < NEW.t_filled THEN
			UPDATE user SET u_thread_filled_count = u_thread_filled_count + 1 WHERE user_id = NEW.t_user_id;
		END IF;
		IF OLD.t_filled > NEW.t_filled THEN
			UPDATE user SET u_thread_filled_count = u_thread_filled_count - 1 WHERE user_id = NEW.t_user_id;
		END IF;
	END IF;
	IF OLD.t_main_category != NEW.t_main_category THEN
		UPDATE comment SET c_main_category = NEW.t_main_category WHERE c_thread_id = NEW.thread_id;
		UPDATE category SET
			cat_first_thread_id = (CASE WHEN cat_thread_count = 1 THEN NULL ELSE cat_first_thread_id END),
			cat_last_thread_id = (SELECT thread_id FROM thread WHERE t_main_category = OLD.t_main_category ORDER BY thread_id DESC LIMIT 1),
			cat_thread_count = cat_thread_count - 1,
			cat_comment_count = cat_comment_count - (SELECT t_comment_count FROM thread WHERE thread_id = OLD.thread_id)
		WHERE category_id = OLD.t_main_category;
		UPDATE category SET
			cat_first_thread_id = (CASE WHEN cat_thread_count = 1 THEN NULL ELSE cat_first_thread_id END),
			cat_last_thread_id = (SELECT thread_id FROM thread WHERE t_main_category = NEW.t_main_category ORDER BY thread_id DESC LIMIT 1),
			cat_thread_count = cat_thread_count + 1,
			cat_comment_count = cat_comment_count + (SELECT t_comment_count FROM thread WHERE thread_id = NEW.thread_id)
		WHERE category_id = NEW.t_main_category;
	END IF;
	IF OLD.t_sub_category != NEW.t_sub_category THEN
		UPDATE comment SET c_sub_category = NEW.t_sub_category WHERE c_thread_id = NEW.thread_id;
		UPDATE category SET
			cat_first_thread_id = (CASE WHEN cat_thread_count = 1 THEN NULL ELSE cat_first_thread_id END),
			cat_last_thread_id = (SELECT thread_id FROM thread WHERE t_sub_category = OLD.t_sub_category ORDER BY thread_id DESC LIMIT 1),
			cat_thread_count = cat_thread_count - 1,
			cat_comment_count = cat_comment_count - (SELECT t_comment_count FROM thread WHERE thread_id = OLD.thread_id)
		WHERE category_id = OLD.t_sub_category;
		UPDATE category SET
			cat_first_thread_id = (CASE WHEN cat_thread_count = 1 THEN NULL ELSE cat_first_thread_id END),
			cat_last_thread_id = (SELECT thread_id FROM thread WHERE t_sub_category = NEW.t_sub_category ORDER BY thread_id DESC LIMIT 1),
			cat_thread_count = cat_thread_count + 1,
			cat_comment_count = cat_comment_count + (SELECT t_comment_count FROM thread WHERE thread_id = NEW.thread_id)
		WHERE category_id = NEW.t_sub_category;
	END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_favorite`
--

CREATE TABLE IF NOT EXISTS `thread_favorite` (
  `thread_favorite_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tf_user_id` bigint(20) unsigned NOT NULL,
  `tf_thread_id` bigint(20) unsigned NOT NULL,
  `tf_thread_user_id` bigint(20) unsigned NOT NULL,
  `tf_datetime` datetime NOT NULL,
  PRIMARY KEY (`thread_favorite_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

--
-- トリガ `thread_favorite`
--
DROP TRIGGER IF EXISTS `after_delete_thread_favorite`;
DELIMITER //
CREATE TRIGGER `after_delete_thread_favorite` AFTER DELETE ON `thread_favorite`
 FOR EACH ROW main:BEGIN
	UPDATE thread SET
		t_first_favorite_id = (CASE WHEN t_first_favorite_id = 1 THEN NULL ELSE t_first_favorite_id END),
		t_last_favorite_id = (SELECT thread_favorite_id FROM thread_favorite_thread WHERE tft_thread_id = OLD.tf_thread_id ORDER BY thread_favorite_id DESC LIMIT 1),
		t_favorite_count = t_favorite_count - 1
	WHERE thread_id = OLD.tf_thread_id;
	UPDATE user SET
		u_first_thread_favorite_id = (CASE WHEN u_thread_favorite_count = 1 THEN NULL ELSE u_first_thread_favorite_id END),
		u_last_thread_favorite_id = (SELECT thread_favorite_id FROM thread_favorite_user WHERE tfu_user_id = OLD.tf_user_id ORDER BY thread_favorite_id DESC LIMIT 1),
		u_thread_favorite_count = u_thread_favorite_count - 1
	WHERE user_id = OLD.tf_user_id;
	UPDATE user SET u_thread_favorited_count = u_thread_favorited_count - 1 WHERE user_id = OLD.tf_thread_user_id;
	UPDATE site SET s_thread_favorite_count = s_thread_favorite_count - 1;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `after_insert_thread_favorite`;
DELIMITER //
CREATE TRIGGER `after_insert_thread_favorite` AFTER INSERT ON `thread_favorite`
 FOR EACH ROW main:BEGIN
	UPDATE thread SET
		t_first_favorite_id = (CASE WHEN t_first_favorite_id IS NULL THEN NEW.thread_favorite_id ELSE t_first_favorite_id END),
		t_last_favorite_id = NEW.thread_favorite_id,
		t_favorite_count = t_favorite_count + 1
	WHERE thread_id = NEW.tf_thread_id;
	UPDATE user SET
		u_first_thread_favorite_id = (CASE WHEN u_first_thread_favorite_id IS NULL THEN NEW.thread_favorite_id ELSE u_first_thread_favorite_id END),
		u_last_thread_favorite_id = NEW.thread_favorite_id,
		u_thread_favorite_count = u_thread_favorite_count + 1
	WHERE user_id = NEW.tf_user_id;
	UPDATE user SET u_thread_favorited_count = u_thread_favorited_count + 1 WHERE user_id = NEW.tf_thread_user_id;
	UPDATE site SET s_thread_favorite_count = s_thread_favorite_count + 1;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_favorite_thread`
--

CREATE TABLE IF NOT EXISTS `thread_favorite_thread` (
  `tft_user_id` bigint(20) unsigned NOT NULL,
  `tft_thread_id` bigint(20) unsigned NOT NULL,
  `thread_favorite_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tft_user_id`,`tft_thread_id`),
  KEY `tft_tid_tfid_index` (`tft_thread_id`,`thread_favorite_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_favorite_user`
--

CREATE TABLE IF NOT EXISTS `thread_favorite_user` (
  `tfu_user_id` bigint(20) unsigned NOT NULL,
  `tfu_thread_id` bigint(20) unsigned NOT NULL,
  `thread_favorite_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`tfu_user_id`,`tfu_thread_id`),
  KEY `tfu_uid_tfid_index` (`tfu_user_id`,`thread_favorite_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_report`
--

CREATE TABLE IF NOT EXISTS `thread_report` (
  `thread_report_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tr_user_id` bigint(20) unsigned NOT NULL,
  `tr_thread_id` bigint(20) unsigned NOT NULL,
  `tr_thread_user_id` bigint(20) unsigned NOT NULL,
  `tr_body` text NOT NULL,
  `tr_report_type` tinyint(4) unsigned NOT NULL,
  `tr_privated` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `tr_datetime` datetime NOT NULL,
  `tr_ip` text,
  `tr_host` text,
  `tr_ua` text,
  PRIMARY KEY (`thread_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- トリガ `thread_report`
--
DROP TRIGGER IF EXISTS `after_delete_thread_report`;
DELIMITER //
CREATE TRIGGER `after_delete_thread_report` AFTER DELETE ON `thread_report`
 FOR EACH ROW main:BEGIN
	UPDATE thread SET
		t_first_report_id = (CASE WHEN t_report_count = 1 THEN NULL ELSE t_first_report_id END),
		t_last_report_id = (SELECT thread_report_id FROM thread_report_thread WHERE trt_thread_id = OLD.tr_thread_id ORDER BY thread_report_id DESC LIMIT 1),
		t_report_count = t_report_count - 1
	WHERE thread_id = OLD.tr_thread_id;
	UPDATE user SET
		u_first_thread_report_id = (CASE WHEN u_thread_report_count = 1 THEN NULL ELSE u_first_thread_report_id END),
		u_last_thread_report_id = (SELECT thread_report_id FROM thread_report_user WHERE tru_user_id = OLD.tr_user_id ORDER BY thread_report_id DESC LIMIT 1),
		u_thread_report_count = u_thread_report_count - 1
	WHERE user_id = OLD.tr_user_id;
	UPDATE user SET u_thread_reported_count = u_thread_reported_count - 1 WHERE user_id = OLD.tr_thread_user_id;
	UPDATE site SET s_thread_report_count = s_thread_report_count - 1;
	UPDATE report_type SET rt_count_thread = rt_count_thread - 1 WHERE report_type_id = OLD.tr_report_type;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `after_insert_thread_report`;
DELIMITER //
CREATE TRIGGER `after_insert_thread_report` AFTER INSERT ON `thread_report`
 FOR EACH ROW main:BEGIN
	UPDATE thread SET
		t_first_report_id = (CASE WHEN t_first_report_id IS NULL THEN NEW.thread_report_id ELSE t_first_report_id END),
		t_last_report_id = NEW.thread_report_id,
		t_report_count = t_report_count + 1
	WHERE thread_id = NEW.tr_thread_id;
	UPDATE user SET
		u_first_thread_report_id = (CASE WHEN u_first_thread_report_id IS NULL THEN NEW.thread_report_id ELSE u_first_thread_report_id END),
		u_last_thread_report_id = NEW.thread_report_id,
		u_thread_report_count = u_thread_report_count + 1
	WHERE user_id = NEW.tr_user_id;
	UPDATE user SET u_thread_reported_count = u_thread_reported_count + 1 WHERE user_id = NEW.tr_thread_user_id;
	UPDATE site SET s_thread_report_count = s_thread_report_count + 1;
	UPDATE report_type SET rt_count_thread = rt_count_thread + 1 WHERE report_type_id = NEW.tr_report_type;

END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_report_thread`
--

CREATE TABLE IF NOT EXISTS `thread_report_thread` (
  `trt_user_id` bigint(20) unsigned NOT NULL,
  `trt_thread_id` bigint(20) unsigned NOT NULL,
  `thread_report_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`trt_user_id`,`trt_thread_id`),
  KEY `trt_tid_trid_index` (`trt_thread_id`,`thread_report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_report_user`
--

CREATE TABLE IF NOT EXISTS `thread_report_user` (
  `tru_user_id` bigint(20) unsigned NOT NULL,
  `tru_thread_id` bigint(20) unsigned NOT NULL,
  `thread_report_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`tru_user_id`,`tru_thread_id`),
  KEY `tru_uid_trid_index` (`tru_user_id`,`thread_report_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `thread_tag`
--

CREATE TABLE IF NOT EXISTS `thread_tag` (
  `tt_thread_id` bigint(20) unsigned NOT NULL,
  `tt_number` tinyint(3) unsigned NOT NULL,
  `tt_tag_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`tt_thread_id`,`tt_number`),
  UNIQUE KEY `tt_tag_tid_unique` (`tt_tag_id`,`tt_thread_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- トリガ `thread_tag`
--
DROP TRIGGER IF EXISTS `after_delete_thread_tag`;
DELIMITER //
CREATE TRIGGER `after_delete_thread_tag` AFTER DELETE ON `thread_tag`
 FOR EACH ROW main:BEGIN
	UPDATE tag SET
		tg_first_thread_id = (CASE WHEN tg_thread_count = 1 THEN NULL ELSE tg_first_thread_id END),
		tg_last_thread_id = (SELECT tt_thread_id FROM thread_tag WHERE tt_tag_id = OLD.tt_tag_id ORDER BY tt_thread_id DESC LIMIT 1),
		tg_thread_count = tg_thread_count - 1
	WHERE tag_id = OLD.tt_tag_id;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `after_insert_thread_tag`;
DELIMITER //
CREATE TRIGGER `after_insert_thread_tag` AFTER INSERT ON `thread_tag`
 FOR EACH ROW main:BEGIN
	IF NEW.tt_tag_id IS NOT NULL AND NEW.tt_tag_id != 0 AND NEW.tt_tag_id != '' THEN
		UPDATE tag SET
			tg_first_thread_id = (CASE WHEN tg_first_thread_id IS NULL THEN NEW.tt_thread_id ELSE tg_first_thread_id END),
			tg_last_thread_id = NEW.tt_thread_id,
			tg_thread_count = tg_thread_count + 1
		WHERE tag_id = NEW.tt_tag_id;
	END IF;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `after_update_thread_tag`;
DELIMITER //
CREATE TRIGGER `after_update_thread_tag` AFTER UPDATE ON `thread_tag`
 FOR EACH ROW main:BEGIN
	UPDATE tag SET
		tg_first_thread_id = (CASE WHEN tg_thread_count = 1 THEN NULL ELSE tg_first_thread_id END),
		tg_last_thread_id = (SELECT tt_thread_id FROM thread_tag WHERE tt_tag_id = NEW.tt_tag_id ORDER BY tt_thread_id DESC LIMIT 1),
		tg_thread_count = tg_thread_count - 1
	WHERE tag_id = OLD.tt_tag_id;
	UPDATE tag SET
		tg_first_thread_id = (CASE WHEN tg_first_thread_id IS NULL THEN NEW.tt_thread_id ELSE tg_first_thread_id END),
		tg_last_thread_id = NEW.tt_thread_id,
		tg_thread_count = tg_thread_count + 1
	WHERE tag_id = NEW.tt_tag_id;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- テーブルの構造 `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `u_twitter_id` varchar(100) NOT NULL,
  `u_twitter_name` text,
  `u_twitter_profile_image` text,
  `u_twitter_profile_banner` text,
  `u_pv_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  `u_thread_filled_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_thread_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_comment_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_thread_favorite_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_thread_favorited_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_comment_favorite_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_comment_favorited_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_thread_report_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_thread_reported_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_comment_report_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_comment_reported_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_privated_thread_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_privated_comment_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_privilege_thread` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `u_privilege_comment` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `u_privilege_thread_favorite` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `u_privilege_thread_report` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `u_privilege_comment_report` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `u_ng_user_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_nged_user_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_ng_word_count` int(10) unsigned NOT NULL DEFAULT '0',
  `u_first_thread_id` bigint(20) unsigned DEFAULT NULL,
  `u_last_thread_id` bigint(20) unsigned DEFAULT NULL,
  `u_first_comment_id` bigint(20) unsigned DEFAULT NULL,
  `u_last_comment_id` bigint(20) unsigned DEFAULT NULL,
  `u_first_thread_favorite_id` bigint(20) unsigned DEFAULT NULL,
  `u_last_thread_favorite_id` bigint(20) unsigned DEFAULT NULL,
  `u_first_thread_report_id` bigint(20) unsigned DEFAULT NULL,
  `u_last_thread_report_id` bigint(20) unsigned DEFAULT NULL,
  `u_first_comment_report_id` bigint(20) unsigned DEFAULT NULL,
  `u_last_comment_report_id` bigint(20) unsigned DEFAULT NULL,
  `u_first_ng_user_id` bigint(20) unsigned DEFAULT NULL,
  `u_last_ng_user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_twitter_id_index` (`u_twitter_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

--
-- トリガ `user`
--
DROP TRIGGER IF EXISTS `after_insert_user`;
DELIMITER //
CREATE TRIGGER `after_insert_user` AFTER INSERT ON `user`
 FOR EACH ROW main:BEGIN
	UPDATE site SET s_user_count = s_user_count + 1;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- テーブルの構造 `user_key`
--

CREATE TABLE IF NOT EXISTS `user_key` (
  `uk_twitter_primary_id` bigint(20) unsigned NOT NULL,
  `uk_user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`uk_twitter_primary_id`),
  UNIQUE KEY `suk_uid_unique` (`uk_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `user_ng`
--

CREATE TABLE IF NOT EXISTS `user_ng` (
  `un_user_id` bigint(20) unsigned NOT NULL,
  `un_ng_user_id` bigint(20) unsigned NOT NULL,
  `un_datetime` datetime NOT NULL,
  PRIMARY KEY (`un_user_id`,`un_ng_user_id`),
  KEY `un_uid_dt_index` (`un_user_id`,`un_datetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- トリガ `user_ng`
--
DROP TRIGGER IF EXISTS `after_delete_user_ng`;
DELIMITER //
CREATE TRIGGER `after_delete_user_ng` AFTER DELETE ON `user_ng`
 FOR EACH ROW main:BEGIN
	UPDATE user SET
		u_first_ng_user_id = (CASE WHEN u_ng_user_count = 1 THEN NULL ELSE u_first_ng_user_id END),
		u_last_ng_user_id = (SELECT un_ng_user_id FROM user_ng WHERE un_user_id = OLD.un_user_id ORDER BY un_datetime DESC LIMIT 1),
		u_ng_user_count = u_ng_user_count - 1
	WHERE user_id = OLD.un_user_id;
	UPDATE user SET u_nged_user_count = u_nged_user_count - 1 WHERE user_id = OLD.un_ng_user_id;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `after_insert_user_ng`;
DELIMITER //
CREATE TRIGGER `after_insert_user_ng` AFTER INSERT ON `user_ng`
 FOR EACH ROW main:BEGIN
	UPDATE user SET
		u_first_ng_user_id = (CASE WHEN u_first_ng_user_id IS NULL THEN NEW.un_ng_user_id ELSE u_first_ng_user_id END),
		u_last_ng_user_id = NEW.un_ng_user_id,
		u_ng_user_count = u_ng_user_count + 1
	WHERE user_id = NEW.un_user_id;
	UPDATE user SET u_nged_user_count = u_nged_user_count + 1 WHERE user_id = NEW.un_ng_user_id;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- テーブルの構造 `user_ng_word`
--

CREATE TABLE IF NOT EXISTS `user_ng_word` (
  `unw_user_id` bigint(20) unsigned NOT NULL,
  `unw_words` mediumtext NOT NULL,
  PRIMARY KEY (`unw_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `user_token`
--

CREATE TABLE IF NOT EXISTS `user_token` (
  `utk_user_id` bigint(20) unsigned NOT NULL,
  `utk_access_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `utk_access_toke_secret` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`utk_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `user_tw`
--

CREATE TABLE IF NOT EXISTS `user_tw` (
  `ut_twitter_id` varchar(100) NOT NULL COMMENT 'TwitterID',
  `ut_user_id` bigint(20) unsigned DEFAULT NULL COMMENT 'ユーザーID',
  PRIMARY KEY (`ut_twitter_id`),
  KEY `sut_uid_index` (`ut_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
