-- 数据库优化和示例数据脚本
-- 注意: 此脚本可以重复执行,会自动检查索引和字段是否存在
-- 兼容 MySQL 5.7+

-- ==========================================
-- 性能优化索引(使用动态SQL兼容MySQL 5.7)
-- ==========================================

-- 匹配记录表优化索引
SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user_match_record' AND INDEX_NAME = 'idx_user_action_time';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_user_match_record` DROP INDEX `idx_user_action_time`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user_match_record' AND INDEX_NAME = 'idx_target_user';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_user_match_record` DROP INDEX `idx_target_user`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

ALTER TABLE `im_user_match_record` 
ADD INDEX `idx_user_action_time` (`user_id`, `action_type`, `created_time`),
ADD INDEX `idx_target_user` (`target_user_id`, `created_time`);

-- 匹配表优化索引
SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user_match' AND INDEX_NAME = 'idx_user1_status';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_user_match` DROP INDEX `idx_user1_status`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user_match' AND INDEX_NAME = 'idx_user2_status';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_user_match` DROP INDEX `idx_user2_status`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

ALTER TABLE `im_user_match`
ADD INDEX `idx_user1_status` (`user1_id`, `status`),
ADD INDEX `idx_user2_status` (`user2_id`, `status`);

-- 分销佣金表优化索引
SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_commission' AND INDEX_NAME = 'idx_distributor_status_time';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_distribution_commission` DROP INDEX `idx_distributor_status_time`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_commission' AND INDEX_NAME = 'idx_buyer_time';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_distribution_commission` DROP INDEX `idx_buyer_time`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_commission' AND INDEX_NAME = 'idx_order_status';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_distribution_commission` DROP INDEX `idx_order_status`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

ALTER TABLE `im_distribution_commission`
ADD INDEX `idx_distributor_status_time` (`distributor_user_id`, `status`, `created_time`),
ADD INDEX `idx_buyer_time` (`buyer_user_id`, `created_time`),
ADD INDEX `idx_order_status` (`order_id`, `status`);

-- 分销用户表优化索引
SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_user' AND INDEX_NAME = 'idx_parent_status';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_distribution_user` DROP INDEX `idx_parent_status`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_user' AND INDEX_NAME = 'idx_grand_parent_status';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_distribution_user` DROP INDEX `idx_grand_parent_status`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_user' AND INDEX_NAME = 'idx_status_activated';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_distribution_user` DROP INDEX `idx_status_activated`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

ALTER TABLE `im_distribution_user`
ADD INDEX `idx_parent_status` (`parent_user_id`, `status`),
ADD INDEX `idx_grand_parent_status` (`grand_parent_user_id`, `status`),
ADD INDEX `idx_status_activated` (`status`, `activated_time`);

