use twibbs;
DELIMITER //
--#--------------------------------------------------------------------------------
--# Stored Procedures Common Libraries
--#
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ user_ng
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# register_user_ng
--#--------------------------------------------------------------------------------
SELECT 'register_user_ng' AS 'Procedure';
DROP PROCEDURE IF EXISTS register_user_ng;
CREATE PROCEDURE register_user_ng(IN fa_user_id BIGINT, IN fa_ng_twitter_id VARCHAR(100))
main:BEGIN
	DECLARE fv_user_id BIGINT;
	DECLARE fv_ng_user_id BIGINT;
	-- check parameter
	IF fa_user_id IS NULL OR fa_ng_twitter_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- check record
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
	-- register
	START TRANSACTION;
	INSERT INTO user_ng (un_user_id, un_ng_user_id, un_datetime) VALUES (fv_user_id, fv_ng_user_id, NOW());
	COMMIT;
	SELECT fv_user_id AS successful;
END;

--#--------------------------------------------------------------------------------
--# delete_user_ng
--#--------------------------------------------------------------------------------
SELECT 'delete_user_ng' AS 'Procedure';
DROP PROCEDURE IF EXISTS delete_user_ng;
CREATE PROCEDURE delete_user_ng(IN fa_user_id BIGINT, IN fa_ng_twitter_id VARCHAR(100))
main:BEGIN
	DECLARE fv_user_id BIGINT;
	DECLARE fv_ng_user_id BIGINT;
	-- check parameter
	IF fa_user_id IS NULL OR fa_ng_twitter_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- check record
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
	-- delete
	START TRANSACTION;
	DELETE FROM user_ng WHERE un_user_id = fv_user_id AND un_ng_user_id = fv_ng_user_id;
	COMMIT;
	SELECT fv_user_id AS successful;
END;
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ user_ng_word
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# register_user_ng_word
--#--------------------------------------------------------------------------------
SELECT 'register_user_ng_word' AS 'Procedure';
DROP PROCEDURE IF EXISTS register_user_ng_word;
CREATE PROCEDURE register_user_ng_word(IN fa_user_id BIGINT, IN fa_words MEDIUMTEXT, IN fa_word_count INT)
main:BEGIN
	DECLARE fv_user_id BIGINT;
	-- check parameter
	IF fa_user_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- check record
	SELECT user_id INTO fv_user_id FROM user WHERE user_id = fa_user_id;
	IF fv_user_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	-- register
	START TRANSACTION;
	INSERT INTO user_ng_word (unw_user_id, unw_words) VALUES (fv_user_id, fa_words) ON DUPLICATE KEY UPDATE unw_words = VALUES(unw_words);
	UPDATE user SET u_ng_word_count = fa_word_count WHERE user_id = fv_user_id;
	COMMIT;
	SELECT fv_user_id AS successful;
END;
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ user
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# register_user
--#--------------------------------------------------------------------------------
SELECT 'register_user' AS 'Procedure';
DROP PROCEDURE IF EXISTS register_user;
CREATE PROCEDURE register_user(IN fa_twitter_primary_id BIGINT UNSIGNED, IN fa_twitter_id VARCHAR(100), IN fa_twitter_name TEXT, IN fa_twitter_profile_image TEXT, IN fa_twitter_profile_banner TEXT, IN fa_access_token TEXT, IN fa_access_token_secret)
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
END;

--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ category
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# register_category
--#--------------------------------------------------------------------------------
SELECT 'register_category' AS 'Procedure';
DROP PROCEDURE IF EXISTS register_category;
CREATE PROCEDURE register_category(IN fa_word VARCHAR(150), IN fa_url_name VARCHAR(50), IN fa_parent INT, IN fa_sort INT, IN fa_description TEXT)
main:BEGIN
	-- check parameter
	IF fa_word IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- register
	START TRANSACTION;
	INSERT IGNORE INTO category
		(cat_word, cat_url_name, cat_parent, cat_sort, cat_description)
		VALUES(fa_word, fa_url_name, fa_parent, fa_sort, fa_description)
		ON DUPLICATE KEY UPDATE
		cat_url_name = VALUES(cat_url_name), cat_parent = VALUES(cat_parent), cat_sort = VALUES(cat_sort), cat_description = VALUES(cat_description);
	COMMIT;
	SELECT category_id AS successful FROM category WHERE cat_word = fa_word LIMIT 1;
