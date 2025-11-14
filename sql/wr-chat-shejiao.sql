/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.191.80
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : wr-chat-shejiao

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 14/11/2025 15:05:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `data_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '数据源名称',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'admin', 'im_user_fund_detail', '用户资产明细表', NULL, NULL, 'ImUserFundDetail', 'crud', 'org.dromara.im', 'im', 'userFundDetail', '用户资产明细', 'Blue', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":4}', NULL, 1, '2025-08-22 16:45:25', 1, '2025-08-26 19:13:27', NULL);
INSERT INTO `gen_table` VALUES (2, 'admin', 'red_detail', '红包明细金额', NULL, NULL, 'RedDetail', 'crud', 'org.dromara.im', 'im', 'detail', '红包明细金额', 'Blue', '0', '/', NULL, NULL, 1, '2025-08-22 17:20:04', NULL, '2025-08-22 17:20:04', NULL);
INSERT INTO `gen_table` VALUES (3, 'admin', 'red_record', '发红包记录', NULL, NULL, 'RedRecord', 'crud', 'org.dromara.im', 'im', 'record', '发红包记录', 'Blue', '0', '/', NULL, NULL, 1, '2025-08-22 17:20:05', NULL, '2025-08-22 17:20:05', NULL);
INSERT INTO `gen_table` VALUES (4, 'admin', 'red_rob_record', '抢红包记录', NULL, NULL, 'RedRobRecord', 'crud', 'org.dromara.im', 'im', 'robRecord', '抢红包记录', 'Blue', '0', '/', NULL, NULL, 1, '2025-08-22 17:20:05', NULL, '2025-08-22 17:20:05', NULL);
INSERT INTO `gen_table` VALUES (5, 'admin', 'im_user_recharge', '用户充值记录', NULL, NULL, 'ImUserRecharge', 'crud', 'org.dromara.im', 'im', 'userRecharge', '用户充值记录', 'Blue', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":\"1960299676476825608\"}', NULL, 1, '2025-08-27 11:11:42', 1, '2025-08-27 11:25:36', NULL);
INSERT INTO `gen_table` VALUES (6, 'admin', 'im_user_withdrawal', '用户提现记录', NULL, NULL, 'ImUserWithdrawal', 'crud', 'org.dromara.im', 'im', 'userWithdrawal', '用户提现记录', 'Blue', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":\"1960299676476825608\"}', NULL, 1, '2025-08-27 11:11:42', 1, '2025-08-27 11:26:41', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'id', '主键', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:27');
INSERT INTO `gen_table_column` VALUES (2, 1, 'user_id', '用户id', 'bigint', 'Long', 'userId', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:28');
INSERT INTO `gen_table_column` VALUES (3, 1, 'describes', '描述', 'varchar', 'String', 'describes', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:29');
INSERT INTO `gen_table_column` VALUES (4, 1, 'type', '资产类型', 'tinyint', 'Integer', 'type', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'select', 'biz_fund_type', 4, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:29');
INSERT INTO `gen_table_column` VALUES (5, 1, 'transfer_flag', '转入转出标识 -1：转出 1：转入', 'tinyint', 'Integer', 'transferFlag', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'select', 'biz_transfer_flag', 5, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:30');
INSERT INTO `gen_table_column` VALUES (6, 1, 'order_no', '订单编号', 'varchar', 'String', 'orderNo', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:30');
INSERT INTO `gen_table_column` VALUES (7, 1, 'point_before', '变动前', 'decimal', 'BigDecimal', 'pointBefore', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:31');
INSERT INTO `gen_table_column` VALUES (8, 1, 'amount', '数量', 'decimal', 'BigDecimal', 'amount', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:31');
INSERT INTO `gen_table_column` VALUES (9, 1, 'point_after', '变动后', 'decimal', 'BigDecimal', 'pointAfter', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 9, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:32');
INSERT INTO `gen_table_column` VALUES (10, 1, 'tx_hash', 'hash', 'varchar', 'String', 'txHash', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 10, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:33');
INSERT INTO `gen_table_column` VALUES (11, 1, 'tx_time', '存证时间', 'datetime', 'Date', 'txTime', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 11, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:33');
INSERT INTO `gen_table_column` VALUES (12, 1, 'remark', '备注', 'varchar', 'String', 'remark', '0', '1', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 12, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:34');
INSERT INTO `gen_table_column` VALUES (13, 1, 'del_flag', '删除标志（0代表存在 2代表删除）', 'char', 'String', 'delFlag', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 13, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:35');
INSERT INTO `gen_table_column` VALUES (14, 1, 'version', '版本', 'int', 'Long', 'version', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 14, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:36');
INSERT INTO `gen_table_column` VALUES (15, 1, 'create_dept', '', 'bigint', 'Long', 'createDept', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 15, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:36');
INSERT INTO `gen_table_column` VALUES (16, 1, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 16, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:37');
INSERT INTO `gen_table_column` VALUES (17, 1, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 17, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:38');
INSERT INTO `gen_table_column` VALUES (18, 1, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 18, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:39');
INSERT INTO `gen_table_column` VALUES (19, 1, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 19, NULL, 1, '2025-08-26 19:07:44', 1, '2025-08-26 19:13:39');
INSERT INTO `gen_table_column` VALUES (20, 2, 'id', '', 'int', 'Long', 'id', '1', '1', '1', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, NULL, 1, '2025-08-26 19:07:52', NULL, '2025-08-26 19:07:52');
INSERT INTO `gen_table_column` VALUES (21, 2, 'record_id', '红包记录id', 'int', 'Long', 'recordId', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, NULL, 1, '2025-08-26 19:07:52', NULL, '2025-08-26 19:07:52');
INSERT INTO `gen_table_column` VALUES (22, 2, 'amount', '金额(单位为分)', 'decimal', 'Long', 'amount', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, NULL, 1, '2025-08-26 19:07:52', NULL, '2025-08-26 19:07:52');
INSERT INTO `gen_table_column` VALUES (23, 2, 'is_active', '是否有效', 'tinyint', 'Long', 'isActive', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, NULL, 1, '2025-08-26 19:07:52', NULL, '2025-08-26 19:07:52');
INSERT INTO `gen_table_column` VALUES (24, 2, 'del_flag', '删除标志（0代表存在 1代表删除）', 'char', 'String', 'delFlag', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 5, NULL, 1, '2025-08-26 19:07:52', NULL, '2025-08-26 19:07:52');
INSERT INTO `gen_table_column` VALUES (25, 2, 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 6, NULL, 1, '2025-08-26 19:07:52', NULL, '2025-08-26 19:07:52');
INSERT INTO `gen_table_column` VALUES (26, 2, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 7, NULL, 1, '2025-08-26 19:07:52', NULL, '2025-08-26 19:07:52');
INSERT INTO `gen_table_column` VALUES (27, 2, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 8, NULL, 1, '2025-08-26 19:07:52', NULL, '2025-08-26 19:07:52');
INSERT INTO `gen_table_column` VALUES (28, 2, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 9, NULL, 1, '2025-08-26 19:07:52', NULL, '2025-08-26 19:07:52');
INSERT INTO `gen_table_column` VALUES (29, 2, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 10, NULL, 1, '2025-08-26 19:07:52', NULL, '2025-08-26 19:07:52');
INSERT INTO `gen_table_column` VALUES (30, 3, 'id', '', 'int', 'Long', 'id', '1', '1', '1', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, NULL, 1, '2025-08-26 19:07:57', NULL, '2025-08-26 19:07:57');
INSERT INTO `gen_table_column` VALUES (31, 3, 'user_id', '用户id', 'int', 'Long', 'userId', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, NULL, 1, '2025-08-26 19:07:57', NULL, '2025-08-26 19:07:57');
INSERT INTO `gen_table_column` VALUES (32, 3, 'red_packet', '红包全局唯一标识串', 'varchar', 'String', 'redPacket', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, NULL, 1, '2025-08-26 19:07:57', NULL, '2025-08-26 19:07:57');
INSERT INTO `gen_table_column` VALUES (33, 3, 'total', '人数', 'int', 'Long', 'total', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, NULL, 1, '2025-08-26 19:07:57', NULL, '2025-08-26 19:07:57');
INSERT INTO `gen_table_column` VALUES (34, 3, 'amount', '总金额(单位为分)', 'decimal', 'Long', 'amount', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, NULL, 1, '2025-08-26 19:07:57', NULL, '2025-08-26 19:07:57');
INSERT INTO `gen_table_column` VALUES (35, 3, 'is_active', '是否有效', 'tinyint', 'Long', 'isActive', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, NULL, 1, '2025-08-26 19:07:57', NULL, '2025-08-26 19:07:57');
INSERT INTO `gen_table_column` VALUES (36, 3, 'del_flag', '删除标志（0代表存在 1代表删除）', 'char', 'String', 'delFlag', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 7, NULL, 1, '2025-08-26 19:07:57', NULL, '2025-08-26 19:07:57');
INSERT INTO `gen_table_column` VALUES (37, 3, 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 8, NULL, 1, '2025-08-26 19:07:57', NULL, '2025-08-26 19:07:57');
INSERT INTO `gen_table_column` VALUES (38, 3, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 9, NULL, 1, '2025-08-26 19:07:57', NULL, '2025-08-26 19:07:57');
INSERT INTO `gen_table_column` VALUES (39, 3, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 10, NULL, 1, '2025-08-26 19:07:57', NULL, '2025-08-26 19:07:57');
INSERT INTO `gen_table_column` VALUES (40, 3, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 11, NULL, 1, '2025-08-26 19:07:57', NULL, '2025-08-26 19:07:57');
INSERT INTO `gen_table_column` VALUES (41, 3, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 12, NULL, 1, '2025-08-26 19:07:57', NULL, '2025-08-26 19:07:57');
INSERT INTO `gen_table_column` VALUES (42, 4, 'id', '', 'int', 'Long', 'id', '1', '1', '1', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, NULL, 1, '2025-08-26 19:08:03', NULL, '2025-08-26 19:08:03');
INSERT INTO `gen_table_column` VALUES (43, 4, 'user_id', '用户账号', 'int', 'Long', 'userId', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, NULL, 1, '2025-08-26 19:08:03', NULL, '2025-08-26 19:08:03');
INSERT INTO `gen_table_column` VALUES (44, 4, 'red_packet', '红包标识串', 'varchar', 'String', 'redPacket', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, NULL, 1, '2025-08-26 19:08:03', NULL, '2025-08-26 19:08:03');
INSERT INTO `gen_table_column` VALUES (45, 4, 'amount', '红包金额(单位为分)', 'decimal', 'Long', 'amount', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, NULL, 1, '2025-08-26 19:08:03', NULL, '2025-08-26 19:08:03');
INSERT INTO `gen_table_column` VALUES (46, 4, 'rob_time', '时间', 'datetime', 'Date', 'robTime', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, NULL, 1, '2025-08-26 19:08:03', NULL, '2025-08-26 19:08:03');
INSERT INTO `gen_table_column` VALUES (47, 4, 'del_flag', '删除标志（0代表存在 1代表删除）', 'char', 'String', 'delFlag', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 6, NULL, 1, '2025-08-26 19:08:03', NULL, '2025-08-26 19:08:03');
INSERT INTO `gen_table_column` VALUES (48, 4, 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 7, NULL, 1, '2025-08-26 19:08:03', NULL, '2025-08-26 19:08:03');
INSERT INTO `gen_table_column` VALUES (49, 4, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 8, NULL, 1, '2025-08-26 19:08:03', NULL, '2025-08-26 19:08:03');
INSERT INTO `gen_table_column` VALUES (50, 4, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 9, NULL, 1, '2025-08-26 19:08:03', NULL, '2025-08-26 19:08:03');
INSERT INTO `gen_table_column` VALUES (51, 4, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 10, NULL, 1, '2025-08-26 19:08:03', NULL, '2025-08-26 19:08:03');
INSERT INTO `gen_table_column` VALUES (52, 4, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 11, NULL, 1, '2025-08-26 19:08:03', NULL, '2025-08-26 19:08:03');
INSERT INTO `gen_table_column` VALUES (53, 5, 'id', '主键', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:36');
INSERT INTO `gen_table_column` VALUES (54, 5, 'user_id', '用户id', 'bigint', 'Long', 'userId', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:36');
INSERT INTO `gen_table_column` VALUES (55, 5, 'order_sn', '订单编号', 'varchar', 'String', 'orderSn', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:37');
INSERT INTO `gen_table_column` VALUES (56, 5, 'amount', '充值金额', 'decimal', 'BigDecimal', 'amount', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:37');
INSERT INTO `gen_table_column` VALUES (57, 5, 'usdt_amount', 'usdt金额', 'decimal', 'BigDecimal', 'usdtAmount', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:37');
INSERT INTO `gen_table_column` VALUES (58, 5, 'tx_hash', 'hash', 'varchar', 'String', 'txHash', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:38');
INSERT INTO `gen_table_column` VALUES (59, 5, 'status', '状态', 'tinyint', 'Integer', 'status', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'select', 'biz_recharge_status', 7, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:38');
INSERT INTO `gen_table_column` VALUES (60, 5, 'from_address', '转出地址', 'varchar', 'String', 'fromAddress', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:38');
INSERT INTO `gen_table_column` VALUES (61, 5, 'to_address', '转入地址', 'varchar', 'String', 'toAddress', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 9, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:39');
INSERT INTO `gen_table_column` VALUES (62, 5, 'notify_data', '链上数据', 'json', 'String', 'notifyData', '0', '1', '1', '1', '1', '1', '1', 'EQ', NULL, '', 10, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:39');
INSERT INTO `gen_table_column` VALUES (63, 5, 'img', '凭证', 'varchar', 'String', 'img', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 11, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:39');
INSERT INTO `gen_table_column` VALUES (64, 5, 'remark', '备注', 'varchar', 'String', 'remark', '0', '1', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 12, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:40');
INSERT INTO `gen_table_column` VALUES (65, 5, 'del_flag', '删除标志（0代表存在 1代表删除）', 'char', 'String', 'delFlag', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 13, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:40');
INSERT INTO `gen_table_column` VALUES (66, 5, 'version', '版本', 'int', 'Long', 'version', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 14, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:40');
INSERT INTO `gen_table_column` VALUES (67, 5, 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 15, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:41');
INSERT INTO `gen_table_column` VALUES (68, 5, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 16, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:41');
INSERT INTO `gen_table_column` VALUES (69, 5, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 17, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:42');
INSERT INTO `gen_table_column` VALUES (70, 5, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 18, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:42');
INSERT INTO `gen_table_column` VALUES (71, 5, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 19, NULL, 1, '2025-08-27 11:16:59', 1, '2025-08-27 11:25:42');
INSERT INTO `gen_table_column` VALUES (72, 6, 'id', '主键', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:41');
INSERT INTO `gen_table_column` VALUES (73, 6, 'user_id', '用户id', 'bigint', 'Long', 'userId', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:42');
INSERT INTO `gen_table_column` VALUES (74, 6, 'type', '类型（1余额）', 'tinyint', 'Integer', 'type', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'select', '', 3, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:42');
INSERT INTO `gen_table_column` VALUES (75, 6, 'order_sn', '订单编号', 'varchar', 'String', 'orderSn', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:43');
INSERT INTO `gen_table_column` VALUES (76, 6, 'amount', '提现金额', 'decimal', 'BigDecimal', 'amount', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:43');
INSERT INTO `gen_table_column` VALUES (77, 6, 'fee_amount', '手续费', 'decimal', 'BigDecimal', 'feeAmount', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:43');
INSERT INTO `gen_table_column` VALUES (78, 6, 'actual_amount', '实际到账金额', 'decimal', 'BigDecimal', 'actualAmount', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:44');
INSERT INTO `gen_table_column` VALUES (79, 6, 'tx_hash', 'hash', 'varchar', 'String', 'txHash', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:44');
INSERT INTO `gen_table_column` VALUES (80, 6, 'status', '状态（1：待审核 2：待确认 3: 已到账 4: 未到账 5: 审核拒绝）', 'tinyint', 'Integer', 'status', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'select', 'biz_withdraw_status', 9, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:45');
INSERT INTO `gen_table_column` VALUES (81, 6, 'from_address', '提现地址', 'varchar', 'String', 'fromAddress', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'input', '', 10, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:45');
INSERT INTO `gen_table_column` VALUES (82, 6, 'notify_data', '数据', 'text', 'String', 'notifyData', '0', '1', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 11, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:46');
INSERT INTO `gen_table_column` VALUES (83, 6, 'remark', '备注', 'varchar', 'String', 'remark', '0', '1', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 12, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:46');
INSERT INTO `gen_table_column` VALUES (84, 6, 'del_flag', '删除标志（0代表存在 2代表删除）', 'char', 'String', 'delFlag', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 13, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:46');
INSERT INTO `gen_table_column` VALUES (85, 6, 'version', '版本', 'int', 'Long', 'version', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 14, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:47');
INSERT INTO `gen_table_column` VALUES (86, 6, 'create_dept', '', 'bigint', 'Long', 'createDept', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 15, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:47');
INSERT INTO `gen_table_column` VALUES (87, 6, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 16, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:48');
INSERT INTO `gen_table_column` VALUES (88, 6, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 17, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:48');
INSERT INTO `gen_table_column` VALUES (89, 6, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 18, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:49');
INSERT INTO `gen_table_column` VALUES (90, 6, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '1', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 19, NULL, 1, '2025-08-27 11:17:04', 1, '2025-08-27 11:26:49');

-- ----------------------------
-- Table structure for im_distribution_commission
-- ----------------------------
DROP TABLE IF EXISTS `im_distribution_commission`;
CREATE TABLE `im_distribution_commission`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `distributor_user_id` bigint NOT NULL COMMENT '分销商用户ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `buyer_user_id` bigint NOT NULL COMMENT '购买用户ID',
  `commission_type` tinyint NOT NULL COMMENT '佣金类型: 1-直推佣金 2-间推佣金',
  `order_amount` decimal(10, 2) NOT NULL COMMENT '订单金额',
  `commission_amount` decimal(10, 2) NOT NULL COMMENT '佣金金额',
  `commission_rate` decimal(5, 4) NOT NULL COMMENT '佣金比例',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态: 0-待结算 1-已结算 2-已取消',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `settled_time` datetime NULL DEFAULT NULL COMMENT '结算时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_distributor_user_id`(`distributor_user_id`) USING BTREE,
  INDEX `idx_order_id`(`order_id`) USING BTREE,
  INDEX `idx_buyer_user_id`(`buyer_user_id`) USING BTREE,
  INDEX `idx_created_time`(`created_time`) USING BTREE,
  INDEX `idx_distributor_status_time`(`distributor_user_id`, `status`, `created_time`) USING BTREE,
  INDEX `idx_buyer_time`(`buyer_user_id`, `created_time`) USING BTREE,
  INDEX `idx_order_status`(`order_id`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '分销佣金记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of im_distribution_commission
-- ----------------------------

-- ----------------------------
-- Table structure for im_distribution_user
-- ----------------------------
DROP TABLE IF EXISTS `im_distribution_user`;
CREATE TABLE `im_distribution_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `referral_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '推广码',
  `parent_user_id` bigint NULL DEFAULT NULL COMMENT '上级分销商用户ID（一级）',
  `grand_parent_user_id` bigint NULL DEFAULT NULL COMMENT '二级上级分销商用户ID',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '分销商状态: 0-未激活 1-已激活 2-已禁用',
  `total_commission` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '累计佣金',
  `available_commission` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '可提现佣金',
  `withdrawn_commission` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '已提现佣金',
  `activation_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '激活条件: 消费金额',
  `activated_time` datetime NULL DEFAULT NULL COMMENT '激活时间',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id`) USING BTREE,
  UNIQUE INDEX `uk_referral_code`(`referral_code`) USING BTREE,
  INDEX `idx_parent_user_id`(`parent_user_id`) USING BTREE,
  INDEX `idx_grand_parent_user_id`(`grand_parent_user_id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_parent_status`(`parent_user_id`, `status`) USING BTREE,
  INDEX `idx_grand_parent_status`(`grand_parent_user_id`, `status`) USING BTREE,
  INDEX `idx_status_activated`(`status`, `activated_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '分销用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of im_distribution_user
-- ----------------------------

-- ----------------------------
-- Table structure for im_file_info
-- ----------------------------
DROP TABLE IF EXISTS `im_file_info`;
CREATE TABLE `im_file_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件名',
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件地址',
  `file_size` int NOT NULL COMMENT '文件大小',
  `file_type` tinyint NOT NULL COMMENT '0:普通文件 1:图片 2:视频',
  `compressed_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '压缩文件路径',
  `cover_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面文件路径，仅视频文件有效',
  `upload_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `is_permanent` tinyint NULL DEFAULT 0 COMMENT '是否永久文件',
  `md5` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件md5',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_md5`(`md5`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 764 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_file_info
-- ----------------------------
INSERT INTO `im_file_info` VALUES (757, 'txlogo.png', 'https://local80minio.gzwrxxkj.com/box-im/image/20250930/1759221586634.png', 65909, 1, 'https://local80minio.gzwrxxkj.com/box-im/image/20250930/1759221586661.png', NULL, '2025-09-30 16:39:47', 1, 'ca8039435bc8bc36bb79509f59dfb04e');
INSERT INTO `im_file_info` VALUES (758, '敏感词库初始化.sql', 'https://local80minio.gzwrxxkj.com/box-im/file/20251104/1762260995470.sql', 41360, 0, NULL, NULL, '2025-11-04 20:56:36', 0, 'e6cf75f782603dd8aa7233464f44ed9f');
INSERT INTO `im_file_info` VALUES (759, 'ali (1).jpeg', 'https://local80minio.gzwrxxkj.com/box-im/image/20251104/1762261028443.jpeg', 59216, 1, 'https://local80minio.gzwrxxkj.com/box-im/image/20251104/1762261028605.jpeg', NULL, '2025-11-04 20:57:09', 0, 'd1d8100b69a555e68905e07dda3733c1');
INSERT INTO `im_file_info` VALUES (760, '微信视频2025-11-04_205949_748.mp4', 'https://local80minio.gzwrxxkj.com/box-im/video/20251104/1762261212507.mp4', 790342, 2, NULL, 'https://local80minio.gzwrxxkj.com/box-im/video/20251104/1762261213212.png', '2025-11-04 21:00:13', 0, '65560c8fe09fb0d8a6481fea1b57de03');
INSERT INTO `im_file_info` VALUES (761, '4.mp3', 'https://local80minio.gzwrxxkj.com/box-im/file/20251104/1762261427020.mp3', 35738, 0, NULL, NULL, '2025-11-04 21:03:47', 0, 'df9c326ceaf3c48147be8ddf483bbcb0');
INSERT INTO `im_file_info` VALUES (762, '4.mp3', 'https://local80minio.gzwrxxkj.com/box-im/file/20251104/1762261440062.mp3', 60854, 0, NULL, NULL, '2025-11-04 21:04:00', 0, '3f0685881371f5ae4f83cf5f25badc71');
INSERT INTO `im_file_info` VALUES (763, '4.mp3', 'https://local80minio.gzwrxxkj.com/box-im/file/20251104/1762261475705.mp3', 45698, 0, NULL, NULL, '2025-11-04 21:04:36', 0, '0c7878194746a649ae7f6786acef46a3');

-- ----------------------------
-- Table structure for im_friend
-- ----------------------------
DROP TABLE IF EXISTS `im_friend`;
CREATE TABLE `im_friend`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `friend_id` bigint NOT NULL COMMENT '好友id',
  `friend_nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '好友昵称',
  `friend_head_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '好友头像',
  `remark_nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注昵称',
  `is_dnd` tinyint NULL DEFAULT NULL COMMENT '免打扰标识(Do Not Disturb)  0:关闭   1:开启',
  `deleted` tinyint NULL DEFAULT NULL COMMENT '删除标识  0：正常   1：已删除',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_friend_id`(`friend_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1181 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '好友' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_friend
-- ----------------------------
INSERT INTO `im_friend` VALUES (1175, 8, 7, '17687978523', '', '', NULL, 0, '2025-11-01 16:53:11');
INSERT INTO `im_friend` VALUES (1176, 7, 8, 'a222', '', '', NULL, 0, '2025-11-01 16:53:11');
INSERT INTO `im_friend` VALUES (1177, 9, 7, '17687978523', '', '', NULL, 0, '2025-11-09 13:59:41');
INSERT INTO `im_friend` VALUES (1178, 7, 9, '老六', '', '', NULL, 0, '2025-11-09 13:59:41');
INSERT INTO `im_friend` VALUES (1179, 9, 8, 'a222', '', '', NULL, 0, '2025-11-09 13:59:50');
INSERT INTO `im_friend` VALUES (1180, 8, 9, '老六', '', '', NULL, 0, '2025-11-09 13:59:50');

-- ----------------------------
-- Table structure for im_friend_request
-- ----------------------------
DROP TABLE IF EXISTS `im_friend_request`;
CREATE TABLE `im_friend_request`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `send_id` bigint NOT NULL COMMENT '发起方用户ID',
  `send_nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发起方昵称，冗余字段',
  `send_head_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发起方头像，冗余字段',
  `recv_id` bigint NOT NULL COMMENT '接收方用户ID',
  `recv_nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '接收方昵称，冗余字段',
  `recv_head_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '接收方头像，冗余字段',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '申请备注',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态  1:未处理 2:同意 3:拒绝 4:过期',
  `apply_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_send_id`(`send_id`) USING BTREE,
  INDEX `idx_recv_id`(`recv_id`) USING BTREE,
  INDEX `idx_apply_time`(`apply_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '好友申请列表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_friend_request
-- ----------------------------

-- ----------------------------
-- Table structure for im_group
-- ----------------------------
DROP TABLE IF EXISTS `im_group`;
CREATE TABLE `im_group`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '群名字',
  `owner_id` bigint NOT NULL COMMENT '群主id',
  `head_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '群头像',
  `head_image_thumb` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '群头像缩略图',
  `notice` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '群公告',
  `top_message_id` bigint NULL DEFAULT NULL COMMENT '置顶消息id',
  `is_muted` tinyint(1) NULL DEFAULT 0 COMMENT '是否开启全体禁言 0:否 1:是',
  `is_banned` tinyint(1) NULL DEFAULT 0 COMMENT '是否被封禁 0:否 1:是',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '被封禁原因',
  `dissolve` tinyint(1) NULL DEFAULT 0 COMMENT '是否已解散',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '群' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_group
-- ----------------------------
INSERT INTO `im_group` VALUES (21, 'a111创建的群聊', 7, 'https://local80minio.gzwrxxkj.com/box-im/image/20250930/1759221586634.png', 'https://local80minio.gzwrxxkj.com/box-im/image/20250930/1759221586661.png', '', NULL, 0, 0, '', 0, '2025-09-30 16:39:48');
INSERT INTO `im_group` VALUES (22, 'vip群聊', 8, '', '', '', NULL, 0, 0, '', 0, '2025-11-09 20:13:42');

-- ----------------------------
-- Table structure for im_group_member
-- ----------------------------
DROP TABLE IF EXISTS `im_group_member`;
CREATE TABLE `im_group_member`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `group_id` bigint NOT NULL COMMENT '群id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `user_nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户昵称',
  `remark_nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '显示昵称备注',
  `head_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户头像',
  `remark_group_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '显示群名备注',
  `is_manager` tinyint(1) NULL DEFAULT 0 COMMENT '是否管理员 0:否 1:是',
  `is_muted` tinyint(1) NULL DEFAULT 0 COMMENT '是否被禁言 0:否 1:是',
  `is_dnd` tinyint NULL DEFAULT NULL COMMENT '免打扰标识(Do Not Disturb)  0:关闭   1:开启',
  `is_top_message` tinyint(1) NULL DEFAULT 0 COMMENT '是否显示置顶消息',
  `quit` tinyint(1) NULL DEFAULT 0 COMMENT '是否已退出',
  `quit_time` datetime NULL DEFAULT NULL COMMENT '退出时间',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_group_id`(`group_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 376 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '群成员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_group_member
-- ----------------------------
INSERT INTO `im_group_member` VALUES (371, 21, 7, '17687978523', '', '', '', 0, 0, NULL, 0, 0, NULL, '2025-09-30 16:39:48');
INSERT INTO `im_group_member` VALUES (372, 21, 8, 'a222', '', '', '', 0, 0, NULL, 0, 0, NULL, '2025-11-01 16:59:26');
INSERT INTO `im_group_member` VALUES (373, 22, 8, 'a222', '', '', '', 0, 0, NULL, 0, 0, NULL, '2025-11-09 20:13:42');
INSERT INTO `im_group_member` VALUES (374, 22, 7, '17687978523', '', '', '', 0, 0, NULL, 0, 0, NULL, '2025-11-09 20:14:06');
INSERT INTO `im_group_member` VALUES (375, 22, 9, '老六', '', '', '', 0, 0, NULL, 0, 0, NULL, '2025-11-09 20:14:06');

-- ----------------------------
-- Table structure for im_group_message
-- ----------------------------
DROP TABLE IF EXISTS `im_group_message`;
CREATE TABLE `im_group_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `group_id` bigint NOT NULL COMMENT '群id',
  `send_id` bigint NOT NULL COMMENT '发送用户id',
  `send_nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '发送用户昵称',
  `recv_ids` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '接收用户id,逗号分隔，为空表示发给所有成员',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '发送内容',
  `at_user_ids` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '被@的用户id列表，逗号分隔',
  `receipt` tinyint NULL DEFAULT 0 COMMENT '是否回执消息',
  `receipt_ok` tinyint NULL DEFAULT 0 COMMENT '回执消息是否完成',
  `type` int NOT NULL COMMENT '消息类型 0:文字 1:图片 2:文件 3:语音 4:视频 21:提示',
  `quote_message_id` bigint NULL DEFAULT NULL COMMENT '引用消息id',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '状态 0:未发出  2:撤回 ',
  `send_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1333 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '群消息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_group_message
-- ----------------------------
INSERT INTO `im_group_message` VALUES (1312, 21, 7, '17687978523', '', '{\"id\":\"redis:red:packet:7:694808452843736\",\"rob\":false,\"userId\":7}', '', 0, 0, 300, NULL, 0, '2025-09-30 16:40:02');
INSERT INTO `im_group_message` VALUES (1313, 21, 7, '17687978523', '', '{\"id\":\"redis:red:packet:7:713951866107057\",\"rob\":false,\"userId\":7}', '', 0, 0, 300, NULL, 0, '2025-09-30 21:59:04');
INSERT INTO `im_group_message` VALUES (1314, 21, 7, '17687978523', '', '1\n', '', 0, 0, 0, NULL, 0, '2025-10-04 18:19:22');
INSERT INTO `im_group_message` VALUES (1315, 21, 7, '17687978523', '', '2\n\n', '', 0, 0, 0, NULL, 0, '2025-10-16 11:50:27');
INSERT INTO `im_group_message` VALUES (1316, 21, 7, '17687978523', '', '\'17687978523\'邀请\'a222\'加入了群聊', NULL, 0, 0, 21, NULL, 0, '2025-11-01 16:59:26');
INSERT INTO `im_group_message` VALUES (1317, 21, 7, '', '', '17687978523 发起了语音通话', NULL, 0, 0, 21, NULL, 0, '2025-11-01 16:59:39');
INSERT INTO `im_group_message` VALUES (1318, 21, 8, '', '', '通话结束', NULL, 0, 0, 21, NULL, 0, '2025-11-01 17:01:25');
INSERT INTO `im_group_message` VALUES (1319, 21, 8, 'a222', '', '{\"name\":\"敏感词库初始化.sql\",\"size\":41360,\"url\":\"https://local80minio.gzwrxxkj.com/box-im/file/20251104/1762260995470.sql\"}', '', 0, 0, 2, NULL, 0, '2025-11-04 20:56:36');
INSERT INTO `im_group_message` VALUES (1320, 21, 8, 'a222', '', '{\"originUrl\":\"https://local80minio.gzwrxxkj.com/box-im/image/20251104/1762261028443.jpeg\",\"thumbUrl\":\"https://local80minio.gzwrxxkj.com/box-im/image/20251104/1762261028605.jpeg\"}', '', 0, 0, 1, NULL, 0, '2025-11-04 20:57:09');
INSERT INTO `im_group_message` VALUES (1321, 21, 8, 'a222', '', '{\"videoUrl\":\"https://local80minio.gzwrxxkj.com/box-im/video/20251104/1762261212507.mp4\",\"coverUrl\":\"https://local80minio.gzwrxxkj.com/box-im/video/20251104/1762261213212.png\"}', '', 0, 0, 4, NULL, 0, '2025-11-04 21:00:13');
INSERT INTO `im_group_message` VALUES (1322, 21, 8, 'a222', '', '{\"duration\":2,\"url\":\"https://local80minio.gzwrxxkj.com/box-im/file/20251104/1762261427020.mp3\"}', '', 0, 0, 3, NULL, 0, '2025-11-04 21:03:47');
INSERT INTO `im_group_message` VALUES (1323, 21, 8, 'a222', '', '{\"duration\":3,\"url\":\"https://local80minio.gzwrxxkj.com/box-im/file/20251104/1762261440062.mp3\"}', '', 0, 0, 3, NULL, 0, '2025-11-04 21:04:00');
INSERT INTO `im_group_message` VALUES (1324, 21, 8, 'a222', '', '{\"duration\":2,\"url\":\"https://local80minio.gzwrxxkj.com/box-im/file/20251104/1762261475705.mp3\"}', '', 0, 0, 3, NULL, 0, '2025-11-04 21:04:36');
INSERT INTO `im_group_message` VALUES (1325, 21, 7, '', '', '17687978523 发起了语音通话', NULL, 0, 0, 21, NULL, 0, '2025-11-04 21:04:49');
INSERT INTO `im_group_message` VALUES (1326, 21, 7, '', '', '通话结束', NULL, 0, 0, 21, NULL, 0, '2025-11-04 21:05:14');
INSERT INTO `im_group_message` VALUES (1327, 21, 7, '', '', '17687978523 发起了语音通话', NULL, 0, 0, 21, NULL, 0, '2025-11-04 21:05:50');
INSERT INTO `im_group_message` VALUES (1328, 21, 8, '', '', '通话结束', NULL, 0, 0, 21, NULL, 0, '2025-11-04 21:07:07');
INSERT INTO `im_group_message` VALUES (1329, 22, 8, 'a222', '', '\'a222\'邀请\'17687978523,老六\'加入了群聊', NULL, 0, 0, 21, NULL, 0, '2025-11-09 20:14:06');
INSERT INTO `im_group_message` VALUES (1330, 22, 8, 'a222', '', '111\n\n', '', 0, 0, 0, NULL, 0, '2025-11-09 20:14:21');
INSERT INTO `im_group_message` VALUES (1331, 21, 8, 'a222', '', '{\"id\":\"redis:red:packet:8:2076356429063782\",\"rob\":false,\"userId\":8}', '', 0, 0, 300, NULL, 0, '2025-11-10 23:24:02');
INSERT INTO `im_group_message` VALUES (1332, 21, 8, 'a222', '', '{\"id\":\"redis:red:packet:8:2076414297607141\",\"rob\":false,\"userId\":8}', '', 0, 0, 300, NULL, 0, '2025-11-10 23:24:59');

-- ----------------------------
-- Table structure for im_mall_order
-- ----------------------------
DROP TABLE IF EXISTS `im_mall_order`;
CREATE TABLE `im_mall_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `product_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
  `quantity` int NOT NULL DEFAULT 1 COMMENT '商品数量',
  `unit_price` decimal(10, 2) NOT NULL COMMENT '单价',
  `total_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
  `payment_method` tinyint NOT NULL COMMENT '支付方式: 1-余额支付 2-iOS内购',
  `ios_receipt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'iOS交易凭证',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '订单状态: 0-待支付 1-已支付 2-已取消 3-已完成',
  `referrer_user_id` bigint NULL DEFAULT NULL COMMENT '推荐人用户ID',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `paid_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `completed_time` datetime NULL DEFAULT NULL COMMENT '完成时间',
  `updated_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sku_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_product_id`(`product_id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_created_time`(`created_time`) USING BTREE,
  INDEX `idx_user_status_time`(`user_id`, `status`, `created_time`) USING BTREE,
  INDEX `idx_product_status`(`product_id`, `status`) USING BTREE,
  INDEX `idx_referrer`(`referrer_user_id`, `status`) USING BTREE,
  INDEX `idx_status_paid`(`status`, `paid_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商城订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of im_mall_order
-- ----------------------------

-- ----------------------------
-- Table structure for im_mall_product
-- ----------------------------
DROP TABLE IF EXISTS `im_mall_product`;
CREATE TABLE `im_mall_product`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品描述',
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品图片',
  `price` decimal(10, 2) NOT NULL COMMENT '商品价格',
  `original_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '原价',
  `stock` int NOT NULL DEFAULT 0 COMMENT '库存',
  `sales_count` int NOT NULL DEFAULT 0 COMMENT '销量',
  `product_type` tinyint NOT NULL DEFAULT 1 COMMENT '商品类型: 1-虚拟商品 2-实物商品',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '商品状态: 0-下架 1-上架',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `enable_distribution` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否支持分销: 0-否 1-是',
  `level1_commission_rate` decimal(5, 4) NULL DEFAULT 0.0000 COMMENT '一级佣金比例',
  `level2_commission_rate` decimal(5, 4) NULL DEFAULT 0.0000 COMMENT '二级佣金比例',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_sort_order`(`sort_order`) USING BTREE,
  INDEX `idx_created_time`(`created_time`) USING BTREE,
  INDEX `idx_status_sort`(`status`, `sort_order`) USING BTREE,
  INDEX `idx_distribution`(`enable_distribution`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商城商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of im_mall_product
-- ----------------------------
INSERT INTO `im_mall_product` VALUES (1, 'VIP会员月卡', '开通VIP会员，享受更多特权', NULL, 30.00, 50.00, 9999, 0, 1, 1, 1, 1, 0.1000, 0.0500, '2025-11-12 15:30:46', '2025-11-12 15:30:46');
INSERT INTO `im_mall_product` VALUES (2, 'VIP会员季卡', '开通VIP会员3个月，享受更多特权', NULL, 80.00, 120.00, 9999, 0, 1, 1, 2, 1, 0.1500, 0.0800, '2025-11-12 15:30:46', '2025-11-12 15:30:46');
INSERT INTO `im_mall_product` VALUES (3, 'VIP会员年卡', '开通VIP会员12个月，享受更多特权', NULL, 288.00, 480.00, 9999, 0, 1, 1, 3, 1, 0.2000, 0.1000, '2025-11-12 15:30:46', '2025-11-12 15:30:46');
INSERT INTO `im_mall_product` VALUES (4, '钻石礼包', '包含1000钻石，可用于购买虚拟礼物', NULL, 98.00, 98.00, 9999, 0, 1, 1, 4, 0, 0.0000, 0.0000, '2025-11-12 15:30:46', '2025-11-12 15:30:46');

-- ----------------------------
-- Table structure for im_mall_sku
-- ----------------------------
DROP TABLE IF EXISTS `im_mall_sku`;
CREATE TABLE `im_mall_sku`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `attributes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` decimal(19, 2) NOT NULL,
  `stock` int NOT NULL DEFAULT 0,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_time` datetime NULL DEFAULT NULL,
  `updated_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_product`(`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of im_mall_sku
-- ----------------------------

-- ----------------------------
-- Table structure for im_private_message
-- ----------------------------
DROP TABLE IF EXISTS `im_private_message`;
CREATE TABLE `im_private_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `send_id` bigint NOT NULL COMMENT '发送用户id',
  `recv_id` bigint NOT NULL COMMENT '接收用户id',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '发送内容',
  `type` tinyint(1) NOT NULL COMMENT '消息类型 0:文字 1:图片 2:文件 3:语音 4:视频 21:提示',
  `quote_message_id` bigint NULL DEFAULT NULL COMMENT '引用消息id',
  `status` tinyint(1) NOT NULL COMMENT '状态 0:未读 1:已发送 2:撤回 3:已读',
  `send_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_send_id`(`send_id`) USING BTREE,
  INDEX `idx_recv_id`(`recv_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2604 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '私聊消息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_private_message
-- ----------------------------
INSERT INTO `im_private_message` VALUES (2593, 8, 7, '你们已成为好友，现在可以开始聊天了', 21, NULL, 1, '2025-11-01 16:53:12');
INSERT INTO `im_private_message` VALUES (2594, 7, 8, '1\n', 0, NULL, 3, '2025-11-01 16:53:35');
INSERT INTO `im_private_message` VALUES (2595, 8, 7, '通话时长 01:01', 41, NULL, 3, '2025-11-01 16:54:45');
INSERT INTO `im_private_message` VALUES (2596, 7, 8, '通话时长 01:15', 41, NULL, 3, '2025-11-01 16:56:09');
INSERT INTO `im_private_message` VALUES (2597, 7, 8, '通话时长 00:26', 41, NULL, 3, '2025-11-01 16:56:48');
INSERT INTO `im_private_message` VALUES (2598, 8, 7, '通话时长 02:16', 41, NULL, 3, '2025-11-01 16:59:13');
INSERT INTO `im_private_message` VALUES (2599, 7, 8, '通话时长 00:24', 41, NULL, 3, '2025-11-04 21:07:47');
INSERT INTO `im_private_message` VALUES (2600, 9, 7, '你们已成为好友，现在可以开始聊天了', 21, NULL, 1, '2025-11-09 13:59:41');
INSERT INTO `im_private_message` VALUES (2601, 9, 8, '你们已成为好友，现在可以开始聊天了', 21, NULL, 1, '2025-11-09 13:59:50');
INSERT INTO `im_private_message` VALUES (2602, 8, 9, '2\n', 0, NULL, 1, '2025-11-09 16:40:35');
INSERT INTO `im_private_message` VALUES (2603, 7, 9, '444\n', 0, NULL, 0, '2025-11-11 10:25:03');

-- ----------------------------
-- Table structure for im_sensitive_word
-- ----------------------------
DROP TABLE IF EXISTS `im_sensitive_word`;
CREATE TABLE `im_sensitive_word`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `content` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '敏感词内容',
  `enabled` tinyint NULL DEFAULT 0 COMMENT '是否启用 0:未启用 1:启用',
  `creator` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '敏感词' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_sensitive_word
-- ----------------------------

-- ----------------------------
-- Table structure for im_sm_push_task
-- ----------------------------
DROP TABLE IF EXISTS `im_sm_push_task`;
CREATE TABLE `im_sm_push_task`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `message_id` bigint NOT NULL COMMENT '系统消息id',
  `seq_no` bigint NULL DEFAULT NULL COMMENT '发送序列号',
  `send_time` datetime NULL DEFAULT NULL COMMENT '推送时间',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 1:待发送 2:发送中 3:已发送 4:已取消',
  `send_to_all` tinyint NULL DEFAULT 1 COMMENT '是否发送给全体用户',
  `recv_ids` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '接收用户id,逗号分隔,send_to_all为false时有效',
  `deleted` tinyint NULL DEFAULT NULL COMMENT '删除标识  0：正常   1：已删除',
  `creator` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_seq_no`(`seq_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统消息推送任务' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_sm_push_task
-- ----------------------------

-- ----------------------------
-- Table structure for im_system_message
-- ----------------------------
DROP TABLE IF EXISTS `im_system_message`;
CREATE TABLE `im_system_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `cover_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图片',
  `intro` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '简介',
  `content_type` tinyint(1) NULL DEFAULT 0 COMMENT '内容类型 0:富文本  1:外部链接',
  `rich_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '富文本内容，base64编码',
  `extern_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外部链接',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '删除标识  0：正常   1：已删除',
  `creator` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统消息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_system_message
-- ----------------------------

-- ----------------------------
-- Table structure for im_user
-- ----------------------------
DROP TABLE IF EXISTS `im_user`;
CREATE TABLE `im_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `head_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户头像',
  `head_image_thumb` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户头像缩略图',
  `wallet_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '钱包地址',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `trade_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '交易密码',
  `balance` decimal(10, 4) NOT NULL DEFAULT 0.0000 COMMENT '余额',
  `sex` tinyint(1) NULL DEFAULT 0 COMMENT '性别 0:男 1:女',
  `phone` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号码',
  `email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `is_banned` tinyint(1) NULL DEFAULT 0 COMMENT '是否被封禁 0:否 1:是',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '被封禁原因',
  `type` smallint NULL DEFAULT 1 COMMENT '用户类型 1:普通用户 2:审核账户',
  `signature` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '个性签名',
  `interests` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '兴趣标签,逗号分隔',
  `is_manual_approve` tinyint(1) NULL DEFAULT 0 COMMENT '是否手动验证好友请求',
  `cid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '客户端id,用于uni-push推送',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态  0:正常  1:已注销',
  `last_login_time` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `age` int NULL DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `longitude` decimal(10, 6) NULL DEFAULT NULL,
  `latitude` decimal(10, 6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_user_name`(`user_name`) USING BTREE,
  UNIQUE INDEX `idx_phone`(`phone`) USING BTREE,
  UNIQUE INDEX `idx_email`(`email`) USING BTREE,
  INDEX `idx_nick_name`(`nick_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_user
-- ----------------------------
INSERT INTO `im_user` VALUES (7, 'a111', '17687978523', '', '', '1111111', '$2a$10$KZhcFcePUTGjpFk.7tyoMenQyTSi8BZ59DPLwyno92NCVUk5Win/C', '$2a$10$tneQ8w90RUgJCRw5nClfDeiYYq9HJrB1.H3QTDReIQkALe.ydjjmq', 89.4800, 0, NULL, NULL, 0, '', 3, '', NULL, 0, '', 0, '2025-11-14 14:52:19', '2025-08-24 23:35:42', NULL, NULL, NULL, NULL);
INSERT INTO `im_user` VALUES (8, '15605020252', 'a222', '', '', '0x9791558F239057029b2c4D66310829C1F3832A59', '$2a$10$k9k9hatFya/KAJYUVLeudORYObiykV4toyBaMBURsD31wSJmzoaoy', '$2a$10$81Wku.sZwQsshUxP8y3MyOUu4NPYb4Zdx8sdFaLFh/5RCp4l.SUXa', 909.1000, 0, NULL, NULL, 0, '', 3, '', NULL, 0, '', 0, '2025-11-10 23:25:33', '2025-11-01 16:53:02', NULL, NULL, NULL, NULL);
INSERT INTO `im_user` VALUES (9, '13011111111', '老六', '', '', '123456', '$2a$10$7ceYNJcRjfbn3HbMbUShNOMzFept8mSO4Jd8InOr7xh7TXzA3amTW', '$2a$10$LbD15OiXa3f2Mm2CnwQE8OabW4RTfawJJSU.B.5NeG1xmfD7ru9Fm', 11110.0000, 0, NULL, NULL, 0, '', 1, '', NULL, 0, '', 0, '2025-11-09 14:01:13', '2025-11-09 13:59:16', NULL, NULL, NULL, NULL);
INSERT INTO `im_user` VALUES (10, '15302284628', 'tina', '', '', NULL, '$2a$10$l49mS8WI4Vx46M4hKMHpneoE6W9IJkoEkVWuMP9rhPskJMvus9cdO', NULL, 0.0000, 0, NULL, NULL, 0, '', 1, '', NULL, 0, '', 0, '2025-11-10 23:00:46', '2025-11-10 22:59:33', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for im_user_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `im_user_blacklist`;
CREATE TABLE `im_user_blacklist`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `from_user_id` bigint NOT NULL COMMENT '拉黑用户id',
  `to_user_id` bigint NOT NULL COMMENT '被拉黑用户id',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_from_user_id`(`from_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户黑名单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_user_blacklist
-- ----------------------------

-- ----------------------------
-- Table structure for im_user_complaint
-- ----------------------------
DROP TABLE IF EXISTS `im_user_complaint`;
CREATE TABLE `im_user_complaint`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `target_type` tinyint NOT NULL COMMENT '投诉对象类型 1:用户 2:群聊',
  `target_id` bigint NOT NULL COMMENT '投诉对象id',
  `target_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '投诉对象名称',
  `type` tinyint NOT NULL COMMENT '投诉原因类型 1:对我造成骚扰 2:疑似诈骗 3:传播不良内容 99:其他',
  `images` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '图片列表,最多9张',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '投诉内容',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 1:未处理 2:已处理',
  `resolved_admin_id` bigint NULL DEFAULT NULL COMMENT '处理投诉的管理员id',
  `resolved_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理结果类型 1:已处理 2:不予处理 3:未涉及不正规行为 4:其他',
  `resolved_summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理结果摘要',
  `resolved_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户投诉' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_user_complaint
-- ----------------------------

-- ----------------------------
-- Table structure for im_user_fund_detail
-- ----------------------------
DROP TABLE IF EXISTS `im_user_fund_detail`;
CREATE TABLE `im_user_fund_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `describes` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `type` tinyint NULL DEFAULT 1 COMMENT '资产类型',
  `transfer_flag` tinyint NULL DEFAULT NULL COMMENT '转入转出标识 -1：转出 1：转入',
  `order_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `point_before` decimal(20, 6) NULL DEFAULT 0.000000 COMMENT '变动前',
  `amount` decimal(20, 6) NULL DEFAULT 0.000000 COMMENT '数量',
  `point_after` decimal(20, 6) NULL DEFAULT 0.000000 COMMENT '变动后',
  `tx_hash` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'hash',
  `tx_time` datetime NULL DEFAULT NULL COMMENT '存证时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `version` int NULL DEFAULT 0 COMMENT '版本',
  `create_dept` bigint NULL DEFAULT NULL,
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_order_sn`(`order_no`) USING BTREE,
  INDEX `idx_user_type`(`user_id`, `type`, `transfer_flag`, `describes`, `amount`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户资产明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_user_fund_detail
-- ----------------------------
INSERT INTO `im_user_fund_detail` VALUES (91, 7, '发红包', 1, -1, 'redis:red:packet:7:694808452843736', 100.000000, 1.000000, 99.000000, '', '2025-09-30 16:40:01', '发红包', '0', 0, NULL, NULL, '2025-09-30 16:40:01', NULL, '2025-09-30 16:40:01');
INSERT INTO `im_user_fund_detail` VALUES (92, 7, '抢红包', 1, 1, 'redis:red:packet:7:694808452843736', 99.000000, 1.000000, 100.000000, '', '2025-09-30 16:40:08', '', '0', 0, NULL, NULL, '2025-09-30 16:40:08', NULL, '2025-09-30 16:40:08');
INSERT INTO `im_user_fund_detail` VALUES (93, 7, '发红包', 1, -1, 'redis:red:packet:7:713951866107057', 100.000000, 11.000000, 89.000000, '', '2025-09-30 21:59:04', '发红包', '0', 0, NULL, NULL, '2025-09-30 21:59:04', NULL, '2025-09-30 21:59:04');
INSERT INTO `im_user_fund_detail` VALUES (94, 7, '抢红包', 1, 1, 'redis:red:packet:7:713951866107057', 89.000000, 0.480000, 89.480000, '', '2025-09-30 21:59:24', '', '0', 0, NULL, NULL, '2025-09-30 21:59:24', NULL, '2025-09-30 21:59:24');
INSERT INTO `im_user_fund_detail` VALUES (95, 8, '购买VIP', 1, -1, NULL, 1110.000000, 100.000000, 1010.000000, NULL, '2025-11-09 20:10:29', NULL, '0', 0, NULL, NULL, '2025-11-09 20:10:29', NULL, '2025-11-09 20:10:29');
INSERT INTO `im_user_fund_detail` VALUES (96, 8, '提现', 1, -1, 'TX1987493038642749440', 1010.000000, 100.000000, 910.000000, NULL, '2025-11-09 20:10:41', NULL, '0', 0, NULL, NULL, '2025-11-09 20:10:41', NULL, '2025-11-09 20:10:41');
INSERT INTO `im_user_fund_detail` VALUES (97, 8, '发红包', 1, -1, 'redis:red:packet:8:2076356429063782', 910.000000, 1.000000, 909.000000, '', '2025-11-10 23:24:02', '发红包', '0', 0, NULL, NULL, '2025-11-10 23:24:02', NULL, '2025-11-10 23:24:02');
INSERT INTO `im_user_fund_detail` VALUES (98, 8, '抢红包', 1, 1, 'redis:red:packet:8:2076356429063782', 909.000000, 0.100000, 909.100000, '', '2025-11-10 23:24:08', '', '0', 0, NULL, NULL, '2025-11-10 23:24:08', NULL, '2025-11-10 23:24:08');
INSERT INTO `im_user_fund_detail` VALUES (99, 8, '发红包', 1, -1, 'redis:red:packet:8:2076414297607141', 909.100000, 10.000000, 899.100000, '', '2025-11-10 23:24:59', '发红包', '0', 0, NULL, NULL, '2025-11-10 23:24:59', NULL, '2025-11-10 23:24:59');
INSERT INTO `im_user_fund_detail` VALUES (100, 8, '抢红包', 1, 1, 'redis:red:packet:8:2076414297607141', 899.100000, 10.000000, 909.100000, '', '2025-11-10 23:25:12', '', '0', 0, NULL, NULL, '2025-11-10 23:25:12', NULL, '2025-11-10 23:25:12');

-- ----------------------------
-- Table structure for im_user_match
-- ----------------------------
DROP TABLE IF EXISTS `im_user_match`;
CREATE TABLE `im_user_match`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user1_id` bigint NOT NULL COMMENT '用户1的ID',
  `user2_id` bigint NOT NULL COMMENT '用户2的ID',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '匹配状态: 1-已匹配 2-已取消',
  `match_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '匹配时间',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_pair`(`user1_id`, `user2_id`) USING BTREE,
  INDEX `idx_user1_id`(`user1_id`) USING BTREE,
  INDEX `idx_user2_id`(`user2_id`) USING BTREE,
  INDEX `idx_match_time`(`match_time`) USING BTREE,
  INDEX `idx_user1_status`(`user1_id`, `status`) USING BTREE,
  INDEX `idx_user2_status`(`user2_id`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户匹配表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of im_user_match
-- ----------------------------

-- ----------------------------
-- Table structure for im_user_match_record
-- ----------------------------
DROP TABLE IF EXISTS `im_user_match_record`;
CREATE TABLE `im_user_match_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '操作用户ID',
  `target_user_id` bigint NOT NULL COMMENT '被浏览用户ID',
  `action_type` tinyint NOT NULL DEFAULT 0 COMMENT '操作类型: 0-仅浏览 1-喜欢 2-不喜欢',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_target`(`user_id`, `target_user_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_target_user_id`(`target_user_id`) USING BTREE,
  INDEX `idx_created_time`(`created_time`) USING BTREE,
  INDEX `idx_user_action_time`(`user_id`, `action_type`, `created_time`) USING BTREE,
  INDEX `idx_target_user`(`target_user_id`, `created_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户匹配记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of im_user_match_record
-- ----------------------------

-- ----------------------------
-- Table structure for im_user_recharge
-- ----------------------------
DROP TABLE IF EXISTS `im_user_recharge`;
CREATE TABLE `im_user_recharge`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `order_sn` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `amount` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '充值金额',
  `usdt_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT 'usdt金额',
  `tx_hash` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'hash',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态（ 1：待确认 2：已到账）',
  `from_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '转出地址',
  `to_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '转入地址',
  `notify_data` json NULL COMMENT '链上数据',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '凭证',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `version` int NULL DEFAULT 0 COMMENT '版本',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_tx_hash`(`tx_hash`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户充值记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_user_recharge
-- ----------------------------

-- ----------------------------
-- Table structure for im_user_withdrawal
-- ----------------------------
DROP TABLE IF EXISTS `im_user_withdrawal`;
CREATE TABLE `im_user_withdrawal`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `type` tinyint NOT NULL COMMENT '类型（1余额）',
  `order_sn` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '提现金额',
  `fee_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '手续费',
  `actual_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '实际到账金额',
  `tx_hash` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'hash',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态（1：待审核 2：待确认 3: 已到账 4: 未到账 5: 审核拒绝）',
  `from_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `notify_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '数据',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `version` int NULL DEFAULT 0 COMMENT '版本',
  `create_dept` bigint NULL DEFAULT NULL,
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户提现记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of im_user_withdrawal
-- ----------------------------
INSERT INTO `im_user_withdrawal` VALUES (28, 8, 1, 'TX1987493038642749440', 100.00, 0.00, 100.00, NULL, 5, '0x9791558F239057029b2c4D66310829C1F3832A59', NULL, NULL, '0', 0, NULL, NULL, '2025-11-09 20:10:41', 1, '2025-11-09 20:12:20');

-- ----------------------------
-- Table structure for red_detail
-- ----------------------------
DROP TABLE IF EXISTS `red_detail`;
CREATE TABLE `red_detail`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `record_id` int NOT NULL COMMENT '红包记录id',
  `amount` decimal(8, 2) NULL DEFAULT NULL COMMENT '金额(单位为分)',
  `is_active` tinyint NULL DEFAULT 1 COMMENT '是否有效',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 99 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '红包明细金额' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of red_detail
-- ----------------------------
INSERT INTO `red_detail` VALUES (83, 11, 1.00, 1, '1', NULL, NULL, '2025-09-30 16:40:01', 2, '2025-10-16 11:35:12');
INSERT INTO `red_detail` VALUES (84, 12, 0.48, 1, '0', NULL, NULL, '2025-09-30 21:59:04', NULL, NULL);
INSERT INTO `red_detail` VALUES (85, 12, 0.91, 1, '0', NULL, NULL, '2025-09-30 21:59:04', NULL, NULL);
INSERT INTO `red_detail` VALUES (86, 12, 0.22, 1, '0', NULL, NULL, '2025-09-30 21:59:04', NULL, NULL);
INSERT INTO `red_detail` VALUES (87, 12, 2.21, 1, '0', NULL, NULL, '2025-09-30 21:59:04', NULL, NULL);
INSERT INTO `red_detail` VALUES (88, 12, 1.01, 1, '0', NULL, NULL, '2025-09-30 21:59:04', NULL, NULL);
INSERT INTO `red_detail` VALUES (89, 12, 0.43, 1, '0', NULL, NULL, '2025-09-30 21:59:04', NULL, NULL);
INSERT INTO `red_detail` VALUES (90, 12, 1.50, 1, '0', NULL, NULL, '2025-09-30 21:59:04', NULL, NULL);
INSERT INTO `red_detail` VALUES (91, 12, 1.39, 1, '0', NULL, NULL, '2025-09-30 21:59:04', NULL, NULL);
INSERT INTO `red_detail` VALUES (92, 12, 0.52, 1, '0', NULL, NULL, '2025-09-30 21:59:04', NULL, NULL);
INSERT INTO `red_detail` VALUES (93, 12, 1.08, 1, '0', NULL, NULL, '2025-09-30 21:59:04', NULL, NULL);
INSERT INTO `red_detail` VALUES (94, 12, 1.25, 1, '0', NULL, NULL, '2025-09-30 21:59:04', NULL, NULL);
INSERT INTO `red_detail` VALUES (95, 13, 0.10, 1, '0', NULL, NULL, '2025-11-10 23:24:02', NULL, NULL);
INSERT INTO `red_detail` VALUES (96, 13, 0.55, 1, '0', NULL, NULL, '2025-11-10 23:24:02', NULL, NULL);
INSERT INTO `red_detail` VALUES (97, 13, 0.35, 1, '0', NULL, NULL, '2025-11-10 23:24:02', NULL, NULL);
INSERT INTO `red_detail` VALUES (98, 14, 10.00, 1, '0', NULL, NULL, '2025-11-10 23:24:59', NULL, NULL);

-- ----------------------------
-- Table structure for red_record
-- ----------------------------
DROP TABLE IF EXISTS `red_record`;
CREATE TABLE `red_record`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户id',
  `red_packet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '红包全局唯一标识串',
  `total` int NOT NULL COMMENT '人数',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '总金额(单位为分)',
  `is_active` tinyint NULL DEFAULT 1 COMMENT '是否有效',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '发红包记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of red_record
-- ----------------------------
INSERT INTO `red_record` VALUES (11, 7, 'redis:red:packet:7:694808452843736', 1, 1.00, 1, '0', NULL, NULL, '2025-09-30 16:40:01', NULL, NULL);
INSERT INTO `red_record` VALUES (12, 7, 'redis:red:packet:7:713951866107057', 11, 11.00, 1, '0', NULL, NULL, '2025-09-30 21:59:04', NULL, NULL);
INSERT INTO `red_record` VALUES (13, 8, 'redis:red:packet:8:2076356429063782', 3, 1.00, 1, '0', NULL, NULL, '2025-11-10 23:24:02', NULL, NULL);
INSERT INTO `red_record` VALUES (14, 8, 'redis:red:packet:8:2076414297607141', 1, 10.00, 1, '0', NULL, NULL, '2025-11-10 23:24:59', NULL, NULL);

-- ----------------------------
-- Table structure for red_rob_record
-- ----------------------------
DROP TABLE IF EXISTS `red_rob_record`;
CREATE TABLE `red_rob_record`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户账号',
  `red_packet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '红包标识串',
  `amount` decimal(8, 2) NULL DEFAULT NULL COMMENT '红包金额(单位为分)',
  `rob_time` datetime NULL DEFAULT NULL COMMENT '时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '抢红包记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of red_rob_record
-- ----------------------------
INSERT INTO `red_rob_record` VALUES (72, 7, 'redis:red:packet:7:694808452843736', 1.00, '2025-09-30 16:40:08', '0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `red_rob_record` VALUES (73, 7, 'redis:red:packet:7:713951866107057', 0.48, '2025-09-30 21:59:24', '0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `red_rob_record` VALUES (74, 8, 'redis:red:packet:8:2076356429063782', 0.10, '2025-11-10 23:24:08', '0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `red_rob_record` VALUES (75, 8, 'redis:red:packet:8:2076414297607141', 10.00, '2025-11-10 23:25:12', '0', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_client
-- ----------------------------
DROP TABLE IF EXISTS `sys_client`;
CREATE TABLE `sys_client`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `client_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端id',
  `client_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端key',
  `client_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端秘钥',
  `grant_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权类型',
  `device_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备类型',
  `active_timeout` int NULL DEFAULT 1800 COMMENT 'token活跃超时时间',
  `timeout` int NULL DEFAULT 604800 COMMENT 'token固定超时',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统授权表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_client
-- ----------------------------
INSERT INTO `sys_client` VALUES (1, 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', 1800, 604800, '0', '0', 103, 1, '2025-08-06 11:49:56', 1, '2025-08-06 11:49:56');
INSERT INTO `sys_client` VALUES (2, '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social', 'android', 1800, 604800, '0', '0', 103, 1, '2025-08-06 11:49:56', 1, '2025-08-06 11:49:56');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` bigint NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '000000', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '000000', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '000000', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (5, '000000', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '000000', '收款地址', 'bsc.toAddress', '0x9791558F239057029b2c4D66310829C1F3832A59', 'N', 100, 1, '2025-08-26 19:04:20', 1, '2025-11-09 20:07:58', '');
INSERT INTO `sys_config` VALUES (7, '000000', 'vip充值金额', 'biz.vip.amount', '100', 'N', 100, 1, '2025-08-26 19:05:28', 1, '2025-08-26 19:05:28', '');
INSERT INTO `sys_config` VALUES (8, '000000', 'vip建群数量', 'biz.create.group', '3', 'N', 100, 1, '2025-08-26 19:06:15', 1, '2025-08-26 19:06:15', '');
INSERT INTO `sys_config` VALUES (9, '000000', '提现手续费', 'biz.fee.ratio', '0', 'N', 100, 1, '2025-08-27 11:48:43', 1, '2025-08-27 11:48:43', '');
INSERT INTO `sys_config` VALUES (10, '000000', '最低提现金额', 'biz.min.withdraw.amount', '1', 'N', 100, 1, '2025-08-27 11:49:24', 1, '2025-08-27 11:49:24', '');
INSERT INTO `sys_config` VALUES (11, '000000', '客服欢迎语', 'biz.im.msg', '感谢使用wr-chat', 'N', 100, 1, '2025-09-01 11:47:45', 1, '2025-11-09 20:08:11', '用户注册后自动添加客服账号，发送的欢迎语');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `dept_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门类别编码',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` bigint NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, '000000', 0, '0', 'IM-CHAT', NULL, 0, 1, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2025-08-06 11:49:55', 1, '2025-10-01 22:44:55');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, '000000', 1, '男', '0', 'sys_user_sex', '', '', 'Y', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, '000000', 2, '女', '1', 'sys_user_sex', '', '', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, '000000', 3, '未知', '2', 'sys_user_sex', '', '', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, '000000', 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, '000000', 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, '000000', 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, '000000', 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (12, '000000', 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, '000000', 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, '000000', 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, '000000', 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, '000000', 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, '000000', 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, '000000', 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, '000000', 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, '000000', 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, '000000', 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, '000000', 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, '000000', 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, '000000', 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, '000000', 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, '000000', 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, '000000', 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, '000000', 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (29, '000000', 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (30, '000000', 0, '密码认证', 'password', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '密码认证');
INSERT INTO `sys_dict_data` VALUES (31, '000000', 0, '短信认证', 'sms', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '短信认证');
INSERT INTO `sys_dict_data` VALUES (32, '000000', 0, '邮件认证', 'email', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '邮件认证');
INSERT INTO `sys_dict_data` VALUES (33, '000000', 0, '小程序认证', 'xcx', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '小程序认证');
INSERT INTO `sys_dict_data` VALUES (34, '000000', 0, '三方登录认证', 'social', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '三方登录认证');
INSERT INTO `sys_dict_data` VALUES (35, '000000', 0, 'PC', 'pc', 'sys_device_type', '', 'default', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'PC');
INSERT INTO `sys_dict_data` VALUES (36, '000000', 0, '安卓', 'android', 'sys_device_type', '', 'default', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '安卓');
INSERT INTO `sys_dict_data` VALUES (37, '000000', 0, 'iOS', 'ios', 'sys_device_type', '', 'default', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'iOS');
INSERT INTO `sys_dict_data` VALUES (38, '000000', 0, '小程序', 'xcx', 'sys_device_type', '', 'default', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '小程序');
INSERT INTO `sys_dict_data` VALUES (39, '000000', 0, '否', 'false', 'im_bool', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (40, '000000', 0, '是', 'true', 'im_bool', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (41, '000000', 0, '正常', '0', 'im_user_status', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (42, '000000', 0, '已注销', '1', 'im_user_status', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (43, '000000', 1, '未发送', '0', 'im_message_status', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (44, '000000', 2, '送达', '1', 'im_message_status', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (45, '000000', 3, '撤回', '2', 'im_message_status', '', 'warning', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (46, '000000', 4, '已读', '3', 'im_message_status', '', 'success', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (47, '000000', 1, '文字', '0', 'im_message_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (48, '000000', 2, '图片', '1', 'im_message_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (49, '000000', 3, '文件', '2', 'im_message_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (50, '000000', 4, '语音', '3', 'im_message_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (51, '000000', 5, '视频', '4', 'im_message_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (52, '000000', 6, '文字提示', '21', 'im_message_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (53, '000000', 7, '语音通话', '40', 'im_message_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (54, '000000', 8, '视频通话', '41', 'im_message_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (55, '000000', 1, '富文本', '0', 'im_sm_content_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (56, '000000', 2, '外部链接', '1', 'im_sm_content_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (57, '000000', 1, '待发送', '1', 'im_sm_push_status', '', 'warn', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (58, '000000', 2, '发送中', '2', 'im_sm_push_status', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (59, '000000', 3, '已发送', '3', 'im_sm_push_status', '', 'success', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (60, '000000', 4, '已取消', '4', 'im_sm_push_status', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (61, '000000', 9, '消息撤回', '10', 'im_message_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (62, '000000', 1, '对我造成骚扰', '1', 'im_complaint_type', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (63, '000000', 2, '疑似诈骗', '2', 'im_complaint_type', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (64, '000000', 3, '传播不良内容', '3', 'im_complaint_type', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (65, '000000', 99, '其他不正规行为', '99', 'im_complaint_type', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (66, '000000', 1, '用户', '1', 'im_complaint_target_type', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (67, '000000', 2, '群', '2', 'im_complaint_target_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (68, '000000', 1, '未处理', '1', 'im_complaint_status', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (69, '000000', 2, '已处理', '2', 'im_complaint_status', '', 'success', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (70, '000000', 1, '情况已核实,已处理', '1', 'im_resolved_type', '', 'success', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (71, '000000', 2, '证据不充分,不予处理', '2', 'im_resolved_type', '', 'danger', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (72, '000000', 3, '投诉内容未涉及不正规行为', '3', 'im_resolved_type', '', 'info', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (73, '000000', 99, '其他情况', '99', 'im_resolved_type', '', 'warning', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (74, '000000', 9, '个人名片', '5', 'im_message_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (75, '000000', 10, '群名片', '6', 'im_message_type', '', 'primary', 'N', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_dict_data` VALUES (76, '000000', 0, 'usdt', '1', 'biz_fund_type', '', 'success', 'N', 100, 1, '2025-08-26 19:10:09', 1, '2025-08-26 19:10:09', '');
INSERT INTO `sys_dict_data` VALUES (77, '000000', 1, '转入', '1', 'biz_transfer_flag', '', 'success', 'N', 100, 1, '2025-08-26 19:11:27', 1, '2025-08-26 19:11:27', '');
INSERT INTO `sys_dict_data` VALUES (78, '000000', 2, '转出', '-1', 'biz_transfer_flag', '', 'danger', 'N', 100, 1, '2025-08-26 19:12:07', 1, '2025-08-26 19:12:07', '');
INSERT INTO `sys_dict_data` VALUES (79, '000000', 1, '待确认', '1', 'biz_recharge_status', '', 'warning', 'N', 100, 1, '2025-08-27 11:21:39', 1, '2025-08-27 11:21:39', '');
INSERT INTO `sys_dict_data` VALUES (80, '000000', 2, '已到账', '2', 'biz_recharge_status', '', 'success', 'N', 100, 1, '2025-08-27 11:21:55', 1, '2025-08-27 11:21:55', '');
INSERT INTO `sys_dict_data` VALUES (81, '000000', 1, '待审核', '1', 'biz_withdraw_status', '', 'primary', 'N', 100, 1, '2025-08-27 11:22:44', 1, '2025-08-27 11:22:44', '');
INSERT INTO `sys_dict_data` VALUES (82, '000000', 2, '待确认', '2', 'biz_withdraw_status', '', 'warning', 'N', 100, 1, '2025-08-27 11:23:09', 1, '2025-08-27 11:23:09', '');
INSERT INTO `sys_dict_data` VALUES (83, '000000', 3, '已到账', '3', 'biz_withdraw_status', '', 'success', 'N', 100, 1, '2025-08-27 11:23:23', 1, '2025-08-27 11:23:23', '');
INSERT INTO `sys_dict_data` VALUES (84, '000000', 4, '未到账', '4', 'biz_withdraw_status', '', 'info', 'N', 100, 1, '2025-08-27 11:23:44', 1, '2025-08-27 11:23:44', '');
INSERT INTO `sys_dict_data` VALUES (85, '000000', 5, '审核拒绝', '5', 'biz_withdraw_status', '', 'danger', 'N', 100, 1, '2025-08-27 11:24:02', 1, '2025-08-27 11:24:02', '');
INSERT INTO `sys_dict_data` VALUES (86, '000000', 1, '普通用户', '1', 'im_user_type', '', 'primary', 'N', 100, 1, '2025-09-01 11:22:53', 1, '2025-09-01 11:22:53', '');
INSERT INTO `sys_dict_data` VALUES (87, '000000', 3, 'vip', '3', 'im_user_type', '', 'success', 'N', 100, 1, '2025-09-01 11:23:07', 1, '2025-09-01 11:23:07', '');
INSERT INTO `sys_dict_data` VALUES (88, '000000', 4, '客服', '4', 'im_user_type', '', 'danger', 'N', 100, 1, '2025-09-01 11:23:21', 1, '2025-09-01 11:23:21', '');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `tenant_id`(`tenant_id`, `dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '000000', '用户性别', 'sys_user_sex', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '000000', '菜单状态', 'sys_show_hide', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '000000', '系统开关', 'sys_normal_disable', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (6, '000000', '系统是否', 'sys_yes_no', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '000000', '通知类型', 'sys_notice_type', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '000000', '通知状态', 'sys_notice_status', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '000000', '操作类型', 'sys_oper_type', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '000000', '系统状态', 'sys_common_status', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (11, '000000', '授权类型', 'sys_grant_type', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '认证授权类型');
INSERT INTO `sys_dict_type` VALUES (12, '000000', '设备类型', 'sys_device_type', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '客户端设备类型');
INSERT INTO `sys_dict_type` VALUES (13, '000000', '布尔值', 'im_bool', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '布尔值, true 或 false');
INSERT INTO `sys_dict_type` VALUES (14, '000000', '用户状态', 'im_user_status', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM用户状态');
INSERT INTO `sys_dict_type` VALUES (15, '000000', '消息状态', 'im_message_status', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM消息状态');
INSERT INTO `sys_dict_type` VALUES (16, '000000', '消息类型', 'im_message_type', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM消息类型');
INSERT INTO `sys_dict_type` VALUES (17, '000000', '系统消息内容类型', 'im_sm_content_type', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM系统消息内容类型');
INSERT INTO `sys_dict_type` VALUES (18, '000000', '系统消息推送状态', 'im_sm_push_status', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM系统消息推送状态');
INSERT INTO `sys_dict_type` VALUES (19, '000000', '投诉原因', 'im_complaint_type', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM投诉原因');
INSERT INTO `sys_dict_type` VALUES (20, '000000', '投诉对象类型', 'im_complaint_target_type', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM投诉对象类型');
INSERT INTO `sys_dict_type` VALUES (21, '000000', '投诉状态', 'im_complaint_status', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM投诉状态');
INSERT INTO `sys_dict_type` VALUES (22, '000000', '投诉处理结果', 'im_resolved_type', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM投诉处理结果');
INSERT INTO `sys_dict_type` VALUES (23, '000000', '资产类型', 'biz_fund_type', 100, 1, '2025-08-26 19:09:29', 1, '2025-08-26 19:09:29', '');
INSERT INTO `sys_dict_type` VALUES (24, '000000', '转入转出', 'biz_transfer_flag', 100, 1, '2025-08-26 19:10:50', 1, '2025-08-26 19:10:50', '');
INSERT INTO `sys_dict_type` VALUES (25, '000000', '充值状态', 'biz_recharge_status', 100, 1, '2025-08-27 11:20:46', 1, '2025-08-27 11:20:46', '');
INSERT INTO `sys_dict_type` VALUES (26, '000000', '提现状态', 'biz_withdraw_status', 100, 1, '2025-08-27 11:21:10', 1, '2025-08-27 11:21:10', '');
INSERT INTO `sys_dict_type` VALUES (27, '000000', '账户类型', 'im_user_type', 100, 1, '2025-09-01 11:22:15', 1, '2025-09-01 11:22:15', '');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `client_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '客户端',
  `device_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '设备类型',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (77, '000000', 'admin', 'pc', 'pc', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-10-01 22:46:38');
INSERT INTO `sys_logininfor` VALUES (78, '000000', 'admin', 'pc', 'pc', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-10-01 22:48:35');
INSERT INTO `sys_logininfor` VALUES (79, '000000', 'admin', 'pc', 'pc', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-10-01 22:48:38');
INSERT INTO `sys_logininfor` VALUES (80, '000000', 'admin', 'pc', 'pc', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', 'Exit successful', '2025-10-01 23:06:52');
INSERT INTO `sys_logininfor` VALUES (81, '000000', 'admin', 'pc', 'pc', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2025-10-01 23:06:56');
INSERT INTO `sys_logininfor` VALUES (82, '000000', 'admin', 'pc', 'pc', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', 'Exit successful', '2025-10-01 23:12:43');
INSERT INTO `sys_logininfor` VALUES (83, '000000', 'imdemo', 'pc', 'pc', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2025-10-01 23:12:47');
INSERT INTO `sys_logininfor` VALUES (84, '000000', 'imdemo', 'pc', 'pc', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2025-10-02 12:18:05');
INSERT INTO `sys_logininfor` VALUES (85, '000000', 'admin', 'pc', 'pc', '61.145.124.44', '中国|广东省|广州市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '1', 'Password input error 1 times', '2025-10-02 18:58:54');
INSERT INTO `sys_logininfor` VALUES (86, '000000', 'admin', 'pc', 'pc', '61.145.124.44', '中国|广东省|广州市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '1', 'Password input error 2 times', '2025-10-02 18:59:01');
INSERT INTO `sys_logininfor` VALUES (87, '000000', 'imdemo', 'pc', 'pc', '2409:8a38:4888:ff40:d55f:ff4:adf8:367a', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2025-10-16 11:34:17');
INSERT INTO `sys_logininfor` VALUES (88, '000000', 'imdemo', 'pc', 'pc', '2409:8a38:4888:ff40:d55f:ff4:adf8:367a', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2025-10-16 15:10:26');
INSERT INTO `sys_logininfor` VALUES (89, '000000', 'imdemo', 'pc', 'pc', '2409:8a38:4888:ff40:cda6:20c8:6349:299b', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2025-11-01 16:52:25');
INSERT INTO `sys_logininfor` VALUES (90, '000000', 'imdemo', 'pc', 'pc', '2409:8a38:4888:ff40:cda6:20c8:6349:299b', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2025-11-04 15:30:05');
INSERT INTO `sys_logininfor` VALUES (91, '000000', 'admin', 'pc', 'pc', '2409:8a38:4888:ff40:981f:b4e1:8a51:58d1', 'XX XX', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2025-11-09 20:01:56');
INSERT INTO `sys_logininfor` VALUES (92, '000000', 'admin', 'pc', 'pc', '2408:824c:4810:5130:440f:ee7a:85b8:e3a5', 'XX XX', 'Chrome', 'OSX', '1', 'Password input error 1 times', '2025-11-09 21:12:08');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query_param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '显示状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1960544573268082696 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 110, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 103, 1, '2025-08-06 11:49:55', 1, '2025-08-27 11:14:13', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 130, 'monitor', NULL, '', 1, 0, 'M', '1', '1', '', 'monitor', 103, 1, '2025-08-06 11:49:55', 1, '2025-08-27 11:13:51', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 140, 'tool', NULL, '', 1, 0, 'M', '1', '1', '', 'tool', 103, 1, '2025-08-06 11:49:55', 1, '2025-08-27 11:30:03', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '用户列表', 1960299676476825608, 1, 'im/user', 'im/user/index', '', 1, 0, 'C', '0', '0', 'im:user:list', 'user', 103, 1, '2025-08-06 11:49:55', 1, '2025-08-27 11:06:37', 'IM用户管理');
INSERT INTO `sys_menu` VALUES (5, '群聊管理', 0, 20, 'im/group', 'im/group/index', '', 1, 0, 'C', '0', '0', 'im:group:list', 'peoples', 103, 1, '2025-08-06 11:49:55', 1, '2025-08-27 11:15:53', 'IM群聊管理');
INSERT INTO `sys_menu` VALUES (6, '消息管理', 0, 30, 'message', NULL, '', 1, 0, 'M', '0', '0', '', 'message', 103, 1, '2025-08-06 11:49:55', 1, '2025-08-27 11:15:04', 'IM消息管理');
INSERT INTO `sys_menu` VALUES (7, '敏感词管理', 0, 22, 'im/sensitiveWord', 'im/sensitiveWord/index', '', 1, 0, 'C', '0', '0', 'im:sensitiveWord:list', 'documentation', 103, 1, '2025-08-06 11:49:55', 1, '2025-08-27 11:16:19', 'IM敏感词管理');
INSERT INTO `sys_menu` VALUES (8, '用户投诉', 0, 40, 'im/complaint', 'im/complaint/index', '', 1, 0, 'C', '0', '0', 'im:complaint:list', 'documentation', 103, 1, '2025-08-06 11:49:55', 1, '2025-08-27 11:14:43', 'IM用户投诉');
INSERT INTO `sys_menu` VALUES (60, '私聊消息', 6, 1, 'private', 'im/message/private/index', '', 1, 0, 'C', '0', '0', 'im:privateMessage:list', 'education', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM私聊消息');
INSERT INTO `sys_menu` VALUES (61, '群聊消息', 6, 2, 'group', 'im/message/group/index', '', 1, 0, 'C', '0', '0', 'im:groupMessage:list', 'category', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM群聊消息');
INSERT INTO `sys_menu` VALUES (62, '系统消息', 6, 4, 'system', 'im/message/system/index', '', 1, 0, 'C', '0', '0', 'im:systemMessage:list', 'druid', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM系统消息');
INSERT INTO `sys_menu` VALUES (63, '推送任务', 6, 4, 'task', 'im/message/task/index', '', 1, 0, 'C', '0', '0', 'im:smPushTask:list', 'my-task', 103, 1, '2025-08-06 11:49:55', NULL, NULL, 'IM推送任务');
INSERT INTO `sys_menu` VALUES (100, '系统用户', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (123, '客户端管理', 1, 11, 'client', 'system/client/index', '', 1, 0, 'C', '0', '0', 'system:client:list', 'international', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '客户端管理菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1061, '客户端管理查询', 123, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1062, '客户端管理新增', 123, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:add', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1063, '客户端管理修改', 123, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1064, '客户端管理删除', 123, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1065, '客户端管理导出', 123, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:export', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (4001, '用户查询', 4, 1, '#', '', '', 1, 0, 'F', '0', '0', 'im:user:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (4002, '用户封禁', 4, 2, '#', '', '', 1, 0, 'F', '0', '0', 'im:user:ban', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (4003, '用户导出', 4, 3, '#', '', '', 1, 0, 'F', '0', '0', 'im:user:export', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (5001, '群聊查询', 5, 1, '#', '', '', 1, 0, 'F', '0', '0', 'im:group:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (5002, '群聊封禁', 5, 2, '#', '', '', 1, 0, 'F', '0', '0', 'im:group:ban', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (5003, '群聊导出', 5, 3, '#', '', '', 1, 0, 'F', '0', '0', 'im:group:export', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (5004, '群聊成员', 5, 4, '#', '', '', 1, 0, 'F', '0', '0', 'im:group:member', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (6001, '私聊消息查询', 60, 1, '#', '', '', 1, 0, 'F', '0', '0', 'im:privateMessage:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (6101, '群聊消息查询', 61, 1, '#', '', '', 1, 0, 'F', '0', '0', 'im:groupMessage:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (6201, '系统消息查询', 62, 1, '#', '', '', 1, 0, 'F', '0', '0', 'im:systemMessage:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (6202, '系统消息添加', 62, 2, '#', '', '', 1, 0, 'F', '0', '0', 'im:systemMessage:add', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (6203, '系统消息删除', 62, 3, '#', '', '', 1, 0, 'F', '0', '0', 'im:systemMessage:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (6204, '系统消息修改', 62, 4, '#', '', '', 1, 0, 'F', '0', '0', 'im:systemMessage:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (6301, '推送任务查询', 63, 1, '#', '', '', 1, 0, 'F', '0', '0', 'im:smPushTask:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (6302, '推送任务添加', 63, 2, '#', '', '', 1, 0, 'F', '0', '0', 'im:smPushTask:add', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (6303, '推送任务删除', 63, 3, '#', '', '', 1, 0, 'F', '0', '0', 'im:smPushTask:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (6304, '推送任务修改', 63, 3, '#', '', '', 1, 0, 'F', '0', '0', 'im:smPushTask:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (7001, '敏感词查询', 7, 1, '#', '', '', 1, 0, 'F', '0', '0', 'im:sensitiveWord:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (7002, '敏感词添加', 7, 2, '#', '', '', 1, 0, 'F', '0', '0', 'im:sensitiveWord:add', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (7003, '敏感词删除', 7, 3, '#', '', '', 1, 0, 'F', '0', '0', 'im:sensitiveWord:remove', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (7004, '敏感词修改', 7, 4, '#', '', '', 1, 0, 'F', '0', '0', 'im:sensitiveWord:edit', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (7005, '敏感词导出', 7, 5, '#', '', '', 1, 0, 'F', '0', '0', 'im:sensitiveWord:export', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (8001, '用户投诉查询', 8, 1, '#', '', '', 1, 0, 'F', '0', '0', 'im:complaint:query', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (8002, '用户投诉处理', 8, 2, '#', '', '', 1, 0, 'F', '0', '0', 'im:complaint:resolve', '#', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299670218924034, '用户资产明细', 1960299676476825608, 2, 'userFundDetail', 'im/userFundDetail/index', NULL, 1, 0, 'C', '0', '0', 'im:userFundDetail:list', 'list', 103, 1, '2025-08-26 19:20:49', 1, '2025-08-27 11:34:00', '用户资产明细菜单');
INSERT INTO `sys_menu` VALUES (1960299670218924035, '用户资产明细查询', 1960299670218924034, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userFundDetail:query', '#', 103, 1, '2025-08-26 19:20:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299670218924036, '用户资产明细新增', 1960299670218924034, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userFundDetail:add', '#', 103, 1, '2025-08-26 19:20:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299670218924037, '用户资产明细修改', 1960299670218924034, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userFundDetail:edit', '#', 103, 1, '2025-08-26 19:20:50', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299670218924038, '用户资产明细删除', 1960299670218924034, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userFundDetail:remove', '#', 103, 1, '2025-08-26 19:20:50', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299670218924039, '用户资产明细导出', 1960299670218924034, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userFundDetail:export', '#', 103, 1, '2025-08-26 19:20:50', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299672722923521, '红包明细金额', 1960299676476825607, 1, 'detail', 'im/detail/index', NULL, 1, 0, 'C', '0', '0', 'im:detail:list', '#', 103, 1, '2025-08-26 19:20:10', 1, '2025-08-27 11:03:34', '红包明细金额菜单');
INSERT INTO `sys_menu` VALUES (1960299672722923522, '红包明细金额查询', 1960299672722923521, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:detail:query', '#', 103, 1, '2025-08-26 19:20:10', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299672722923523, '红包明细金额新增', 1960299672722923521, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:detail:add', '#', 103, 1, '2025-08-26 19:20:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299672722923524, '红包明细金额修改', 1960299672722923521, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:detail:edit', '#', 103, 1, '2025-08-26 19:20:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299672722923525, '红包明细金额删除', 1960299672722923521, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:detail:remove', '#', 103, 1, '2025-08-26 19:20:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299672722923526, '红包明细金额导出', 1960299672722923521, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:detail:export', '#', 103, 1, '2025-08-26 19:20:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299674350313473, '发红包记录', 1960299676476825607, 1, 'record', 'im/record/index', NULL, 1, 0, 'C', '0', '0', 'im:record:list', '#', 103, 1, '2025-08-26 19:20:20', 1, '2025-08-27 11:03:59', '发红包记录菜单');
INSERT INTO `sys_menu` VALUES (1960299674350313474, '发红包记录查询', 1960299674350313473, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:record:query', '#', 103, 1, '2025-08-26 19:20:21', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299674350313475, '发红包记录新增', 1960299674350313473, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:record:add', '#', 103, 1, '2025-08-26 19:20:21', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299674350313476, '发红包记录修改', 1960299674350313473, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:record:edit', '#', 103, 1, '2025-08-26 19:20:21', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299674350313477, '发红包记录删除', 1960299674350313473, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:record:remove', '#', 103, 1, '2025-08-26 19:20:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299674350313478, '发红包记录导出', 1960299674350313473, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:record:export', '#', 103, 1, '2025-08-26 19:20:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299676476825601, '抢红包记录', 1960299676476825607, 1, 'robRecord', 'im/robRecord/index', NULL, 1, 0, 'C', '0', '0', 'im:robRecord:list', '#', 103, 1, '2025-08-26 19:20:40', 1, '2025-08-27 11:04:44', '抢红包记录菜单');
INSERT INTO `sys_menu` VALUES (1960299676476825602, '抢红包记录查询', 1960299676476825601, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:robRecord:query', '#', 103, 1, '2025-08-26 19:20:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299676476825603, '抢红包记录新增', 1960299676476825601, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:robRecord:add', '#', 103, 1, '2025-08-26 19:20:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299676476825604, '抢红包记录修改', 1960299676476825601, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:robRecord:edit', '#', 103, 1, '2025-08-26 19:20:41', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299676476825605, '抢红包记录删除', 1960299676476825601, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:robRecord:remove', '#', 103, 1, '2025-08-26 19:20:41', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299676476825606, '抢红包记录导出', 1960299676476825601, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:robRecord:export', '#', 103, 1, '2025-08-26 19:20:41', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960299676476825607, '红包管理', 0, 2, 'red', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'email', 100, 1, '2025-08-27 11:02:57', 1, '2025-08-27 11:02:57', '');
INSERT INTO `sys_menu` VALUES (1960299676476825608, '用户管理', 0, 1, 'imUser', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'people', 100, 1, '2025-08-27 11:06:09', 1, '2025-08-27 11:06:09', '');
INSERT INTO `sys_menu` VALUES (1960544571196096513, '用户充值记录', 1960299676476825608, 3, 'userRecharge', 'im/userRecharge/index', NULL, 1, 0, 'C', '0', '0', 'im:userRecharge:list', 'caret-forward', 103, 1, '2025-08-27 11:28:17', 1, '2025-08-27 11:33:36', '用户充值记录菜单');
INSERT INTO `sys_menu` VALUES (1960544571196096514, '用户充值记录查询', 1960544571196096513, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userRecharge:query', '#', 103, 1, '2025-08-27 11:28:17', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960544571196096515, '用户充值记录新增', 1960544571196096513, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userRecharge:add', '#', 103, 1, '2025-08-27 11:28:17', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960544571196096516, '用户充值记录修改', 1960544571196096513, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userRecharge:edit', '#', 103, 1, '2025-08-27 11:28:18', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960544571196096517, '用户充值记录删除', 1960544571196096513, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userRecharge:remove', '#', 103, 1, '2025-08-27 11:28:18', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960544571196096518, '用户充值记录导出', 1960544571196096513, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userRecharge:export', '#', 103, 1, '2025-08-27 11:28:18', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960544573268082690, '用户提现记录', 1960299676476825608, 4, 'userWithdrawal', 'im/userWithdrawal/index', NULL, 1, 0, 'C', '0', '0', 'im:userWithdrawal:list', 'caret-back', 103, 1, '2025-08-27 11:28:28', 1, '2025-08-27 11:33:10', '用户提现记录菜单');
INSERT INTO `sys_menu` VALUES (1960544573268082691, '用户提现记录查询', 1960544573268082690, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userWithdrawal:query', '#', 103, 1, '2025-08-27 11:28:28', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960544573268082692, '用户提现记录新增', 1960544573268082690, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userWithdrawal:add', '#', 103, 1, '2025-08-27 11:28:28', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960544573268082693, '用户提现记录修改', 1960544573268082690, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userWithdrawal:edit', '#', 103, 1, '2025-08-27 11:28:28', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960544573268082694, '用户提现记录删除', 1960544573268082690, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userWithdrawal:remove', '#', 103, 1, '2025-08-27 11:28:29', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1960544573268082695, '用户提现记录导出', 1960544573268082690, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'im:userWithdrawal:export', '#', 103, 1, '2025-08-27 11:28:29', NULL, NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` bigint NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '000000', '1', '1', 0x3C703E3131313C696D67207372633D2268747470733A2F2F6C6F63616C38306D696E696F2E677A777278786B6A2E636F6D2F626F782D696D2F696D6167652F32303235303932392F313735393133343636383930352E706E672220616C743D2265336238326232633230303264373130356430613261656436623536663836632E706E672220646174612D687265663D2222207374796C653D22222F3E3C2F703E, '0', 100, 1, '2025-09-29 16:31:11', 1, '2025-09-29 16:31:11', '');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (96, '000000', '操作日志', 9, 'org.dromara.system.controller.monitor.SysOperlogController.clean()', 'DELETE', 1, 'admin', 'IM-CHAT', '/chat/monitor/operlog/clean', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-10-01 22:46:11', 39);
INSERT INTO `sys_oper_log` VALUES (97, '000000', '登录日志', 9, 'org.dromara.system.controller.monitor.SysLogininforController.clean()', 'DELETE', 1, 'admin', 'IM-CHAT', '/chat/monitor/logininfor/clean', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-10-01 22:46:14', 36);
INSERT INTO `sys_oper_log` VALUES (98, '000000', '个人信息', 2, 'org.dromara.system.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', 'IM-CHAT', '/chat/system/user/profile/updatePwd', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', '{}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-10-01 23:09:00', 205);
INSERT INTO `sys_oper_log` VALUES (99, '000000', '角色管理', 1, 'org.dromara.system.controller.system.SysRoleController.add()', 'POST', 1, 'admin', 'IM-CHAT', '/chat/system/role', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":2,\"roleName\":\"imdemo演示\",\"roleKey\":\"imdemo\",\"roleSort\":1,\"dataScope\":\"1\",\"menuCheckStrictly\":true,\"deptCheckStrictly\":true,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[6,62,63,1,100,101,102,103,104,105,106,107,108,500,501,123,\"1960299676476825608\",4,4001,4002,4003,\"1960299670218924034\",\"1960299670218924035\",\"1960299670218924036\",\"1960299670218924037\",\"1960299670218924038\",\"1960299670218924039\",\"1960544571196096513\",\"1960544571196096514\",\"1960544571196096515\",\"1960544571196096516\",\"1960544571196096517\",\"1960544571196096518\",\"1960544573268082690\",\"1960544573268082691\",\"1960544573268082692\",\"1960544573268082693\",\"1960544573268082694\",\"1960544573268082695\",\"1960299676476825607\",\"1960299672722923521\",\"1960299672722923522\",\"1960299672722923523\",\"1960299672722923524\",\"1960299672722923525\",\"1960299672722923526\",\"1960299674350313473\",\"1960299674350313474\",\"1960299674350313475\",\"1960299674350313476\",\"1960299674350313477\",\"1960299674350313478\",\"1960299676476825601\",\"1960299676476825602\",\"1960299676476825603\",\"1960299676476825604\",\"1960299676476825605\",\"1960299676476825606\",5,5001,5002,5003,5004,7,7001,7002,7003,7004,7005,60,6001,61,6101,6201,6301,8,8001,8002,1001,1008,1013,1017,1021,1026,1031,1036,1040,1043,1061],\"deptIds\":[],\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-10-01 23:12:15', 80);
INSERT INTO `sys_oper_log` VALUES (100, '000000', '用户管理', 1, 'org.dromara.system.controller.system.SysUserController.add()', 'POST', 1, 'admin', 'IM-CHAT', '/chat/system/user', '2408:824c:4810:9b60:e5f5:e104:2b44:57b', 'XX XX', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":2,\"deptId\":100,\"userName\":\"imdemo\",\"nickName\":\"imdemo\",\"userType\":null,\"email\":null,\"phonenumber\":null,\"sex\":null,\"status\":\"0\",\"remark\":\"\",\"roleIds\":[2],\"postIds\":[],\"roleId\":null,\"excludeUserIds\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-10-01 23:12:33', 100);
INSERT INTO `sys_oper_log` VALUES (101, '000000', '红包明细金额', 3, 'org.dromara.im.controller.RedDetailController.remove()', 'DELETE', 1, 'imdemo', 'IM-CHAT', '/chat/im/detail/83', '2409:8a38:4888:ff40:d55f:ff4:adf8:367a', 'XX XX', '[83]', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-10-16 11:35:12', 25);
INSERT INTO `sys_oper_log` VALUES (102, '000000', '参数管理', 2, 'org.dromara.system.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', 'IM-CHAT', '/chat/system/config', '2409:8a38:4888:ff40:981f:b4e1:8a51:58d1', 'XX XX', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-08-26 19:04:20\",\"updateBy\":null,\"updateTime\":null,\"configId\":6,\"configName\":\"收款地址\",\"configKey\":\"bsc.toAddress\",\"configValue\":\"0x9791558F239057029b2c4D66310829C1F3832A59\",\"configType\":\"N\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-11-09 20:07:58', 168);
INSERT INTO `sys_oper_log` VALUES (103, '000000', '参数管理', 2, 'org.dromara.system.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', 'IM-CHAT', '/chat/system/config', '2409:8a38:4888:ff40:981f:b4e1:8a51:58d1', 'XX XX', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-09-01 11:47:45\",\"updateBy\":null,\"updateTime\":null,\"configId\":11,\"configName\":\"客服欢迎语\",\"configKey\":\"biz.im.msg\",\"configValue\":\"感谢使用wr-chat\",\"configType\":\"N\",\"remark\":\"用户注册后自动添加客服账号，发送的欢迎语\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-11-09 20:08:11', 11);
INSERT INTO `sys_oper_log` VALUES (104, '000000', '用户提现记录', 2, 'org.dromara.im.controller.ImUserWithdrawalController.edit()', 'PUT', 1, 'admin', 'IM-CHAT', '/chat/im/userWithdrawal', '2409:8a38:4888:ff40:981f:b4e1:8a51:58d1', 'XX XX', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-11-09 20:10:41\",\"updateBy\":null,\"updateTime\":\"2025-11-09 20:10:41\",\"id\":28,\"userId\":8,\"type\":1,\"orderSn\":\"TX1987493038642749440\",\"amount\":\"100.00\",\"feeAmount\":\"0.00\",\"actualAmount\":\"100.00\",\"txHash\":null,\"status\":1,\"fromAddress\":\"0x9791558F239057029b2c4D66310829C1F3832A59\",\"notifyData\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-11-09 20:11:24', 14);
INSERT INTO `sys_oper_log` VALUES (105, '000000', '用户提现记录', 2, 'org.dromara.im.controller.ImUserWithdrawalController.edit()', 'PUT', 1, 'admin', 'IM-CHAT', '/chat/im/userWithdrawal', '2409:8a38:4888:ff40:981f:b4e1:8a51:58d1', 'XX XX', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-11-09 20:10:41\",\"updateBy\":null,\"updateTime\":\"2025-11-09 20:11:24\",\"id\":28,\"userId\":8,\"type\":1,\"orderSn\":\"TX1987493038642749440\",\"amount\":\"100.00\",\"feeAmount\":\"0.00\",\"actualAmount\":\"100.00\",\"txHash\":null,\"status\":1,\"fromAddress\":\"0x9791558F239057029b2c4D66310829C1F3832A59\",\"notifyData\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-11-09 20:11:53', 27);
INSERT INTO `sys_oper_log` VALUES (106, '000000', '用户提现记录', 2, 'org.dromara.im.controller.ImUserWithdrawalController.edit()', 'PUT', 1, 'admin', 'IM-CHAT', '/chat/im/userWithdrawal', '2409:8a38:4888:ff40:981f:b4e1:8a51:58d1', 'XX XX', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":28,\"userId\":null,\"type\":1,\"orderSn\":null,\"amount\":\"100.00\",\"feeAmount\":null,\"actualAmount\":null,\"txHash\":null,\"status\":5,\"fromAddress\":null,\"notifyData\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-11-09 20:12:20', 22);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '岗位类别编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '000000', '超级管理员', 'superadmin', 1, '1', 1, 1, '0', '0', 103, 1, '2025-08-06 11:49:55', NULL, NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '000000', 'imdemo演示', 'imdemo', 1, '1', 1, 1, '0', '0', 100, 1, '2025-10-01 23:12:15', 1, '2025-10-01 23:12:15', '');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 5);
INSERT INTO `sys_role_menu` VALUES (2, 6);
INSERT INTO `sys_role_menu` VALUES (2, 7);
INSERT INTO `sys_role_menu` VALUES (2, 8);
INSERT INTO `sys_role_menu` VALUES (2, 60);
INSERT INTO `sys_role_menu` VALUES (2, 61);
INSERT INTO `sys_role_menu` VALUES (2, 62);
INSERT INTO `sys_role_menu` VALUES (2, 63);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 123);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1061);
INSERT INTO `sys_role_menu` VALUES (2, 4001);
INSERT INTO `sys_role_menu` VALUES (2, 4002);
INSERT INTO `sys_role_menu` VALUES (2, 4003);
INSERT INTO `sys_role_menu` VALUES (2, 5001);
INSERT INTO `sys_role_menu` VALUES (2, 5002);
INSERT INTO `sys_role_menu` VALUES (2, 5003);
INSERT INTO `sys_role_menu` VALUES (2, 5004);
INSERT INTO `sys_role_menu` VALUES (2, 6001);
INSERT INTO `sys_role_menu` VALUES (2, 6101);
INSERT INTO `sys_role_menu` VALUES (2, 6201);
INSERT INTO `sys_role_menu` VALUES (2, 6301);
INSERT INTO `sys_role_menu` VALUES (2, 7001);
INSERT INTO `sys_role_menu` VALUES (2, 7002);
INSERT INTO `sys_role_menu` VALUES (2, 7003);
INSERT INTO `sys_role_menu` VALUES (2, 7004);
INSERT INTO `sys_role_menu` VALUES (2, 7005);
INSERT INTO `sys_role_menu` VALUES (2, 8001);
INSERT INTO `sys_role_menu` VALUES (2, 8002);
INSERT INTO `sys_role_menu` VALUES (2, 1960299670218924034);
INSERT INTO `sys_role_menu` VALUES (2, 1960299670218924035);
INSERT INTO `sys_role_menu` VALUES (2, 1960299670218924036);
INSERT INTO `sys_role_menu` VALUES (2, 1960299670218924037);
INSERT INTO `sys_role_menu` VALUES (2, 1960299670218924038);
INSERT INTO `sys_role_menu` VALUES (2, 1960299670218924039);
INSERT INTO `sys_role_menu` VALUES (2, 1960299672722923521);
INSERT INTO `sys_role_menu` VALUES (2, 1960299672722923522);
INSERT INTO `sys_role_menu` VALUES (2, 1960299672722923523);
INSERT INTO `sys_role_menu` VALUES (2, 1960299672722923524);
INSERT INTO `sys_role_menu` VALUES (2, 1960299672722923525);
INSERT INTO `sys_role_menu` VALUES (2, 1960299672722923526);
INSERT INTO `sys_role_menu` VALUES (2, 1960299674350313473);
INSERT INTO `sys_role_menu` VALUES (2, 1960299674350313474);
INSERT INTO `sys_role_menu` VALUES (2, 1960299674350313475);
INSERT INTO `sys_role_menu` VALUES (2, 1960299674350313476);
INSERT INTO `sys_role_menu` VALUES (2, 1960299674350313477);
INSERT INTO `sys_role_menu` VALUES (2, 1960299674350313478);
INSERT INTO `sys_role_menu` VALUES (2, 1960299676476825601);
INSERT INTO `sys_role_menu` VALUES (2, 1960299676476825602);
INSERT INTO `sys_role_menu` VALUES (2, 1960299676476825603);
INSERT INTO `sys_role_menu` VALUES (2, 1960299676476825604);
INSERT INTO `sys_role_menu` VALUES (2, 1960299676476825605);
INSERT INTO `sys_role_menu` VALUES (2, 1960299676476825606);
INSERT INTO `sys_role_menu` VALUES (2, 1960299676476825607);
INSERT INTO `sys_role_menu` VALUES (2, 1960299676476825608);
INSERT INTO `sys_role_menu` VALUES (2, 1960544571196096513);
INSERT INTO `sys_role_menu` VALUES (2, 1960544571196096514);
INSERT INTO `sys_role_menu` VALUES (2, 1960544571196096515);
INSERT INTO `sys_role_menu` VALUES (2, 1960544571196096516);
INSERT INTO `sys_role_menu` VALUES (2, 1960544571196096517);
INSERT INTO `sys_role_menu` VALUES (2, 1960544571196096518);
INSERT INTO `sys_role_menu` VALUES (2, 1960544573268082690);
INSERT INTO `sys_role_menu` VALUES (2, 1960544573268082691);
INSERT INTO `sys_role_menu` VALUES (2, 1960544573268082692);
INSERT INTO `sys_role_menu` VALUES (2, 1960544573268082693);
INSERT INTO `sys_role_menu` VALUES (2, 1960544573268082694);
INSERT INTO `sys_role_menu` VALUES (2, 1960544573268082695);

-- ----------------------------
-- Table structure for sys_social
-- ----------------------------
DROP TABLE IF EXISTS `sys_social`;
CREATE TABLE `sys_social`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '租户id',
  `auth_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '平台+平台唯一id',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户来源',
  `open_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台编号唯一id',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户的授权令牌',
  `expire_in` int NULL DEFAULT NULL COMMENT '用户的授权令牌的有效期，部分平台可能没有',
  `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '刷新令牌，部分平台可能没有',
  `access_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台的授权信息，部分平台可能没有',
  `union_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户的 unionid',
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授予的权限，部分平台可能没有',
  `token_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个别平台的授权信息，部分平台可能没有',
  `id_token` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'id token，部分平台可能没有',
  `mac_algorithm` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
  `mac_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户的授权code，部分平台可能没有',
  `oauth_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
  `oauth_token_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '社会化关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_social
-- ----------------------------

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户编号',
  `contact_user_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `company_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业名称',
  `license_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '统一社会信用代码',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业简介',
  `domain` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '域名',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `package_id` bigint NULL DEFAULT NULL COMMENT '租户套餐编号',
  `expire_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
  `account_count` int NULL DEFAULT -1 COMMENT '用户数量（-1不限制）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '租户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------

-- ----------------------------
-- Table structure for sys_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_package`;
CREATE TABLE `sys_tenant_package`  (
  `package_id` bigint NOT NULL AUTO_INCREMENT COMMENT '租户套餐id',
  `package_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '套餐名称',
  `menu_ids` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联菜单id',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`package_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '租户套餐表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_tenant_package
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'sys_user' COMMENT '用户类型（sys_user系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '000000', 100, 'admin', 'admin', 'sys_user', 'xxx@163.com', '15888888888', '1', NULL, '$2a$10$3lHFc.9WepUDcLXguM.oEeiiGrsoChWx3cfmOr5/CMTJuljOV5rle', '0', '0', '2409:8a38:4888:ff40:981f:b4e1:8a51:58d1', '2025-11-09 20:01:56', 103, 1, '2025-08-06 11:49:55', 1, '2025-11-09 20:01:56', '管理员');
INSERT INTO `sys_user` VALUES (2, '000000', 100, 'imdemo', 'imdemo', 'sys_user', '', '', '0', NULL, '$2a$10$leqXyaZ1Eol8PdcgzpDPyui6bJV9Tu77hdJg10J0mxoTTFTEugSxq', '0', '0', '2409:8a38:4888:ff40:cda6:20c8:6349:299b', '2025-11-04 15:30:05', 100, 1, '2025-10-01 23:12:33', 2, '2025-11-04 15:30:05', '');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