-- 商品表优化索引
SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_product' AND INDEX_NAME = 'idx_status_sort';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_mall_product` DROP INDEX `idx_status_sort`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_product' AND INDEX_NAME = 'idx_distribution';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_mall_product` DROP INDEX `idx_distribution`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

ALTER TABLE `im_mall_product`
ADD INDEX `idx_status_sort` (`status`, `sort_order`),
ADD INDEX `idx_distribution` (`enable_distribution`, `status`);

-- 订单表优化索引
SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND INDEX_NAME = 'idx_user_status_time';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_mall_order` DROP INDEX `idx_user_status_time`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND INDEX_NAME = 'idx_product_status';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_mall_order` DROP INDEX `idx_product_status`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND INDEX_NAME = 'idx_referrer';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_mall_order` DROP INDEX `idx_referrer`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND INDEX_NAME = 'idx_status_paid';
SET @sql = IF(@idx_exists > 0, 'ALTER TABLE `im_mall_order` DROP INDEX `idx_status_paid`', 'SELECT ''Index not exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

ALTER TABLE `im_mall_order`
ADD INDEX `idx_user_status_time` (`user_id`, `status`, `created_time`),
ADD INDEX `idx_product_status` (`product_id`, `status`),
ADD INDEX `idx_referrer` (`referrer_user_id`, `status`),
ADD INDEX `idx_status_paid` (`status`, `paid_time`);

-- ==========================================
-- 为User表添加推荐相关字段(如果不存在)
-- ==========================================

-- 检查并添加兴趣标签字段
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'interests';
SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `im_user` ADD COLUMN `interests` VARCHAR(500) COMMENT ''兴趣标签,逗号分隔'' AFTER `signature`', 
    'SELECT ''Column interests already exists'' AS Info');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 检查并添加年龄字段
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'age';
SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `im_user` ADD COLUMN `age` INT(3) COMMENT ''年龄'' AFTER `birthday`', 
    'SELECT ''Column age already exists'' AS Info');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 检查并添加城市字段
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'city';
SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `im_user` ADD COLUMN `city` VARCHAR(100) COMMENT ''所在城市'' AFTER `age`', 
    'SELECT ''Column city already exists'' AS Info');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 检查并添加经度字段
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'longitude';
SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `im_user` ADD COLUMN `longitude` DECIMAL(10, 6) COMMENT ''经度'' AFTER `city`', 
    'SELECT ''Column longitude already exists'' AS Info');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 检查并添加纬度字段
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'latitude';
SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `im_user` ADD COLUMN `latitude` DECIMAL(10, 6) COMMENT ''纬度'' AFTER `longitude`', 
    'SELECT ''Column latitude already exists'' AS Info');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 注意: 空间索引需要字段为NOT NULL,这里跳过创建
-- 如果需要使用地理位置功能,请手动执行以下语句:
-- ALTER TABLE `im_user` MODIFY `longitude` DECIMAL(10, 6) NOT NULL;

-- ==========================================
-- 新增商城相关表 (如果不存在)
-- ==========================================