END;
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ tag
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# register_tag
--#--------------------------------------------------------------------------------
SELECT 'register_tag' AS 'Procedure';
DROP PROCEDURE IF EXISTS register_tag;
CREATE PROCEDURE register_tag(IN fa_word VARCHAR(150))
main:BEGIN
	-- check parameter
	IF fa_word IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- register
	START TRANSACTION;
	INSERT IGNORE INTO tag (tg_word) VALUES (fa_word);
	COMMIT;
	SELECT tag_id AS successful FROM tag WHERE tg_word = fa_word LIMIT 1;
END;

--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ thread
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# register_thread
--#--------------------------------------------------------------------------------
SELECT 'register_thread' AS 'Procedure';
DROP PROCEDURE IF EXISTS register_thread;
CREATE PROCEDURE register_thread(IN fa_user_id BIGINT, IN fa_title TEXT, IN fa_body TEXT, IN fa_category_id INT, IN fa_ip TEXT)
main:BEGIN
	DECLARE fv_user_id BIGINT;
	DECLARE fv_parent INT;
	DECLARE fv_main_category_id INT;
	DECLARE fv_sub_category_id INT DEFAULT 0;
	DECLARE fv_insert_id BIGINT;
	-- check parameter
	IF fa_user_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- check record
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
	-- register
	START TRANSACTION;
	INSERT IGNORE INTO thread
		(t_user_id, t_title, t_body, t_main_category, t_sub_category, t_ip, t_datetime)
		VALUES(fa_user_id, fa_title, fa_body, fv_main_category_id, fv_sub_category_id, fa_ip, NOW());
	SELECT LAST_INSERT_ID() INTO fv_insert_id;
	COMMIT;
	SELECT fv_insert_id AS successful;
END;
--#--------------------------------------------------------------------------------
--# remove_thread
--#--------------------------------------------------------------------------------
SELECT 'remove_thread' AS 'Procedure';
DROP PROCEDURE IF EXISTS remove_thread;
CREATE PROCEDURE remove_thread(IN fa_thread_id BIGINT, IN fa_user_id BIGINT)
main:BEGIN

	DECLARE fv_thread_id BIGINT;
	DECLARE fv_user_id BIGINT;
	DECLARE fv_privated TINYINT DEFAULT 0;

	-- check parameter
	IF fa_thread_id IS NULL OR fa_thread_id = 0 OR fa_user_id IS NULL OR fa_user_id = 0 THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;

	-- check record
	SELECT thread_id, t_user_id INTO fv_thread_id, fv_user_id FROM thread WHERE thread_id = fa_thread_id AND t_privated = 0 LIMIT 1;
	IF fv_thread_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;

	IF fa_user_id = fv_user_id THEN
		SET fv_privated = 2;
	END IF;

	-- update
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
END;
--#--------------------------------------------------------------------------------
--# admin_remove_thread
--#--------------------------------------------------------------------------------
SELECT 'admin_remove_thread' AS 'Procedure';
DROP PROCEDURE IF EXISTS admin_remove_thread;
CREATE PROCEDURE admin_remove_thread(IN fa_thread_id BIGINT)
main:BEGIN

	DECLARE fv_thread_id BIGINT;

	-- check parameter
	IF fa_thread_id IS NULL OR fa_thread_id = 0 THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;

	-- check record
	SELECT thread_id INTO fv_thread_id FROM thread WHERE thread_id = fa_thread_id LIMIT 1;
	IF fv_thread_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;

	-- update
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
END;
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ thread_favorite
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# register_thread_favorite
--#--------------------------------------------------------------------------------
SELECT 'register_thread_favorite' AS 'Procedure';
DROP PROCEDURE IF EXISTS register_thread_favorite;
CREATE PROCEDURE register_thread_favorite(IN fa_favorite_user_id BIGINT, IN fa_thread_id BIGINT)
main:BEGIN
	DECLARE fv_thread_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	DECLARE fv_insert_id BIGINT;
	-- check parameter
	IF fa_favorite_user_id IS NULL OR fa_thread_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- check record
	SELECT thread_id, t_user_id INTO fv_thread_id, fv_thread_user_id FROM thread WHERE thread_id = fa_thread_id LIMIT 1;
	IF fv_thread_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	-- register
	START TRANSACTION;
	INSERT INTO thread_favorite_user (tfu_user_id, tfu_thread_id) VALUES (fa_favorite_user_id, fa_thread_id);
	INSERT INTO thread_favorite_thread (tft_user_id, tft_thread_id) VALUES (fa_favorite_user_id, fa_thread_id);
	INSERT INTO thread_favorite (tf_user_id, tf_thread_id, tf_thread_user_id, tf_datetime) VALUES (fa_favorite_user_id, fa_thread_id, fv_thread_user_id, NOW());
	SELECT LAST_INSERT_ID() INTO fv_insert_id;
	UPDATE thread_favorite_user SET thread_favorite_id = fv_insert_id WHERE tfu_user_id = fa_favorite_user_id AND tfu_thread_id = fa_thread_id;
	UPDATE thread_favorite_thread SET thread_favorite_id = fv_insert_id WHERE tft_user_id = fa_favorite_user_id AND tft_thread_id = fa_thread_id;
	COMMIT;
	SELECT fv_insert_id AS successful;
