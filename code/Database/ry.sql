/*
 Navicat Premium Data Transfer

 Source Server         : 118.25.137.127_3307
 Source Server Type    : MySQL
 Source Server Version : 80200
 Source Host           : 118.25.137.127:3307
 Source Schema         : ry

 Target Server Type    : MySQL
 Target Server Version : 80200
 File Encoding         : 65001

 Date: 14/01/2024 18:42:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Fund_Info
-- ----------------------------
DROP TABLE IF EXISTS `Fund_Info`;
CREATE TABLE `Fund_Info`  (
  `f_id` bigint NOT NULL AUTO_INCREMENT COMMENT '基金代码',
  `f_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '基金名称',
  `f_type` int NULL DEFAULT NULL COMMENT '基金类型',
  `f_size` int NULL DEFAULT NULL COMMENT '基金规模',
  `f_monitor` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '基金经理',
  `f_start_time` datetime NULL DEFAULT NULL COMMENT '基金成立日',
  `f_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '基金所属公司',
  `f_level` int NULL DEFAULT NULL COMMENT '基金评级(0~4)',
  `f_risk_level` int NULL DEFAULT NULL COMMENT '基金风险评级(012对应低中高)',
  `f_overview` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '基金基本概况',
  `f_status` int NULL DEFAULT NULL COMMENT '基金状态',
  PRIMARY KEY (`f_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Fund_Info
-- ----------------------------
INSERT INTO `Fund_Info` VALUES (1, '1234', NULL, 3, 'test', '2023-12-24 00:00:00', '105', 3, 3, 'test01', NULL);
INSERT INTO `Fund_Info` VALUES (2, '寄', NULL, 3, NULL, '2023-12-05 00:00:00', '104', 3, 2, NULL, NULL);
INSERT INTO `Fund_Info` VALUES (3, '混合货币C', NULL, 5, 'zwc', '2023-12-28 00:00:00', '105', 5, 1, NULL, NULL);
INSERT INTO `Fund_Info` VALUES (4, '社保投资A', NULL, 3, 'zk', '2023-12-28 00:00:00', '107', 2, 2, NULL, NULL);
INSERT INTO `Fund_Info` VALUES (5, '同济大学科技园', NULL, 4, '小郑', '2024-01-01 00:00:00', '104', 5, 3, NULL, NULL);

-- ----------------------------
-- Table structure for Fund_Worth
-- ----------------------------
DROP TABLE IF EXISTS `Fund_Worth`;
CREATE TABLE `Fund_Worth`  (
  `f_id` bigint NOT NULL COMMENT '基金代码',
  `f_time` datetime NOT NULL COMMENT '估值时间',
  `f_time_value` float NULL DEFAULT NULL COMMENT '净值',
  PRIMARY KEY (`f_id`, `f_time`) USING BTREE,
  CONSTRAINT `fk_worth_fund` FOREIGN KEY (`f_id`) REFERENCES `Fund_Info` (`f_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Fund_Worth
-- ----------------------------

-- ----------------------------
-- Table structure for Hold_Info
-- ----------------------------
DROP TABLE IF EXISTS `Hold_Info`;
CREATE TABLE `Hold_Info`  (
  `hold_id` bigint NOT NULL COMMENT '持仓记录的ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户内部代码',
  `card_id` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '绑定的银行卡号',
  `f_id` bigint NULL DEFAULT NULL COMMENT '基金编号',
  `f_portion` int NULL DEFAULT NULL COMMENT '基金份额',
  PRIMARY KEY (`hold_id`) USING BTREE,
  INDEX `FK_hold_card`(`card_id`) USING BTREE,
  INDEX `FK_hold_user`(`user_id`) USING BTREE,
  INDEX `fk_hold_fund`(`f_id`) USING BTREE,
  CONSTRAINT `FK_hold_card` FOREIGN KEY (`card_id`) REFERENCES `User_Card` (`card_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_hold_fund` FOREIGN KEY (`f_id`) REFERENCES `Fund_Info` (`f_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_hold_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Hold_Info
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for Transaction_Info
-- ----------------------------
DROP TABLE IF EXISTS `Transaction_Info`;
CREATE TABLE `Transaction_Info`  (
  `f_stream_id` bigint NOT NULL AUTO_INCREMENT COMMENT '交易流水编号',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户内部代码',
  `card_id` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '使用的银行卡号',
  `f_id` bigint NULL DEFAULT NULL COMMENT '基金代码',
  `f_deal_time` datetime NULL DEFAULT NULL COMMENT '交易时间',
  `f_deal_amount` int NULL DEFAULT NULL COMMENT '交易金额',
  `f_deal_status` int NULL DEFAULT NULL COMMENT '交易状态',
  `f_deal_type` int NULL DEFAULT NULL COMMENT '交易类型（0申购1赎回）',
  PRIMARY KEY (`f_stream_id`) USING BTREE,
  INDEX `FK_deal_user`(`user_id`) USING BTREE,
  INDEX `FK_deal_card`(`card_id`) USING BTREE,
  INDEX `fk_deal_fund`(`f_id`) USING BTREE,
  CONSTRAINT `FK_deal_card` FOREIGN KEY (`card_id`) REFERENCES `User_Card` (`card_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_deal_fund` FOREIGN KEY (`f_id`) REFERENCES `Fund_Info` (`f_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_deal_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Transaction_Info
-- ----------------------------
INSERT INTO `Transaction_Info` VALUES (1, 106, '114514', 1, NULL, NULL, 2, 0);
INSERT INTO `Transaction_Info` VALUES (2, 106, '114514', 1, '2023-12-26 00:00:00', 6, 1, 0);
INSERT INTO `Transaction_Info` VALUES (3, 106, '114514', 2, '2023-12-26 00:00:00', 10, 1, 1);
INSERT INTO `Transaction_Info` VALUES (4, 106, '114514', 2, '2023-12-26 00:00:00', 10, 1, 1);
INSERT INTO `Transaction_Info` VALUES (5, 106, '114514', 1, '2023-12-26 00:00:00', 1, 1, 1);
INSERT INTO `Transaction_Info` VALUES (6, 106, '114514', 1, '2023-12-26 00:00:00', 200, 1, 0);
INSERT INTO `Transaction_Info` VALUES (7, 106, '114514', 2, '2023-12-27 00:00:00', 100, 2, 0);
INSERT INTO `Transaction_Info` VALUES (8, 101, '2154314', 1, '2023-12-27 00:00:00', 200, 1, 0);
INSERT INTO `Transaction_Info` VALUES (9, 101, '2154314', 1, '2023-12-27 00:00:00', 300, 1, 0);

-- ----------------------------
-- Table structure for User_Card
-- ----------------------------
DROP TABLE IF EXISTS `User_Card`;
CREATE TABLE `User_Card`  (
  `card_id` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '银行卡号',
  `user_id` bigint NULL DEFAULT NULL COMMENT '持卡人ID',
  `card_amount` int NULL DEFAULT NULL COMMENT '金额',
  `card_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卡状态（0正常 1停用）',
  PRIMARY KEY (`card_id`) USING BTREE,
  INDEX `PK_card_user`(`user_id`) USING BTREE,
  CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of User_Card
-- ----------------------------
INSERT INTO `User_Card` VALUES ('114514', 106, 100, NULL);
INSERT INTO `User_Card` VALUES ('19999999', 107, 103, NULL);
INSERT INTO `User_Card` VALUES ('2154101', 101, 2500, NULL);
INSERT INTO `User_Card` VALUES ('2154314', 101, 24500, NULL);

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'Fund_Info', '基金信息', NULL, NULL, 'FundInfo', 'crud', 'element-ui', 'com.ruoyi.fund', 'fund_manage', 'FundManagement', '基金管理', 'ruoyi', '0', '/', '{\"parentMenuId\":\"1\"}', 'admin', '2023-12-23 02:51:17', '', '2023-12-23 05:17:32', NULL);
INSERT INTO `gen_table` VALUES (2, 'Transaction_Info', '交易流水表', NULL, NULL, 'TransactionInfo', 'crud', 'element-ui', 'com.ruoyi.trans', 'transaction_manage', 'trans', 'trans', 'z', '0', '/', '{\"parentMenuId\":\"1\"}', 'admin', '2023-12-23 07:38:19', '', '2023-12-26 15:24:47', NULL);
INSERT INTO `gen_table` VALUES (3, 'User_Card', '银行卡表', '', '', 'UserCard', 'crud', 'element-ui', 'com.ruoyi.card', 'card', 'CardManagement', '银行卡管理', 'ruoyi', '0', '/', '{\"parentMenuId\":\"1\"}', 'admin', '2023-12-24 07:34:08', '', '2023-12-26 10:42:04', NULL);
INSERT INTO `gen_table` VALUES (4, 'sys_user', '用户信息表', NULL, NULL, 'SysUser', 'crud', '', 'com.ruoyi.system', 'system', 'user', '用户信息', 'ruoyi', '0', '/', NULL, 'admin', '2023-12-26 08:56:58', '', NULL, NULL);

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
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'f_id', '基金代码', 'varchar(6)', 'String', 'fId', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-12-23 02:51:17', '', '2023-12-23 05:17:32');
INSERT INTO `gen_table_column` VALUES (2, 1, 'f_name', '基金名称', 'varchar(20)', 'String', 'fName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2023-12-23 02:51:17', '', '2023-12-23 05:17:32');
INSERT INTO `gen_table_column` VALUES (3, 1, 'f_type', '基金类型', 'int', 'Long', 'fType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2023-12-23 02:51:18', '', '2023-12-23 05:17:32');
INSERT INTO `gen_table_column` VALUES (4, 1, 'f_size', '基金规模', 'int', 'Long', 'fSize', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2023-12-23 02:51:18', '', '2023-12-23 05:17:32');
INSERT INTO `gen_table_column` VALUES (5, 1, 'f_monitor', '基金经理', 'varchar(20)', 'String', 'fMonitor', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2023-12-23 02:51:18', '', '2023-12-23 05:17:32');
INSERT INTO `gen_table_column` VALUES (6, 1, 'f_start_time', '基金成立日', 'datetime', 'Date', 'fStartTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2023-12-23 02:51:18', '', '2023-12-23 05:17:32');
INSERT INTO `gen_table_column` VALUES (7, 1, 'f_company', '基金所属公司', 'varchar(20)', 'String', 'fCompany', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2023-12-23 02:51:18', '', '2023-12-23 05:17:32');
INSERT INTO `gen_table_column` VALUES (8, 1, 'f_level', '基金评级(0~4)', 'int', 'Long', 'fLevel', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2023-12-23 02:51:18', '', '2023-12-23 05:17:32');
INSERT INTO `gen_table_column` VALUES (9, 1, 'f_risk_level', '基金风险评级(012对应低中高)', 'int', 'Long', 'fRiskLevel', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2023-12-23 02:51:18', '', '2023-12-23 05:17:32');
INSERT INTO `gen_table_column` VALUES (10, 1, 'f_overview', '基金基本概况', 'varchar(100)', 'String', 'fOverview', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2023-12-23 02:51:18', '', '2023-12-23 05:17:32');
INSERT INTO `gen_table_column` VALUES (11, 1, 'f_status', '基金状态', 'int', 'Long', 'fStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 11, 'admin', '2023-12-23 02:51:18', '', '2023-12-23 05:17:32');
INSERT INTO `gen_table_column` VALUES (12, 2, 'f_stream_id', '交易流水编号', 'bigint', 'Long', 'fStreamId', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-12-23 07:38:19', '', '2023-12-26 15:24:47');
INSERT INTO `gen_table_column` VALUES (13, 2, 'user_id', '用户内部代码', 'bigint', 'Long', 'userId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2023-12-23 07:38:19', '', '2023-12-26 15:24:47');
INSERT INTO `gen_table_column` VALUES (14, 2, 'card_id', '使用的银行卡号', 'char(20)', 'String', 'cardId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2023-12-23 07:38:19', '', '2023-12-26 15:24:47');
INSERT INTO `gen_table_column` VALUES (15, 2, 'f_id', '基金代码', 'varchar(20)', 'String', 'fId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2023-12-23 07:38:19', '', '2023-12-26 15:24:47');
INSERT INTO `gen_table_column` VALUES (16, 2, 'f_deal_time', '交易时间', 'datetime', 'Date', 'fDealTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2023-12-23 07:38:19', '', '2023-12-26 15:24:47');
INSERT INTO `gen_table_column` VALUES (17, 2, 'f_deal_amount', '交易金额', 'int', 'Long', 'fDealAmount', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2023-12-23 07:38:19', '', '2023-12-26 15:24:47');
INSERT INTO `gen_table_column` VALUES (18, 2, 'f_deal_status', '交易状态', 'int', 'Long', 'fDealStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 7, 'admin', '2023-12-23 07:38:19', '', '2023-12-26 15:24:47');
INSERT INTO `gen_table_column` VALUES (19, 2, 'f_deal_type', '交易类型（0申购1赎回）', 'int', 'Long', 'fDealType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 8, 'admin', '2023-12-23 07:38:19', '', '2023-12-26 15:24:47');
INSERT INTO `gen_table_column` VALUES (20, 3, 'card_id', '银行卡号', 'char(20)', 'String', 'cardId', '1', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 1, 'admin', '2023-12-24 07:34:08', '', '2023-12-26 10:42:04');
INSERT INTO `gen_table_column` VALUES (21, 3, 'user_id', '持卡人ID', 'bigint', 'Long', 'userId', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2023-12-24 07:34:08', '', '2023-12-26 10:42:04');
INSERT INTO `gen_table_column` VALUES (22, 3, 'card_amount', '金额', 'int', 'Long', 'cardAmount', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 3, 'admin', '2023-12-24 07:34:08', '', '2023-12-26 10:42:04');
INSERT INTO `gen_table_column` VALUES (23, 3, 'card_status', '卡状态（0正常 1停用）', 'char(1)', 'String', 'cardStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2023-12-24 07:34:09', '', '2023-12-26 10:42:04');
INSERT INTO `gen_table_column` VALUES (24, 4, 'user_id', '用户ID', 'bigint', 'Long', 'userId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-12-26 08:56:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (25, 4, 'dept_id', '部门ID', 'bigint', 'Long', 'deptId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2023-12-26 08:56:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (26, 4, 'user_name', '用户账号', 'varchar(30)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2023-12-26 08:56:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (27, 4, 'nick_name', '用户昵称', 'varchar(30)', 'String', 'nickName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2023-12-26 08:56:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (28, 4, 'user_type', '用户类型（00系统用户）', 'varchar(2)', 'String', 'userType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2023-12-26 08:56:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (29, 4, 'email', '用户邮箱', 'varchar(50)', 'String', 'email', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2023-12-26 08:56:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (30, 4, 'phonenumber', '手机号码', 'varchar(11)', 'String', 'phonenumber', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2023-12-26 08:56:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (31, 4, 'sex', '用户性别（0男 1女 2未知）', 'char(1)', 'String', 'sex', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 8, 'admin', '2023-12-26 08:56:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (32, 4, 'avatar', '头像地址', 'varchar(100)', 'String', 'avatar', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2023-12-26 08:56:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (33, 4, 'password', '密码', 'varchar(100)', 'String', 'password', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2023-12-26 08:56:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (34, 4, 'status', '帐号状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 11, 'admin', '2023-12-26 08:56:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (35, 4, 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2023-12-26 08:56:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (36, 4, 'login_ip', '最后登录IP', 'varchar(128)', 'String', 'loginIp', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 13, 'admin', '2023-12-26 08:56:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (37, 4, 'login_date', '最后登录时间', 'datetime', 'Date', 'loginDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 14, 'admin', '2023-12-26 08:56:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (38, 4, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 15, 'admin', '2023-12-26 08:56:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (39, 4, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 16, 'admin', '2023-12-26 08:56:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (40, 4, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 17, 'admin', '2023-12-26 08:56:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (41, 4, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 18, 'admin', '2023-12-26 08:56:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (42, 4, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 19, 'admin', '2023-12-26 08:56:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (43, 4, 'c_ID_type', '用户证件类型', 'int', 'Long', 'cIdType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 20, 'admin', '2023-12-26 08:56:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (44, 4, 'c_ID', '用户证件号码', 'char(20)', 'String', 'cId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 21, 'admin', '2023-12-26 08:56:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (45, 4, 'c_risk_level', '用户风险等级（012对应低中高）', 'int', 'Long', 'cRiskLevel', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 22, 'admin', '2023-12-26 08:56:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (46, 4, 'c_address', '用户地址', 'varchar(20)', 'String', 'cAddress', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 23, 'admin', '2023-12-26 08:56:59', '', NULL);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2023-12-14 02:55:48', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2023-12-14 02:55:48', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2023-12-14 02:55:48', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2023-12-14 02:55:48', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2023-12-14 02:55:48', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2023-12-14 02:55:48', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 210 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', 'WolfTech', 0, 'Weichen Zhang', '15536937551', '2151414@tongji.edu.cn', '0', '0', 'admin', '2023-12-14 02:55:42', 'admin', '2023-12-20 13:21:14');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', 'Fund Company', 2, 'Zhi Zheng', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-12-14 02:55:42', 'admin', '2023-12-20 13:28:26');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', 'Developer', 1, '郑恺', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-12-14 02:55:42', 'admin', '2023-12-20 13:28:54');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '易方达基金管理有限公司', 1, '汤可娴', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-12-14 02:55:42', 'admin', '2023-12-20 13:22:58');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '广发基金管理有限公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-12-14 02:55:42', 'admin', '2023-12-20 13:23:13');
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '华夏基金管理有限公司', 3, '', '', '', '0', '0', 'admin', '2023-12-14 02:55:42', 'admin', '2023-12-20 13:24:50');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '南方基金管理股份有限公司', 4, '', '', '', '0', '0', 'admin', '2023-12-14 02:55:42', 'admin', '2023-12-20 13:25:10');
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '天弘基金管理有限公司', 5, '', '', '', '0', '0', 'admin', '2023-12-14 02:55:42', 'admin', '2023-12-20 13:25:38');
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-12-14 02:55:42', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-12-14 02:55:42', '', NULL);
INSERT INTO `sys_dept` VALUES (200, 100, '0,100', 'Client', 3, NULL, NULL, NULL, '0', '2', 'admin', '2023-12-20 13:31:07', '', NULL);
INSERT INTO `sys_dept` VALUES (201, 200, '0,100,200', '支付宝', 0, NULL, NULL, NULL, '0', '2', 'admin', '2023-12-20 13:31:45', '', NULL);
INSERT INTO `sys_dept` VALUES (202, 200, '0,100,200', '中国农业银行', 1, NULL, NULL, NULL, '0', '2', 'admin', '2023-12-20 13:33:05', '', NULL);
INSERT INTO `sys_dept` VALUES (203, 200, '0,100,200', '中国招商银行', 2, NULL, NULL, NULL, '0', '2', 'admin', '2023-12-20 13:33:23', '', NULL);
INSERT INTO `sys_dept` VALUES (204, 200, '0,100,200', '天天基金网', 3, NULL, NULL, NULL, '0', '2', 'admin', '2023-12-20 13:33:54', '', NULL);
INSERT INTO `sys_dept` VALUES (205, 103, '0,100,101,103', '支付宝', 3, NULL, NULL, NULL, '0', '2', 'Hongfei Fan', '2023-12-20 14:11:34', '', NULL);
INSERT INTO `sys_dept` VALUES (206, 103, '0,100,101,103', '中国工商银行', 1, '郑埴', '15356201811', '1420223146@qq.com', '0', '0', 'admin', '2023-12-23 07:30:04', '', NULL);
INSERT INTO `sys_dept` VALUES (207, 103, '0,100,101,103', '支付宝', 0, '无', NULL, NULL, '0', '0', 'admin', '2023-12-23 07:30:25', '', NULL);
INSERT INTO `sys_dept` VALUES (208, 104, '0,100,101,104', '京东金融', 0, NULL, NULL, NULL, '0', '0', 'admin', '2023-12-23 07:30:41', '', NULL);
INSERT INTO `sys_dept` VALUES (209, 105, '0,100,101,105', '支付宝', 0, NULL, NULL, NULL, '0', '0', 'admin', '2023-12-23 07:30:50', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2023-12-14 02:55:48', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-12-14 02:55:48', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-12-14 02:55:48', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-12-14 02:55:48', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-12-14 02:55:48', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-12-14 02:55:48', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2023-12-14 02:55:48', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2023-12-14 02:55:48', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2023-12-14 02:55:47', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2023-12-14 02:55:48', '', '2023-12-14 13:34:31', '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2023-12-14 02:55:48', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2023-12-14 02:55:48', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
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
) ENGINE = InnoDB AUTO_INCREMENT = 291 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2023-12-14 05:49:46');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2023-12-14 06:00:08');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2023-12-14 13:25:50');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2023-12-14 13:36:42');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-14 15:13:48');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-14 15:58:55');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-14 16:47:09');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2023-12-15 02:37:08');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2023-12-18 04:24:50');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2023-12-18 04:24:53');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 09:25:50');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-20 09:29:54');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 09:32:16');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 11:14:35');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-20 11:35:56');
INSERT INTO `sys_logininfor` VALUES (115, 'ry', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码已失效', '2023-12-20 11:42:49');
INSERT INTO `sys_logininfor` VALUES (116, 'ry', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 11:42:55');
INSERT INTO `sys_logininfor` VALUES (117, 'ry', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-20 11:43:47');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 11:43:51');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-20 11:45:31');
INSERT INTO `sys_logininfor` VALUES (120, 'ry', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 11:45:42');
INSERT INTO `sys_logininfor` VALUES (121, 'ry', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-20 11:46:10');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码错误', '2023-12-20 11:46:17');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 11:46:20');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 13:02:46');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-20 13:48:54');
INSERT INTO `sys_logininfor` VALUES (126, 'zwc11', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码错误', '2023-12-20 13:49:06');
INSERT INTO `sys_logininfor` VALUES (127, 'zwc11', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2023-12-20 13:49:10');
INSERT INTO `sys_logininfor` VALUES (128, 'zwc', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 13:49:18');
INSERT INTO `sys_logininfor` VALUES (129, 'zwc', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-20 13:53:13');
INSERT INTO `sys_logininfor` VALUES (130, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 13:53:31');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 14:04:42');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-20 14:08:16');
INSERT INTO `sys_logininfor` VALUES (133, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 14:08:51');
INSERT INTO `sys_logininfor` VALUES (134, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-20 14:12:20');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 14:12:24');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-20 14:13:12');
INSERT INTO `sys_logininfor` VALUES (137, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 14:13:30');
INSERT INTO `sys_logininfor` VALUES (138, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-20 14:15:03');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-20 14:15:09');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-22 01:44:04');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-22 02:20:32');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 02:39:08');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 03:55:38');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 05:10:06');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 07:28:07');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 07:32:59');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 08:42:14');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码已失效', '2023-12-23 11:01:52');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码错误', '2023-12-23 11:01:59');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 11:02:02');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 11:07:59');
INSERT INTO `sys_logininfor` VALUES (152, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2023-12-23 11:08:19');
INSERT INTO `sys_logininfor` VALUES (153, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 11:08:24');
INSERT INTO `sys_logininfor` VALUES (154, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 11:10:50');
INSERT INTO `sys_logininfor` VALUES (155, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 11:10:55');
INSERT INTO `sys_logininfor` VALUES (156, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 11:11:08');
INSERT INTO `sys_logininfor` VALUES (157, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 11:11:14');
INSERT INTO `sys_logininfor` VALUES (158, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 11:13:04');
INSERT INTO `sys_logininfor` VALUES (159, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 11:13:10');
INSERT INTO `sys_logininfor` VALUES (160, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 11:36:26');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 11:36:35');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 11:37:28');
INSERT INTO `sys_logininfor` VALUES (163, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 11:37:34');
INSERT INTO `sys_logininfor` VALUES (164, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 11:38:49');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 11:38:57');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 11:40:35');
INSERT INTO `sys_logininfor` VALUES (167, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 11:41:23');
INSERT INTO `sys_logininfor` VALUES (168, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 12:19:36');
INSERT INTO `sys_logininfor` VALUES (169, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 12:56:40');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 12:56:45');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 12:58:10');
INSERT INTO `sys_logininfor` VALUES (172, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 12:58:16');
INSERT INTO `sys_logininfor` VALUES (173, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 12:58:26');
INSERT INTO `sys_logininfor` VALUES (174, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 12:58:32');
INSERT INTO `sys_logininfor` VALUES (175, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 12:58:35');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 12:58:39');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 13:00:15');
INSERT INTO `sys_logininfor` VALUES (178, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 13:00:22');
INSERT INTO `sys_logininfor` VALUES (179, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 13:01:12');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 13:01:17');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 13:02:17');
INSERT INTO `sys_logininfor` VALUES (182, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2023-12-23 13:02:24');
INSERT INTO `sys_logininfor` VALUES (183, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 13:02:32');
INSERT INTO `sys_logininfor` VALUES (184, 'az', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-23 14:18:27');
INSERT INTO `sys_logininfor` VALUES (185, 'az', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '退出成功', '2023-12-23 14:31:50');
INSERT INTO `sys_logininfor` VALUES (186, 'az', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '退出成功', '2023-12-23 14:31:50');
INSERT INTO `sys_logininfor` VALUES (187, 'az', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-23 14:32:25');
INSERT INTO `sys_logininfor` VALUES (188, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 15:06:18');
INSERT INTO `sys_logininfor` VALUES (189, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 15:06:30');
INSERT INTO `sys_logininfor` VALUES (190, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 15:25:27');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 15:25:32');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 15:48:26');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 15:48:32');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 15:49:06');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 15:49:09');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-23 15:56:13');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 16:20:05');
INSERT INTO `sys_logininfor` VALUES (198, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 16:20:09');
INSERT INTO `sys_logininfor` VALUES (199, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 16:21:47');
INSERT INTO `sys_logininfor` VALUES (200, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 16:21:53');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 16:26:28');
INSERT INTO `sys_logininfor` VALUES (202, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 16:26:34');
INSERT INTO `sys_logininfor` VALUES (203, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 16:28:06');
INSERT INTO `sys_logininfor` VALUES (204, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 16:28:11');
INSERT INTO `sys_logininfor` VALUES (205, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 16:28:19');
INSERT INTO `sys_logininfor` VALUES (206, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 16:28:24');
INSERT INTO `sys_logininfor` VALUES (207, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 16:29:05');
INSERT INTO `sys_logininfor` VALUES (208, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 16:29:11');
INSERT INTO `sys_logininfor` VALUES (209, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 16:30:27');
INSERT INTO `sys_logininfor` VALUES (210, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 16:30:42');
INSERT INTO `sys_logininfor` VALUES (211, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 16:30:58');
INSERT INTO `sys_logininfor` VALUES (212, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 16:32:27');
INSERT INTO `sys_logininfor` VALUES (213, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 16:33:05');
INSERT INTO `sys_logininfor` VALUES (214, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 16:41:06');
INSERT INTO `sys_logininfor` VALUES (215, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 16:41:11');
INSERT INTO `sys_logininfor` VALUES (216, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-23 16:42:31');
INSERT INTO `sys_logininfor` VALUES (217, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-23 16:42:37');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-23 18:28:57');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-24 00:28:08');
INSERT INTO `sys_logininfor` VALUES (220, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-24 02:56:36');
INSERT INTO `sys_logininfor` VALUES (221, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '1', '验证码错误', '2023-12-24 04:10:00');
INSERT INTO `sys_logininfor` VALUES (222, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-24 04:10:07');
INSERT INTO `sys_logininfor` VALUES (223, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-24 04:43:41');
INSERT INTO `sys_logininfor` VALUES (224, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2023-12-24 05:52:52');
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-24 05:54:48');
INSERT INTO `sys_logininfor` VALUES (226, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-24 06:46:12');
INSERT INTO `sys_logininfor` VALUES (227, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-24 07:00:58');
INSERT INTO `sys_logininfor` VALUES (228, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2023-12-24 07:10:56');
INSERT INTO `sys_logininfor` VALUES (229, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-24 07:11:06');
INSERT INTO `sys_logininfor` VALUES (230, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-24 08:37:13');
INSERT INTO `sys_logininfor` VALUES (231, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-25 16:42:05');
INSERT INTO `sys_logininfor` VALUES (232, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-25 18:03:08');
INSERT INTO `sys_logininfor` VALUES (233, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-26 08:53:38');
INSERT INTO `sys_logininfor` VALUES (234, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '1', '验证码错误', '2023-12-26 10:29:35');
INSERT INTO `sys_logininfor` VALUES (235, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-26 10:29:38');
INSERT INTO `sys_logininfor` VALUES (236, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-26 13:29:06');
INSERT INTO `sys_logininfor` VALUES (237, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-26 15:18:59');
INSERT INTO `sys_logininfor` VALUES (238, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-27 05:27:04');
INSERT INTO `sys_logininfor` VALUES (239, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-27 06:02:40');
INSERT INTO `sys_logininfor` VALUES (240, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '1', '验证码已失效', '2023-12-27 06:38:32');
INSERT INTO `sys_logininfor` VALUES (241, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-27 06:38:36');
INSERT INTO `sys_logininfor` VALUES (242, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-27 06:50:27');
INSERT INTO `sys_logininfor` VALUES (243, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '1', '验证码已失效', '2023-12-27 08:02:36');
INSERT INTO `sys_logininfor` VALUES (244, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-27 08:02:40');
INSERT INTO `sys_logininfor` VALUES (245, 'zwc', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2023-12-27 08:08:12');
INSERT INTO `sys_logininfor` VALUES (246, 'zwc', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2023-12-27 13:20:29');
INSERT INTO `sys_logininfor` VALUES (247, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-27 13:24:49');
INSERT INTO `sys_logininfor` VALUES (248, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-27 13:26:11');
INSERT INTO `sys_logininfor` VALUES (249, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-27 13:34:52');
INSERT INTO `sys_logininfor` VALUES (250, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-27 13:50:27');
INSERT INTO `sys_logininfor` VALUES (251, 'zwc', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '1', '验证码错误', '2023-12-27 13:50:56');
INSERT INTO `sys_logininfor` VALUES (252, 'zwc', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2023-12-27 13:51:03');
INSERT INTO `sys_logininfor` VALUES (253, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-28 06:20:52');
INSERT INTO `sys_logininfor` VALUES (254, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2023-12-28 06:38:38');
INSERT INTO `sys_logininfor` VALUES (255, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-28 06:38:53');
INSERT INTO `sys_logininfor` VALUES (256, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2023-12-28 06:39:15');
INSERT INTO `sys_logininfor` VALUES (257, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '1', '用户不存在/密码错误', '2023-12-28 06:39:24');
INSERT INTO `sys_logininfor` VALUES (258, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-28 06:39:32');
INSERT INTO `sys_logininfor` VALUES (259, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2023-12-28 06:39:55');
INSERT INTO `sys_logininfor` VALUES (260, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '1', '用户不存在/密码错误', '2023-12-28 06:40:02');
INSERT INTO `sys_logininfor` VALUES (261, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '1', '验证码错误', '2023-12-28 06:40:06');
INSERT INTO `sys_logininfor` VALUES (262, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '1', '用户不存在/密码错误', '2023-12-28 06:40:20');
INSERT INTO `sys_logininfor` VALUES (263, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-28 06:40:46');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2023-12-28 06:41:22');
INSERT INTO `sys_logininfor` VALUES (265, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-28 06:41:34');
INSERT INTO `sys_logininfor` VALUES (266, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2023-12-28 06:56:34');
INSERT INTO `sys_logininfor` VALUES (267, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '1', '验证码错误', '2023-12-28 07:00:07');
INSERT INTO `sys_logininfor` VALUES (268, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-28 07:00:12');
INSERT INTO `sys_logininfor` VALUES (269, 'Hongfei Fan', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2023-12-28 07:03:24');
INSERT INTO `sys_logininfor` VALUES (270, 'az', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-28 07:03:31');
INSERT INTO `sys_logininfor` VALUES (271, 'az', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2023-12-28 07:07:30');
INSERT INTO `sys_logininfor` VALUES (272, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2023-12-28 07:07:41');
INSERT INTO `sys_logininfor` VALUES (273, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码已失效', '2024-01-07 06:23:04');
INSERT INTO `sys_logininfor` VALUES (274, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-07 06:23:06');
INSERT INTO `sys_logininfor` VALUES (275, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-10 16:31:52');
INSERT INTO `sys_logininfor` VALUES (276, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码已失效', '2024-01-11 12:26:06');
INSERT INTO `sys_logininfor` VALUES (277, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 12:26:09');
INSERT INTO `sys_logininfor` VALUES (278, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 14:09:53');
INSERT INTO `sys_logininfor` VALUES (279, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-11 14:10:04');
INSERT INTO `sys_logininfor` VALUES (280, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 14:10:41');
INSERT INTO `sys_logininfor` VALUES (281, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-11 14:11:09');
INSERT INTO `sys_logininfor` VALUES (282, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 14:11:14');
INSERT INTO `sys_logininfor` VALUES (283, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-11 14:20:43');
INSERT INTO `sys_logininfor` VALUES (284, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 14:20:48');
INSERT INTO `sys_logininfor` VALUES (285, 'zz', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-11 14:20:56');
INSERT INTO `sys_logininfor` VALUES (286, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 14:21:02');
INSERT INTO `sys_logininfor` VALUES (287, 'az', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-11 14:28:12');
INSERT INTO `sys_logininfor` VALUES (288, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 14:28:22');
INSERT INTO `sys_logininfor` VALUES (289, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码已失效', '2024-01-12 19:12:49');
INSERT INTO `sys_logininfor` VALUES (290, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-13 02:38:16');

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
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2031 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2023-12-14 02:55:43', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2023-12-14 02:55:43', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2023-12-14 02:55:43', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2023-12-14 02:55:43', '', NULL, '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2023-12-14 02:55:43', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2023-12-14 02:55:43', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2023-12-14 02:55:43', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2023-12-14 02:55:43', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2023-12-14 02:55:43', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2023-12-14 02:55:43', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2023-12-14 02:55:43', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2023-12-14 02:55:43', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2023-12-14 02:55:43', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2023-12-14 02:55:43', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2023-12-14 02:55:43', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2023-12-14 02:55:43', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2023-12-14 02:55:43', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2023-12-14 02:55:43', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2023-12-14 02:55:43', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2023-12-14 02:55:43', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2023-12-14 02:55:43', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2023-12-14 02:55:43', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2023-12-14 02:55:43', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2023-12-14 02:55:43', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2023-12-14 02:55:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '基金管理', 1, 1, 'FundManagement', 'fund_manage/FundManagement/index', NULL, 1, 0, 'C', '0', '0', 'fund_manage:FundManagement:list', 'rate', 'admin', '2023-12-23 05:27:04', 'admin', '2023-12-24 07:11:25', '基金管理菜单');
INSERT INTO `sys_menu` VALUES (2007, '基金管理查询', 2006, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'fund_manage:FundManagement:query', '#', 'admin', '2023-12-23 05:27:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '基金管理新增', 2006, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'fund_manage:FundManagement:add', '#', 'admin', '2023-12-23 05:27:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '基金管理修改', 2006, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'fund_manage:FundManagement:edit', '#', 'admin', '2023-12-23 05:27:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '基金管理删除', 2006, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'fund_manage:FundManagement:remove', '#', 'admin', '2023-12-23 05:27:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '基金管理导出', 2006, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'fund_manage:FundManagement:export', '#', 'admin', '2023-12-23 05:27:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '银行卡管理', 1, 4, 'CardManagement', 'card/CardManagement/index', NULL, 1, 0, 'C', '0', '0', 'card:CardManagement:list', 'money', 'admin', '2023-12-26 10:30:12', 'admin', '2023-12-26 10:39:47', '银行卡管理菜单');
INSERT INTO `sys_menu` VALUES (2020, '银行卡管理查询', 2019, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'card:CardManagement:query', '#', 'admin', '2023-12-26 10:30:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '银行卡管理新增', 2019, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'card:CardManagement:add', '#', 'admin', '2023-12-26 10:30:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '银行卡管理修改', 2019, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'card:CardManagement:edit', '#', 'admin', '2023-12-26 10:30:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '银行卡管理删除', 2019, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'card:CardManagement:remove', '#', 'admin', '2023-12-26 10:30:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '银行卡管理导出', 2019, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'card:CardManagement:export', '#', 'admin', '2023-12-26 10:30:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '业务管理', 1, 1, 'trans', 'transaction_manage/trans/index', NULL, 1, 0, 'C', '0', '0', 'transaction_manage:trans:list', 'size', 'admin', '2023-12-26 15:27:24', 'admin', '2023-12-26 15:31:10', 'trans菜单');
INSERT INTO `sys_menu` VALUES (2026, 'trans查询', 2025, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'transaction_manage:trans:query', '#', 'admin', '2023-12-26 15:27:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, 'trans新增', 2025, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'transaction_manage:trans:add', '#', 'admin', '2023-12-26 15:27:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, 'trans修改', 2025, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'transaction_manage:trans:edit', '#', 'admin', '2023-12-26 15:27:26', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, 'trans删除', 2025, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'transaction_manage:trans:remove', '#', 'admin', '2023-12-26 15:27:26', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, 'trans导出', 2025, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'transaction_manage:trans:export', '#', 'admin', '2023-12-26 15:27:26', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (10, '关于基金修改Bug修复', '2', 0x3C703EE59FBAE98791E4BFAEE694B9E697B6E69687E69CACE6A186E698BEE7A4BAE99499E8AFAFE79A84427567E5B7B2E4BFAEE5A48DEFBC813C2F703E, '0', 'zwc', '2023-12-27 08:14:36', '', NULL, NULL);
INSERT INTO `sys_notice` VALUES (11, '维护通知', '2', 0x3C703E32303233E5B9B43132E69C883235E697A531313A30302D32303233E5B9B43132E69C883236E697A5323A3030E997B4E8BF9BE8A18CE7B3BBE7BB9FE7BBB4E68AA4EFBC813C2F703E, '0', 'zwc', '2023-12-27 08:16:01', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
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
) ENGINE = InnoDB AUTO_INCREMENT = 380 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '定时任务', 2, 'com.ruoyi.quartz.controller.SysJobController.changeStatus()', 'PUT', 1, 'admin', '研发部门', '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":1,\"misfirePolicy\":\"0\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-14 13:34:23', 360);
INSERT INTO `sys_oper_log` VALUES (101, '定时任务', 2, 'com.ruoyi.quartz.controller.SysJobController.changeStatus()', 'PUT', 1, 'admin', '研发部门', '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":1,\"misfirePolicy\":\"0\",\"params\":{},\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-14 13:34:31', 116);
INSERT INTO `sys_oper_log` VALUES (102, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":101,\"nickName\":\"zz\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":100,\"userName\":\"zz\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 11:54:02', 219);
INSERT INTO `sys_oper_log` VALUES (103, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/user/100', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 11:54:40', 104);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/101', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2023-12-20 13:13:25', 16);
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/1007', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2023-12-20 13:13:56', 52);
INSERT INTO `sys_oper_log` VALUES (106, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/user/2', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:15:42', 129);
INSERT INTO `sys_oper_log` VALUES (107, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"WolfTech\",\"email\":\"2151414@tongji.edu.cn\",\"leader\":\"Weichen Zhang\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15536937551\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:21:14', 78);
INSERT INTO `sys_oper_log` VALUES (108, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"Fund Company\",\"email\":\"ry@qq.com\",\"leader\":\"Zhi Zheng\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"WolfTech\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:22:13', 140);
INSERT INTO `sys_oper_log` VALUES (109, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"易方达基金管理有限公司\",\"email\":\"ry@qq.com\",\"leader\":\"汤可娴\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"Fund Company\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:22:58', 125);
INSERT INTO `sys_oper_log` VALUES (110, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"广发基金管理有限公司\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"parentName\":\"Fund Company\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:23:13', 109);
INSERT INTO `sys_oper_log` VALUES (111, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"华夏基金管理有限公司\",\"email\":\"\",\"leader\":\"\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"parentName\":\"Fund Company\",\"phone\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:24:50', 152);
INSERT INTO `sys_oper_log` VALUES (112, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":106,\"deptName\":\"南方基金管理股份有限公司\",\"email\":\"\",\"leader\":\"\",\"orderNum\":4,\"params\":{},\"parentId\":101,\"parentName\":\"Fund Company\",\"phone\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:25:10', 184);
INSERT INTO `sys_oper_log` VALUES (113, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":107,\"deptName\":\"天弘基金管理有限公司\",\"email\":\"\",\"leader\":\"\",\"orderNum\":5,\"params\":{},\"parentId\":101,\"parentName\":\"Fund Company\",\"phone\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:25:39', 117);
INSERT INTO `sys_oper_log` VALUES (114, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"Fund Company\",\"email\":\"ry@qq.com\",\"leader\":\"Zhi Zheng\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"parentName\":\"WolfTech\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:28:26', 126);
INSERT INTO `sys_oper_log` VALUES (115, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":102,\"deptName\":\"Developer\",\"email\":\"ry@qq.com\",\"leader\":\"郑恺\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"WolfTech\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:28:54', 126);
INSERT INTO `sys_oper_log` VALUES (116, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/108', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:29:12', 60);
INSERT INTO `sys_oper_log` VALUES (117, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/109', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:29:15', 52);
INSERT INTO `sys_oper_log` VALUES (118, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"Client\",\"orderNum\":3,\"params\":{},\"parentId\":100,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:31:07', 68);
INSERT INTO `sys_oper_log` VALUES (119, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,200\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"支付宝\",\"orderNum\":0,\"params\":{},\"parentId\":200,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:31:45', 57);
INSERT INTO `sys_oper_log` VALUES (120, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,200\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"中国农业银行\",\"orderNum\":1,\"params\":{},\"parentId\":200,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:33:05', 91);
INSERT INTO `sys_oper_log` VALUES (121, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,200\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"中国招商银行\",\"orderNum\":2,\"params\":{},\"parentId\":200,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:33:23', 53);
INSERT INTO `sys_oper_log` VALUES (122, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,200\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"天天基金网\",\"orderNum\":3,\"params\":{},\"parentId\":200,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:33:54', 57);
INSERT INTO `sys_oper_log` VALUES (123, '角色管理', 3, 'com.ruoyi.web.controller.system.SysRoleController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/role/2', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:34:28', 147);
INSERT INTO `sys_oper_log` VALUES (124, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"roleId\":100,\"roleKey\":\"@PreAuthorize(`@ss.hasRole(\'developer\')`)\",\"roleName\":\"Developer\",\"roleSort\":1,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:36:17', 138);
INSERT INTO `sys_oper_log` VALUES (125, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-12-20 13:36:17\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"roleId\":100,\"roleKey\":\"Developer\",\"roleName\":\"开发者\",\"roleSort\":1,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:37:00', 201);
INSERT INTO `sys_oper_log` VALUES (126, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,107,1000,1001,1002,1003,1004,1005,103,1016,1017,1018,1019,1035],\"params\":{},\"roleId\":101,\"roleKey\":\"FundAgent\",\"roleName\":\"基金业务员\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:40:35', 116);
INSERT INTO `sys_oper_log` VALUES (127, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":102,\"email\":\"2151414@tongji.edu.cn\",\"nickName\":\"zwc\",\"params\":{},\"phonenumber\":\"15536937551\",\"postIds\":[],\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userId\":101,\"userName\":\"zwc\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:44:37', 233);
INSERT INTO `sys_oper_log` VALUES (128, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":102,\"nickName\":\"zk\",\"params\":{},\"postIds\":[],\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userId\":102,\"userName\":\"zk\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:45:35', 168);
INSERT INTO `sys_oper_log` VALUES (129, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":102,\"nickName\":\"lzk\",\"params\":{},\"postIds\":[],\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userId\":103,\"userName\":\"lzk\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:46:02', 207);
INSERT INTO `sys_oper_log` VALUES (130, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[],\"params\":{},\"roleId\":102,\"roleKey\":\"Client\",\"roleName\":\"客户\",\"roleSort\":3,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:47:30', 61);
INSERT INTO `sys_oper_log` VALUES (131, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2023-12-20 13:44:37\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":102,\"deptName\":\"Developer\",\"leader\":\"郑恺\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"status\":\"0\"},\"deptId\":102,\"email\":\"2151414@tongji.edu.cn\",\"loginIp\":\"\",\"nickName\":\"zwc11\",\"params\":{},\"phonenumber\":\"15536937551\",\"postIds\":[],\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"Developer\",\"roleName\":\"开发者\",\"roleSort\":1,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":101,\"userName\":\"zwc\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:48:50', 593);
INSERT INTO `sys_oper_log` VALUES (132, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'zwc', 'Developer', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2023/12/20/我的成长_20231220215036A001.jpg\",\"code\":200}', 0, NULL, '2023-12-20 13:50:36', 134);
INSERT INTO `sys_oper_log` VALUES (133, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'zwc', 'Developer', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"2151414@tongji.edu.cn\",\"nickName\":\"zwc11\",\"params\":{},\"phonenumber\":\"15536937551\",\"sex\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:50:44', 66);
INSERT INTO `sys_oper_log` VALUES (134, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'zwc', 'Developer', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"2151414@tongji.edu.cn\",\"nickName\":\"zwc11\",\"params\":{},\"phonenumber\":\"15536937551\",\"sex\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:51:36', 62);
INSERT INTO `sys_oper_log` VALUES (135, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'zwc', 'Developer', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"zwc\",\"deptId\":103,\"nickName\":\"Rene Fan\",\"params\":{},\"postIds\":[],\"roleIds\":[101],\"sex\":\"0\",\"status\":\"0\",\"userId\":104,\"userName\":\"Hongfei Fan\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 13:52:45', 197);
INSERT INTO `sys_oper_log` VALUES (136, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'Hongfei Fan', '易方达基金管理有限公司', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101,103\",\"children\":[],\"createBy\":\"Hongfei Fan\",\"deptName\":\"支付宝\",\"orderNum\":3,\"params\":{},\"parentId\":103,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 14:11:35', 76);
INSERT INTO `sys_oper_log` VALUES (137, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'Hongfei Fan', '易方达基金管理有限公司', '/system/dept/205', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 14:12:07', 72);
INSERT INTO `sys_oper_log` VALUES (138, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-12-20 13:40:35\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":101,\"roleKey\":\"FundAgent\",\"roleName\":\"基金业务员\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-20 14:13:06', 106);
INSERT INTO `sys_oper_log` VALUES (139, '用户管理', 5, 'com.ruoyi.web.controller.system.SysUserController.export()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/system/user/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-12-20 14:16:46', 1108);
INSERT INTO `sys_oper_log` VALUES (140, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"Fund_Info\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 02:51:18', 471);
INSERT INTO `sys_oper_log` VALUES (141, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"FundInfo\",\"className\":\"FundInfo\",\"columns\":[{\"capJavaField\":\"FId\",\"columnComment\":\"基金代码\",\"columnId\":1,\"columnName\":\"f_id\",\"columnType\":\"varchar(6)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 02:51:17\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"fId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FName\",\"columnComment\":\"基金名称\",\"columnId\":2,\"columnName\":\"f_name\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 02:51:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"fName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FType\",\"columnComment\":\"基金类型\",\"columnId\":3,\"columnName\":\"f_type\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 02:51:18\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"fType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FSize\",\"columnComment\":\"基金规模\",\"columnId\":4,\"columnName\":\"f_size\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 02:51:18\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"fSize\",\"javaType\":\"Long\",', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 03:56:49', 284);
INSERT INTO `sys_oper_log` VALUES (142, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"Fund_Info\"}', NULL, 0, NULL, '2023-12-23 03:56:55', 252);
INSERT INTO `sys_oper_log` VALUES (143, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"FundManagement\",\"className\":\"FundInfo\",\"columns\":[{\"capJavaField\":\"FId\",\"columnComment\":\"基金代码\",\"columnId\":1,\"columnName\":\"f_id\",\"columnType\":\"varchar(6)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 02:51:17\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"fId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2023-12-23 03:56:48\",\"usableColumn\":false},{\"capJavaField\":\"FName\",\"columnComment\":\"基金名称\",\"columnId\":2,\"columnName\":\"f_name\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 02:51:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"fName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2023-12-23 03:56:48\",\"usableColumn\":false},{\"capJavaField\":\"FType\",\"columnComment\":\"基金类型\",\"columnId\":3,\"columnName\":\"f_type\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 02:51:18\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"fType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2023-12-23 03:56:48\",\"usableColumn\":false},{\"capJavaField\":\"FSize\",\"columnComment\":\"基金规模\",\"columnId\":4,\"columnName\":\"f_size\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 02:51:18\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 05:17:32', 296);
INSERT INTO `sys_oper_log` VALUES (144, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"Fund_Info\"}', NULL, 0, NULL, '2023-12-23 05:17:35', 239);
INSERT INTO `sys_oper_log` VALUES (145, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-12-20 13:40:35\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,107,2006,2007,2008,2009,2010,2011,1000,1001,1002,1003,1004,1005,103,1016,1017,1018,1019,1035],\"params\":{},\"roleId\":101,\"roleKey\":\"FundAgent\",\"roleName\":\"基金业务员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 05:35:58', 169);
INSERT INTO `sys_oper_log` VALUES (146, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/system/dept/200', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"存在下级部门,不允许删除\",\"code\":601}', 0, NULL, '2023-12-23 07:29:22', 20);
INSERT INTO `sys_oper_log` VALUES (147, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/system/dept/201', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 07:29:27', 63);
INSERT INTO `sys_oper_log` VALUES (148, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/system/dept/202', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 07:29:29', 85);
INSERT INTO `sys_oper_log` VALUES (149, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/system/dept/203', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 07:29:32', 79);
INSERT INTO `sys_oper_log` VALUES (150, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/system/dept/204', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 07:29:34', 70);
INSERT INTO `sys_oper_log` VALUES (151, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/system/dept/200', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 07:29:36', 76);
INSERT INTO `sys_oper_log` VALUES (152, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101,103\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"中国工商银行\",\"email\":\"1420223146@qq.com\",\"leader\":\"郑埴\",\"orderNum\":1,\"params\":{},\"parentId\":103,\"phone\":\"15356201811\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 07:30:04', 90);
INSERT INTO `sys_oper_log` VALUES (153, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101,103\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"支付宝\",\"leader\":\"无\",\"orderNum\":0,\"params\":{},\"parentId\":103,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 07:30:25', 53);
INSERT INTO `sys_oper_log` VALUES (154, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101,104\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"京东金融\",\"orderNum\":0,\"params\":{},\"parentId\":104,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 07:30:41', 62);
INSERT INTO `sys_oper_log` VALUES (155, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101,105\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"支付宝\",\"orderNum\":0,\"params\":{},\"parentId\":105,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 07:30:50', 50);
INSERT INTO `sys_oper_log` VALUES (156, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"Transaction_Info\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 07:38:20', 238);
INSERT INTO `sys_oper_log` VALUES (157, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":102,\"email\":\"1420223146@qq.com\",\"nickName\":\"alo\",\"params\":{},\"phonenumber\":\"15356201811\",\"postIds\":[1],\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userId\":105,\"userName\":\"zz\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 08:18:20', 255);
INSERT INTO `sys_oper_log` VALUES (158, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'zz', 'Developer', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"zz\",\"deptId\":104,\"nickName\":\"AgentZ\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":106,\"userName\":\"az\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 11:09:53', 165);
INSERT INTO `sys_oper_log` VALUES (159, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'zz', 'Developer', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"zz\",\"createTime\":\"2023-12-23 11:09:53\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"广发基金管理有限公司\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":104,\"email\":\"\",\"loginDate\":\"2023-12-23 19:10:56\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"AgentZ\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[101],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"zz\",\"userId\":106,\"userName\":\"az\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 11:11:26', 155);
INSERT INTO `sys_oper_log` VALUES (160, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-12-20 13:40:35\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":101,\"roleKey\":\"FundAgent\",\"roleName\":\"基金业务员\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 11:37:13', 88);
INSERT INTO `sys_oper_log` VALUES (161, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-12-20 13:47:30\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":102,\"roleKey\":\"Client\",\"roleName\":\"客户\",\"roleSort\":3,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 11:37:18', 73);
INSERT INTO `sys_oper_log` VALUES (162, '用户管理', 5, 'com.ruoyi.web.controller.system.SysUserController.export()', 'POST', 1, 'az', '广发基金管理有限公司', '/system/user/export', '127.0.0.1', '内网IP', '{\"deptId\":\"104\",\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-12-23 11:41:47', 919);
INSERT INTO `sys_oper_log` VALUES (163, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'az', '广发基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"az\",\"deptId\":104,\"nickName\":\"小郑\",\"params\":{},\"postIds\":[],\"roleIds\":[101],\"status\":\"0\",\"userId\":107,\"userName\":\"小郑\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 12:26:07', 163);
INSERT INTO `sys_oper_log` VALUES (164, '用户管理', 4, 'com.ruoyi.web.controller.system.SysUserController.insertAuthRole()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/user/authRole', '127.0.0.1', '内网IP', '{\"roleIds\":\"102\",\"userId\":\"106\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 12:57:58', 84);
INSERT INTO `sys_oper_log` VALUES (165, '用户管理', 4, 'com.ruoyi.web.controller.system.SysUserController.insertAuthRole()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/user/authRole', '127.0.0.1', '内网IP', '{\"roleIds\":\"102\",\"userId\":\"107\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 12:58:06', 84);
INSERT INTO `sys_oper_log` VALUES (166, '用户管理', 4, 'com.ruoyi.web.controller.system.SysUserController.insertAuthRole()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/user/authRole', '127.0.0.1', '内网IP', '{\"roleIds\":\"101\",\"userId\":\"106\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 12:58:54', 63);
INSERT INTO `sys_oper_log` VALUES (167, '用户管理', 4, 'com.ruoyi.web.controller.system.SysUserController.insertAuthRole()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/user/authRole', '127.0.0.1', '内网IP', '{\"roleIds\":\"101\",\"userId\":\"107\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 12:59:03', 65);
INSERT INTO `sys_oper_log` VALUES (168, '用户管理', 5, 'com.ruoyi.web.controller.system.SysUserController.export()', 'POST', 1, 'az', '广发基金管理有限公司', '/system/user/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-12-23 14:31:51', 1636);
INSERT INTO `sys_oper_log` VALUES (169, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'zz', 'Developer', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-12-20 13:40:35\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,101,107,1000,1001,1002,1003,1004,1005,1007,103,1016,1017,1018,1019,1035],\"params\":{},\"roleId\":101,\"roleKey\":\"FundAgent\",\"roleName\":\"基金业务员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"zz\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 16:28:00', 190);
INSERT INTO `sys_oper_log` VALUES (170, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'zz', 'Developer', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-12-20 13:40:35\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":101,\"roleKey\":\"FundAgent\",\"roleName\":\"基金业务员\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 16:29:56', 86);
INSERT INTO `sys_oper_log` VALUES (171, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'zz', 'Developer', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-12-20 13:40:35\",\"dataScope\":\"3\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":101,\"roleKey\":\"FundAgent\",\"roleName\":\"基金业务员\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 16:31:35', 86);
INSERT INTO `sys_oper_log` VALUES (172, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'zz', 'Developer', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-12-20 13:40:35\",\"dataScope\":\"3\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,107,1000,1001,1002,1003,1004,1005,103,1016,1017,1018,1019,1035],\"params\":{},\"roleId\":101,\"roleKey\":\"FundAgent\",\"roleName\":\"基金业务员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"zz\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 16:33:37', 164);
INSERT INTO `sys_oper_log` VALUES (173, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'zz', 'Developer', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"zz\",\"deptId\":208,\"nickName\":\"郑先生\",\"params\":{},\"postIds\":[],\"roleIds\":[102],\"status\":\"0\",\"userId\":108,\"userName\":\"郑先生\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 16:40:51', 155);
INSERT INTO `sys_oper_log` VALUES (174, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'zz', 'Developer', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-12-20 13:40:35\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":101,\"roleKey\":\"FundAgent\",\"roleName\":\"基金业务员\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 16:41:53', 112);
INSERT INTO `sys_oper_log` VALUES (175, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.changeStatus()', 'PUT', 1, 'az', '广发基金管理有限公司', '/system/user/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"status\":\"1\",\"updateBy\":\"az\",\"userId\":108}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 17:42:46', 58);
INSERT INTO `sys_oper_log` VALUES (176, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.changeStatus()', 'PUT', 1, 'az', '广发基金管理有限公司', '/system/user/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"status\":\"0\",\"updateBy\":\"az\",\"userId\":108}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-23 17:42:46', 47);
INSERT INTO `sys_oper_log` VALUES (177, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fLevel\":3,\"fName\":\"ABCD\",\"fSize\":3,\"fStartTime\":\"2023-12-04\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,                          f_start_time,                          f_level )           values ( ?,                          ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 02:24:17', 214);
INSERT INTO `sys_oper_log` VALUES (178, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"1\",\"fLevel\":3,\"fMonitor\":\"1\",\"fName\":\"ABCD\",\"fOverview\":\"1\",\"fSize\":3,\"fStartTime\":\"2023-12-04\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,             f_monitor,             f_start_time,             f_company,             f_level,                          f_overview )           values ( ?,                          ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 02:24:37', 18);
INSERT INTO `sys_oper_log` VALUES (179, '基金管理', 5, 'com.ruoyi.fund.controller.FundInfoController.export()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement/export', '127.0.0.1', '内网IP', '{\"fLevel\":\"0\",\"fSize\":\"0\",\"fRiskLevel\":\"0\",\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-12-24 02:25:45', 620);
INSERT INTO `sys_oper_log` VALUES (180, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":102,\"email\":\"1234@qq.com\",\"nickName\":\"1234\",\"params\":{},\"phonenumber\":\"14111111111\",\"postIds\":[1],\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userId\":109,\"userName\":\"1234\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-24 02:28:00', 236);
INSERT INTO `sys_oper_log` VALUES (181, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/system/user/109', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-24 02:28:08', 94);
INSERT INTO `sys_oper_log` VALUES (182, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"102\",\"fLevel\":3,\"fMonitor\":\"kaizheng\",\"fName\":\"1234\",\"fOverview\":\"1234\",\"fSize\":3,\"fStartTime\":\"2023-12-05\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,             f_monitor,             f_start_time,             f_company,             f_level,                          f_overview )           values ( ?,                          ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 05:12:51', 32);
INSERT INTO `sys_oper_log` VALUES (183, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"102\",\"fLevel\":3,\"fMonitor\":\"kaizheng\",\"fName\":\"1234\",\"fOverview\":\"1234\",\"fSize\":3,\"fStartTime\":\"2023-12-05\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,             f_monitor,             f_start_time,             f_company,             f_level,                          f_overview )           values ( ?,                          ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 05:16:29', 30);
INSERT INTO `sys_oper_log` VALUES (184, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"102\",\"fLevel\":3,\"fMonitor\":\"kaizheng\",\"fName\":\"1234\",\"fOverview\":\"1234\",\"fSize\":3,\"fStartTime\":\"2023-12-05\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,             f_monitor,             f_start_time,             f_company,             f_level,                          f_overview )           values ( ?,                          ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 05:17:15', 19);
INSERT INTO `sys_oper_log` VALUES (185, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"102\",\"fLevel\":3,\"fMonitor\":\"kaizheng\",\"fName\":\"1234\",\"fOverview\":\"1234\",\"fSize\":3,\"fStartTime\":\"2023-12-05\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,             f_monitor,             f_start_time,             f_company,             f_level,                          f_overview )           values ( ?,                          ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 05:17:30', 41);
INSERT INTO `sys_oper_log` VALUES (186, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"102\",\"fLevel\":3,\"fMonitor\":\"kaizheng\",\"fName\":\"1234\",\"fOverview\":\"1234\",\"fSize\":3,\"fStartTime\":\"2023-12-05\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,             f_monitor,             f_start_time,             f_company,             f_level,                          f_overview )           values ( ?,                          ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 05:18:51', 30);
INSERT INTO `sys_oper_log` VALUES (187, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"102\",\"fLevel\":3,\"fMonitor\":\"kaizheng\",\"fName\":\"1234\",\"fOverview\":\"1234\",\"fSize\":3,\"fStartTime\":\"2023-12-05\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,             f_monitor,             f_start_time,             f_company,             f_level,                          f_overview )           values ( ?,                          ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 05:20:31', 35);
INSERT INTO `sys_oper_log` VALUES (188, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"102\",\"fLevel\":3,\"fMonitor\":\"kaizheng\",\"fName\":\"1234\",\"fOverview\":\"1234\",\"fSize\":3,\"fStartTime\":\"2023-12-05\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,             f_monitor,             f_start_time,             f_company,             f_level,                          f_overview )           values ( ?,                          ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 05:20:57', 21);
INSERT INTO `sys_oper_log` VALUES (189, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"102\",\"fLevel\":3,\"fMonitor\":\"kaizheng\",\"fName\":\"1234\",\"fOverview\":\"1234\",\"fSize\":3,\"fStartTime\":\"2023-12-05\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,             f_monitor,             f_start_time,             f_company,             f_level,                          f_overview )           values ( ?,                          ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 05:21:18', 21);
INSERT INTO `sys_oper_log` VALUES (190, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"102\",\"fLevel\":3,\"fMonitor\":\"kaizheng\",\"fName\":\"1234\",\"fOverview\":\"1234\",\"fSize\":3,\"fStartTime\":\"2023-12-05\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,             f_monitor,             f_start_time,             f_company,             f_level,                          f_overview )           values ( ?,                          ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 05:21:22', 23);
INSERT INTO `sys_oper_log` VALUES (191, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"100\",\"fLevel\":3,\"fMonitor\":\"1234\",\"fName\":\"1234\",\"fOverview\":\"1234\",\"fSize\":3,\"fStartTime\":\"2023-12-05\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,             f_monitor,             f_start_time,             f_company,             f_level,                          f_overview )           values ( ?,                          ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 05:41:42', 181);
INSERT INTO `sys_oper_log` VALUES (192, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"101\",\"fLevel\":3,\"fMonitor\":\"1234\",\"fName\":\"1234\",\"fOverview\":\"1111\",\"fRiskLevel\":3,\"fSize\":3,\"fStartTime\":\"2023-12-05\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\fund_manage\\FundInfoMapper.xml]\r\n### The error may involve com.ruoyi.fund.mapper.FundInfoMapper.insertFundInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Fund_Info          ( f_name,                          f_size,             f_monitor,             f_start_time,             f_company,             f_level,             f_risk_level,             f_overview )           values ( ?,                          ?,             ?,             ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'f_id\' doesn\'t have a default value\n; Field \'f_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_id\' doesn\'t have a default value', '2023-12-24 05:42:49', 16);
INSERT INTO `sys_oper_log` VALUES (193, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"104\",\"fLevel\":3,\"fMonitor\":\"test\",\"fName\":\"1234\",\"fOverview\":\"test01\",\"fRiskLevel\":3,\"fSize\":3,\"fStartTime\":\"2023-12-24\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-24 06:02:16', 121);
INSERT INTO `sys_oper_log` VALUES (194, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'az', '广发基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"az\",\"credID\":\"null\",\"credType\":\"0\",\"deptId\":208,\"nickName\":\"pzone\",\"params\":{},\"phonenumber\":\"15356101111\",\"postIds\":[],\"riskLevel\":\"0\",\"roleIds\":[102],\"sex\":\"2\",\"status\":\"0\",\"userId\":110,\"userName\":\"pz\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-24 07:01:53', 236);
INSERT INTO `sys_oper_log` VALUES (195, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'az', '广发基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"az\",\"createTime\":\"2023-12-24 07:01:53\",\"credID\":\"null\",\"credType\":\"0\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101,104\",\"children\":[],\"deptId\":208,\"deptName\":\"京东金融\",\"orderNum\":0,\"params\":{},\"parentId\":104,\"status\":\"0\"},\"deptId\":208,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"pzone\",\"params\":{},\"phonenumber\":\"15356101111\",\"postIds\":[],\"riskLevel\":\"1\",\"roleIds\":[102],\"roles\":[{\"admin\":false,\"dataScope\":\"5\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":102,\"roleKey\":\"Client\",\"roleName\":\"客户\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"2\",\"status\":\"0\",\"updateBy\":\"az\",\"userId\":110,\"userName\":\"pz\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'0\',\n			\'null\',\n			\n			\'1\',\n 			update_time = sysdate() \n 		where user_id = 110\' at line 15\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET dept_id = ?,     user_name = ?,     nick_name = ?,     email = ?,     phonenumber = ?,     sex = ?,               status = ?,               update_by = ?,         ?,    ?,        ?,     update_time = sysdate()     where user_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'0\',\n			\'null\',\n			\n			\'1\',\n 			update_time = sysdate() \n 		where user_id = 110\' at line 15\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'0\',\n			\'null\',\n			\n			\'1\',\n 			update_time = sysdate() \n 		where user_id = 110\' at line 15', '2023-12-24 07:05:18', 462);
INSERT INTO `sys_oper_log` VALUES (196, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'az', '广发基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"az\",\"createTime\":\"2023-12-24 07:01:53\",\"credID\":\"null\",\"credType\":\"0\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101,104\",\"children\":[],\"deptId\":208,\"deptName\":\"京东金融\",\"orderNum\":0,\"params\":{},\"parentId\":104,\"status\":\"0\"},\"deptId\":208,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"pzone\",\"params\":{},\"phonenumber\":\"15356101111\",\"postIds\":[],\"riskLevel\":\"1\",\"roleIds\":[102],\"roles\":[{\"admin\":false,\"dataScope\":\"5\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":102,\"roleKey\":\"Client\",\"roleName\":\"客户\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"2\",\"status\":\"0\",\"updateBy\":\"az\",\"userId\":110,\"userName\":\"pz\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'0\',\n			\'null\',\n			\n			\'1\',\n 			update_time = sysdate() \n 		where user_id = 110\' at line 15\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET dept_id = ?,     user_name = ?,     nick_name = ?,     email = ?,     phonenumber = ?,     sex = ?,               status = ?,               update_by = ?,         ?,    ?,        ?,     update_time = sysdate()     where user_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'0\',\n			\'null\',\n			\n			\'1\',\n 			update_time = sysdate() \n 		where user_id = 110\' at line 15\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'0\',\n			\'null\',\n			\n			\'1\',\n 			update_time = sysdate() \n 		where user_id = 110\' at line 15', '2023-12-24 07:06:09', 122);
INSERT INTO `sys_oper_log` VALUES (197, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'az', '广发基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"az\",\"createTime\":\"2023-12-24 07:01:53\",\"credID\":\"null\",\"credType\":\"0\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101,104\",\"children\":[],\"deptId\":208,\"deptName\":\"京东金融\",\"orderNum\":0,\"params\":{},\"parentId\":104,\"status\":\"0\"},\"deptId\":208,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"pzone\",\"params\":{},\"phonenumber\":\"15356101111\",\"postIds\":[],\"riskLevel\":\"1\",\"roleIds\":[102],\"roles\":[{\"admin\":false,\"dataScope\":\"5\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":102,\"roleKey\":\"Client\",\"roleName\":\"客户\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"2\",\"status\":\"0\",\"updateBy\":\"az\",\"userId\":110,\"userName\":\"pz\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'0\',\n			\'null\',\n			\n			\'1\',\n 			update_time = sysdate() \n 		where user_id = 110\' at line 15\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET dept_id = ?,     user_name = ?,     nick_name = ?,     email = ?,     phonenumber = ?,     sex = ?,               status = ?,               update_by = ?,         ?,    ?,        ?,     update_time = sysdate()     where user_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'0\',\n			\'null\',\n			\n			\'1\',\n 			update_time = sysdate() \n 		where user_id = 110\' at line 15\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'0\',\n			\'null\',\n			\n			\'1\',\n 			update_time = sysdate() \n 		where user_id = 110\' at line 15', '2023-12-24 07:08:34', 149);
INSERT INTO `sys_oper_log` VALUES (198, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'az', '广发基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"zz\",\"createTime\":\"2023-12-23 16:40:50\",\"credID\":\"111\",\"credType\":\"0\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101,104\",\"children\":[],\"deptId\":208,\"deptName\":\"京东金融\",\"orderNum\":0,\"params\":{},\"parentId\":104,\"status\":\"0\"},\"deptId\":208,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"郑先生\",\"params\":{},\"phonenumber\":\"15356201811\",\"postIds\":[],\"riskLevel\":\"1\",\"roleIds\":[102],\"roles\":[{\"admin\":false,\"dataScope\":\"5\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":102,\"roleKey\":\"Client\",\"roleName\":\"客户\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"userId\":108,\"userName\":\"郑先生\"}', '{\"msg\":\"修改用户\'郑先生\'失败，手机号码已存在\",\"code\":500}', 0, NULL, '2023-12-24 07:09:22', 57);
INSERT INTO `sys_oper_log` VALUES (199, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'az', '广发基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"zz\",\"createTime\":\"2023-12-23 16:40:50\",\"credID\":\"111\",\"credType\":\"0\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101,104\",\"children\":[],\"deptId\":208,\"deptName\":\"京东金融\",\"orderNum\":0,\"params\":{},\"parentId\":104,\"status\":\"0\"},\"deptId\":208,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"郑先生\",\"params\":{},\"phonenumber\":\"15356201810\",\"postIds\":[],\"riskLevel\":\"1\",\"roleIds\":[102],\"roles\":[{\"admin\":false,\"dataScope\":\"5\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":102,\"roleKey\":\"Client\",\"roleName\":\"客户\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"az\",\"userId\":108,\"userName\":\"郑先生\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'c_riskLevel\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET dept_id = ?,     user_name = ?,     nick_name = ?,     email = ?,     phonenumber = ?,     sex = ?,               status = ?,               update_by = ?,         c_ID_type = ?,    c_ID = ?,        c_riskLevel = ?,     update_time = sysdate()     where user_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'c_riskLevel\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'c_riskLevel\' in \'field list\'', '2023-12-24 07:09:27', 224);
INSERT INTO `sys_oper_log` VALUES (200, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'az', '广发基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"zz\",\"createTime\":\"2023-12-23 16:40:50\",\"credID\":\"111\",\"credType\":\"0\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101,104\",\"children\":[],\"deptId\":208,\"deptName\":\"京东金融\",\"orderNum\":0,\"params\":{},\"parentId\":104,\"status\":\"0\"},\"deptId\":208,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"郑先生\",\"params\":{},\"phonenumber\":\"15356201810\",\"postIds\":[],\"riskLevel\":\"1\",\"roleIds\":[102],\"roles\":[{\"admin\":false,\"dataScope\":\"5\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":102,\"roleKey\":\"Client\",\"roleName\":\"客户\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"az\",\"userId\":108,\"userName\":\"郑先生\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'c_riskLevel\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET dept_id = ?,     user_name = ?,     nick_name = ?,     email = ?,     phonenumber = ?,     sex = ?,               status = ?,               update_by = ?,         c_ID_type = ?,    c_ID = ?,        c_riskLevel = ?,     update_time = sysdate()     where user_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'c_riskLevel\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'c_riskLevel\' in \'field list\'', '2023-12-24 07:09:33', 144);
INSERT INTO `sys_oper_log` VALUES (201, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'az', '广发基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"zz\",\"createTime\":\"2023-12-23 16:40:50\",\"credID\":\"111\",\"credType\":\"0\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101,104\",\"children\":[],\"deptId\":208,\"deptName\":\"京东金融\",\"orderNum\":0,\"params\":{},\"parentId\":104,\"status\":\"0\"},\"deptId\":208,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"郑先生\",\"params\":{},\"phonenumber\":\"15356201810\",\"postIds\":[],\"riskLevel\":\"1\",\"roleIds\":[102],\"roles\":[{\"admin\":false,\"dataScope\":\"5\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":102,\"roleKey\":\"Client\",\"roleName\":\"客户\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"az\",\"userId\":108,\"userName\":\"郑先生\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-24 07:10:33', 326);
INSERT INTO `sys_oper_log` VALUES (202, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"fund_manage/FundManagement/index\",\"createTime\":\"2023-12-23 05:27:04\",\"icon\":\"rate\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"基金管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"FundManagement\",\"perms\":\"fund_manage:FundManagement:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-24 07:11:25', 61);
INSERT INTO `sys_oper_log` VALUES (203, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"User_Card\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-24 07:34:09', 174);
INSERT INTO `sys_oper_log` VALUES (204, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"User_Card\"}', NULL, 0, NULL, '2023-12-24 07:34:39', 70);
INSERT INTO `sys_oper_log` VALUES (205, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/Card/index\",\"createBy\":\"admin\",\"icon\":\"money\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"银行卡管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"Card\",\"perms\":\"system:Card:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-24 08:50:36', 142);
INSERT INTO `sys_oper_log` VALUES (206, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"User_Card\"}', NULL, 0, NULL, '2023-12-26 08:55:25', 193);
INSERT INTO `sys_oper_log` VALUES (207, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"sys_user\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 08:56:59', 600);
INSERT INTO `sys_oper_log` VALUES (208, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"sys_user,User_Card\"}', NULL, 0, NULL, '2023-12-26 08:57:25', 111);
INSERT INTO `sys_oper_log` VALUES (209, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"card\",\"className\":\"UserCard\",\"columns\":[{\"capJavaField\":\"CardId\",\"columnComment\":\"银行卡号\",\"columnId\":20,\"columnName\":\"card_id\",\"columnType\":\"char(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"持卡人ID\",\"columnId\":21,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CardAmount\",\"columnComment\":\"金额\",\"columnId\":22,\"columnName\":\"card_amount\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardAmount\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CardStatus\",\"columnComment\":\"卡状态（0正常 1停用）\",\"columnId\":23,\"columnName\":\"card_status\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"j', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 09:21:41', 158);
INSERT INTO `sys_oper_log` VALUES (210, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"card\",\"className\":\"UserCard\",\"columns\":[{\"capJavaField\":\"CardId\",\"columnComment\":\"银行卡号\",\"columnId\":20,\"columnName\":\"card_id\",\"columnType\":\"char(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:21:41\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"持卡人ID\",\"columnId\":21,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:21:41\",\"usableColumn\":false},{\"capJavaField\":\"CardAmount\",\"columnComment\":\"金额\",\"columnId\":22,\"columnName\":\"card_amount\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardAmount\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:21:41\",\"usableColumn\":false},{\"capJavaField\":\"CardStatus\",\"columnComment\":\"卡状态（0正常 1停用）\",\"columnId\":23,\"columnName\":\"card_status\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":tru', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 09:23:01', 123);
INSERT INTO `sys_oper_log` VALUES (211, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"card\",\"className\":\"UserCard\",\"columns\":[{\"capJavaField\":\"CardId\",\"columnComment\":\"银行卡号\",\"columnId\":20,\"columnName\":\"card_id\",\"columnType\":\"char(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:23:01\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"持卡人ID\",\"columnId\":21,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:23:01\",\"usableColumn\":false},{\"capJavaField\":\"CardAmount\",\"columnComment\":\"金额\",\"columnId\":22,\"columnName\":\"card_amount\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardAmount\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:23:01\",\"usableColumn\":false},{\"capJavaField\":\"CardStatus\",\"columnComment\":\"卡状态（0正常 1停用）\",\"columnId\":23,\"columnName\":\"card_status\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":tru', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 09:23:16', 139);
INSERT INTO `sys_oper_log` VALUES (212, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"User_Card\"}', NULL, 0, NULL, '2023-12-26 09:23:21', 144);
INSERT INTO `sys_oper_log` VALUES (213, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"card\",\"className\":\"UserCard\",\"columns\":[{\"capJavaField\":\"CardId\",\"columnComment\":\"银行卡号\",\"columnId\":20,\"columnName\":\"card_id\",\"columnType\":\"char(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:23:16\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"持卡人ID\",\"columnId\":21,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:23:16\",\"usableColumn\":false},{\"capJavaField\":\"CardAmount\",\"columnComment\":\"金额\",\"columnId\":22,\"columnName\":\"card_amount\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardAmount\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:23:16\",\"usableColumn\":false},{\"capJavaField\":\"CardStatus\",\"columnComment\":\"卡状态（0正常 1停用）\",\"columnId\":23,\"columnName\":\"card_status\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":tru', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 09:23:34', 133);
INSERT INTO `sys_oper_log` VALUES (214, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"User_Card\"}', NULL, 0, NULL, '2023-12-26 09:23:47', 67);
INSERT INTO `sys_oper_log` VALUES (215, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"CardManagement\",\"className\":\"UserCard\",\"columns\":[{\"capJavaField\":\"CardId\",\"columnComment\":\"银行卡号\",\"columnId\":20,\"columnName\":\"card_id\",\"columnType\":\"char(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:23:34\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"持卡人ID\",\"columnId\":21,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:23:34\",\"usableColumn\":false},{\"capJavaField\":\"CardAmount\",\"columnComment\":\"金额\",\"columnId\":22,\"columnName\":\"card_amount\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardAmount\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:23:34\",\"usableColumn\":false},{\"capJavaField\":\"CardStatus\",\"columnComment\":\"卡状态（0正常 1停用）\",\"columnId\":23,\"columnName\":\"card_status\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 09:26:49', 144);
INSERT INTO `sys_oper_log` VALUES (216, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"User_Card\"}', NULL, 0, NULL, '2023-12-26 09:27:02', 55);
INSERT INTO `sys_oper_log` VALUES (217, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"CardManagement\",\"className\":\"UserCard\",\"columns\":[{\"capJavaField\":\"CardId\",\"columnComment\":\"银行卡号\",\"columnId\":20,\"columnName\":\"card_id\",\"columnType\":\"char(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:26:49\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"持卡人ID\",\"columnId\":21,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:26:49\",\"usableColumn\":false},{\"capJavaField\":\"CardAmount\",\"columnComment\":\"金额\",\"columnId\":22,\"columnName\":\"card_amount\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardAmount\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:26:49\",\"usableColumn\":false},{\"capJavaField\":\"CardStatus\",\"columnComment\":\"卡状态（0正常 1停用）\",\"columnId\":23,\"columnName\":\"card_status\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 09:40:27', 172);
INSERT INTO `sys_oper_log` VALUES (218, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"User_Card\"}', NULL, 0, NULL, '2023-12-26 09:40:40', 158);
INSERT INTO `sys_oper_log` VALUES (219, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"CardManagement\",\"className\":\"UserCard\",\"columns\":[{\"capJavaField\":\"CardId\",\"columnComment\":\"银行卡号\",\"columnId\":20,\"columnName\":\"card_id\",\"columnType\":\"char(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:40:27\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"持卡人ID\",\"columnId\":21,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:40:27\",\"usableColumn\":false},{\"capJavaField\":\"CardAmount\",\"columnComment\":\"金额\",\"columnId\":22,\"columnName\":\"card_amount\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"cardAmount\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 09:40:27\",\"usableColumn\":false},{\"capJavaField\":\"CardStatus\",\"columnComment\":\"卡状态（0正常 1停用）\",\"columnId\":23,\"columnName\":\"card_status\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 10:33:55', 217);
INSERT INTO `sys_oper_log` VALUES (220, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"User_Card\"}', NULL, 0, NULL, '2023-12-26 10:34:01', 151);
INSERT INTO `sys_oper_log` VALUES (221, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"card/CardManagement/index\",\"createTime\":\"2023-12-26 10:30:12\",\"icon\":\"money\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2019,\"menuName\":\"银行卡管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":1,\"path\":\"CardManagement\",\"perms\":\"card:CardManagement:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 10:39:47', 59);
INSERT INTO `sys_oper_log` VALUES (222, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"params\":{},\"userId\":2154314}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'card_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.insertUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into User_Card          ( user_id,             card_amount )           values ( ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'card_id\' doesn\'t have a default value\n; Field \'card_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'card_id\' doesn\'t have a default value', '2023-12-26 10:40:30', 85);
INSERT INTO `sys_oper_log` VALUES (223, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"params\":{},\"userId\":2154314}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'card_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.insertUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into User_Card          ( user_id,             card_amount )           values ( ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'card_id\' doesn\'t have a default value\n; Field \'card_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'card_id\' doesn\'t have a default value', '2023-12-26 10:40:36', 18);
INSERT INTO `sys_oper_log` VALUES (224, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"CardManagement\",\"className\":\"UserCard\",\"columns\":[{\"capJavaField\":\"CardId\",\"columnComment\":\"银行卡号\",\"columnId\":20,\"columnName\":\"card_id\",\"columnType\":\"char(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 10:33:55\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"持卡人ID\",\"columnId\":21,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 10:33:55\",\"usableColumn\":false},{\"capJavaField\":\"CardAmount\",\"columnComment\":\"金额\",\"columnId\":22,\"columnName\":\"card_amount\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:08\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"cardAmount\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 10:33:55\",\"usableColumn\":false},{\"capJavaField\":\"CardStatus\",\"columnComment\":\"卡状态（0正常 1停用）\",\"columnId\":23,\"columnName\":\"card_status\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-24 07:34:09\",\"dictType\":\"\",\"edit\":true', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 10:42:04', 177);
INSERT INTO `sys_oper_log` VALUES (225, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"User_Card\"}', NULL, 0, NULL, '2023-12-26 10:42:22', 164);
INSERT INTO `sys_oper_log` VALUES (226, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"params\":{},\"userId\":2154314}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'card_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.insertUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into User_Card          ( user_id,             card_amount )           values ( ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'card_id\' doesn\'t have a default value\n; Field \'card_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'card_id\' doesn\'t have a default value', '2023-12-26 10:52:24', 166);
INSERT INTO `sys_oper_log` VALUES (227, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"1234\",\"params\":{},\"userId\":2154314}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-26 11:01:29', 19);
INSERT INTO `sys_oper_log` VALUES (228, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"1234\",\"params\":{},\"userId\":2154314}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-26 11:01:41', 22);
INSERT INTO `sys_oper_log` VALUES (229, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"1234\",\"params\":{},\"userId\":2154314}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-26 11:03:19', 29);
INSERT INTO `sys_oper_log` VALUES (230, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"1234\",\"params\":{},\"userId\":2154314}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-26 11:08:54', 21);
INSERT INTO `sys_oper_log` VALUES (231, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"1234\",\"params\":{},\"userId\":2154314}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-26 11:14:11', 25);
INSERT INTO `sys_oper_log` VALUES (232, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"1234\",\"params\":{},\"userId\":2154314}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-26 11:14:43', 18);
INSERT INTO `sys_oper_log` VALUES (233, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"1234\",\"params\":{},\"userId\":2154314}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-26 11:14:49', 18);
INSERT INTO `sys_oper_log` VALUES (234, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"1234\",\"params\":{},\"userId\":2154314}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-26 11:18:28', 26);
INSERT INTO `sys_oper_log` VALUES (235, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"12345\",\"params\":{},\"userId\":2154314}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`))\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.insertUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into User_Card          ( card_id,             user_id,             card_amount )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`))\n; Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`))', '2023-12-26 11:18:45', 281);
INSERT INTO `sys_oper_log` VALUES (236, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"12345\",\"params\":{},\"userId\":2154314}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`))\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.insertUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into User_Card          ( card_id,             user_id,             card_amount )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`))\n; Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`))', '2023-12-26 11:19:20', 24);
INSERT INTO `sys_oper_log` VALUES (237, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"2154314001\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 11:23:07', 29);
INSERT INTO `sys_oper_log` VALUES (238, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2400,\"cardId\":\"2154314001\",\"params\":{},\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'2154314001\' for key \'User_Card.PRIMARY\'\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.insertUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into User_Card          ( card_id,             user_id,             card_amount )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'2154314001\' for key \'User_Card.PRIMARY\'\n; Duplicate entry \'2154314001\' for key \'User_Card.PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'2154314001\' for key \'User_Card.PRIMARY\'', '2023-12-26 11:25:12', 22);
INSERT INTO `sys_oper_log` VALUES (239, '银行卡管理', 3, 'com.ruoyi.card.controller.UserCardController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement/2154314001', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 13:29:20', 38);
INSERT INTO `sys_oper_log` VALUES (240, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"2154314\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 13:29:34', 31);
INSERT INTO `sys_oper_log` VALUES (241, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"2154101\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 13:29:56', 28);
INSERT INTO `sys_oper_log` VALUES (242, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":100,\"cardId\":\"2154444\",\"params\":{},\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 13:51:02', 26);
INSERT INTO `sys_oper_log` VALUES (243, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":200,\"cardId\":\"2154444\",\"params\":{},\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 13:51:13', 32);
INSERT INTO `sys_oper_log` VALUES (244, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2500,\"cardId\":\"2154313\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-26 13:51:41', 18);
INSERT INTO `sys_oper_log` VALUES (245, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":250,\"cardId\":\"2154314\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 13:51:53', 29);
INSERT INTO `sys_oper_log` VALUES (246, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":25000,\"cardId\":\"2154314\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:19:37', 32);
INSERT INTO `sys_oper_log` VALUES (247, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":100,\"cardId\":\"19999999\",\"params\":{},\"userId\":104}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:27:43', 27);
INSERT INTO `sys_oper_log` VALUES (248, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":3,\"cardId\":\"101\",\"params\":{},\"userId\":2154314}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`))\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.insertUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into User_Card          ( card_id,             user_id,             card_amount )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`))\n; Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`))', '2023-12-26 14:28:20', 25);
INSERT INTO `sys_oper_log` VALUES (249, '银行卡管理', 3, 'com.ruoyi.card.controller.UserCardController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement/2154444', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:34:23', 30);
INSERT INTO `sys_oper_log` VALUES (250, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":100,\"cardId\":\"19999999\",\"params\":{},\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:34:27', 38);
INSERT INTO `sys_oper_log` VALUES (251, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":101,\"cardId\":\"19999999\",\"params\":{},\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:37:36', 59);
INSERT INTO `sys_oper_log` VALUES (252, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":103,\"cardId\":\"19999999\",\"params\":{},\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:38:08', 33);
INSERT INTO `sys_oper_log` VALUES (253, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":104,\"cardId\":\"19999999\",\"params\":{},\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:40:04', 91);
INSERT INTO `sys_oper_log` VALUES (254, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":105,\"cardId\":\"19999999\",\"params\":{},\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:40:35', 30);
INSERT INTO `sys_oper_log` VALUES (255, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":106,\"cardId\":\"19999999\",\"params\":{},\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:41:36', 32);
INSERT INTO `sys_oper_log` VALUES (256, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":107,\"cardId\":\"19999999\",\"params\":{},\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:41:45', 44);
INSERT INTO `sys_oper_log` VALUES (257, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":106,\"cardId\":\"19999999\",\"params\":{},\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:42:01', 29);
INSERT INTO `sys_oper_log` VALUES (258, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":105,\"cardId\":\"19999999\",\"params\":{},\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:42:07', 37);
INSERT INTO `sys_oper_log` VALUES (259, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":104,\"cardId\":\"19999999\",\"params\":{},\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:42:17', 55);
INSERT INTO `sys_oper_log` VALUES (260, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":103,\"cardId\":\"19999999\",\"params\":{},\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 14:44:47', 27);
INSERT INTO `sys_oper_log` VALUES (261, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":103,\"cardId\":\"19999999\",\"params\":{},\"userId\":1058}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`))\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.updateUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update User_Card          SET user_id = ?,             card_amount = ?          where card_id = ?\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`))\n; Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry`.`User_Card`, CONSTRAINT `PK_card_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`))', '2023-12-26 14:45:45', 30);
INSERT INTO `sys_oper_log` VALUES (262, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":100,\"cardId\":\"114514\",\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 15:10:54', 150);
INSERT INTO `sys_oper_log` VALUES (263, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":99,\"cardId\":\"114514\",\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 15:11:03', 51);
INSERT INTO `sys_oper_log` VALUES (264, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"trans\",\"className\":\"TransactionInfo\",\"columns\":[{\"capJavaField\":\"FStreamId\",\"columnComment\":\"交易流水编号\",\"columnId\":12,\"columnName\":\"f_stream_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 07:38:19\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"fStreamId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户内部代码\",\"columnId\":13,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 07:38:19\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CardId\",\"columnComment\":\"使用的银行卡号\",\"columnId\":14,\"columnName\":\"card_id\",\"columnType\":\"char(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 07:38:19\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FId\",\"columnComment\":\"基金代码\",\"columnId\":15,\"columnName\":\"f_id\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 07:38:19\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"ja', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 15:22:01', 673);
INSERT INTO `sys_oper_log` VALUES (265, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"Transaction_Info\"}', NULL, 0, NULL, '2023-12-26 15:22:07', 324);
INSERT INTO `sys_oper_log` VALUES (266, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"trans\",\"className\":\"TransactionInfo\",\"columns\":[{\"capJavaField\":\"FStreamId\",\"columnComment\":\"交易流水编号\",\"columnId\":12,\"columnName\":\"f_stream_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 07:38:19\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"fStreamId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 15:22:00\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户内部代码\",\"columnId\":13,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 07:38:19\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 15:22:00\",\"usableColumn\":false},{\"capJavaField\":\"CardId\",\"columnComment\":\"使用的银行卡号\",\"columnId\":14,\"columnName\":\"card_id\",\"columnType\":\"char(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 07:38:19\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cardId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2023-12-26 15:22:01\",\"usableColumn\":false},{\"capJavaField\":\"FId\",\"columnComment\":\"基金代码\",\"columnId\":15,\"columnName\":\"f_id\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2023-12-23 07:38:19\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 15:24:48', 897);
INSERT INTO `sys_oper_log` VALUES (267, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '易方达基金管理有限公司', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"Transaction_Info\"}', NULL, 0, NULL, '2023-12-26 15:24:51', 82);
INSERT INTO `sys_oper_log` VALUES (268, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"transaction_manage/trans/index\",\"createTime\":\"2023-12-26 15:27:24\",\"icon\":\"size\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2025,\"menuName\":\"业务管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"trans\",\"perms\":\"transaction_manage:trans:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 15:31:11', 120);
INSERT INTO `sys_oper_log` VALUES (269, 'trans', 5, 'com.ruoyi.trans.controller.TransactionInfoController.export()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-12-26 15:31:20', 1120);
INSERT INTO `sys_oper_log` VALUES (270, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":99,\"cardId\":\"111\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 15:56:42', 93);
INSERT INTO `sys_oper_log` VALUES (271, '银行卡管理', 3, 'com.ruoyi.card.controller.UserCardController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement/111', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 15:56:52', 66);
INSERT INTO `sys_oper_log` VALUES (272, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":1,\"cardId\":\"101\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 15:57:01', 60);
INSERT INTO `sys_oper_log` VALUES (273, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"111\",\"fDealAmount\":123,\"fDealType\":0,\"fId\":\"123\",\"params\":{},\"userId\":105}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info          ( user_id,             card_id,             f_id,                          f_deal_amount,                          f_deal_type )           values ( ?,             ?,             ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 15:57:02', 191);
INSERT INTO `sys_oper_log` VALUES (274, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"111\",\"fDealAmount\":123,\"fDealType\":0,\"fId\":\"123\",\"params\":{},\"userId\":105}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info          ( user_id,             card_id,             f_id,                          f_deal_amount,                          f_deal_type )           values ( ?,             ?,             ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 15:57:31', 46);
INSERT INTO `sys_oper_log` VALUES (275, '银行卡管理', 3, 'com.ruoyi.card.controller.UserCardController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement/101', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 15:58:15', 52);
INSERT INTO `sys_oper_log` VALUES (276, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":1,\"cardId\":\"111\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 15:58:46', 26);
INSERT INTO `sys_oper_log` VALUES (277, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"111\",\"fDealAmount\":123,\"fDealType\":0,\"fId\":\"123\",\"params\":{},\"userId\":105}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info          ( user_id,             card_id,             f_id,                          f_deal_amount,                          f_deal_type )           values ( ?,             ?,             ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 16:00:10', 46);
INSERT INTO `sys_oper_log` VALUES (278, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"111\",\"fDealAmount\":123,\"fDealType\":0,\"fId\":\"123\",\"params\":{},\"userId\":105}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info          ( user_id,             card_id,             f_id,                          f_deal_amount,                          f_deal_type )           values ( ?,             ?,             ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 16:00:24', 28);
INSERT INTO `sys_oper_log` VALUES (279, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":99,\"cardId\":\"111\",\"params\":{},\"userId\":102}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.insertUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into User_Card          ( card_id,             user_id,             card_amount )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'\n; Duplicate entry \'111\' for key \'User_Card.PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'', '2023-12-26 16:01:28', 107);
INSERT INTO `sys_oper_log` VALUES (280, '银行卡管理', 3, 'com.ruoyi.card.controller.UserCardController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement/111', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:04:03', 30);
INSERT INTO `sys_oper_log` VALUES (281, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":1,\"cardId\":\"111\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:04:11', 55);
INSERT INTO `sys_oper_log` VALUES (282, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":12,\"cardId\":\"111\",\"params\":{},\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.insertUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into User_Card          ( card_id,             user_id,             card_amount )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'\n; Duplicate entry \'111\' for key \'User_Card.PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'', '2023-12-26 16:04:35', 36);
INSERT INTO `sys_oper_log` VALUES (283, '银行卡管理', 3, 'com.ruoyi.card.controller.UserCardController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement/111', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:09:50', 48);
INSERT INTO `sys_oper_log` VALUES (284, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":1,\"cardId\":\"111\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:09:58', 44);
INSERT INTO `sys_oper_log` VALUES (285, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":1,\"cardId\":\"111\",\"params\":{},\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.insertUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into User_Card          ( card_id,             user_id,             card_amount )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'\n; Duplicate entry \'111\' for key \'User_Card.PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'', '2023-12-26 16:10:18', 67);
INSERT INTO `sys_oper_log` VALUES (286, '银行卡管理', 3, 'com.ruoyi.card.controller.UserCardController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement/111', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:11:22', 35);
INSERT INTO `sys_oper_log` VALUES (287, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":1,\"cardId\":\"111\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:11:26', 32);
INSERT INTO `sys_oper_log` VALUES (288, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":2,\"cardId\":\"112\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:13:57', 34);
INSERT INTO `sys_oper_log` VALUES (289, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":1,\"cardId\":\"111\",\"params\":{},\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.insertUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into User_Card          ( card_id,             user_id,             card_amount )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'\n; Duplicate entry \'111\' for key \'User_Card.PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'', '2023-12-26 16:14:15', 115);
INSERT INTO `sys_oper_log` VALUES (290, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"1\",\"fDealAmount\":1,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info          ( user_id,             card_id,             f_id,             f_deal_time,             f_deal_amount,             f_deal_status,             f_deal_type )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 16:18:56', 68);
INSERT INTO `sys_oper_log` VALUES (291, '银行卡管理', 3, 'com.ruoyi.card.controller.UserCardController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement/112', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:20:02', 38);
INSERT INTO `sys_oper_log` VALUES (292, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":1,\"cardId\":\"112\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:20:08', 32);
INSERT INTO `sys_oper_log` VALUES (293, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":1,\"cardId\":\"111\",\"params\":{},\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'\r\n### The error may exist in file [E:\\GitDownload\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.insertUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into User_Card          ( card_id,             user_id,             card_amount )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'\n; Duplicate entry \'111\' for key \'User_Card.PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'111\' for key \'User_Card.PRIMARY\'', '2023-12-26 16:20:44', 76);
INSERT INTO `sys_oper_log` VALUES (294, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"1\",\"fDealAmount\":1,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info          ( user_id,             card_id,             f_id,             f_deal_time,             f_deal_amount,             f_deal_status,             f_deal_type )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 16:21:27', 272);
INSERT INTO `sys_oper_log` VALUES (295, '银行卡管理', 1, 'com.ruoyi.card.controller.UserCardController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":1,\"cardId\":\"1111\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:22:16', 36);
INSERT INTO `sys_oper_log` VALUES (296, '银行卡管理', 3, 'com.ruoyi.card.controller.UserCardController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement/111,1111,112', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:22:28', 37);
INSERT INTO `sys_oper_log` VALUES (297, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"1\",\"fDealAmount\":1,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info          ( user_id,             card_id,             f_id,             f_deal_time,             f_deal_amount,             f_deal_status,             f_deal_type )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 16:23:51', 44);
INSERT INTO `sys_oper_log` VALUES (298, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":199,\"cardId\":\"114514\",\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:26:35', 32);
INSERT INTO `sys_oper_log` VALUES (299, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":299,\"cardId\":\"114514\",\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:26:40', 39);
INSERT INTO `sys_oper_log` VALUES (300, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"1\",\"fDealAmount\":1,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info          ( user_id,             card_id,             f_id,             f_deal_time,             f_deal_amount,             f_deal_status,             f_deal_type )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 16:33:51', 547937);
INSERT INTO `sys_oper_log` VALUES (301, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":103,\"cardId\":\"19999999\",\"params\":{},\"userId\":107}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:35:32', 36);
INSERT INTO `sys_oper_log` VALUES (302, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"1\",\"fDealAmount\":1,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info          ( user_id,             card_id,             f_id,             f_deal_time,             f_deal_amount,             f_deal_status,             f_deal_type )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 16:36:09', 104722);
INSERT INTO `sys_oper_log` VALUES (303, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"1\",\"fDealAmount\":1,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info          ( user_id,             card_id,             f_id,             f_deal_time,             f_deal_amount,             f_deal_status,             f_deal_type )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 16:36:28', 15147);
INSERT INTO `sys_oper_log` VALUES (304, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"1\",\"fDealAmount\":1,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info          ( user_id,             card_id,             f_id,             f_deal_time,             f_deal_amount,             f_deal_status,             f_deal_type )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 16:36:39', 19);
INSERT INTO `sys_oper_log` VALUES (305, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"1\",\"fDealAmount\":1,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             1, \n             \'1\', \n             \'1\', \n  \' at line 10\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_user(                            user_id,               card_id,               f_id,               f_deal_time,               f_deal_amount,               f_deal_status,               f_deal_type,          )values(                            ?,               ?,               ?,               ?,               ?,               ?,               ?,\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             1, \n             \'1\', \n             \'1\', \n  \' at line 10\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             1, \n             \'1\', \n             \'1\', \n  \' at line 10', '2023-12-26 16:47:57', 280);
INSERT INTO `sys_oper_log` VALUES (306, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"1\",\"fDealAmount\":1,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             1, \n             \'1\', \n             \'1\', \n  \' at line 10\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info(                            user_id,               card_id,               f_id,               f_deal_time,               f_deal_amount,               f_deal_status,               f_deal_type,          )values(                            ?,               ?,               ?,               ?,               ?,               ?,               ?,\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             1, \n             \'1\', \n             \'1\', \n  \' at line 10\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             1, \n             \'1\', \n             \'1\', \n  \' at line 10', '2023-12-26 16:48:46', 118);
INSERT INTO `sys_oper_log` VALUES (307, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"1\",\"fDealAmount\":1,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":110}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             110, \n             \'1\', \n             \'1\', \n\' at line 10\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info(                            user_id,               card_id,               f_id,               f_deal_time,               f_deal_amount,               f_deal_status,               f_deal_type,          )values(                            ?,               ?,               ?,               ?,               ?,               ?,               ?,\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             110, \n             \'1\', \n             \'1\', \n\' at line 10\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             110, \n             \'1\', \n             \'1\', \n\' at line 10', '2023-12-26 16:50:03', 43);
INSERT INTO `sys_oper_log` VALUES (308, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"104\",\"fLevel\":3,\"fName\":\"寄\",\"fRiskLevel\":2,\"fSize\":3,\"fStartTime\":\"2023-12-05\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 16:51:11', 39);
INSERT INTO `sys_oper_log` VALUES (309, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealAmount\":10,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":106}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             106, \n             \'114514\', \n             \'\' at line 10\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info(                            user_id,               card_id,               f_id,               f_deal_time,               f_deal_amount,               f_deal_status,               f_deal_type,          )values(                            ?,               ?,               ?,               ?,               ?,               ?,               ?,\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             106, \n             \'114514\', \n             \'\' at line 10\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             106, \n             \'114514\', \n             \'\' at line 10', '2023-12-26 16:51:49', 20);
INSERT INTO `sys_oper_log` VALUES (310, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealAmount\":10,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"2\",\"params\":{},\"userId\":106}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             106, \n             \'114514\', \n             \'\' at line 10\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info(                            user_id,               card_id,               f_id,               f_deal_time,               f_deal_amount,               f_deal_status,               f_deal_type,          )values(                            ?,               ?,               ?,               ?,               ?,               ?,               ?,\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             106, \n             \'114514\', \n             \'\' at line 10\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             106, \n             \'114514\', \n             \'\' at line 10', '2023-12-26 16:52:58', 26);
INSERT INTO `sys_oper_log` VALUES (311, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealAmount\":100,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"2\",\"params\":{},\"userId\":106}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             106, \n             \'114514\', \n             \'\' at line 10\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info(                            user_id,               card_id,               f_id,               f_deal_time,               f_deal_amount,               f_deal_status,               f_deal_type,          )values(                            ?,               ?,               ?,               ?,               ?,               ?,               ?,\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             106, \n             \'114514\', \n             \'\' at line 10\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             106, \n             \'114514\', \n             \'\' at line 10', '2023-12-26 16:53:03', 23);
INSERT INTO `sys_oper_log` VALUES (312, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealAmount\":100,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"2\",\"params\":{},\"userId\":106}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             106, \n             \'114514\', \n             \'\' at line 10\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info(                            user_id,               card_id,               f_id,               f_deal_time,               f_deal_amount,               f_deal_status,               f_deal_type,          )values(                            ?,               ?,               ?,               ?,               ?,               ?,               ?,\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             106, \n             \'114514\', \n             \'\' at line 10\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')values(\n             \n             106, \n             \'114514\', \n             \'\' at line 10', '2023-12-26 16:53:54', 19);
INSERT INTO `sys_oper_log` VALUES (313, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealAmount\":5,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":106}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info(                            user_id,               card_id,               f_id,               f_deal_time,               f_deal_amount,               f_deal_status,               f_deal_type          )values(                            ?,               ?,               ?,               ?,               ?,               ?,               ?          )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 16:59:53', 244);
INSERT INTO `sys_oper_log` VALUES (314, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealAmount\":5,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"params\":{},\"userId\":106}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\transaction_manage\\TransactionInfoMapper.xml]\r\n### The error may involve com.ruoyi.trans.mapper.TransactionInfoMapper.insertTransactionInfo-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into Transaction_Info(                            user_id,               card_id,               f_id,               f_deal_time,               f_deal_amount,               f_deal_status,               f_deal_type          )values(                            ?,               ?,               ?,               ?,               ?,               ?,               ?          )\r\n### Cause: java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value\n; Field \'f_stream_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'f_stream_id\' doesn\'t have a default value', '2023-12-26 17:07:01', 44);
INSERT INTO `sys_oper_log` VALUES (315, 'trans', 5, 'com.ruoyi.trans.controller.TransactionInfoController.export()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-12-26 17:16:37', 1415);
INSERT INTO `sys_oper_log` VALUES (316, 'trans', 3, 'com.ruoyi.trans.controller.TransactionInfoController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans/1', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 17:30:00', 46);
INSERT INTO `sys_oper_log` VALUES (317, 'trans', 3, 'com.ruoyi.trans.controller.TransactionInfoController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans/1', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 17:32:00', 42);
INSERT INTO `sys_oper_log` VALUES (318, 'trans', 3, 'com.ruoyi.trans.controller.TransactionInfoController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans/1', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 17:33:31', 43);
INSERT INTO `sys_oper_log` VALUES (319, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-26 17:56:44', 27);
INSERT INTO `sys_oper_log` VALUES (320, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-26 17:59:53', 18);
INSERT INTO `sys_oper_log` VALUES (321, 'trans', 3, 'com.ruoyi.trans.controller.TransactionInfoController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans/1', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-26 18:08:48', 43);
INSERT INTO `sys_oper_log` VALUES (322, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealAmount\":6,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"fStreamId\":2,\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 05:27:24', 99);
INSERT INTO `sys_oper_log` VALUES (323, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":0,\"params\":{}}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 06:24:06', 71);
INSERT INTO `sys_oper_log` VALUES (324, '基金管理', 2, 'com.ruoyi.fund.controller.FundInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"104\",\"fId\":\"1\",\"fLevel\":3,\"fMonitor\":\"test\",\"fName\":\"1234\",\"fOverview\":\"test01\",\"fRiskLevel\":3,\"fSize\":3,\"fStartTime\":\"2023-12-24\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 06:39:17', 55);
INSERT INTO `sys_oper_log` VALUES (325, '基金管理', 2, 'com.ruoyi.fund.controller.FundInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"209\",\"fId\":\"1\",\"fLevel\":3,\"fMonitor\":\"test\",\"fName\":\"1234\",\"fOverview\":\"test01\",\"fRiskLevel\":3,\"fSize\":3,\"fStartTime\":\"2023-12-24\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 06:39:30', 27);
INSERT INTO `sys_oper_log` VALUES (326, '基金管理', 2, 'com.ruoyi.fund.controller.FundInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"105\",\"fId\":\"1\",\"fLevel\":3,\"fMonitor\":\"test\",\"fName\":\"1234\",\"fOverview\":\"test01\",\"fRiskLevel\":3,\"fSize\":3,\"fStartTime\":\"2023-12-24\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 06:44:08', 29);
INSERT INTO `sys_oper_log` VALUES (327, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":0,\"params\":{}}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 06:50:34', 28);
INSERT INTO `sys_oper_log` VALUES (328, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":1,\"params\":{}}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 06:57:21', 18);
INSERT INTO `sys_oper_log` VALUES (329, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":1,\"params\":{}}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 06:57:39', 16);
INSERT INTO `sys_oper_log` VALUES (330, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":1,\"params\":{}}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 06:58:23', 18);
INSERT INTO `sys_oper_log` VALUES (331, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":1,\"fStreamId\":1,\"params\":{}}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 07:00:37', 18);
INSERT INTO `sys_oper_log` VALUES (332, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealStatus\":1,\"fId\":\"1\",\"fStreamId\":1,\"params\":{},\"userId\":106}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 07:01:22', 18);
INSERT INTO `sys_oper_log` VALUES (333, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealStatus\":1,\"fId\":\"1\",\"fStreamId\":1,\"params\":{},\"userId\":106}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 07:05:12', 141429);
INSERT INTO `sys_oper_log` VALUES (334, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealStatus\":1,\"fId\":\"1\",\"fStreamId\":1,\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:05:59', 42);
INSERT INTO `sys_oper_log` VALUES (335, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":1,\"params\":{}}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 07:16:15', 38);
INSERT INTO `sys_oper_log` VALUES (336, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":1,\"params\":{}}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 07:16:18', 20);
INSERT INTO `sys_oper_log` VALUES (337, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":1,\"params\":{}}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 07:16:45', 22);
INSERT INTO `sys_oper_log` VALUES (338, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":1,\"params\":{}}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 07:18:01', 34);
INSERT INTO `sys_oper_log` VALUES (339, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealStatus\":1,\"fStreamId\":1,\"params\":{},\"userId\":106}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2023-12-27 07:19:13', 19);
INSERT INTO `sys_oper_log` VALUES (340, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealAmount\":10,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":1,\"fId\":\"2\",\"fStreamId\":3,\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:19:38', 272);
INSERT INTO `sys_oper_log` VALUES (341, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealStatus\":1,\"fStreamId\":1,\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:19:41', 35);
INSERT INTO `sys_oper_log` VALUES (342, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealAmount\":10,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":1,\"fId\":\"2\",\"fStreamId\":4,\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:20:13', 57);
INSERT INTO `sys_oper_log` VALUES (343, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealStatus\":1,\"fStreamId\":1,\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:20:21', 27);
INSERT INTO `sys_oper_log` VALUES (344, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealAmount\":1,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":1,\"fId\":\"1\",\"fStreamId\":5,\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:26:59', 30);
INSERT INTO `sys_oper_log` VALUES (345, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where card_id = null\' at line 3\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.updateUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update User_Card                    where card_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where card_id = null\' at line 3\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where card_id = null\' at line 3', '2023-12-27 07:28:05', 152);
INSERT INTO `sys_oper_log` VALUES (346, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":1,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:40:36', 26);
INSERT INTO `sys_oper_log` VALUES (347, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where card_id = null\' at line 3\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.updateUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update User_Card                    where card_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where card_id = null\' at line 3\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where card_id = null\' at line 3', '2023-12-27 07:40:37', 58);
INSERT INTO `sys_oper_log` VALUES (348, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealAmount\":200,\"fDealStatus\":0,\"fDealTime\":\"2023-12-26\",\"fDealType\":0,\"fId\":\"1\",\"fStreamId\":6,\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:42:42', 37);
INSERT INTO `sys_oper_log` VALUES (349, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where card_id = null\' at line 3\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.updateUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update User_Card                    where card_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where card_id = null\' at line 3\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where card_id = null\' at line 3', '2023-12-27 07:43:17', 31);
INSERT INTO `sys_oper_log` VALUES (350, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where card_id = null\' at line 3\r\n### The error may exist in file [C:\\Users\\Zheng\\Desktop\\Java EE\\Assignment B\\Project_JavaEE\\ruoyi-admin\\target\\classes\\mapper\\card\\UserCardMapper.xml]\r\n### The error may involve com.ruoyi.card.mapper.UserCardMapper.updateUserCard-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update User_Card                    where card_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where card_id = null\' at line 3\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where card_id = null\' at line 3', '2023-12-27 07:43:53', 17);
INSERT INTO `sys_oper_log` VALUES (351, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":99,\"cardId\":\"114514\",\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:45:12', 26);
INSERT INTO `sys_oper_log` VALUES (352, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":-101,\"cardId\":\"114514\",\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:45:17', 40);
INSERT INTO `sys_oper_log` VALUES (353, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":500,\"cardId\":\"114514\",\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:45:38', 27);
INSERT INTO `sys_oper_log` VALUES (354, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":300,\"cardId\":\"114514\",\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:45:54', 27);
INSERT INTO `sys_oper_log` VALUES (355, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":1,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:46:02', 28);
INSERT INTO `sys_oper_log` VALUES (356, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":100,\"cardId\":\"114514\",\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 07:46:02', 31);
INSERT INTO `sys_oper_log` VALUES (357, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'zwc', 'Developer', '/system/menu/105', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2023-12-27 08:13:02', 44);
INSERT INTO `sys_oper_log` VALUES (358, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'zwc', 'Developer', '/system/menu/1025', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2023-12-27 08:13:08', 133);
INSERT INTO `sys_oper_log` VALUES (359, '通知公告', 1, 'com.ruoyi.web.controller.system.SysNoticeController.add()', 'POST', 1, 'zwc', 'Developer', '/system/notice', '127.0.0.1', '内网IP', '{\"createBy\":\"zwc\",\"noticeContent\":\"<p>基金修改时文本框显示错误的Bug已修复！</p>\",\"noticeTitle\":\"关于基金修改Bug修复\",\"noticeType\":\"2\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 08:14:36', 55);
INSERT INTO `sys_oper_log` VALUES (360, '通知公告', 3, 'com.ruoyi.web.controller.system.SysNoticeController.remove()', 'DELETE', 1, 'zwc', 'Developer', '/system/notice/1', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 08:15:08', 217);
INSERT INTO `sys_oper_log` VALUES (361, '通知公告', 3, 'com.ruoyi.web.controller.system.SysNoticeController.remove()', 'DELETE', 1, 'zwc', 'Developer', '/system/notice/2', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 08:15:12', 363);
INSERT INTO `sys_oper_log` VALUES (362, '通知公告', 1, 'com.ruoyi.web.controller.system.SysNoticeController.add()', 'POST', 1, 'zwc', 'Developer', '/system/notice', '127.0.0.1', '内网IP', '{\"createBy\":\"zwc\",\"noticeContent\":\"<p>2023年12月25日11:00-2023年12月26日2:00间进行系统维护！</p>\",\"noticeTitle\":\"维护通知\",\"noticeType\":\"2\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-27 08:16:02', 48);
INSERT INTO `sys_oper_log` VALUES (363, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"105\",\"fLevel\":5,\"fMonitor\":\"zwc\",\"fName\":\"混合货币基金C\",\"fRiskLevel\":1,\"fSize\":5,\"fStartTime\":\"2023-12-28\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 06:21:55', 57);
INSERT INTO `sys_oper_log` VALUES (364, '基金管理', 2, 'com.ruoyi.fund.controller.FundInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"105\",\"fId\":\"3\",\"fLevel\":5,\"fMonitor\":\"zwc\",\"fName\":\"混合货币C\",\"fRiskLevel\":1,\"fSize\":5,\"fStartTime\":\"2023-12-28\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 06:22:04', 40);
INSERT INTO `sys_oper_log` VALUES (365, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"107\",\"fLevel\":2,\"fMonitor\":\"zk\",\"fName\":\"社保投资A\",\"fRiskLevel\":2,\"fSize\":3,\"fStartTime\":\"2023-12-28\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 06:22:51', 41);
INSERT INTO `sys_oper_log` VALUES (366, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"114514\",\"fDealAmount\":100,\"fDealStatus\":0,\"fDealTime\":\"2023-12-27\",\"fDealType\":0,\"fId\":\"2\",\"fStreamId\":7,\"params\":{},\"userId\":106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 06:36:09', 65);
INSERT INTO `sys_oper_log` VALUES (367, 'trans', 3, 'com.ruoyi.trans.controller.TransactionInfoController.remove()', 'DELETE', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans/7', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 06:36:23', 38);
INSERT INTO `sys_oper_log` VALUES (368, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"2154314\",\"fDealAmount\":200,\"fDealStatus\":0,\"fDealTime\":\"2023-12-27\",\"fDealType\":0,\"fId\":\"1\",\"fStreamId\":8,\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 06:37:36', 36);
INSERT INTO `sys_oper_log` VALUES (369, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":1,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 06:37:52', 41);
INSERT INTO `sys_oper_log` VALUES (370, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":24800,\"cardId\":\"2154314\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 06:37:52', 38);
INSERT INTO `sys_oper_log` VALUES (371, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-12-20 13:40:35\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,107,1000,1001,1002,1003,1004,1005,2006,2007,2008,2009,2010,2011,2025,2026,2027,2028,2029,2030,2019,2020,2021,2022,2023,2024,1035],\"params\":{},\"roleId\":101,\"roleKey\":\"FundAgent\",\"roleName\":\"基金业务员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 06:41:19', 225);
INSERT INTO `sys_oper_log` VALUES (372, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'Hongfei Fan', '易方达基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"Hongfei Fan\",\"credID\":\"351111111111111111\",\"credType\":\"0\",\"deptId\":206,\"nickName\":\"zwc\",\"params\":{},\"phonenumber\":\"15111111111\",\"postIds\":[],\"riskLevel\":\"0\",\"roleIds\":[],\"sex\":\"1\",\"status\":\"0\",\"userId\":111,\"userName\":\"zwc001\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 07:02:13', 307);
INSERT INTO `sys_oper_log` VALUES (373, 'trans', 1, 'com.ruoyi.trans.controller.TransactionInfoController.add()', 'POST', 1, 'az', '广发基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"cardId\":\"2154314\",\"fDealAmount\":300,\"fDealStatus\":0,\"fDealTime\":\"2023-12-27\",\"fDealType\":0,\"fId\":\"1\",\"fStreamId\":9,\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 07:06:48', 51);
INSERT INTO `sys_oper_log` VALUES (374, 'trans', 2, 'com.ruoyi.trans.controller.TransactionInfoController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/transaction_manage/trans', '127.0.0.1', '内网IP', '{\"fDealStatus\":1,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 07:20:54', 65);
INSERT INTO `sys_oper_log` VALUES (375, '银行卡管理', 2, 'com.ruoyi.card.controller.UserCardController.edit()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/card/CardManagement', '127.0.0.1', '内网IP', '{\"cardAmount\":24500,\"cardId\":\"2154314\",\"params\":{},\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-12-28 07:20:54', 43);
INSERT INTO `sys_oper_log` VALUES (376, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '易方达基金管理有限公司', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"adm\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-07 06:24:29', 78);
INSERT INTO `sys_oper_log` VALUES (377, '基金管理', 1, 'com.ruoyi.fund.controller.FundInfoController.add()', 'POST', 1, 'az', '广发基金管理有限公司', '/fund_manage/FundManagement', '127.0.0.1', '内网IP', '{\"fCompany\":\"104\",\"fLevel\":5,\"fMonitor\":\"小郑\",\"fName\":\"同济大学科技园\",\"fRiskLevel\":3,\"fSize\":4,\"fStartTime\":\"2024-01-01\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-11 14:21:43', 45);
INSERT INTO `sys_oper_log` VALUES (378, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"credID\":\"23435466\",\"credType\":\"0\",\"deptId\":104,\"nickName\":\"zk\",\"params\":{},\"phonenumber\":\"15111111111\",\"postIds\":[],\"riskLevel\":\"0\",\"roleIds\":[102],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"zk123\"}', '{\"msg\":\"新增用户\'zk123\'失败，手机号码已存在\",\"code\":500}', 0, NULL, '2024-01-13 02:53:32', 63);
INSERT INTO `sys_oper_log` VALUES (379, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '易方达基金管理有限公司', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"credID\":\"23435466\",\"credType\":\"0\",\"deptId\":104,\"nickName\":\"zk\",\"params\":{},\"phonenumber\":\"16111111111\",\"postIds\":[],\"riskLevel\":\"0\",\"roleIds\":[102],\"sex\":\"0\",\"status\":\"0\",\"userId\":112,\"userName\":\"zk123\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 02:54:05', 368);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2023-12-14 02:55:43', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2023-12-14 02:55:43', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2023-12-14 02:55:43', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '2', 'admin', '2023-12-14 02:55:43', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (100, '开发者', 'Developer', 1, '1', 1, 1, '0', '0', 'admin', '2023-12-20 13:36:17', 'admin', '2023-12-20 13:37:00', NULL);
INSERT INTO `sys_role` VALUES (101, '基金业务员', 'FundAgent', 2, '4', 1, 1, '0', '0', 'admin', '2023-12-20 13:40:35', 'admin', '2023-12-28 06:41:19', NULL);
INSERT INTO `sys_role` VALUES (102, '客户', 'Client', 3, '5', 0, 1, '0', '0', 'admin', '2023-12-20 13:47:30', '', '2023-12-23 11:37:18', NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE,
  INDEX `fk_rm_menu`(`menu_id`) USING BTREE,
  CONSTRAINT `fk_rm_menu` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`menu_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_rm_role` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (100, 1);
INSERT INTO `sys_role_menu` VALUES (101, 1);
INSERT INTO `sys_role_menu` VALUES (100, 2);
INSERT INTO `sys_role_menu` VALUES (100, 3);
INSERT INTO `sys_role_menu` VALUES (100, 4);
INSERT INTO `sys_role_menu` VALUES (100, 100);
INSERT INTO `sys_role_menu` VALUES (101, 100);
INSERT INTO `sys_role_menu` VALUES (100, 101);
INSERT INTO `sys_role_menu` VALUES (100, 102);
INSERT INTO `sys_role_menu` VALUES (100, 103);
INSERT INTO `sys_role_menu` VALUES (100, 104);
INSERT INTO `sys_role_menu` VALUES (100, 105);
INSERT INTO `sys_role_menu` VALUES (100, 106);
INSERT INTO `sys_role_menu` VALUES (100, 107);
INSERT INTO `sys_role_menu` VALUES (101, 107);
INSERT INTO `sys_role_menu` VALUES (100, 108);
INSERT INTO `sys_role_menu` VALUES (100, 109);
INSERT INTO `sys_role_menu` VALUES (100, 110);
INSERT INTO `sys_role_menu` VALUES (100, 111);
INSERT INTO `sys_role_menu` VALUES (100, 112);
INSERT INTO `sys_role_menu` VALUES (100, 113);
INSERT INTO `sys_role_menu` VALUES (100, 114);
INSERT INTO `sys_role_menu` VALUES (100, 115);
INSERT INTO `sys_role_menu` VALUES (100, 116);
INSERT INTO `sys_role_menu` VALUES (100, 117);
INSERT INTO `sys_role_menu` VALUES (100, 500);
INSERT INTO `sys_role_menu` VALUES (100, 501);
INSERT INTO `sys_role_menu` VALUES (100, 1000);
INSERT INTO `sys_role_menu` VALUES (101, 1000);
INSERT INTO `sys_role_menu` VALUES (100, 1001);
INSERT INTO `sys_role_menu` VALUES (101, 1001);
INSERT INTO `sys_role_menu` VALUES (100, 1002);
INSERT INTO `sys_role_menu` VALUES (101, 1002);
INSERT INTO `sys_role_menu` VALUES (100, 1003);
INSERT INTO `sys_role_menu` VALUES (101, 1003);
INSERT INTO `sys_role_menu` VALUES (100, 1004);
INSERT INTO `sys_role_menu` VALUES (101, 1004);
INSERT INTO `sys_role_menu` VALUES (100, 1005);
INSERT INTO `sys_role_menu` VALUES (101, 1005);
INSERT INTO `sys_role_menu` VALUES (100, 1006);
INSERT INTO `sys_role_menu` VALUES (100, 1007);
INSERT INTO `sys_role_menu` VALUES (100, 1008);
INSERT INTO `sys_role_menu` VALUES (100, 1009);
INSERT INTO `sys_role_menu` VALUES (100, 1010);
INSERT INTO `sys_role_menu` VALUES (100, 1011);
INSERT INTO `sys_role_menu` VALUES (100, 1012);
INSERT INTO `sys_role_menu` VALUES (100, 1013);
INSERT INTO `sys_role_menu` VALUES (100, 1014);
INSERT INTO `sys_role_menu` VALUES (100, 1015);
INSERT INTO `sys_role_menu` VALUES (100, 1016);
INSERT INTO `sys_role_menu` VALUES (100, 1017);
INSERT INTO `sys_role_menu` VALUES (100, 1018);
INSERT INTO `sys_role_menu` VALUES (100, 1019);
INSERT INTO `sys_role_menu` VALUES (100, 1020);
INSERT INTO `sys_role_menu` VALUES (100, 1021);
INSERT INTO `sys_role_menu` VALUES (100, 1022);
INSERT INTO `sys_role_menu` VALUES (100, 1023);
INSERT INTO `sys_role_menu` VALUES (100, 1024);
INSERT INTO `sys_role_menu` VALUES (100, 1025);
INSERT INTO `sys_role_menu` VALUES (100, 1026);
INSERT INTO `sys_role_menu` VALUES (100, 1027);
INSERT INTO `sys_role_menu` VALUES (100, 1028);
INSERT INTO `sys_role_menu` VALUES (100, 1029);
INSERT INTO `sys_role_menu` VALUES (100, 1030);
INSERT INTO `sys_role_menu` VALUES (100, 1031);
INSERT INTO `sys_role_menu` VALUES (100, 1032);
INSERT INTO `sys_role_menu` VALUES (100, 1033);
INSERT INTO `sys_role_menu` VALUES (100, 1034);
INSERT INTO `sys_role_menu` VALUES (100, 1035);
INSERT INTO `sys_role_menu` VALUES (101, 1035);
INSERT INTO `sys_role_menu` VALUES (100, 1036);
INSERT INTO `sys_role_menu` VALUES (100, 1037);
INSERT INTO `sys_role_menu` VALUES (100, 1038);
INSERT INTO `sys_role_menu` VALUES (100, 1039);
INSERT INTO `sys_role_menu` VALUES (100, 1040);
INSERT INTO `sys_role_menu` VALUES (100, 1041);
INSERT INTO `sys_role_menu` VALUES (100, 1042);
INSERT INTO `sys_role_menu` VALUES (100, 1043);
INSERT INTO `sys_role_menu` VALUES (100, 1044);
INSERT INTO `sys_role_menu` VALUES (100, 1045);
INSERT INTO `sys_role_menu` VALUES (100, 1046);
INSERT INTO `sys_role_menu` VALUES (100, 1047);
INSERT INTO `sys_role_menu` VALUES (100, 1048);
INSERT INTO `sys_role_menu` VALUES (100, 1049);
INSERT INTO `sys_role_menu` VALUES (100, 1050);
INSERT INTO `sys_role_menu` VALUES (100, 1051);
INSERT INTO `sys_role_menu` VALUES (100, 1052);
INSERT INTO `sys_role_menu` VALUES (100, 1053);
INSERT INTO `sys_role_menu` VALUES (100, 1054);
INSERT INTO `sys_role_menu` VALUES (100, 1055);
INSERT INTO `sys_role_menu` VALUES (100, 1056);
INSERT INTO `sys_role_menu` VALUES (100, 1057);
INSERT INTO `sys_role_menu` VALUES (100, 1058);
INSERT INTO `sys_role_menu` VALUES (100, 1059);
INSERT INTO `sys_role_menu` VALUES (100, 1060);
INSERT INTO `sys_role_menu` VALUES (101, 2006);
INSERT INTO `sys_role_menu` VALUES (101, 2007);
INSERT INTO `sys_role_menu` VALUES (101, 2008);
INSERT INTO `sys_role_menu` VALUES (101, 2009);
INSERT INTO `sys_role_menu` VALUES (101, 2010);
INSERT INTO `sys_role_menu` VALUES (101, 2011);
INSERT INTO `sys_role_menu` VALUES (101, 2019);
INSERT INTO `sys_role_menu` VALUES (101, 2020);
INSERT INTO `sys_role_menu` VALUES (101, 2021);
INSERT INTO `sys_role_menu` VALUES (101, 2022);
INSERT INTO `sys_role_menu` VALUES (101, 2023);
INSERT INTO `sys_role_menu` VALUES (101, 2024);
INSERT INTO `sys_role_menu` VALUES (101, 2025);
INSERT INTO `sys_role_menu` VALUES (101, 2026);
INSERT INTO `sys_role_menu` VALUES (101, 2027);
INSERT INTO `sys_role_menu` VALUES (101, 2028);
INSERT INTO `sys_role_menu` VALUES (101, 2029);
INSERT INTO `sys_role_menu` VALUES (101, 2030);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `c_ID_type` int NULL DEFAULT NULL COMMENT '用户证件类型',
  `c_ID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户证件号码',
  `c_risk_level` int NULL DEFAULT NULL COMMENT '用户风险等级（012对应低中高）',
  `c_address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户地址',
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `fk_user_dept`(`dept_id`) USING BTREE,
  INDEX `user_name`(`user_name`) USING BTREE,
  CONSTRAINT `fk_user_dept` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', 'adm', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2024-01-13 10:38:17', 'admin', '2023-12-14 02:55:42', '', '2024-01-13 02:38:15', '管理员', NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '2', '127.0.0.1', '2023-12-20 19:45:43', 'admin', '2023-12-14 02:55:42', '', '2023-12-20 11:45:42', '测试员', NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (100, 101, 'zz', 'zz', '00', '', '', '0', '', '$2a$10$jtz.hSc6Von1Ju0OZ5kEJ.N0EzW0G9kW0ZhIj66fzyVFVtPR8aj76', '0', '2', '', NULL, 'admin', '2023-12-20 11:54:02', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (101, 102, 'zwc', 'zwc11', '00', '2151414@tongji.edu.cn', '15536937551', '0', '/profile/avatar/2023/12/20/我的成长_20231220215036A001.jpg', '$2a$10$kyz6eUIVvQge.oXkM8wlnO18VrKWjCRWPSwmXmOsq7mzzMNC8MNVG', '0', '0', '127.0.0.1', '2023-12-27 21:51:03', 'admin', '2023-12-20 13:44:37', 'admin', '2023-12-27 13:51:03', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (102, 102, 'zk', 'zk', '00', '', '', '0', '', '$2a$10$KPBxk8/NwLXVLvGWd5TVC.X2fr8fuutSKUkHPWtuMWDZisISZkMMi', '0', '0', '', NULL, 'admin', '2023-12-20 13:45:35', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (103, 102, 'lzk', 'lzk', '00', '', '', '0', '', '$2a$10$2vmxkDqtVe7ejuewKsfgbOCwXqwapu7PKGxs8JB1ISiUdaiT8Q0Jy', '0', '0', '', NULL, 'admin', '2023-12-20 13:46:02', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (104, 103, 'Hongfei Fan', 'Rene Fan', '00', '', '', '0', '', '$2a$10$DSJCPY4USvTwUDFbkhz4lejCX3L36cGJbflTAuUT3gC0fI3YMpIcq', '0', '0', '127.0.0.1', '2023-12-28 15:00:13', 'zwc', '2023-12-20 13:52:45', '', '2023-12-28 07:00:11', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (105, 102, 'zz', 'alo', '00', '1420223146@qq.com', '15356201811', '0', '', '$2a$10$CtdV9P0LewrT0pVfAEIXp.f2RqK/7mDZ9l3hPv0Qunfygx4Qhygzy', '0', '0', '127.0.0.1', '2024-01-11 22:20:49', 'admin', '2023-12-23 08:18:20', '', '2024-01-11 14:20:48', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (106, 104, 'az', 'AgentZ', '00', '', '', '0', '', '$2a$10$cQbL6GQOB/C1JPPsgd3IDuskZv1gqd/ff.4NvqbYQBteLEXp.3h1G', '0', '0', '127.0.0.1', '2024-01-11 22:21:03', 'zz', '2023-12-23 11:09:53', 'zz', '2024-01-11 14:21:02', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (107, 104, '小郑', '小郑', '00', '', '', '0', '', '$2a$10$a7nwaUoRvlQrsLBODWFLpe3yxI284W2Fn.CvQkZDkvzKq/MqTUbga', '0', '0', '', NULL, 'az', '2023-12-23 12:26:07', '', NULL, NULL, NULL, NULL, 1, NULL);
INSERT INTO `sys_user` VALUES (108, 208, '郑先生', '郑先生', '00', '', '15356201810', '0', '', '$2a$10$v.EGEBPape7mFR/tLbNkguBpI3knh6HG2kRrX8XGxYd/6Ukc7Rqji', '0', '0', '', NULL, 'zz', '2023-12-23 16:40:50', 'az', '2023-12-24 07:10:33', NULL, 0, '111', 1, NULL);
INSERT INTO `sys_user` VALUES (109, 102, '1234', '1234', '00', '1234@qq.com', '14111111111', '0', '', '$2a$10$82fgHRDdFA0U8AEAy8rXLenmAxM9MKR71JMZl5Q7gj69Zf226545a', '0', '2', '', NULL, 'admin', '2023-12-24 02:28:00', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (110, 208, 'pz', 'pzone', '00', '', '15356101111', '2', '', '$2a$10$AbECfG0pwKYEuZqdJUhqC.l8d1B9OvOChyghSCIxIznBXtbBM9i/K', '0', '0', '', NULL, 'az', '2023-12-24 07:01:53', '', NULL, NULL, 0, 'null', 0, NULL);
INSERT INTO `sys_user` VALUES (111, 206, 'zwc001', 'zwc', '00', '', '15111111111', '1', '', '$2a$10$62Xr1vxcA2rhKDOwrtN7f.HHSx0mjS8fCr.WBYWJ5/9X//IBVQ5hO', '0', '0', '', NULL, 'Hongfei Fan', '2023-12-28 07:02:13', '', NULL, NULL, 0, '351111111111111111', 0, NULL);
INSERT INTO `sys_user` VALUES (112, 104, 'zk123', 'zk', '00', '', '16111111111', '0', '', '$2a$10$NpYberYgXepBz2bGAFPzHeRzPCQwVfc8AniAPlxNo1XZqcG1BZcsS', '0', '0', '', NULL, 'admin', '2024-01-13 02:54:05', '', NULL, NULL, 0, '23435466', 0, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (105, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `fk_ur_role`(`role_id`) USING BTREE,
  CONSTRAINT `fk_ur_role` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_ur_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (101, 100);
INSERT INTO `sys_user_role` VALUES (102, 100);
INSERT INTO `sys_user_role` VALUES (103, 100);
INSERT INTO `sys_user_role` VALUES (105, 100);
INSERT INTO `sys_user_role` VALUES (104, 101);
INSERT INTO `sys_user_role` VALUES (106, 101);
INSERT INTO `sys_user_role` VALUES (107, 101);
INSERT INTO `sys_user_role` VALUES (108, 102);
INSERT INTO `sys_user_role` VALUES (110, 102);
INSERT INTO `sys_user_role` VALUES (112, 102);

SET FOREIGN_KEY_CHECKS = 1;
