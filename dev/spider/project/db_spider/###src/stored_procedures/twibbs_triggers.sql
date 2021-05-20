use spider_twibbs;
DELIMITER //
--#--------------------------------------------------------------------------------
--# Twibbs Triggers Common Libraries
--#
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ user_ng
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# after_insert_user_ng
--#--------------------------------------------------------------------------------
SELECT 'after_insert_user_ng' AS 'Trigger';
DROP TRIGGER IF EXISTS after_insert_user_ng;
CREATE TRIGGER after_insert_user_ng AFTER INSERT ON user_ng FOR EACH ROW
main:BEGIN
	UPDATE user SET
		u_first_ng_user_id = (CASE WHEN u_first_ng_user_id IS NULL THEN NEW.un_ng_user_id ELSE u_first_ng_user_id END),
		u_last_ng_user_id = NEW.un_ng_user_id,
		u_ng_user_count = u_ng_user_count + 1
	WHERE user_id = NEW.un_user_id;
	UPDATE user SET u_nged_user_count = u_nged_user_count + 1 WHERE user_id = NEW.un_ng_user_id;
END;
--#--------------------------------------------------------------------------------
--# after_delete_user_ng
--#--------------------------------------------------------------------------------
SELECT 'after_delete_user_ng' AS 'Trigger';
DROP TRIGGER IF EXISTS after_delete_user_ng;
CREATE TRIGGER after_delete_user_ng AFTER DELETE ON user_ng FOR EACH ROW
main:BEGIN
	UPDATE user SET
		u_first_ng_user_id = (CASE WHEN u_ng_user_count = 1 THEN NULL ELSE u_first_ng_user_id END),
		u_last_ng_user_id = (SELECT un_ng_user_id FROM user_ng WHERE un_user_id = OLD.un_user_id ORDER BY un_datetime DESC LIMIT 1),
		u_ng_user_count = u_ng_user_count - 1
	WHERE user_id = OLD.un_user_id;
	UPDATE user SET u_nged_user_count = u_nged_user_count - 1 WHERE user_id = OLD.un_ng_user_id;
END;
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ user
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# after_insert_user
--#--------------------------------------------------------------------------------
SELECT 'after_insert_user' AS 'Trigger';
DROP TRIGGER IF EXISTS after_insert_user;
CREATE TRIGGER after_insert_user AFTER INSERT ON user FOR EACH ROW
main:BEGIN
	UPDATE site SET s_user_count = s_user_count + 1;
END;
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ comment
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# after_insert_comment
--#--------------------------------------------------------------------------------
SELECT 'after_insert_comment' AS 'Trigger';
DROP TRIGGER IF EXISTS after_insert_comment;
CREATE TRIGGER after_insert_comment AFTER INSERT ON comment FOR EACH ROW
main:BEGIN
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
END;
--#--------------------------------------------------------------------------------
--# after_update_comment
--#--------------------------------------------------------------------------------
SELECT 'after_update_comment' AS 'Trigger';
DROP TRIGGER IF EXISTS after_update_comment;
CREATE TRIGGER after_update_comment AFTER UPDATE ON comment FOR EACH ROW
main:BEGIN
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
END;

--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ comment_report
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# after_insert_comment_report
--#--------------------------------------------------------------------------------
SELECT 'after_insert_comment_report' AS 'Trigger';
DROP TRIGGER IF EXISTS after_insert_comment_report;
CREATE TRIGGER after_insert_comment_report AFTER INSERT ON comment_report FOR EACH ROW
main:BEGIN
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
END;
--#--------------------------------------------------------------------------------
--# after_delete_comment_report
--#--------------------------------------------------------------------------------
SELECT 'after_delete_comment_report' AS 'Trigger';
DROP TRIGGER IF EXISTS after_delete_comment_report;
CREATE TRIGGER after_delete_comment_report AFTER DELETE ON comment_report FOR EACH ROW
main:BEGIN
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
END;
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ thread
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# after_insert_thread
--#--------------------------------------------------------------------------------
SELECT 'after_insert_thread' AS 'Trigger';
DROP TRIGGER IF EXISTS after_insert_thread;
CREATE TRIGGER after_insert_thread AFTER INSERT ON thread FOR EACH ROW
main:BEGIN
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
END;
--#--------------------------------------------------------------------------------
--# after_update_thread
--#--------------------------------------------------------------------------------
SELECT 'after_update_thread' AS 'Trigger';
DROP TRIGGER IF EXISTS after_update_thread;
CREATE TRIGGER after_update_thread AFTER UPDATE ON thread FOR EACH ROW
main:BEGIN
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
END;

