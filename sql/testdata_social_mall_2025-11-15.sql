-- 社交匹配与商城测试数据（2025-11-15）
-- 说明：用于本地/测试环境快速构造可推荐用户与基本商城数据

SET NAMES utf8mb4;
SET @@session.time_zone = '+8:00';

-- =============================
-- 一、用户画像数据（用于匹配推荐）
-- =============================

-- 创建12个有效用户（status=0，未封禁），分布在沪京深三地
INSERT INTO `im_user` (`id`,`user_name`,`nick_name`,`sex`,`age`,`city`,`interests`,`longitude`,`latitude`,`head_image`,`signature`,`is_banned`,`status`,`last_login_time`,`created_time`,`type`)
VALUES
 (5001,'alice','Alice',1,24,'上海','音乐,旅行,电影',121.4737,31.2304,'/img/u1.png','热爱生活与音乐',0,0, NOW(), NOW(), 2),
 (5002,'bob','Bob',0,26,'北京','音乐,电影,运动',116.4074,39.9042,'/img/u2.png','跑步与摄影',0,0, DATE_SUB(NOW(), INTERVAL 1 DAY), NOW(), 2),
 (5003,'cindy','Cindy',1,25,'深圳','旅行,美食,阅读',114.0579,22.5431,'/img/u3.png','做一个有趣的人',0,0, DATE_SUB(NOW(), INTERVAL 2 DAY), NOW(), 2),
 (5004,'david','David',0,28,'上海','运动,阅读,电影',121.4737,31.2304,'/img/u4.png','理性且温柔',0,0, DATE_SUB(NOW(), INTERVAL 3 DAY), NOW(), 2),
 (5005,'eva','Eva',1,22,'北京','音乐,美食,运动',116.4074,39.9042,'/img/u5.png','新手厨艺爱好者',0,0, DATE_SUB(NOW(), INTERVAL 4 DAY), NOW(), 2),
 (5006,'frank','Frank',0,30,'深圳','电影,旅行,数码',114.0579,22.5431,'/img/u6.png','数码控',0,0, DATE_SUB(NOW(), INTERVAL 5 DAY), NOW(), 2),
 (5007,'grace','Grace',1,27,'上海','阅读,旅行,艺术',121.4737,31.2304,'/img/u7.png','艺术展爱好者',0,0, DATE_SUB(NOW(), INTERVAL 0 DAY), NOW(), 2),
 (5008,'henry','Henry',0,29,'北京','运动,音乐,户外',116.4074,39.9042,'/img/u8.png','户外露营',0,0, DATE_SUB(NOW(), INTERVAL 1 DAY), NOW(), 2),
 (5009,'iris','Iris',1,23,'深圳','美食,电影,摄影',114.0579,22.5431,'/img/u9.png','记录生活',0,0, DATE_SUB(NOW(), INTERVAL 2 DAY), NOW(), 2),
 (5010,'jack','Jack',0,31,'上海','旅行,运动,音乐',121.4737,31.2304,'/img/u10.png','旅行达人',0,0, DATE_SUB(NOW(), INTERVAL 3 DAY), NOW(), 2),
 (5011,'kate','Kate',1,26,'北京','阅读,艺术,电影',116.4074,39.9042,'/img/u11.png','书虫一枚',0,0, DATE_SUB(NOW(), INTERVAL 4 DAY), NOW(), 2),
 (5012,'leo','Leo',0,27,'深圳','数码,运动,音乐',114.0579,22.5431,'/img/u12.png','节奏与力量',0,0, DATE_SUB(NOW(), INTERVAL 5 DAY), NOW(), 2)
ON DUPLICATE KEY UPDATE
 `nick_name`=VALUES(`nick_name`),`sex`=VALUES(`sex`),`age`=VALUES(`age`),`city`=VALUES(`city`),`interests`=VALUES(`interests`),
 `longitude`=VALUES(`longitude`),`latitude`=VALUES(`latitude`),`head_image`=VALUES(`head_image`),`signature`=VALUES(`signature`),
 `is_banned`=VALUES(`is_banned`),`status`=VALUES(`status`),`last_login_time`=VALUES(`last_login_time`),`type`=VALUES(`type`);

-- =============================
-- 二、商城基础数据（可用于后台验证）
-- =============================

-- 商品（上架、支持分销）
INSERT INTO `im_mall_product` (`product_name`,`description`,`image_url`,`price`,`original_price`,`stock`,`sales_count`,`product_type`,`status`,`sort_order`,`enable_distribution`,`level1_commission_rate`,`level2_commission_rate`,`created_time`,`updated_time`)
VALUES ('旅行随身杯','保温随身杯，适合出行与办公','/img/p1.png', 69.90, 99.00, 100, 0, 2, 1, 1, 1, 0.10, 0.05, NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_time`=VALUES(`updated_time`);

-- 关联SKU（两种规格）
INSERT INTO `im_mall_sku` (`product_id`,`sku_code`,`attributes`,`price`,`stock`,`status`,`created_time`,`updated_time`)
SELECT p.id, 'CUP-RED', '颜色:红色;容量:350ml', 69.90, 50, 1, NOW(), NOW() FROM `im_mall_product` p WHERE p.product_name='旅行随身杯'
ON DUPLICATE KEY UPDATE `price`=VALUES(`price`),`stock`=VALUES(`stock`),`updated_time`=VALUES(`updated_time`);

INSERT INTO `im_mall_sku` (`product_id`,`sku_code`,`attributes`,`price`,`stock`,`status`,`created_time`,`updated_time`)
SELECT p.id, 'CUP-BLK', '颜色:黑色;容量:500ml', 79.90, 50, 1, NOW(), NOW() FROM `im_mall_product` p WHERE p.product_name='旅行随身杯'
ON DUPLICATE KEY UPDATE `price`=VALUES(`price`),`stock`=VALUES(`stock`),`updated_time`=VALUES(`updated_time`);

-- =============================
-- 三、清理视图（可选）
-- =============================
-- 如需清空当前用户的浏览记录，避免过滤过多候选：请取消注释执行
-- DELETE FROM `im_user_match_record` WHERE `user_id` IN (SELECT `id` FROM `im_user` WHERE `type`=2);

-- 结束