END;

--#--------------------------------------------------------------------------------
--# delete_thread_favorite
--#--------------------------------------------------------------------------------
SELECT 'delete_thread_favorite' AS 'Procedure';
DROP PROCEDURE IF EXISTS delete_thread_favorite;
CREATE PROCEDURE delete_thread_favorite(IN fa_favorite_user_id BIGINT, IN fa_thread_id BIGINT)
main:BEGIN
	-- check parameter
	IF fa_favorite_user_id IS NULL OR fa_thread_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- delete
	START TRANSACTION;
	DELETE thread_favorite, thread_favorite_user, thread_favorite_thread
		FROM thread_favorite_thread
		INNER JOIN thread_favorite ON thread_favorite.thread_favorite_id = thread_favorite_thread.thread_favorite_id
		INNER JOIN thread_favorite_user ON thread_favorite_user.tfu_user_id = thread_favorite_thread.tft_user_id AND thread_favorite_user.tfu_thread_id = thread_favorite_thread.tft_thread_id
	WHERE thread_favorite_thread.tft_user_id = fa_favorite_user_id AND thread_favorite_thread.tft_thread_id = fa_thread_id;
	COMMIT;
	SELECT 1 AS successful;
END;
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ thread_report
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# register_thread_report
--#--------------------------------------------------------------------------------
SELECT 'register_thread_report' AS 'Procedure';
DROP PROCEDURE IF EXISTS register_thread_report;
CREATE PROCEDURE register_thread_report(IN fa_report_user_id BIGINT, IN fa_thread_id BIGINT, IN fa_body TEXT, IN fa_report_type TINYINT, IN fa_ip TEXT, IN fa_host TEXT, IN fa_ua TEXT)
main:BEGIN
	DECLARE fv_user_id BIGINT;
	DECLARE fv_privilege TINYINT;
	DECLARE fv_thread_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	DECLARE fv_report_count INT;
	DECLARE fv_privated TINYINT;
	DECLARE fv_report_type_id TINYINT;
	DECLARE fv_insert_id BIGINT;
	-- check parameter
	IF fa_report_user_id IS NULL OR fa_thread_id IS NULL OR fa_body = '' OR fa_report_type IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- check record
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
	-- register
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
END;
--#--------------------------------------------------------------------------------
--# delete_thread_report
--#--------------------------------------------------------------------------------
SELECT 'delete_thread_report' AS 'Procedure';
DROP PROCEDURE IF EXISTS delete_thread_report;
CREATE PROCEDURE delete_thread_report(IN fa_report_user_id BIGINT, IN fa_thread_id BIGINT, IN fa_sess_user_id BIGINT)
main:BEGIN
	DECLARE fv_thread_report_id BIGINT;
	DECLARE fv_report_user_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	-- check parameter
	IF fa_report_user_id IS NULL OR fa_thread_id IS NULL OR fa_sess_user_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- check record
	SELECT thread_report.thread_report_id, tr_user_id, tr_thread_user_id INTO fv_thread_report_id, fv_report_user_id, fv_thread_user_id FROM thread_report_user INNER JOIN thread_report ON thread_report.thread_report_id = thread_report_user.thread_report_id WHERE tru_user_id = fa_report_user_id AND tru_thread_id = fa_thread_id LIMIT 1;
	IF fv_thread_report_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	-- remove
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
END;
--#--------------------------------------------------------------------------------
--# admin_delete_thread_report
--#--------------------------------------------------------------------------------
SELECT 'admin_delete_thread_report' AS 'Procedure';
DROP PROCEDURE IF EXISTS admin_delete_thread_report;
CREATE PROCEDURE admin_delete_thread_report(IN fa_report_user_id BIGINT, IN fa_thread_id BIGINT)
main:BEGIN
	-- check parameter
	IF fa_report_user_id IS NULL OR fa_thread_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	START TRANSACTION;
	UPDATE thread_report SET tr_body = '', tr_privated = 1, tr_ip = '', tr_host = '', tr_ua = '' WHERE tr_user_id = fa_report_user_id AND tr_thread_id = fa_thread_id;
	COMMIT;
	SELECT 1 AS successful;
