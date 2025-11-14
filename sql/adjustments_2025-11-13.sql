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

ALTER TABLE `im_distribution_user` 
  ADD COLUMN IF NOT EXISTS `activated_time` datetime NULL,
  ADD COLUMN IF NOT EXISTS `created_time` datetime NULL,
  ADD COLUMN IF NOT EXISTS `updated_time` datetime NULL,
  ADD COLUMN IF NOT EXISTS `total_commission` decimal(19,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `available_commission` decimal(19,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `withdrawn_commission` decimal(19,2) NOT NULL DEFAULT 0;

ALTER TABLE `im_distribution_commission`
  ADD COLUMN IF NOT EXISTS `status` tinyint NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `created_time` datetime NULL,
  ADD COLUMN IF NOT EXISTS `settled_time` datetime NULL,
  ADD COLUMN IF NOT EXISTS `order_amount` decimal(19,2) NOT NULL,
  ADD COLUMN IF NOT EXISTS `commission_rate` decimal(10,4) NOT NULL;

ALTER TABLE `im_mall_product`
  ADD COLUMN IF NOT EXISTS `enable_distribution` tinyint NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `level1_commission_rate` decimal(10,4) NOT NULL DEFAULT 0.0000,
  ADD COLUMN IF NOT EXISTS `level2_commission_rate` decimal(10,4) NOT NULL DEFAULT 0.0000,
  ADD COLUMN IF NOT EXISTS `sales_count` int NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `sort_order` int NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `created_time` datetime NULL,
  ADD COLUMN IF NOT EXISTS `updated_time` datetime NULL;

ALTER TABLE `im_mall_sku`
  ADD COLUMN IF NOT EXISTS `updated_time` datetime NULL;

ALTER TABLE `im_mall_order`
  ADD COLUMN IF NOT EXISTS `sku_id` bigint NULL,
  ADD COLUMN IF NOT EXISTS `ios_receipt` text,
  ADD COLUMN IF NOT EXISTS `referrer_user_id` bigint NULL,
  ADD COLUMN IF NOT EXISTS `paid_time` datetime NULL,
  ADD COLUMN IF NOT EXISTS `completed_time` datetime NULL,
  ADD COLUMN IF NOT EXISTS `created_time` datetime NULL,
  ADD COLUMN IF NOT EXISTS `updated_time` datetime NULL;

-- 用户表字段补齐，确保与实体映射一致
ALTER TABLE `im_user`
  ADD COLUMN IF NOT EXISTS `age` int NULL,
  ADD COLUMN IF NOT EXISTS `city` varchar(255) NULL,
  ADD COLUMN IF NOT EXISTS `longitude` decimal(10,6) NULL,
  ADD COLUMN IF NOT EXISTS `latitude` decimal(10,6) NULL;
