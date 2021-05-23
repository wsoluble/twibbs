
-- site record
INSERT INTO spider_twibbs.site (s_pv_count) VALUES (0);

-- insert admin user
CALL spider_twibbs.register_user(1395198975997714437, 'w_soluble_dev', '水溶性＠API開発用', 'https://pbs.twimg.com/profile_images/1395207662808100865/9Y0mD8Ho_normal.jpg', 'https://pbs.twimg.com/profile_banners/1395198975997714437/1621477572');