-- 社交匹配和分销商城功能数据库脚本

-- 用户匹配记录表
CREATE TABLE IF NOT EXISTS `im_user_match_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) NOT NULL COMMENT '操作用户ID',
  `target_user_id` bigint(20) NOT NULL COMMENT '被浏览用户ID',
  `action_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '操作类型: 0-仅浏览 1-喜欢 2-不喜欢',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_target_user_id` (`target_user_id`),
  KEY `idx_created_time` (`created_time`),
  UNIQUE KEY `uk_user_target` (`user_id`, `target_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户匹配记录表';

-- 用户匹配表
CREATE TABLE IF NOT EXISTS `im_user_match` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user1_id` bigint(20) NOT NULL COMMENT '用户1的ID',
  `user2_id` bigint(20) NOT NULL COMMENT '用户2的ID',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '匹配状态: 1-已匹配 2-已取消',
  `match_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '匹配时间',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user1_id` (`user1_id`),
  KEY `idx_user2_id` (`user2_id`),
  KEY `idx_match_time` (`match_time`),
  UNIQUE KEY `uk_user_pair` (`user1_id`, `user2_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户匹配表';

-- 分销用户表
CREATE TABLE IF NOT EXISTS `im_distribution_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `referral_code` varchar(32) NOT NULL COMMENT '推广码',
  `parent_user_id` bigint(20) DEFAULT NULL COMMENT '上级分销商用户ID（一级）',
  `grand_parent_user_id` bigint(20) DEFAULT NULL COMMENT '二级上级分销商用户ID',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '分销商状态: 0-未激活 1-已激活 2-已禁用',
  `total_commission` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '累计佣金',
  `available_commission` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '可提现佣金',
  `withdrawn_commission` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '已提现佣金',
  `activation_amount` decimal(10,2) DEFAULT NULL COMMENT '激活条件: 消费金额',
  `activated_time` datetime DEFAULT NULL COMMENT '激活时间',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`),
  UNIQUE KEY `uk_referral_code` (`referral_code`),
  KEY `idx_parent_user_id` (`parent_user_id`),
  KEY `idx_grand_parent_user_id` (`grand_parent_user_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分销用户表';

-- 分销佣金记录表
CREATE TABLE IF NOT EXISTS `im_distribution_commission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `distributor_user_id` bigint(20) NOT NULL COMMENT '分销商用户ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `buyer_user_id` bigint(20) NOT NULL COMMENT '购买用户ID',
  `commission_type` tinyint(4) NOT NULL COMMENT '佣金类型: 1-直推佣金 2-间推佣金',
  `order_amount` decimal(10,2) NOT NULL COMMENT '订单金额',
  `commission_amount` decimal(10,2) NOT NULL COMMENT '佣金金额',
  `commission_rate` decimal(5,4) NOT NULL COMMENT '佣金比例',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态: 0-待结算 1-已结算 2-已取消',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `settled_time` datetime DEFAULT NULL COMMENT '结算时间',
  PRIMARY KEY (`id`),
  KEY `idx_distributor_user_id` (`distributor_user_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_buyer_user_id` (`buyer_user_id`),
  KEY `idx_created_time` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分销佣金记录表';

-- 商城商品表
CREATE TABLE IF NOT EXISTS `im_mall_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_name` varchar(200) NOT NULL COMMENT '商品名称',
  `description` text COMMENT '商品描述',
  `image_url` varchar(500) DEFAULT NULL COMMENT '商品图片',
  `price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '原价',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `sales_count` int(11) NOT NULL DEFAULT '0' COMMENT '销量',
  `product_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '商品类型: 1-虚拟商品 2-实物商品',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '商品状态: 0-下架 1-上架',
  `sort_order` int(11) DEFAULT '0' COMMENT '排序',
  `enable_distribution` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否支持分销: 0-否 1-是',
  `level1_commission_rate` decimal(5,4) DEFAULT '0.0000' COMMENT '一级佣金比例',
  `level2_commission_rate` decimal(5,4) DEFAULT '0.0000' COMMENT '二级佣金比例',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort_order` (`sort_order`),
  KEY `idx_created_time` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商城商品表';

-- 商城订单表
CREATE TABLE IF NOT EXISTS `im_mall_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_no` varchar(64) NOT NULL COMMENT '订单号',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `product_id` bigint(20) NOT NULL COMMENT '商品ID',
  `product_name` varchar(200) NOT NULL COMMENT '商品名称',
  `quantity` int(11) NOT NULL DEFAULT '1' COMMENT '商品数量',
  `unit_price` decimal(10,2) NOT NULL COMMENT '单价',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `payment_method` tinyint(4) NOT NULL COMMENT '支付方式: 1-余额支付 2-iOS内购',
  `ios_receipt` text COMMENT 'iOS交易凭证',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单状态: 0-待支付 1-已支付 2-已取消 3-已完成',
  `referrer_user_id` bigint(20) DEFAULT NULL COMMENT '推荐人用户ID',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `paid_time` datetime DEFAULT NULL COMMENT '支付时间',
  `completed_time` datetime DEFAULT NULL COMMENT '完成时间',
  `updated_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_status` (`status`),
  KEY `idx_created_time` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商城订单表';

-- 插入示例商品数据
INSERT INTO `im_mall_product` (`product_name`, `description`, `price`, `original_price`, `stock`, `product_type`, `status`, `sort_order`, `enable_distribution`, `level1_commission_rate`, `level2_commission_rate`) VALUES
('VIP会员月卡', '开通VIP会员，享受更多特权', 30.00, 50.00, 9999, 1, 1, 1, 1, 0.1000, 0.0500),
('VIP会员季卡', '开通VIP会员3个月，享受更多特权', 80.00, 120.00, 9999, 1, 1, 2, 1, 0.1500, 0.0800),
('VIP会员年卡', '开通VIP会员12个月，享受更多特权', 288.00, 480.00, 9999, 1, 1, 3, 1, 0.2000, 0.1000),
('钻石礼包', '包含1000钻石，可用于购买虚拟礼物', 98.00, 98.00, 9999, 1, 1, 4, 0, 0.0000, 0.0000);