END;
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ thread_tag
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# register_thread_tag
--#--------------------------------------------------------------------------------
SELECT 'register_thread_tag' AS 'Procedure';
DROP PROCEDURE IF EXISTS register_thread_tag;
CREATE PROCEDURE register_thread_tag(IN fa_thread_id BIGINT, IN fa_number TINYINT, IN fa_tag_id INT)
main:BEGIN
	-- check parameter
	IF fa_thread_id IS NULL OR fa_number IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- register
	START TRANSACTION;
	INSERT IGNORE INTO thread_tag (tt_thread_id, tt_number, tt_tag_id) VALUES (fa_thread_id, fa_number, fa_tag_id) ON DUPLICATE KEY UPDATE tt_tag_id = VALUES(tt_tag_id);
	COMMIT;
	SELECT 1 AS successful;
END;
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ comment
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# register_comment
--#--------------------------------------------------------------------------------
SELECT 'register_comment' AS 'Procedure';
DROP PROCEDURE IF EXISTS register_comment;
CREATE PROCEDURE register_comment(IN fa_thread_id BIGINT, IN fa_user_id BIGINT, IN fa_body TEXT, IN fa_ip TEXT)
main:BEGIN
	DECLARE fv_thread_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	DECLARE fv_main_category_id INT;
	DECLARE fv_sub_category_id INT;
	DECLARE fv_privated TINYINT;
	DECLARE fv_filled TINYINT;
	DECLARE fv_insert_id BIGINT;
	-- check parameter
	IF fa_thread_id IS NULL OR fa_user_id IS NULL OR fa_body IS NULL OR fa_body = '' THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- check record
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
	-- register
	START TRANSACTION;
	INSERT INTO comment
		(c_user_id, c_thread_id, c_thread_user_id, c_body, c_main_category, c_sub_category, c_ip, c_datetime)
		VALUES(fa_user_id, fa_thread_id, fv_thread_user_id, fa_body, fv_main_category_id, fv_sub_category_id, fa_ip, NOW());
	SELECT LAST_INSERT_ID() INTO fv_insert_id;
	COMMIT;
	SELECT fv_insert_id AS successful;