CREATE TABLE IF NOT EXISTS `im_mall_category` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `parent_id` BIGINT NULL,
  `name` VARCHAR(100) NOT NULL,
  `status` TINYINT NOT NULL DEFAULT 1,
  `sort_order` INT NOT NULL DEFAULT 0,
  `created_time` DATETIME NULL,
  `updated_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_parent_status` (`parent_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `im_mall_sku` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT NOT NULL,
  `sku_code` VARCHAR(64) NOT NULL,
  `attributes` VARCHAR(512) NULL,
  `price` DECIMAL(18, 6) NOT NULL,
  `stock` INT NOT NULL DEFAULT 0,
  `status` TINYINT NOT NULL DEFAULT 1,
  `created_time` DATETIME NULL,
  `updated_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_product_sku_code` (`product_id`, `sku_code`),
  INDEX `idx_product_status` (`product_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `im_mall_aftersale` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT NOT NULL,
  `user_id` BIGINT NOT NULL,
  `reason` VARCHAR(512) NULL,
  `status` TINYINT NOT NULL DEFAULT 0,
  `created_time` DATETIME NULL,
  `updated_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_user_status_time` (`user_id`, `status`, `created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- MallOrder表新增字段(如果不存在)
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'sku_id';
SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `im_mall_order` ADD COLUMN `sku_id` BIGINT AFTER `product_id`', 
    'SELECT ''Column sku_id already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'shipping_carrier';
SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `im_mall_order` ADD COLUMN `shipping_carrier` VARCHAR(64) AFTER `status`', 
    'SELECT ''Column shipping_carrier already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'shipping_no';
SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `im_mall_order` ADD COLUMN `shipping_no` VARCHAR(64) AFTER `shipping_carrier`', 
    'SELECT ''Column shipping_no already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'shipped_time';
SET @sql = IF(@col_exists = 0, 
    'ALTER TABLE `im_mall_order` ADD COLUMN `shipped_time` DATETIME AFTER `shipping_no`', 
    'SELECT ''Column shipped_time already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
-- ALTER TABLE `im_user` MODIFY `latitude` DECIMAL(10, 6) NOT NULL;
-- ALTER TABLE `im_user` ADD SPATIAL INDEX `idx_location` (POINT(`longitude`, `latitude`));

-- ==========================================
-- 插入更多示例商品数据
-- ==========================================

INSERT INTO `im_mall_product` 
(`product_name`, `description`, `image_url`, `price`, `original_price`, `stock`, `product_type`, 
 `status`, `sort_order`, `enable_distribution`, `level1_commission_rate`, `level2_commission_rate`) 
VALUES
('超级会员年卡', '开通超级会员12个月，尊享全部特权', NULL, 588.00, 999.00, 9999, 1, 1, 5, 1, 0.2500, 0.1500),
('钻石礼包-小', '包含500钻石', NULL, 50.00, 50.00, 9999, 1, 1, 6, 0, 0.0000, 0.0000),
('钻石礼包-中', '包含2000钻石,额外赠送200钻石', NULL, 198.00, 198.00, 9999, 1, 1, 7, 0, 0.0000, 0.0000),
('钻石礼包-大', '包含5000钻石,额外赠送1000钻石', NULL, 488.00, 488.00, 9999, 1, 1, 8, 0, 0.0000, 0.0000),
('表情包-可爱', '50个精选可爱表情', NULL, 9.90, 19.90, 9999, 1, 1, 9, 1, 0.3000, 0.1000),
('表情包-搞笑', '50个精选搞笑表情', NULL, 9.90, 19.90, 9999, 1, 1, 10, 1, 0.3000, 0.1000),
('主题皮肤-星空', '精美星空主题皮肤', NULL, 12.00, 25.00, 9999, 1, 1, 11, 1, 0.2000, 0.1000),
('主题皮肤-粉色', '精美粉色主题皮肤', NULL, 12.00, 25.00, 9999, 1, 1, 12, 1, 0.2000, 0.1000),
('聊天背景-清新', '10款清新聊天背景', NULL, 6.00, 12.00, 9999, 1, 1, 13, 1, 0.2500, 0.1000),
('聊天背景-科技', '10款科技感聊天背景', NULL, 6.00, 12.00, 9999, 1, 1, 14, 1, 0.2500, 0.1000);

-- ==========================================
-- 插入示例分销用户数据(测试用)
-- ==========================================

-- 注意: 实际使用时user_id应该是真实存在的用户ID
-- INSERT INTO `im_distribution_user` 
-- (`user_id`, `referral_code`, `parent_user_id`, `status`, `activated_time`) 
-- VALUES
-- (100, 'ABC12345', NULL, 1, NOW()),
-- (101, 'DEF67890', 100, 1, NOW()),
-- (102, 'GHI11111', 100, 1, NOW()),
-- (103, 'JKL22222', 101, 1, NOW());

-- ==========================================
-- 创建统计视图
-- 注意: CREATE OR REPLACE VIEW 会自动替换已存在的视图
-- ==========================================

-- 分销商佣金汇总视图
DROP VIEW IF EXISTS `v_distributor_commission_summary`;
CREATE VIEW `v_distributor_commission_summary` AS
SELECT 
    du.user_id,
    du.referral_code,
    du.status,
    COUNT(dc.id) as total_orders,
    SUM(dc.commission_amount) as total_commission,
    SUM(CASE WHEN dc.commission_type = 1 THEN dc.commission_amount ELSE 0 END) as level1_commission,
    SUM(CASE WHEN dc.commission_type = 2 THEN dc.commission_amount ELSE 0 END) as level2_commission,
    (SELECT COUNT(*) FROM im_distribution_user WHERE parent_user_id = du.user_id) as level1_count,
    (SELECT COUNT(*) FROM im_distribution_user WHERE grand_parent_user_id = du.user_id) as level2_count
FROM im_distribution_user du
LEFT JOIN im_distribution_commission dc ON du.user_id = dc.distributor_user_id AND dc.status = 1
WHERE du.status = 1
GROUP BY du.user_id, du.referral_code, du.status;

-- 商品销售统计视图
DROP VIEW IF EXISTS `v_product_sales_summary`;
CREATE VIEW `v_product_sales_summary` AS
SELECT 
    p.id,
    p.product_name,
    p.price,
    p.stock,
    p.sales_count,
    COUNT(o.id) as order_count,
    SUM(o.quantity) as total_quantity,
    SUM(o.total_amount) as total_sales_amount
FROM im_mall_product p
LEFT JOIN im_mall_order o ON p.id = o.product_id AND o.status IN (1, 3)
GROUP BY p.id, p.product_name, p.price, p.stock, p.sales_count;

-- 用户匹配统计视图
DROP VIEW IF EXISTS `v_user_match_summary`;
CREATE VIEW `v_user_match_summary` AS
SELECT 
    u.id as user_id,
    u.nick_name,
    COUNT(DISTINCT mr.target_user_id) as viewed_count,
    COUNT(DISTINCT CASE WHEN mr.action_type = 1 THEN mr.target_user_id END) as liked_count,
    COUNT(DISTINCT CASE WHEN mr.action_type = 2 THEN mr.target_user_id END) as disliked_count,
    COUNT(DISTINCT m.id) as matched_count
FROM im_user u
LEFT JOIN im_user_match_record mr ON u.id = mr.user_id
LEFT JOIN im_user_match m ON (u.id = m.user1_id OR u.id = m.user2_id) AND m.status = 1
GROUP BY u.id, u.nick_name;

-- ==========================================
-- 数据清理存储过程
-- ==========================================

DELIMITER $$

-- 删除已存在的存储过程
DROP PROCEDURE IF EXISTS `sp_clean_expired_orders`$$

-- 清理过期的未支付订单(超过24小时)
CREATE PROCEDURE `sp_clean_expired_orders`()
BEGIN
    UPDATE im_mall_order 
    SET status = 2, updated_time = NOW()
    WHERE status = 0 
    AND TIMESTAMPDIFF(HOUR, created_time, NOW()) > 24;
    
    SELECT ROW_COUNT() as affected_rows;
END$$

-- 统计分销商每日数据
CREATE PROCEDURE `sp_daily_distributor_stats`(IN target_date DATE)
BEGIN
    SELECT 
        du.user_id,
        du.referral_code,
        COUNT(dc.id) as order_count,
        SUM(dc.commission_amount) as commission_amount,
        SUM(CASE WHEN dc.commission_type = 1 THEN dc.commission_amount ELSE 0 END) as level1_commission,
        SUM(CASE WHEN dc.commission_type = 2 THEN dc.commission_amount ELSE 0 END) as level2_commission
    FROM im_distribution_user du
    LEFT JOIN im_distribution_commission dc 
        ON du.user_id = dc.distributor_user_id 
        AND dc.status = 1
        AND DATE(dc.created_time) = target_date
    WHERE du.status = 1
    GROUP BY du.user_id, du.referral_code
    ORDER BY commission_amount DESC;
END$$

DELIMITER ;

-- ==========================================
-- 定时任务建议(需要配合应用程序或MySQL Event)
-- ==========================================

-- 启用事件调度器
SET GLOBAL event_scheduler = ON;

-- 每天凌晨清理过期订单
CREATE EVENT IF NOT EXISTS `evt_clean_expired_orders`
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '00:00:00')
DO CALL sp_clean_expired_orders();

-- ==========================================
-- 性能监控查询示例
-- ==========================================

-- 查看慢查询
-- SHOW VARIABLES LIKE 'slow_query_log%';
-- SHOW VARIABLES LIKE 'long_query_time';

-- 查看表大小
-- SELECT 
--     table_name AS `Table`,
--     ROUND(((data_length + index_length) / 1024 / 1024), 2) AS `Size (MB)`
-- FROM information_schema.TABLES
-- WHERE table_schema = 'wr-chat-shejiao'
-- ORDER BY (data_length + index_length) DESC;

-- 查看索引使用情况
-- SELECT 
--     table_name,
--     index_name,
--     cardinality,
--     column_name
-- FROM information_schema.STATISTICS
-- WHERE table_schema = 'wr-chat-shejiao'
-- ORDER BY table_name, index_name;
