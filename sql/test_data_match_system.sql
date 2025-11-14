-- ========================================
-- 缘分匹配系统测试数据
-- Test Data for Match/Fate System
-- ========================================
-- 此脚本包含：
-- 1. 30个测试用户（不同年龄、性别、兴趣、地理位置）
-- 2. 匹配操作记录（喜欢/不喜欢）
-- 3. 成功匹配的用户对
-- ========================================

-- 清理现有测试数据（可选，根据需要取消注释）
-- DELETE FROM im_user_match_record WHERE user_id >= 100;
-- DELETE FROM im_user_match WHERE user1_id >= 100 OR user2_id >= 100;
-- DELETE FROM im_user WHERE id >= 100;

-- ========================================
-- 1. 插入30个测试用户
-- ========================================
-- 注意：密码统一为 "123456" 的BCrypt加密: $2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty
-- 交易密码统一为 "888888" 的BCrypt加密: $2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O

-- 女性用户 (15位)
INSERT INTO `im_user` (`id`, `user_name`, `nick_name`, `head_image`, `head_image_thumb`, `wallet_address`, `password`, `trade_password`, `balance`, `sex`, `phone`, `email`, `is_banned`, `reason`, `type`, `signature`, `interests`, `is_manual_approve`, `cid`, `status`, `last_login_time`, `created_time`, `age`, `city`, `longitude`, `latitude`) VALUES
(100, 'test_user_100', '小雨', 'https://picsum.photos/200?random=100', 'https://picsum.photos/100?random=100', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 100.0000, 1, '13800000100', 'test100@example.com', 0, '', 1, '喜欢音乐和旅行，寻找志同道合的朋友', '音乐,旅行,摄影', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 24) HOUR, NOW() - INTERVAL 30 DAY, 24, '北京', 116.407526, 39.904030),
(101, 'test_user_101', '晓晓', 'https://picsum.photos/200?random=101', 'https://picsum.photos/100?random=101', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 150.0000, 1, '13800000101', 'test101@example.com', 0, '', 1, '热爱生活，享受每一天', '美食,健身,阅读', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 12) HOUR, NOW() - INTERVAL 25 DAY, 26, '上海', 121.473701, 31.230416),
(102, 'test_user_102', '梦琪', 'https://picsum.photos/200?random=102', 'https://picsum.photos/100?random=102', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 200.0000, 1, '13800000102', 'test102@example.com', 0, '', 1, '爱笑的女孩运气不会太差', '电影,音乐,购物', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 6) HOUR, NOW() - INTERVAL 20 DAY, 23, '广州', 113.264434, 23.129162),
(103, 'test_user_103', '雅静', 'https://picsum.photos/200?random=103', 'https://picsum.photos/100?random=103', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 180.0000, 1, '13800000103', 'test103@example.com', 0, '', 1, '简单生活，快乐工作', '瑜伽,绘画,咖啡', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 48) HOUR, NOW() - INTERVAL 15 DAY, 28, '深圳', 114.057868, 22.543099),
(104, 'test_user_104', '欣欣', 'https://picsum.photos/200?random=104', 'https://picsum.photos/100?random=104', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 120.0000, 1, '13800000104', 'test104@example.com', 0, '', 1, '喜欢宠物，养了两只猫', '宠物,烘焙,舞蹈', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 3) HOUR, NOW() - INTERVAL 10 DAY, 25, '杭州', 120.153576, 30.287459),
(105, 'test_user_105', '倩倩', 'https://picsum.photos/200?random=105', 'https://picsum.photos/100?random=105', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 250.0000, 1, '13800000105', 'test105@example.com', 0, '', 1, '旅行达人，去过30个城市', '旅行,摄影,美食', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 2) HOUR, NOW() - INTERVAL 5 DAY, 27, '成都', 104.065735, 30.659462),
(106, 'test_user_106', '婷婷', 'https://picsum.photos/200?random=106', 'https://picsum.photos/100?random=106', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 130.0000, 1, '13800000106', 'test106@example.com', 0, '', 1, '热爱运动的活力女孩', '健身,跑步,游泳', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 36) HOUR, NOW() - INTERVAL 8 DAY, 24, '武汉', 114.305393, 30.593099),
(107, 'test_user_107', '诗琪', 'https://picsum.photos/200?random=107', 'https://picsum.photos/100?random=107', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 190.0000, 1, '13800000107', 'test107@example.com', 0, '', 1, '文艺青年，热爱文学', '阅读,写作,电影', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 1) HOUR, NOW() - INTERVAL 3 DAY, 26, '南京', 118.796877, 32.060255),
(108, 'test_user_108', '佳佳', 'https://picsum.photos/200?random=108', 'https://picsum.photos/100?random=108', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 160.0000, 1, '13800000108', 'test108@example.com', 0, '', 1, '喜欢探索新鲜事物', '美食,探店,音乐', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 8) HOUR, NOW() - INTERVAL 12 DAY, 25, '西安', 108.948024, 34.263161),
(109, 'test_user_109', '嘉嘉', 'https://picsum.photos/200?random=109', 'https://picsum.photos/100?random=109', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 170.0000, 1, '13800000109', 'test109@example.com', 0, '', 1, '爱好广泛，喜欢交朋友', '瑜伽,旅行,摄影', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 5) HOUR, NOW() - INTERVAL 7 DAY, 29, '重庆', 106.504962, 29.533155),
(110, 'test_user_110', '琳琳', 'https://picsum.photos/200?random=110', 'https://picsum.photos/100?random=110', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 140.0000, 1, '13800000110', 'test110@example.com', 0, '', 1, '摄影爱好者，记录美好瞬间', '摄影,旅行,咖啡', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 16) HOUR, NOW() - INTERVAL 6 DAY, 27, '天津', 117.190182, 39.125596),
(111, 'test_user_111', '思思', 'https://picsum.photos/200?random=111', 'https://picsum.photos/100?random=111', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 210.0000, 1, '13800000111', 'test111@example.com', 0, '', 1, '热爱音乐，会弹钢琴', '音乐,钢琴,电影', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 4) HOUR, NOW() - INTERVAL 4 DAY, 24, '苏州', 120.619585, 31.299379),
(112, 'test_user_112', '雪儿', 'https://picsum.photos/200?random=112', 'https://picsum.photos/100?random=112', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 180.0000, 1, '13800000112', 'test112@example.com', 0, '', 1, '甜点爱好者，会做蛋糕', '烘焙,美食,购物', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 10) HOUR, NOW() - INTERVAL 9 DAY, 26, '青岛', 120.382639, 36.067082),
(113, 'test_user_113', '妮妮', 'https://picsum.photos/200?random=113', 'https://picsum.photos/100?random=113', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 220.0000, 1, '13800000113', 'test113@example.com', 0, '', 1, '喜欢安静，享受独处时光', '阅读,茶道,绘画', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 20) HOUR, NOW() - INTERVAL 11 DAY, 28, '大连', 121.618622, 38.914590),
(114, 'test_user_114', '珊珊', 'https://picsum.photos/200?random=114', 'https://picsum.photos/100?random=114', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 195.0000, 1, '13800000114', 'test114@example.com', 0, '', 1, '热爱自然，喜欢户外活动', '徒步,露营,旅行', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 7) HOUR, NOW() - INTERVAL 13 DAY, 25, '厦门', 118.089425, 24.479834);

