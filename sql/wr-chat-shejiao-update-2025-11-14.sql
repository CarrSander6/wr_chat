-- 最新增量更新脚本（2025-11-14）
-- 说明：在基础备份 d:/code/wurun/wr_chat/sql/wr-chat-shejiao.sql 之后执行本脚本，实现菜单与结构更新

-- ==========================================
-- 一、后台菜单（商城管理）
-- ==========================================

INSERT INTO `sys_menu` (`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query_param`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_dept`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
VALUES ('商城管理', 0, 150, 'mall', NULL, '', 1, 0, 'M', '0', '0', '', 'shopping-cart', 1, 1, NOW(), NULL, NULL, '商城管理目录');

-- 商品分类
INSERT INTO `sys_menu` (`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query_param`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_dept`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT '商品分类', m.menu_id, 1, 'mall/category', 'mall/category/index', '', 1, 0, 'C', '0', '0', 'mall:category:list', 'list', 1, 1, NOW(), NULL, NULL, '商品分类管理'
FROM `sys_menu` m WHERE m.path='mall' AND m.menu_type='M' LIMIT 1;

-- SKU管理
INSERT INTO `sys_menu` (`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query_param`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_dept`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT 'SKU管理', m.menu_id, 2, 'mall/sku', 'mall/sku/index', '', 1, 0, 'C', '0', '0', 'mall:sku:list', 'table', 1, 1, NOW(), NULL, NULL, 'SKU管理'
FROM `sys_menu` m WHERE m.path='mall' AND m.menu_type='M' LIMIT 1;

-- 订单发货
INSERT INTO `sys_menu` (`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query_param`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_dept`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT '订单发货', m.menu_id, 3, 'mall/order-ship', 'mall/order/ship', '', 1, 0, 'C', '0', '0', 'mall:order:ship', 'edit', 1, 1, NOW(), NULL, NULL, '订单发货'
FROM `sys_menu` m WHERE m.path='mall' AND m.menu_type='M' LIMIT 1;

-- 售后审批
INSERT INTO `sys_menu` (`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query_param`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_dept`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT '售后审批', m.menu_id, 4, 'mall/aftersale', 'mall/aftersale/index', '', 1, 0, 'C', '0', '0', 'mall:aftersale:list', 'form', 1, 1, NOW(), NULL, NULL, '售后审批'
FROM `sys_menu` m WHERE m.path='mall' AND m.menu_type='M' LIMIT 1;

-- ==========================================
-- 二、数据库结构调整（与代码一致）
-- ==========================================

-- 1) 用户画像字段
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'interests';
SET @sql = IF(@col_exists = 0, 
  'ALTER TABLE `im_user` ADD COLUMN `interests` VARCHAR(500) NULL COMMENT ''兴趣标签,逗号分隔'' AFTER `signature`',
  'SELECT ''Column interests already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'age';
SET @sql = IF(@col_exists = 0, 
  'ALTER TABLE `im_user` ADD COLUMN `age` INT(3) NULL COMMENT ''年龄'' AFTER `interests`',
  'SELECT ''Column age already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'city';
SET @sql = IF(@col_exists = 0, 
  'ALTER TABLE `im_user` ADD COLUMN `city` VARCHAR(100) NULL COMMENT ''所在城市'' AFTER `age`',
  'SELECT ''Column city already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'longitude';
SET @sql = IF(@col_exists = 0, 
  'ALTER TABLE `im_user` ADD COLUMN `longitude` DECIMAL(10, 6) NULL COMMENT ''经度'' AFTER `city`',
  'SELECT ''Column longitude already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'latitude';
SET @sql = IF(@col_exists = 0, 
  'ALTER TABLE `im_user` ADD COLUMN `latitude` DECIMAL(10, 6) NULL COMMENT ''纬度'' AFTER `longitude`',
  'SELECT ''Column latitude already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- 2) 商品分类表
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

-- 3) SKU表字段补充：sku_code + 唯一约束
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_sku' AND COLUMN_NAME = 'sku_code';
SET @sql = IF(@col_exists = 0, 
  'ALTER TABLE `im_mall_sku` ADD COLUMN `sku_code` VARCHAR(64) NOT NULL AFTER `product_id`',
  'SELECT ''Column sku_code already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_sku' AND INDEX_NAME = 'uk_product_sku_code';
SET @sql = IF(@idx_exists = 0, 
  'ALTER TABLE `im_mall_sku` ADD UNIQUE KEY `uk_product_sku_code` (`product_id`, `sku_code`)',
  'SELECT ''Index uk_product_sku_code already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- 4) 订单表扩展：SKU与发货信息
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'sku_id';
SET @sql = IF(@col_exists = 0, 
  'ALTER TABLE `im_mall_order` ADD COLUMN `sku_id` BIGINT NULL AFTER `product_id`',
  'SELECT ''Column sku_id already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'shipping_carrier';
SET @sql = IF(@col_exists = 0, 
  'ALTER TABLE `im_mall_order` ADD COLUMN `shipping_carrier` VARCHAR(64) NULL AFTER `status`',
  'SELECT ''Column shipping_carrier already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'shipping_no';
SET @sql = IF(@col_exists = 0, 
  'ALTER TABLE `im_mall_order` ADD COLUMN `shipping_no` VARCHAR(64) NULL AFTER `shipping_carrier`',
  'SELECT ''Column shipping_no already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'shipped_time';
SET @sql = IF(@col_exists = 0, 
  'ALTER TABLE `im_mall_order` ADD COLUMN `shipped_time` DATETIME NULL AFTER `shipping_no`',
  'SELECT ''Column shipped_time already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- 5) 售后申请表
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

-- ==========================================
-- 三、索引优化（与代码访问路径匹配）
-- ==========================================

-- 匹配记录与匹配表索引（提升候选、历史与互相喜欢查询性能）
SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user_match_record' AND INDEX_NAME = 'idx_user_action_time';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_user_match_record` ADD INDEX `idx_user_action_time` (`user_id`, `action_type`, `created_time`)', 'SELECT ''Index idx_user_action_time already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user_match_record' AND INDEX_NAME = 'idx_target_user';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_user_match_record` ADD INDEX `idx_target_user` (`target_user_id`, `created_time`)', 'SELECT ''Index idx_target_user already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user_match' AND INDEX_NAME = 'idx_user1_status';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_user_match` ADD INDEX `idx_user1_status` (`user1_id`, `status`)', 'SELECT ''Index idx_user1_status already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user_match' AND INDEX_NAME = 'idx_user2_status';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_user_match` ADD INDEX `idx_user2_status` (`user2_id`, `status`)', 'SELECT ''Index idx_user2_status already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- 分销索引（佣金列表与统计查询）
SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_commission' AND INDEX_NAME = 'idx_distributor_status_time';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_distribution_commission` ADD INDEX `idx_distributor_status_time` (`distributor_user_id`, `status`, `created_time`)', 'SELECT ''Index idx_distributor_status_time already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_commission' AND INDEX_NAME = 'idx_buyer_time';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_distribution_commission` ADD INDEX `idx_buyer_time` (`buyer_user_id`, `created_time`)', 'SELECT ''Index idx_buyer_time already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_commission' AND INDEX_NAME = 'idx_order_status';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_distribution_commission` ADD INDEX `idx_order_status` (`order_id`, `status`)', 'SELECT ''Index idx_order_status already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_user' AND INDEX_NAME = 'idx_parent_status';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_distribution_user` ADD INDEX `idx_parent_status` (`parent_user_id`, `status`)', 'SELECT ''Index idx_parent_status already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_user' AND INDEX_NAME = 'idx_grand_parent_status';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_distribution_user` ADD INDEX `idx_grand_parent_status` (`grand_parent_user_id`, `status`)', 'SELECT ''Index idx_grand_parent_status already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_user' AND INDEX_NAME = 'idx_status_activated';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_distribution_user` ADD INDEX `idx_status_activated` (`status`, `activated_time`)', 'SELECT ''Index idx_status_activated already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- 商品与订单索引（列表与统计）
SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_product' AND INDEX_NAME = 'idx_status_sort';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_mall_product` ADD INDEX `idx_status_sort` (`status`, `sort_order`)', 'SELECT ''Index idx_status_sort already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_product' AND INDEX_NAME = 'idx_distribution';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_mall_product` ADD INDEX `idx_distribution` (`enable_distribution`, `status`)', 'SELECT ''Index idx_distribution already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND INDEX_NAME = 'idx_user_status_time';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_mall_order` ADD INDEX `idx_user_status_time` (`user_id`, `status`, `created_time`)', 'SELECT ''Index idx_user_status_time already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND INDEX_NAME = 'idx_product_status';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_mall_order` ADD INDEX `idx_product_status` (`product_id`, `status`)', 'SELECT ''Index idx_product_status already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND INDEX_NAME = 'idx_referrer';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_mall_order` ADD INDEX `idx_referrer` (`referrer_user_id`, `status`)', 'SELECT ''Index idx_referrer already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @idx_exists = 0;
SELECT COUNT(*) INTO @idx_exists FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND INDEX_NAME = 'idx_status_paid';
SET @sql = IF(@idx_exists = 0, 'ALTER TABLE `im_mall_order` ADD INDEX `idx_status_paid` (`status`, `paid_time`)', 'SELECT ''Index idx_status_paid already exists'' AS Info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- 结束