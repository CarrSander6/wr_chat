CREATE TABLE IF NOT EXISTS `im_distribution_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `referral_code` varchar(32) NOT NULL,
  `parent_user_id` bigint NULL,
  `grand_parent_user_id` bigint NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `total_commission` decimal(19,2) NOT NULL DEFAULT 0,
  `available_commission` decimal(19,2) NOT NULL DEFAULT 0,
  `withdrawn_commission` decimal(19,2) NOT NULL DEFAULT 0,
  `activated_time` datetime NULL,
  `created_time` datetime NULL,
  `updated_time` datetime NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`),
  UNIQUE KEY `uk_referral_code` (`referral_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `im_distribution_commission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `distributor_user_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `buyer_user_id` bigint NOT NULL,
  `commission_type` tinyint NOT NULL,
  `order_amount` decimal(19,2) NOT NULL,
  `commission_amount` decimal(19,2) NOT NULL,
  `commission_rate` decimal(10,4) NOT NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `created_time` datetime NULL,
  `settled_time` datetime NULL,
  PRIMARY KEY (`id`),
  KEY `idx_distributor` (`distributor_user_id`),
  KEY `idx_order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `im_mall_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_name` varchar(200) NOT NULL,
  `description` text,
  `image_url` varchar(500),
  `price` decimal(19,2) NOT NULL,
  `original_price` decimal(19,2),
  `stock` int NOT NULL DEFAULT 0,
  `sales_count` int NOT NULL DEFAULT 0,
  `product_type` tinyint NOT NULL DEFAULT 1,
  `status` tinyint NOT NULL DEFAULT 1,
  `enable_distribution` tinyint NOT NULL DEFAULT 0,
  `level1_commission_rate` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `level2_commission_rate` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `sort_order` int NOT NULL DEFAULT 0,
  `created_time` datetime NULL,
  `updated_time` datetime NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `im_mall_sku` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `attributes` varchar(255),
  `price` decimal(19,2) NOT NULL,
  `stock` int NOT NULL DEFAULT 0,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_time` datetime NULL,
  `updated_time` datetime NULL,
  PRIMARY KEY (`id`),
  KEY `idx_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `im_mall_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_no` varchar(64) NOT NULL,
  `user_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `sku_id` bigint NULL,
  `product_name` varchar(200) NOT NULL,
  `quantity` int NOT NULL DEFAULT 1,
  `unit_price` decimal(19,2) NOT NULL,
  `total_amount` decimal(19,2) NOT NULL,
  `payment_method` tinyint NOT NULL,
  `ios_receipt` text,
  `status` tinyint NOT NULL DEFAULT 0,
  `referrer_user_id` bigint NULL,
  `paid_time` datetime NULL,
  `completed_time` datetime NULL,
  `created_time` datetime NULL,
  `updated_time` datetime NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `im_user_match_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `target_user_id` bigint NOT NULL,
  `action_type` tinyint NOT NULL DEFAULT 0,
  `created_time` datetime NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_target` (`user_id`, `target_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `im_user_match` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user1_id` bigint NOT NULL,
  `user2_id` bigint NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `match_time` datetime NULL,
  `created_time` datetime NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_pair` (`user1_id`, `user2_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `im_user_blacklist` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint NOT NULL,
  `to_user_id` bigint NOT NULL,
  `created_time` datetime NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_black_pair` (`from_user_id`, `to_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_user' AND COLUMN_NAME = 'activated_time');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_distribution_user` ADD COLUMN `activated_time` datetime NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_user' AND COLUMN_NAME = 'created_time');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_distribution_user` ADD COLUMN `created_time` datetime NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_user' AND COLUMN_NAME = 'updated_time');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_distribution_user` ADD COLUMN `updated_time` datetime NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_user' AND COLUMN_NAME = 'total_commission');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_distribution_user` ADD COLUMN `total_commission` decimal(19,2) NOT NULL DEFAULT 0', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_user' AND COLUMN_NAME = 'available_commission');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_distribution_user` ADD COLUMN `available_commission` decimal(19,2) NOT NULL DEFAULT 0', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_user' AND COLUMN_NAME = 'withdrawn_commission');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_distribution_user` ADD COLUMN `withdrawn_commission` decimal(19,2) NOT NULL DEFAULT 0', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_commission' AND COLUMN_NAME = 'status');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_distribution_commission` ADD COLUMN `status` tinyint NOT NULL DEFAULT 0', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_commission' AND COLUMN_NAME = 'created_time');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_distribution_commission` ADD COLUMN `created_time` datetime NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_commission' AND COLUMN_NAME = 'settled_time');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_distribution_commission` ADD COLUMN `settled_time` datetime NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_commission' AND COLUMN_NAME = 'order_amount');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_distribution_commission` ADD COLUMN `order_amount` decimal(19,2) NOT NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_distribution_commission' AND COLUMN_NAME = 'commission_rate');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_distribution_commission` ADD COLUMN `commission_rate` decimal(10,4) NOT NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_product' AND COLUMN_NAME = 'enable_distribution');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_product` ADD COLUMN `enable_distribution` tinyint NOT NULL DEFAULT 0', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_product' AND COLUMN_NAME = 'level1_commission_rate');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_product` ADD COLUMN `level1_commission_rate` decimal(10,4) NOT NULL DEFAULT 0.0000', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_product' AND COLUMN_NAME = 'level2_commission_rate');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_product` ADD COLUMN `level2_commission_rate` decimal(10,4) NOT NULL DEFAULT 0.0000', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_product' AND COLUMN_NAME = 'sales_count');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_product` ADD COLUMN `sales_count` int NOT NULL DEFAULT 0', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_product' AND COLUMN_NAME = 'sort_order');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_product` ADD COLUMN `sort_order` int NOT NULL DEFAULT 0', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_product' AND COLUMN_NAME = 'created_time');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_product` ADD COLUMN `created_time` datetime NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_product' AND COLUMN_NAME = 'updated_time');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_product` ADD COLUMN `updated_time` datetime NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_sku' AND COLUMN_NAME = 'updated_time');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_sku` ADD COLUMN `updated_time` datetime NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'sku_id');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_order` ADD COLUMN `sku_id` bigint NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'ios_receipt');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_order` ADD COLUMN `ios_receipt` text', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'referrer_user_id');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_order` ADD COLUMN `referrer_user_id` bigint NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'paid_time');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_order` ADD COLUMN `paid_time` datetime NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'completed_time');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_order` ADD COLUMN `completed_time` datetime NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'created_time');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_order` ADD COLUMN `created_time` datetime NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_mall_order' AND COLUMN_NAME = 'updated_time');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_mall_order` ADD COLUMN `updated_time` datetime NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'age');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_user` ADD COLUMN `age` int NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'city');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_user` ADD COLUMN `city` varchar(255) NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'longitude');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_user` ADD COLUMN `longitude` decimal(10,6) NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'im_user' AND COLUMN_NAME = 'latitude');
SET @sql := IF(@exists = 0, 'ALTER TABLE `im_user` ADD COLUMN `latitude` decimal(10,6) NULL', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