-- 男性用户 (15位)
INSERT INTO `im_user` (`id`, `user_name`, `nick_name`, `head_image`, `head_image_thumb`, `wallet_address`, `password`, `trade_password`, `balance`, `sex`, `phone`, `email`, `is_banned`, `reason`, `type`, `signature`, `interests`, `is_manual_approve`, `cid`, `status`, `last_login_time`, `created_time`, `age`, `city`, `longitude`, `latitude`) VALUES
(115, 'test_user_115', '阿伟', 'https://picsum.photos/200?random=115', 'https://picsum.photos/100?random=115', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 100.0000, 0, '13900000115', 'test115@example.com', 0, '', 1, '程序员一枚，热爱编程', '编程,游戏,电影', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 12) HOUR, NOW() - INTERVAL 28 DAY, 26, '北京', 116.407526, 39.904030),
(116, 'test_user_116', '小明', 'https://picsum.photos/200?random=116', 'https://picsum.photos/100?random=116', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 150.0000, 0, '13900000116', 'test116@example.com', 0, '', 1, '热爱运动，篮球足球都喜欢', '篮球,足球,健身', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 4) HOUR, NOW() - INTERVAL 22 DAY, 25, '上海', 121.473701, 31.230416),
(117, 'test_user_117', '浩然', 'https://picsum.photos/200?random=117', 'https://picsum.photos/100?random=117', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 200.0000, 0, '13900000117', 'test117@example.com', 0, '', 1, '喜欢旅行和摄影', '旅行,摄影,咖啡', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 2) HOUR, NOW() - INTERVAL 18 DAY, 28, '广州', 113.264434, 23.129162),
(118, 'test_user_118', '子轩', 'https://picsum.photos/200?random=118', 'https://picsum.photos/100?random=118', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 180.0000, 0, '13900000118', 'test118@example.com', 0, '', 1, '音乐发烧友，会弹吉他', '音乐,吉他,摇滚', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 8) HOUR, NOW() - INTERVAL 14 DAY, 27, '深圳', 114.057868, 22.543099),
(119, 'test_user_119', '俊杰', 'https://picsum.photos/200?random=119', 'https://picsum.photos/100?random=119', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 120.0000, 0, '13900000119', 'test119@example.com', 0, '', 1, '爱好美食，喜欢探店', '美食,探店,旅行', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 1) HOUR, NOW() - INTERVAL 9 DAY, 24, '杭州', 120.153576, 30.287459),
(120, 'test_user_120', '志强', 'https://picsum.photos/200?random=120', 'https://picsum.photos/100?random=120', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 250.0000, 0, '13900000120', 'test120@example.com', 0, '', 1, '健身达人，坚持锻炼3年', '健身,跑步,营养', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 15) HOUR, NOW() - INTERVAL 5 DAY, 29, '成都', 104.065735, 30.659462),
(121, 'test_user_121', '文博', 'https://picsum.photos/200?random=121', 'https://picsum.photos/100?random=121', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 130.0000, 0, '13900000121', 'test121@example.com', 0, '', 1, '读书爱好者，每月看10本书', '阅读,写作,历史', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 6) HOUR, NOW() - INTERVAL 7 DAY, 26, '武汉', 114.305393, 30.593099),
(122, 'test_user_122', '天宇', 'https://picsum.photos/200?random=122', 'https://picsum.photos/100?random=122', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 190.0000, 0, '13900000122', 'test122@example.com', 0, '', 1, '电影爱好者，每周必看一部', '电影,摄影,音乐', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 3) HOUR, NOW() - INTERVAL 3 DAY, 25, '南京', 118.796877, 32.060255),
(123, 'test_user_123', '瑞阳', 'https://picsum.photos/200?random=123', 'https://picsum.photos/100?random=123', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 160.0000, 0, '13900000123', 'test123@example.com', 0, '', 1, '热爱电竞，王者荣耀钻石段位', '游戏,电竞,动漫', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 18) HOUR, NOW() - INTERVAL 10 DAY, 23, '西安', 108.948024, 34.263161),
(124, 'test_user_124', '建国', 'https://picsum.photos/200?random=124', 'https://picsum.photos/100?random=124', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 170.0000, 0, '13900000124', 'test124@example.com', 0, '', 1, '摄影师，记录美好生活', '摄影,旅行,美食', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 9) HOUR, NOW() - INTERVAL 6 DAY, 30, '重庆', 106.504962, 29.533155),
(125, 'test_user_125', '鹏飞', 'https://picsum.photos/200?random=125', 'https://picsum.photos/100?random=125', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 140.0000, 0, '13900000125', 'test125@example.com', 0, '', 1, '咖啡爱好者，精品咖啡品鉴师', '咖啡,烘焙,音乐', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 5) HOUR, NOW() - INTERVAL 5 DAY, 27, '天津', 117.190182, 39.125596),
(126, 'test_user_126', '宇航', 'https://picsum.photos/200?random=126', 'https://picsum.photos/100?random=126', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 210.0000, 0, '13900000126', 'test126@example.com', 0, '', 1, '户外运动爱好者，喜欢登山', '登山,徒步,露营', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 11) HOUR, NOW() - INTERVAL 4 DAY, 28, '苏州', 120.619585, 31.299379),
(127, 'test_user_127', '凯文', 'https://picsum.photos/200?random=127', 'https://picsum.photos/100?random=127', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 180.0000, 0, '13900000127', 'test127@example.com', 0, '', 1, '设计师，热爱艺术', '设计,绘画,摄影', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 14) HOUR, NOW() - INTERVAL 8 DAY, 26, '青岛', 120.382639, 36.067082),
(128, 'test_user_128', '嘉华', 'https://picsum.photos/200?random=128', 'https://picsum.photos/100?random=128', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 220.0000, 0, '13900000128', 'test128@example.com', 0, '', 1, '科技迷，关注最新科技动态', '科技,数码,编程', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 7) HOUR, NOW() - INTERVAL 11 DAY, 25, '大连', 121.618622, 38.914590),
(129, 'test_user_129', '俊豪', 'https://picsum.photos/200?random=129', 'https://picsum.photos/100?random=129', NULL, '$2a$10$N.zmdr9k7uOCQb97.AnUu.wU8NUU8YcJNZ5gTb7iLw1q4sS8w0Nty', '$2a$10$H5V9zGu/kGwZK.TQm2h5N.GBgKvxO6y7rnCQhC9nZs5TGkj8BvJ6O', 195.0000, 0, '13900000129', 'test129@example.com', 0, '', 1, '喜欢旅行，走遍大江南北', '旅行,摄影,历史', 0, '', 0, NOW() - INTERVAL FLOOR(RAND() * 13) HOUR, NOW() - INTERVAL 12 DAY, 29, '厦门', 118.089425, 24.479834);