END;
--#--------------------------------------------------------------------------------
--# remove_comment
--#--------------------------------------------------------------------------------
SELECT 'remove_comment' AS 'Procedure';
DROP PROCEDURE IF EXISTS remove_comment;
CREATE PROCEDURE remove_comment(IN fa_comment_id BIGINT, IN fa_user_id BIGINT)
main:BEGIN
	DECLARE fv_comment_id BIGINT;
	DECLARE fv_user_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	DECLARE fv_privated TINYINT DEFAULT 0;
	-- check parameter
	IF fa_comment_id IS NULL OR fa_comment_id = 0 OR fa_user_id IS NULL OR fa_user_id = 0 THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- check record
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
	-- update
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
END;
--#--------------------------------------------------------------------------------
--# admin_remove_comment
--#--------------------------------------------------------------------------------
SELECT 'admin_remove_comment' AS 'Procedure';
DROP PROCEDURE IF EXISTS admin_remove_comment;
CREATE PROCEDURE admin_remove_comment(IN fa_comment_id BIGINT)
main:BEGIN
	-- check parameter
	IF fa_comment_id IS NULL OR fa_comment_id = 0 THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- update
	START TRANSACTION;
	UPDATE comment SET c_main_category = 0, c_sub_category = 0, c_body = '', c_ip = '', c_privated = 1 WHERE comment_id = fa_comment_id;
	DELETE comment_report, comment_report_user, comment_report_comment
		FROM comment_report_comment
		INNER JOIN comment_report ON comment_report.comment_report_id = comment_report_comment.comment_report_id
		INNER JOIN comment_report_user ON comment_report_user.cru_user_id = comment_report_comment.crc_user_id AND comment_report_user.cru_comment_id = comment_report_comment.crc_comment_id
	WHERE comment_report_comment.crc_comment_id = fa_comment_id;
	COMMIT;
	SELECT 1 AS successful;
END;
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ comment_report
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# register_comment_report
--#--------------------------------------------------------------------------------
SELECT 'register_comment_report' AS 'Procedure';
DROP PROCEDURE IF EXISTS register_comment_report;
CREATE PROCEDURE register_comment_report(IN fa_report_user_id BIGINT, IN fa_comment_id BIGINT, IN fa_body TEXT, IN fa_report_type TINYINT, IN fa_ip TEXT, IN fa_host TEXT, IN fa_ua TEXT)
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
	-- check parameter
	IF fa_report_user_id IS NULL OR fa_comment_id IS NULL OR fa_body = '' OR fa_report_type IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- check record
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
	-- register
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
END;
--#--------------------------------------------------------------------------------
--# delete_comment_report
--#--------------------------------------------------------------------------------
SELECT 'delete_comment_report' AS 'Procedure';
DROP PROCEDURE IF EXISTS delete_comment_report;
CREATE PROCEDURE delete_comment_report(IN fa_report_user_id BIGINT, IN fa_comment_id BIGINT, IN fa_sess_user_id BIGINT)
main:BEGIN
	DECLARE fv_comment_report_id BIGINT;
	DECLARE fv_report_user_id BIGINT;
	DECLARE fv_thread_user_id BIGINT;
	-- check parameter
	IF fa_report_user_id IS NULL OR fa_comment_id IS NULL OR fa_sess_user_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- check record
	SELECT comment_report.comment_report_id, cr_user_id, cr_thread_user_id INTO fv_comment_report_id, fv_report_user_id, fv_thread_user_id FROM comment_report_user INNER JOIN comment_report ON comment_report.comment_report_id = comment_report_user.comment_report_id WHERE cru_user_id = fa_report_user_id AND cru_comment_id = fa_comment_id LIMIT 1;
	IF fv_comment_report_id IS NULL THEN
		SELECT 'record_not_found' AS error;
		LEAVE main;
	END IF;
	-- remove
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
END;
--#--------------------------------------------------------------------------------
--# admin_delete_comment_report
--#--------------------------------------------------------------------------------
SELECT 'admin_delete_comment_report' AS 'Procedure';
DROP PROCEDURE IF EXISTS admin_delete_comment_report;
CREATE PROCEDURE admin_delete_comment_report(IN fa_report_user_id BIGINT, IN fa_comment_id BIGINT)
main:BEGIN
	-- check parameter
	IF fa_report_user_id IS NULL OR fa_comment_id IS NULL OR fa_sess_user_id IS NULL THEN
		SELECT 'invalid_parameter' AS error;
		LEAVE main;
	END IF;
	-- remove
	START TRANSACTION;
	UPDATE comment_report SET cr_body = '', cr_privated = 1, cr_ip = '', cr_host = '', cr_ua = '' WHERE cr_user_id = fa_report_user_id AND cr_comment_id = fa_comment_id;
	COMMIT;
	SELECT 1 AS successful;
END;

//
DELIMITER ;