--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ thread_favorite
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# after_insert_thread_favorite
--#--------------------------------------------------------------------------------
SELECT 'after_insert_thread_favorite' AS 'Trigger';
DROP TRIGGER IF EXISTS after_insert_thread_favorite;
CREATE TRIGGER after_insert_thread_favorite AFTER INSERT ON thread_favorite FOR EACH ROW
main:BEGIN
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
END;
--#--------------------------------------------------------------------------------
--# after_delete_thread_favorite
--#--------------------------------------------------------------------------------
SELECT 'after_delete_thread_favorite' AS 'Trigger';
DROP TRIGGER IF EXISTS after_delete_thread_favorite;
CREATE TRIGGER after_delete_thread_favorite AFTER DELETE ON thread_favorite FOR EACH ROW
main:BEGIN
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
END;

--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ thread_report
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# after_insert_thread_report
--#--------------------------------------------------------------------------------
SELECT 'after_insert_thread_report' AS 'Trigger';
DROP TRIGGER IF EXISTS after_insert_thread_report;
CREATE TRIGGER after_insert_thread_report AFTER INSERT ON thread_report FOR EACH ROW
main:BEGIN
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

END;
--#--------------------------------------------------------------------------------
--# after_delete_thread_report
--#--------------------------------------------------------------------------------
SELECT 'after_delete_thread_report' AS 'Trigger';
DROP TRIGGER IF EXISTS after_delete_thread_report;
CREATE TRIGGER after_delete_thread_report AFTER DELETE ON thread_report FOR EACH ROW
main:BEGIN
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
END;

--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# @@ thread_tag
--#--------------------------------------------------------------------------------
--#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--#--------------------------------------------------------------------------------
--# after_insert_thread_tag
--#--------------------------------------------------------------------------------
SELECT 'after_insert_thread_tag' AS 'Trigger';
DROP TRIGGER IF EXISTS after_insert_thread_tag;
CREATE TRIGGER after_insert_thread_tag AFTER INSERT ON thread_tag FOR EACH ROW
main:BEGIN
	IF NEW.tt_tag_id IS NOT NULL AND NEW.tt_tag_id != 0 AND NEW.tt_tag_id != '' THEN
		UPDATE tag SET
			tg_first_thread_id = (CASE WHEN tg_first_thread_id IS NULL THEN NEW.tt_thread_id ELSE tg_first_thread_id END),
			tg_last_thread_id = NEW.tt_thread_id,
			tg_thread_count = tg_thread_count + 1
		WHERE tag_id = NEW.tt_tag_id;
	END IF;
END;
--#--------------------------------------------------------------------------------
--# after_update_thread_tag
--#--------------------------------------------------------------------------------
SELECT 'after_update_thread_tag' AS 'Trigger';
DROP TRIGGER IF EXISTS after_update_thread_tag;
CREATE TRIGGER after_update_thread_tag AFTER UPDATE ON thread_tag FOR EACH ROW
main:BEGIN
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
END;
--#--------------------------------------------------------------------------------
--# after_delete_thread_tag
--#--------------------------------------------------------------------------------
SELECT 'after_delete_thread_tag' AS 'Trigger';
DROP TRIGGER IF EXISTS after_delete_thread_tag;
CREATE TRIGGER after_delete_thread_tag AFTER DELETE ON thread_tag FOR EACH ROW
main:BEGIN
	UPDATE tag SET
		tg_first_thread_id = (CASE WHEN tg_thread_count = 1 THEN NULL ELSE tg_first_thread_id END),
		tg_last_thread_id = (SELECT tt_thread_id FROM thread_tag WHERE tt_tag_id = OLD.tt_tag_id ORDER BY tt_thread_id DESC LIMIT 1),
		tg_thread_count = tg_thread_count - 1
	WHERE tag_id = OLD.tt_tag_id;
END;

//
DELIMITER ;