-- ========================================
-- 2. 插入匹配记录（用户操作历史）
-- ========================================
-- 记录类型: 1-喜欢 2-不喜欢

-- 用户100（小雨）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(100, 115, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢阿伟
(100, 116, 1, NOW() - INTERVAL 2 DAY),  -- 喜欢小明
(100, 117, 2, NOW() - INTERVAL 3 DAY),  -- 不喜欢浩然
(100, 118, 1, NOW() - INTERVAL 4 DAY),  -- 喜欢子轩
(100, 119, 2, NOW() - INTERVAL 5 DAY);  -- 不喜欢俊杰

-- 用户101（晓晓）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(101, 115, 2, NOW() - INTERVAL 1 DAY),
(101, 116, 1, NOW() - INTERVAL 2 DAY),  -- 喜欢小明
(101, 120, 1, NOW() - INTERVAL 3 DAY),  -- 喜欢志强
(101, 121, 2, NOW() - INTERVAL 4 DAY);

-- 用户102（梦琪）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(102, 117, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢浩然
(102, 118, 2, NOW() - INTERVAL 2 DAY),
(102, 122, 1, NOW() - INTERVAL 3 DAY),  -- 喜欢天宇
(102, 123, 1, NOW() - INTERVAL 4 DAY);  -- 喜欢瑞阳

-- 用户103（雅静）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(103, 119, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢俊杰
(103, 124, 1, NOW() - INTERVAL 2 DAY),  -- 喜欢建国
(103, 125, 2, NOW() - INTERVAL 3 DAY);

-- 用户104（欣欣）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(104, 120, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢志强
(104, 126, 1, NOW() - INTERVAL 2 DAY),  -- 喜欢宇航
(104, 127, 2, NOW() - INTERVAL 3 DAY);

-- 男性用户的操作记录
-- 用户115（阿伟）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(115, 100, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢小雨（互相喜欢）
(115, 101, 1, NOW() - INTERVAL 2 DAY),
(115, 102, 2, NOW() - INTERVAL 3 DAY),
(115, 103, 1, NOW() - INTERVAL 4 DAY);

-- 用户116（小明）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(116, 100, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢小雨（互相喜欢）
(116, 101, 1, NOW() - INTERVAL 2 DAY),  -- 喜欢晓晓（互相喜欢）
(116, 104, 1, NOW() - INTERVAL 3 DAY),
(116, 105, 2, NOW() - INTERVAL 4 DAY);

-- 用户117（浩然）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(117, 102, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢梦琪（互相喜欢）
(117, 106, 1, NOW() - INTERVAL 2 DAY),
(117, 107, 2, NOW() - INTERVAL 3 DAY);

-- 用户118（子轩）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(118, 100, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢小雨（互相喜欢）
(118, 108, 1, NOW() - INTERVAL 2 DAY),
(118, 109, 1, NOW() - INTERVAL 3 DAY);

-- 用户119（俊杰）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(119, 103, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢雅静（互相喜欢）
(119, 110, 1, NOW() - INTERVAL 2 DAY),
(119, 111, 2, NOW() - INTERVAL 3 DAY);

-- 用户120（志强）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(120, 101, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢晓晓（互相喜欢）
(120, 104, 1, NOW() - INTERVAL 2 DAY),  -- 喜欢欣欣（互相喜欢）
(120, 112, 1, NOW() - INTERVAL 3 DAY);

-- 用户122（天宇）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(122, 102, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢梦琪（互相喜欢）
(122, 113, 1, NOW() - INTERVAL 2 DAY),
(122, 114, 2, NOW() - INTERVAL 3 DAY);

-- 用户124（建国）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(124, 103, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢雅静（互相喜欢）
(124, 105, 1, NOW() - INTERVAL 2 DAY),
(124, 106, 2, NOW() - INTERVAL 3 DAY);

-- 用户126（宇航）的操作记录
INSERT INTO `im_user_match_record` (`user_id`, `target_user_id`, `action_type`, `created_time`) VALUES
(126, 104, 1, NOW() - INTERVAL 1 DAY),  -- 喜欢欣欣（互相喜欢）
(126, 107, 1, NOW() - INTERVAL 2 DAY),
(126, 108, 2, NOW() - INTERVAL 3 DAY);

-- ========================================
-- 3. 插入成功匹配记录
-- ========================================
-- 双方互相喜欢的记录

INSERT INTO `im_user_match` (`user1_id`, `user2_id`, `status`, `match_time`, `created_time`) VALUES
(100, 115, 1, NOW() - INTERVAL 1 DAY, NOW() - INTERVAL 1 DAY),   -- 小雨 & 阿伟
(100, 116, 1, NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 2 DAY),   -- 小雨 & 小明
(100, 118, 1, NOW() - INTERVAL 1 DAY, NOW() - INTERVAL 1 DAY),   -- 小雨 & 子轩
(101, 116, 1, NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 2 DAY),   -- 晓晓 & 小明
(101, 120, 1, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 3 DAY),   -- 晓晓 & 志强
(102, 117, 1, NOW() - INTERVAL 1 DAY, NOW() - INTERVAL 1 DAY),   -- 梦琪 & 浩然
(102, 122, 1, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 3 DAY),   -- 梦琪 & 天宇
(103, 119, 1, NOW() - INTERVAL 1 DAY, NOW() - INTERVAL 1 DAY),   -- 雅静 & 俊杰
(103, 124, 1, NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 2 DAY),   -- 雅静 & 建国
(104, 120, 1, NOW() - INTERVAL 1 DAY, NOW() - INTERVAL 1 DAY),   -- 欣欣 & 志强
(104, 126, 1, NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 2 DAY);   -- 欣欣 & 宇航

-- ========================================
-- 4. 数据验证查询
-- ========================================
-- 执行完插入后，可以运行以下查询验证数据

-- 查询测试用户数量
-- SELECT COUNT(*) AS test_user_count FROM im_user WHERE id >= 100;

-- 查询匹配记录数量
-- SELECT COUNT(*) AS match_record_count FROM im_user_match_record WHERE user_id >= 100;

-- 查询成功匹配数量
-- SELECT COUNT(*) AS match_count FROM im_user_match WHERE user1_id >= 100 OR user2_id >= 100;

-- 查询某个用户的推荐列表（以用户7为例）
-- SELECT u.* FROM im_user u 
-- WHERE u.id NOT IN (
--     SELECT target_user_id FROM im_user_match_record WHERE user_id = 7
-- ) 
-- AND u.id != 7 
-- AND u.status = 0 
-- AND u.is_banned = 0
-- LIMIT 10;

-- 查询用户的匹配历史
-- SELECT umr.*, u.nick_name, u.head_image_thumb 
-- FROM im_user_match_record umr
-- LEFT JOIN im_user u ON umr.target_user_id = u.id
-- WHERE umr.user_id = 100
-- ORDER BY umr.created_time DESC;

-- 查询用户的已匹配列表
-- SELECT um.*, 
--        u1.nick_name AS user1_name, 
--        u2.nick_name AS user2_name
-- FROM im_user_match um
-- LEFT JOIN im_user u1 ON um.user1_id = u1.id
-- LEFT JOIN im_user u2 ON um.user2_id = u2.id
-- WHERE (um.user1_id = 100 OR um.user2_id = 100) AND um.status = 1
-- ORDER BY um.match_time DESC;

-- ========================================
-- 说明
-- ========================================
-- 1. 所有测试用户的密码都是: 123456
-- 2. 所有测试用户的交易密码都是: 888888
-- 3. 用户ID从100开始，避免与现有用户冲突
-- 4. 包含15个女性用户（100-114）和15个男性用户（115-129）
-- 5. 每个用户都有完整的资料：昵称、签名、兴趣、年龄、城市、地理位置
-- 6. 模拟了真实的匹配场景：互相喜欢、单向喜欢、不喜欢等
-- 7. 创建了11对成功匹配的用户
-- 8. 地理位置覆盖了北京、上海、广州、深圳等主要城市
-- ========================================
