/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50713
Source Host           : localhost:3306
Source Database       : ecss

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2016-12-29 16:13:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for access_token
-- ----------------------------
DROP TABLE IF EXISTS `access_token`;
CREATE TABLE `access_token` (
  `uid` int(10) NOT NULL,
  `token` varchar(64) NOT NULL COMMENT 'app用户登陆凭证',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `im_token` varchar(64) DEFAULT NULL COMMENT '第三方IM登陆凭证',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of access_token
-- ----------------------------

-- ----------------------------
-- Table structure for app_version
-- ----------------------------
DROP TABLE IF EXISTS `app_version`;
CREATE TABLE `app_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL COMMENT '更新说明',
  `create_time` datetime DEFAULT NULL,
  `link_url` varchar(255) DEFAULT NULL COMMENT '外部下载地址',
  `nature_no` int(11) DEFAULT NULL COMMENT '自然版本号',
  `os` varchar(20) DEFAULT NULL COMMENT '系统类型android or ios',
  `url` varchar(200) DEFAULT NULL COMMENT '内部下载地址',
  `version_no` varchar(20) DEFAULT NULL COMMENT '版本号',
  `status` tinyint(4) DEFAULT NULL COMMENT '1-有效   0-无效',
  `is_force` tinyint(4) DEFAULT '0' COMMENT '是否强制升级 0:否 1：是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of app_version
-- ----------------------------

-- ----------------------------
-- Table structure for as_aftersaleod
-- ----------------------------
DROP TABLE IF EXISTS `as_aftersaleod`;
CREATE TABLE `as_aftersaleod` (
  `asodID` varchar(50) NOT NULL,
  `customer` varchar(50) DEFAULT NULL,
  `executer` varchar(50) DEFAULT NULL,
  `express` varchar(50) DEFAULT NULL,
  `courierNum` varchar(50) DEFAULT NULL,
  `bkexpress` varchar(50) DEFAULT NULL,
  `bkcourierNum` varchar(50) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `addr` varchar(50) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`asodID`),
  KEY `idx_asod_st` (`executer`),
  KEY `idx_asod_cus` (`customer`),
  KEY `idx_asod_ex` (`bkexpress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of as_aftersaleod
-- ----------------------------
INSERT INTO `as_aftersaleod` VALUES ('AS10041', '10017', 'dsf', null, 'dasf', null, 'adsf12', '0.00', 'adsf', '2');

-- ----------------------------
-- Table structure for as_aftersaleod_de
-- ----------------------------
DROP TABLE IF EXISTS `as_aftersaleod_de`;
CREATE TABLE `as_aftersaleod_de` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `asodID` varchar(50) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  `newqty` smallint(6) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_asodde_asID` (`asodID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of as_aftersaleod_de
-- ----------------------------
INSERT INTO `as_aftersaleod_de` VALUES ('1', 'AS10041', '1001', '1', '0', null);

-- ----------------------------
-- Table structure for console_sequence
-- ----------------------------
DROP TABLE IF EXISTS `console_sequence`;
CREATE TABLE `console_sequence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(10) DEFAULT NULL,
  `code` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of console_sequence
-- ----------------------------
INSERT INTO `console_sequence` VALUES ('2', '类目', '100012');
INSERT INTO `console_sequence` VALUES ('3', '商家', '10020');
INSERT INTO `console_sequence` VALUES ('4', '入库', '100025');
INSERT INTO `console_sequence` VALUES ('5', '订单', '10053');

-- ----------------------------
-- Table structure for del_mall_customer_olineshop
-- ----------------------------
DROP TABLE IF EXISTS `del_mall_customer_olineshop`;
CREATE TABLE `del_mall_customer_olineshop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cusmoter` varchar(50) DEFAULT NULL,
  `olshopID` tinyint(4) DEFAULT NULL,
  `olshopName` varchar(50) DEFAULT NULL,
  `olshopAddt` varchar(200) DEFAULT NULL,
  `olshopPic` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_olshop_cus` (`cusmoter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of del_mall_customer_olineshop
-- ----------------------------

-- ----------------------------
-- Table structure for del_mall_staff
-- ----------------------------
DROP TABLE IF EXISTS `del_mall_staff`;
CREATE TABLE `del_mall_staff` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `passwd` varchar(50) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `alias_name` varchar(50) DEFAULT NULL,
  `real_name` varchar(50) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `brithday` date DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `wechat` varchar(50) DEFAULT NULL,
  `hiredate` date DEFAULT NULL,
  `positions` varchar(50) DEFAULT NULL,
  `roleID` tinyint(3) unsigned DEFAULT NULL,
  `unCode` varchar(50) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_staff_alnm` (`alias_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of del_mall_staff
-- ----------------------------

-- ----------------------------
-- Table structure for del_sk_stock_log
-- ----------------------------
DROP TABLE IF EXISTS `del_sk_stock_log`;
CREATE TABLE `del_sk_stock_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(50) DEFAULT NULL,
  `module` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(50) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `oldQuantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_stklg_sku` (`sku`),
  KEY `idx_stklg_sCd` (`sourceCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of del_sk_stock_log
-- ----------------------------

-- ----------------------------
-- Table structure for dict_data
-- ----------------------------
DROP TABLE IF EXISTS `dict_data`;
CREATE TABLE `dict_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '名称',
  `value` varchar(255) NOT NULL COMMENT '对应的值',
  `remark` varchar(32) DEFAULT NULL,
  `seq` int(11) NOT NULL COMMENT '排序，由小到大',
  `update_time` int(10) NOT NULL,
  `dict_type_id` int(11) NOT NULL COMMENT '字典类型ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of dict_data
-- ----------------------------
INSERT INTO `dict_data` VALUES ('4', '诽谤辱骂', '1', '', '1', '1467514812', '3');
INSERT INTO `dict_data` VALUES ('5', '淫秽色情', '2', '', '2', '1467514834', '3');
INSERT INTO `dict_data` VALUES ('6', '垃圾广告', '3', '', '3', '1467514907', '3');

-- ----------------------------
-- Table structure for dict_type
-- ----------------------------
DROP TABLE IF EXISTS `dict_type`;
CREATE TABLE `dict_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `remark` varchar(32) DEFAULT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of dict_type
-- ----------------------------
INSERT INTO `dict_type` VALUES ('1', '兴趣爱好', '用户选择兴趣爱好', '0');
INSERT INTO `dict_type` VALUES ('3', '举报内容', '举报内容2', '1473167795');

-- ----------------------------
-- Table structure for mall_cart
-- ----------------------------
DROP TABLE IF EXISTS `mall_cart`;
CREATE TABLE `mall_cart` (
  `cusCode` varchar(50) NOT NULL,
  `totalCount` smallint(5) unsigned DEFAULT '0',
  `amount` decimal(12,2) DEFAULT '0.00',
  PRIMARY KEY (`cusCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_cart
-- ----------------------------
INSERT INTO `mall_cart` VALUES ('10017', '1', '55.00');

-- ----------------------------
-- Table structure for mall_cart_de
-- ----------------------------
DROP TABLE IF EXISTS `mall_cart_de`;
CREATE TABLE `mall_cart_de` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cusCode` varchar(50) NOT NULL,
  `sku` varchar(50) NOT NULL,
  `priceType` char(1) NOT NULL,
  `skuCount` smallint(5) unsigned DEFAULT '0',
  `price` decimal(12,2) DEFAULT '0.00' COMMENT '单价',
  `skuAmount` decimal(12,2) DEFAULT '0.00' COMMENT '总价格',
  PRIMARY KEY (`id`),
  KEY `idx_cart_cus` (`cusCode`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_cart_de
-- ----------------------------
INSERT INTO `mall_cart_de` VALUES ('1', '10017', 'ABC1001', 'S', '1', '55.00', '55.00');

-- ----------------------------
-- Table structure for mall_category
-- ----------------------------
DROP TABLE IF EXISTS `mall_category`;
CREATE TABLE `mall_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cateName` varchar(50) DEFAULT NULL,
  `cateCode` varchar(50) DEFAULT NULL,
  `parentCode` varchar(50) DEFAULT NULL,
  `remare` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cate_code` (`cateCode`),
  KEY `idx_cate_pcode` (`parentCode`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_category
-- ----------------------------
INSERT INTO `mall_category` VALUES ('1', '类目1', '1001', null, null);
INSERT INTO `mall_category` VALUES ('2', '类目1-1', '1002', '1001', null);
INSERT INTO `mall_category` VALUES ('3', '类目1-2', '1003', '1001', null);
INSERT INTO `mall_category` VALUES ('4', '类目2', '2001', null, null);
INSERT INTO `mall_category` VALUES ('5', '类目2-1', '2002', '2001', null);
INSERT INTO `mall_category` VALUES ('11', '类目3', '100004', null, null);
INSERT INTO `mall_category` VALUES ('12', '类目2-2-1', '100005', '2001', null);
INSERT INTO `mall_category` VALUES ('13', '类目3-1', '100008', '100004', null);
INSERT INTO `mall_category` VALUES ('14', '类目3-2', '100011', '100004', null);
INSERT INTO `mall_category` VALUES ('15', '类目2-3', '100012', '2001', null);

-- ----------------------------
-- Table structure for mall_customer
-- ----------------------------
DROP TABLE IF EXISTS `mall_customer`;
CREATE TABLE `mall_customer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cusCode` varchar(50) NOT NULL,
  `cusName` varchar(50) NOT NULL,
  `passwd` varchar(50) NOT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `sex` char(1) NOT NULL,
  `birthday` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `wechat` varchar(50) NOT NULL,
  `upCode` varchar(50) DEFAULT NULL,
  `saler` varchar(50) DEFAULT NULL,
  `rate` tinyint(4) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `priceType` char(1) DEFAULT NULL,
  `cusType` char(1) DEFAULT NULL,
  `coupon` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cus_cd` (`cusCode`),
  KEY `idx_sus_nm` (`cusName`),
  KEY `idx_cus_sa` (`saler`),
  KEY `idx_cus_uncd` (`upCode`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_customer
-- ----------------------------
INSERT INTO `mall_customer` VALUES ('16', '10017', 'hanlei', '10fa0ba0c063c50e69c941e22c509c62', '1', 'M', '2016-10-26', 'jesse.18@163.com', '18660791231', '18615267773', '1212', '1111', '0', null, 'A', '0', '1');
INSERT INTO `mall_customer` VALUES ('17', '10018', '王心刚', 'bb61b2bb7b36f5db6d79d2dc3ec42c20', '0', 'M', '2016-12-25', 'jesse.18@163.com', '18615267773', '18615267773', null, null, '0', null, null, '0', '1');
INSERT INTO `mall_customer` VALUES ('19', '10020', '郭丽娜', '20c737b5f9d6ec6ccb856445ccc10464', '1', 'F', '2016-12-31', 'jesse.18@163.com', '18615267773', '18615267773', '10017', 'sdf', '0', null, 'A', '1', '1');

-- ----------------------------
-- Table structure for mall_customer_addr
-- ----------------------------
DROP TABLE IF EXISTS `mall_customer_addr`;
CREATE TABLE `mall_customer_addr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer` varchar(50) DEFAULT NULL,
  `addr` varchar(200) DEFAULT NULL,
  `recipient` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `used` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cusaddr_cus` (`customer`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_customer_addr
-- ----------------------------
INSERT INTO `mall_customer_addr` VALUES ('1', '10017', '山东省济南市青岛路演马家苑7号楼2单元1703室', '张三', '18615267773', '1');
INSERT INTO `mall_customer_addr` VALUES ('2', '10017', '北京市大兴区亦庄经济开发区朝林广场', '韩磊', '18615267773', '0');

-- ----------------------------
-- Table structure for mall_customer_shop
-- ----------------------------
DROP TABLE IF EXISTS `mall_customer_shop`;
CREATE TABLE `mall_customer_shop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer` varchar(50) DEFAULT NULL,
  `category` char(1) DEFAULT NULL,
  `shopName` varchar(50) DEFAULT NULL,
  `shopAddr` varchar(200) DEFAULT NULL,
  `shopPic` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_shop_cus` (`customer`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_customer_shop
-- ----------------------------
INSERT INTO `mall_customer_shop` VALUES ('1', '10017', null, '张三的店', '山东省济南市青岛路演马家苑7号楼2单元1703室', 'hanlei.jpg');
INSERT INTO `mall_customer_shop` VALUES ('2', '10017', '1', '李四的店', ' 山东省济南市青岛路演马家苑7号楼2单元1703室', '韩磊.JPG');

-- ----------------------------
-- Table structure for mall_customer_sku
-- ----------------------------
DROP TABLE IF EXISTS `mall_customer_sku`;
CREATE TABLE `mall_customer_sku` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer` varchar(50) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cusasku_cus` (`customer`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_customer_sku
-- ----------------------------
INSERT INTO `mall_customer_sku` VALUES ('1', '10017', '1001');
INSERT INTO `mall_customer_sku` VALUES ('2', '10017', '1002');

-- ----------------------------
-- Table structure for mall_sku
-- ----------------------------
DROP TABLE IF EXISTS `mall_sku`;
CREATE TABLE `mall_sku` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `skuName` varchar(50) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `attribute` char(1) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `specName` varchar(50) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `exclusive` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sku_cate` (`category`),
  KEY `idx_sku_code` (`sku`),
  KEY `idx_sku_attr` (`attribute`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_sku
-- ----------------------------
INSERT INTO `mall_sku` VALUES ('4', '烟嘴', '1001', '1002', null, null, '黑色', '', '1001.jpg', '1');
INSERT INTO `mall_sku` VALUES ('5', '烟嘴01', '1002', '1002', null, null, '棕色', null, '1002.jpg', '0');
INSERT INTO `mall_sku` VALUES ('6', '烟嘴2', '1003', '1002', null, null, '白色', null, '1003.jpg', '0');
INSERT INTO `mall_sku` VALUES ('9', '电子烟', 'ABC1001', '2002', null, null, 'ABC', null, 'event.jpg', '1');

-- ----------------------------
-- Table structure for mall_sku_nprice
-- ----------------------------
DROP TABLE IF EXISTS `mall_sku_nprice`;
CREATE TABLE `mall_sku_nprice` (
  `sku` varchar(50) NOT NULL,
  `priceType` char(1) NOT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  `offStat` tinyint(4) DEFAULT NULL,
  `num1` smallint(6) DEFAULT NULL,
  `price1` decimal(12,2) DEFAULT NULL,
  `num2` smallint(6) DEFAULT NULL,
  `price2` decimal(12,2) DEFAULT NULL,
  `num3` smallint(6) DEFAULT NULL,
  `price3` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`sku`,`priceType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_sku_nprice
-- ----------------------------
INSERT INTO `mall_sku_nprice` VALUES ('1001', 'A', null, null, '5', '10.00', '5', '10.00', '5', '10.00');
INSERT INTO `mall_sku_nprice` VALUES ('1001', 'B', null, null, '5', '10.00', '5', '10.00', '5', '10.00');
INSERT INTO `mall_sku_nprice` VALUES ('1001', 'C', null, null, '5', '10.00', '5', '10.00', '5', '10.00');
INSERT INTO `mall_sku_nprice` VALUES ('1001', 'D', null, null, '5', '10.00', '5', '10.00', '5', '10.00');
INSERT INTO `mall_sku_nprice` VALUES ('1002', 'A', null, null, '5', '10.00', '5', '10.00', '5', '10.00');
INSERT INTO `mall_sku_nprice` VALUES ('1002', 'B', null, null, '5', '10.00', '5', '10.00', '5', '10.00');
INSERT INTO `mall_sku_nprice` VALUES ('1002', 'C', null, null, '5', '10.00', '5', '10.00', '5', '10.00');
INSERT INTO `mall_sku_nprice` VALUES ('1002', 'D', null, null, '5', '10.00', '5', '10.00', '5', '10.00');
INSERT INTO `mall_sku_nprice` VALUES ('1003', 'A', null, null, '5', '10.00', '5', '10.00', '5', '10.00');
INSERT INTO `mall_sku_nprice` VALUES ('1003', 'B', null, null, '5', '10.00', '5', '10.00', '5', '10.00');
INSERT INTO `mall_sku_nprice` VALUES ('1003', 'C', null, null, '5', '10.00', '5', '10.00', '5', '10.00');
INSERT INTO `mall_sku_nprice` VALUES ('1003', 'D', null, null, '5', '10.00', '5', '10.00', '5', '10.00');
INSERT INTO `mall_sku_nprice` VALUES ('ABC1001', 'A', null, null, '10', '80.00', '50', '70.00', '100', '60.00');
INSERT INTO `mall_sku_nprice` VALUES ('ABC1001', 'B', null, null, '10', '90.00', '50', '80.00', '100', '70.00');
INSERT INTO `mall_sku_nprice` VALUES ('ABC1001', 'C', null, null, '10', '100.00', '50', '90.00', '100', '80.00');
INSERT INTO `mall_sku_nprice` VALUES ('ABC1001', 'D', null, null, '10', '110.00', '50', '100.00', '100', '90.00');

-- ----------------------------
-- Table structure for mall_sku_sprice
-- ----------------------------
DROP TABLE IF EXISTS `mall_sku_sprice`;
CREATE TABLE `mall_sku_sprice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(50) DEFAULT NULL,
  `customer` varchar(50) DEFAULT NULL,
  `firstbuy` char(1) DEFAULT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_spri_pri` (`customer`,`sku`,`price`),
  KEY `idx_spri_1stby` (`customer`,`sku`,`firstbuy`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mall_sku_sprice
-- ----------------------------
INSERT INTO `mall_sku_sprice` VALUES ('1', '1001', '10017', null, '2.00');
INSERT INTO `mall_sku_sprice` VALUES ('2', '1003', '10017', null, '1.00');
INSERT INTO `mall_sku_sprice` VALUES ('3', 'ABC1001', '10017', null, '55.00');
INSERT INTO `mall_sku_sprice` VALUES ('4', '1001', '10020', null, '9.00');

-- ----------------------------
-- Table structure for od_order
-- ----------------------------
DROP TABLE IF EXISTS `od_order`;
CREATE TABLE `od_order` (
  `orderID` varchar(50) NOT NULL,
  `customer` varchar(50) DEFAULT NULL,
  `reviewer` varchar(50) DEFAULT NULL,
  `addrID` int(10) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL COMMENT '订单总金额',
  `courierNum` varchar(50) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `odtime` datetime DEFAULT NULL,
  `express` varchar(50) DEFAULT NULL,
  `certificate` varchar(255) DEFAULT NULL,
  `cost` decimal(12,2) DEFAULT NULL COMMENT '成本',
  `rated` date DEFAULT NULL,
  `rebated` date DEFAULT NULL,
  PRIMARY KEY (`orderID`),
  KEY `idx_od_cus` (`customer`),
  KEY `idx_od_rev` (`reviewer`),
  KEY `idx_od_st` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of od_order
-- ----------------------------
INSERT INTO `od_order` VALUES ('O10024', '10017', '', '1', '64.00', '1111', '3', '2016-11-05 14:38:58', '啊啊啊', 'home.png', null, null, null);
INSERT INTO `od_order` VALUES ('O10025', '10017', '', '1', '64.00', '1111', '3', '2016-11-05 14:38:58', '啊啊啊', null, null, null, null);
INSERT INTO `od_order` VALUES ('O10044', '10017', null, null, '20.00', null, '0', '2016-12-24 14:51:21', null, '', null, null, null);
INSERT INTO `od_order` VALUES ('O10045', '10017', null, '1', '0.00', null, '1', '2016-12-25 23:18:27', null, '100171482933411930', '2.00', null, null);
INSERT INTO `od_order` VALUES ('O10046', '10017', null, '1', '0.00', null, '1', '2016-12-25 23:19:58', null, '100171482933020363', '2.00', null, null);
INSERT INTO `od_order` VALUES ('O10050', '10017', null, '1', '2.00', null, '1', '2016-12-25 23:29:22', null, 'fc3.jpg', '2.00', null, null);
INSERT INTO `od_order` VALUES ('O10052', '10017', null, '1', '2.00', null, '1', '2016-12-26 00:03:12', null, 'event.jpg', null, null, null);
INSERT INTO `od_order` VALUES ('O10053', '10017', null, '1', '4.00', null, '1', '2016-12-26 00:04:22', null, '3.jpg', null, null, null);

-- ----------------------------
-- Table structure for od_order_addr
-- ----------------------------
DROP TABLE IF EXISTS `od_order_addr`;
CREATE TABLE `od_order_addr` (
  `orderID` varchar(50) NOT NULL,
  `addr` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`orderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of od_order_addr
-- ----------------------------
INSERT INTO `od_order_addr` VALUES ('O10024', '山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773');
INSERT INTO `od_order_addr` VALUES ('O10025', '山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773');
INSERT INTO `od_order_addr` VALUES ('O10044', 'adsfadsf');
INSERT INTO `od_order_addr` VALUES ('O10045', '山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773');
INSERT INTO `od_order_addr` VALUES ('O10046', '山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773');
INSERT INTO `od_order_addr` VALUES ('O10050', '山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773');
INSERT INTO `od_order_addr` VALUES ('O10052', '山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773');
INSERT INTO `od_order_addr` VALUES ('O10053', '山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773');

-- ----------------------------
-- Table structure for od_order_de
-- ----------------------------
DROP TABLE IF EXISTS `od_order_de`;
CREATE TABLE `od_order_de` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orderID` varchar(50) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  `allcost` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_odde_odID` (`orderID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of od_order_de
-- ----------------------------
INSERT INTO `od_order_de` VALUES ('1', 'O10024', '1001', '22', '2.00', '2600.00');
INSERT INTO `od_order_de` VALUES ('2', 'O10024', '1002', '2', '10.00', '400.00');
INSERT INTO `od_order_de` VALUES ('3', 'O10025', '1002', '2', '10.00', '400.00');
INSERT INTO `od_order_de` VALUES ('4', 'O10044', '1002', '2', '10.00', null);
INSERT INTO `od_order_de` VALUES ('5', 'O10045', '1001', '1', '2.00', null);
INSERT INTO `od_order_de` VALUES ('6', 'O10046', '1001', '1', '2.00', null);
INSERT INTO `od_order_de` VALUES ('10', 'O10050', '1001', '1', '2.00', null);
INSERT INTO `od_order_de` VALUES ('11', 'O10052', '1001', '2', '2.00', null);
INSERT INTO `od_order_de` VALUES ('12', 'O10053', '1001', '2', '2.00', null);

-- ----------------------------
-- Table structure for sku_inbound
-- ----------------------------
DROP TABLE IF EXISTS `sku_inbound`;
CREATE TABLE `sku_inbound` (
  `inboundID` varchar(50) NOT NULL,
  `executor` varchar(50) DEFAULT NULL,
  `extime` datetime DEFAULT NULL,
  PRIMARY KEY (`inboundID`),
  KEY `idx_in_exer` (`executor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sku_inbound
-- ----------------------------
INSERT INTO `sku_inbound` VALUES ('100021', 'admin', '2016-11-05 14:36:56');
INSERT INTO `sku_inbound` VALUES ('100022', 'admin', '2016-11-05 14:38:15');
INSERT INTO `sku_inbound` VALUES ('100025', 'admin', '2016-12-27 21:32:31');

-- ----------------------------
-- Table structure for sku_inbound_de
-- ----------------------------
DROP TABLE IF EXISTS `sku_inbound_de`;
CREATE TABLE `sku_inbound_de` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inboundID` varchar(50) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  `cost` decimal(12,2) DEFAULT NULL,
  `leftQty` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_inde_inid` (`inboundID`),
  KEY `idx_inde_sku` (`sku`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sku_inbound_de
-- ----------------------------
INSERT INTO `sku_inbound_de` VALUES ('1', '100021', '0', '1001', '20', '100.00', '20');
INSERT INTO `sku_inbound_de` VALUES ('2', '100021', '0', '1002', '5', '200.00', '5');
INSERT INTO `sku_inbound_de` VALUES ('3', '100022', '0', '1001', '2', '300.00', '2');
INSERT INTO `sku_inbound_de` VALUES ('4', '100025', '1', 'ABC1001', '100', '50.00', '100');

-- ----------------------------
-- Table structure for sku_outbound
-- ----------------------------
DROP TABLE IF EXISTS `sku_outbound`;
CREATE TABLE `sku_outbound` (
  `outboundID` varchar(50) NOT NULL,
  `executor` varchar(50) DEFAULT NULL,
  `extime` datetime DEFAULT NULL,
  PRIMARY KEY (`outboundID`),
  KEY `idx_in_exer` (`executor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sku_outbound
-- ----------------------------

-- ----------------------------
-- Table structure for sku_outbound_de
-- ----------------------------
DROP TABLE IF EXISTS `sku_outbound_de`;
CREATE TABLE `sku_outbound_de` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `outboundID` varchar(50) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  `allcost` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_otde_ouid` (`outboundID`),
  KEY `idx_otde_sku` (`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sku_outbound_de
-- ----------------------------

-- ----------------------------
-- Table structure for sk_stock
-- ----------------------------
DROP TABLE IF EXISTS `sk_stock`;
CREATE TABLE `sk_stock` (
  `sku` varchar(50) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sk_stock
-- ----------------------------
INSERT INTO `sk_stock` VALUES ('1001', '15');
INSERT INTO `sk_stock` VALUES ('1002', '3');
INSERT INTO `sk_stock` VALUES ('1003', '0');
INSERT INTO `sk_stock` VALUES ('ABC1001', '100');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '系统用户ID',
  `from` varchar(255) DEFAULT NULL COMMENT '来源 url',
  `ip` varchar(22) DEFAULT NULL COMMENT '客户端IP',
  `url` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL COMMENT '记录时间',
  `err_msg` text COMMENT '异常信息',
  `err_code` int(10) DEFAULT '0' COMMENT '状态码，0：正常',
  `class_name` varchar(200) DEFAULT NULL COMMENT 'controller类名',
  `method_name` varchar(64) DEFAULT NULL COMMENT '方法名',
  `start_time` datetime DEFAULT NULL COMMENT '操作时间',
  `spend_time` bigint(20) DEFAULT NULL COMMENT '耗时，毫秒',
  `params` text COMMENT '提供的参数',
  PRIMARY KEY (`id`),
  KEY `FK_sys_EVENT` (`uid`),
  CONSTRAINT `sys_log_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_login_record
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_record`;
CREATE TABLE `sys_login_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_uid` int(11) NOT NULL,
  `login_date` datetime NOT NULL COMMENT '登陆时间',
  `login_err_times` int(11) NOT NULL COMMENT '1天内连续出错次数',
  `login_status` tinyint(4) NOT NULL COMMENT '1-成功  0-失败',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台系统登陆记录';

-- ----------------------------
-- Records of sys_login_record
-- ----------------------------

-- ----------------------------
-- Table structure for sys_res
-- ----------------------------
DROP TABLE IF EXISTS `sys_res`;
CREATE TABLE `sys_res` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `name` varchar(111) DEFAULT NULL,
  `des` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `iconCls` varchar(255) DEFAULT 'am-icon-file',
  `seq` int(11) DEFAULT '1',
  `type` int(1) DEFAULT '2' COMMENT '1 功能 2 权限',
  `modifydate` timestamp NULL DEFAULT NULL,
  `enabled` int(1) DEFAULT '1' COMMENT '是否启用 1：启用  0：禁用',
  `level` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_res
-- ----------------------------
INSERT INTO `sys_res` VALUES ('1', null, '系统管理', '系统管理', '', 'fa-cogs', '10', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('2', '1', '资源管理', null, '/sys/res', 'fa-list', '1', '1', null, '1', '1');
INSERT INTO `sys_res` VALUES ('3', '1', '角色管理', null, '/sys/role', 'fa-list', '10', '1', null, '1', '1');
INSERT INTO `sys_res` VALUES ('4', '1', '用户管理', null, '/sys/user', 'fa-list', '11', '1', null, '1', '1');
INSERT INTO `sys_res` VALUES ('9', '4', '用户删除', null, '/sys/user/delete', 'fa-list', '1', '2', null, '1', '2');
INSERT INTO `sys_res` VALUES ('12', '4', '搜索用户', null, '/sys/user/serach', 'fa-list', '1', '2', null, '1', '2');
INSERT INTO `sys_res` VALUES ('18', '2', '资源删除', null, '/sys/res/delete', 'fa-list', '11', '2', null, '1', '0');
INSERT INTO `sys_res` VALUES ('19', '2', '资源保存', null, '/sys/res/save', 'fa-list', '11', '2', null, '1', '0');
INSERT INTO `sys_res` VALUES ('28', '3', '角色删除', null, '/sys/role/delete', 'fa-list', '11', '2', null, '1', '0');
INSERT INTO `sys_res` VALUES ('29', '3', '角色保存', null, '/sys/role/save', 'fa-list', '11', '2', null, '1', '0');
INSERT INTO `sys_res` VALUES ('63', '4', '冻结用户', null, '/sys/user/freeze', 'fa-list', '11', '2', null, '1', '0');
INSERT INTO `sys_res` VALUES ('146', '4', '用户列表', null, '/sys/user/list', 'fa-list', '8', '2', null, '1', '0');
INSERT INTO `sys_res` VALUES ('147', '4', '用户保存', null, '/sys/user/save', 'fa-list', '10', '2', null, '1', '0');
INSERT INTO `sys_res` VALUES ('150', '1', '操作日志', null, '/sys/log', 'fa-list', '11', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('152', null, '控制台', '1234', '/', 'fa-desktop', '1', '1', '2015-02-10 16:09:40', '1', '0');
INSERT INTO `sys_res` VALUES ('181', '1', '数据字典', null, '/dict', 'fa-list', '12', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('182', '181', '数据字典列表', null, '/dict/list', 'fa-list', '1', '2', null, '1', '0');
INSERT INTO `sys_res` VALUES ('192', null, 'APP管理', null, '', 'fa-android', '9', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('193', '192', 'App版本管理', null, '/app', '', '1', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('194', null, '商城管理', null, '', '', '2', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('195', '194', '类目管理', null, '/mall/category', '', '1', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('196', '194', '商品管理', null, '/mall/sku', '', '2', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('197', '194', '商户管理', null, '/mall/customer', '', '3', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('198', null, '库存管理', null, '', '', '4', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('199', '198', '入库管理', null, '/stock/inbound', '', '1', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('200', '198', '出库管理', null, '/stock/outbound', '', '2', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('201', '194', '订单管理', null, '/mall/order', '', '4', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('202', '198', '库存查询', null, '/stock/stock', '', '3', '1', null, '1', '0');
INSERT INTO `sys_res` VALUES ('203', '194', '返修单管理', null, '/mall/aftersale', '', '5', '1', null, '1', '0');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL DEFAULT '',
  `des` varchar(55) DEFAULT NULL,
  `seq` int(11) DEFAULT '1',
  `createdate` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '0-禁用  1-启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', 'admin', '超级管理员', '1', '2015-05-05 14:24:26', '1');
INSERT INTO `sys_role` VALUES ('56', '内容编辑', '内容编辑4', '1', null, '1');
INSERT INTO `sys_role` VALUES ('57', '客服人员', '客服人员', '1', null, '1');
INSERT INTO `sys_role` VALUES ('60', 'dd', 'ss ', '1', null, '1');
INSERT INTO `sys_role` VALUES ('61', '销售人员', '销售人员', '1', '2016-12-28 22:10:00', '1');

-- ----------------------------
-- Table structure for sys_role_res
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_res`;
CREATE TABLE `sys_role_res` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `res_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sys_ROLE_RES_RES_ID` (`res_id`),
  KEY `FK_sys_ROLE_RES_ROLE_ID` (`role_id`),
  CONSTRAINT `sys_role_res_ibfk_1` FOREIGN KEY (`res_id`) REFERENCES `sys_res` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_role_res_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4208 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_role_res
-- ----------------------------
INSERT INTO `sys_role_res` VALUES ('4141', '1', '1');
INSERT INTO `sys_role_res` VALUES ('4142', '2', '1');
INSERT INTO `sys_role_res` VALUES ('4143', '18', '1');
INSERT INTO `sys_role_res` VALUES ('4144', '19', '1');
INSERT INTO `sys_role_res` VALUES ('4145', '3', '1');
INSERT INTO `sys_role_res` VALUES ('4146', '28', '1');
INSERT INTO `sys_role_res` VALUES ('4147', '29', '1');
INSERT INTO `sys_role_res` VALUES ('4148', '4', '1');
INSERT INTO `sys_role_res` VALUES ('4149', '9', '1');
INSERT INTO `sys_role_res` VALUES ('4150', '12', '1');
INSERT INTO `sys_role_res` VALUES ('4151', '63', '1');
INSERT INTO `sys_role_res` VALUES ('4152', '146', '1');
INSERT INTO `sys_role_res` VALUES ('4153', '147', '1');
INSERT INTO `sys_role_res` VALUES ('4154', '150', '1');
INSERT INTO `sys_role_res` VALUES ('4155', '181', '1');
INSERT INTO `sys_role_res` VALUES ('4156', '182', '1');
INSERT INTO `sys_role_res` VALUES ('4157', '152', '1');
INSERT INTO `sys_role_res` VALUES ('4162', '192', '1');
INSERT INTO `sys_role_res` VALUES ('4163', '193', '1');
INSERT INTO `sys_role_res` VALUES ('4168', '1', '56');
INSERT INTO `sys_role_res` VALUES ('4169', '2', '56');
INSERT INTO `sys_role_res` VALUES ('4170', '18', '56');
INSERT INTO `sys_role_res` VALUES ('4171', '19', '56');
INSERT INTO `sys_role_res` VALUES ('4172', '3', '56');
INSERT INTO `sys_role_res` VALUES ('4173', '28', '56');
INSERT INTO `sys_role_res` VALUES ('4174', '29', '56');
INSERT INTO `sys_role_res` VALUES ('4175', '194', '1');
INSERT INTO `sys_role_res` VALUES ('4176', '195', '1');
INSERT INTO `sys_role_res` VALUES ('4179', '1', '60');
INSERT INTO `sys_role_res` VALUES ('4180', '2', '60');
INSERT INTO `sys_role_res` VALUES ('4181', '18', '60');
INSERT INTO `sys_role_res` VALUES ('4182', '19', '60');
INSERT INTO `sys_role_res` VALUES ('4183', '3', '60');
INSERT INTO `sys_role_res` VALUES ('4184', '28', '60');
INSERT INTO `sys_role_res` VALUES ('4185', '29', '60');
INSERT INTO `sys_role_res` VALUES ('4186', '4', '60');
INSERT INTO `sys_role_res` VALUES ('4187', '9', '60');
INSERT INTO `sys_role_res` VALUES ('4188', '12', '60');
INSERT INTO `sys_role_res` VALUES ('4189', '63', '60');
INSERT INTO `sys_role_res` VALUES ('4190', '146', '60');
INSERT INTO `sys_role_res` VALUES ('4191', '147', '60');
INSERT INTO `sys_role_res` VALUES ('4192', '150', '60');
INSERT INTO `sys_role_res` VALUES ('4193', '181', '60');
INSERT INTO `sys_role_res` VALUES ('4194', '182', '60');
INSERT INTO `sys_role_res` VALUES ('4195', '152', '60');
INSERT INTO `sys_role_res` VALUES ('4196', '192', '60');
INSERT INTO `sys_role_res` VALUES ('4197', '193', '60');
INSERT INTO `sys_role_res` VALUES ('4198', '194', '60');
INSERT INTO `sys_role_res` VALUES ('4199', '195', '60');
INSERT INTO `sys_role_res` VALUES ('4200', '196', '1');
INSERT INTO `sys_role_res` VALUES ('4201', '197', '1');
INSERT INTO `sys_role_res` VALUES ('4202', '198', '1');
INSERT INTO `sys_role_res` VALUES ('4203', '199', '1');
INSERT INTO `sys_role_res` VALUES ('4204', '200', '1');
INSERT INTO `sys_role_res` VALUES ('4205', '201', '1');
INSERT INTO `sys_role_res` VALUES ('4206', '202', '1');
INSERT INTO `sys_role_res` VALUES ('4207', '203', '1');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `des` varchar(55) DEFAULT NULL,
  `status` int(1) DEFAULT '1' COMMENT '#1 不在线 2.封号状态 ',
  `icon` varchar(255) DEFAULT '/images/guest.jpg',
  `email` varchar(50) DEFAULT NULL,
  `createdate` datetime DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `token` varchar(64) DEFAULT NULL COMMENT 'cookieid',
  `wxid` varchar(64) DEFAULT NULL COMMENT '微信号',
  `realName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_index` (`name`),
  UNIQUE KEY `token_index` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '6fc3b9ada8c1e50b400cd6998ff7be76ea3ae312', '1289', '1', '/sys/static/i/9.jpg', 'admin@admin.com', '2015-07-15 18:00:27', '1234567', 'UzNk7MKbVABao0I275SAs9ShzyYtLQooG42fkoDcL9QtkuFP1Xm7QOtIMrbvxbLc', '234324324', '管理员');
INSERT INTO `sys_user` VALUES ('32', 'eason', '5d46f91596dc2f24c1535148f778af0a25612289', 'sfsf', '1', '/images/guest.jpg', '569165857@qq.com', '2016-06-12 23:54:24', '13332892938', null, null, '医生');
INSERT INTO `sys_user` VALUES ('34', 'test', '6fc3b9ada8c1e50b400cd6998ff7be76ea3ae312', 'dfsdfsdfddf ', '1', '/images/guest.jpg', '569165857@qq.com', '2016-07-02 22:24:50', '13332892938', 'hDEflmnlVituFC6hbfTzeze8RVSRseIfdgBAGkAU2RRh4c4kIrIYXTTuwEG2Caem', null, null);
INSERT INTO `sys_user` VALUES ('35', 'liubotest', '250778b614cb9de3273881f2be42cc8b28e83c6a', '测试', '1', '/images/guest.jpg', '', '2016-10-12 16:27:49', '', null, null, null);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_SYSTME_USER_ROLE_USER_ID` (`user_id`),
  KEY `FK_SYSTME_USER_ROLE_ROLE_ID` (`role_id`),
  CONSTRAINT `sys_user_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_user_role_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=338 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('315', '1', '1');
INSERT INTO `sys_user_role` VALUES ('333', '32', '1');
INSERT INTO `sys_user_role` VALUES ('334', '32', '56');
INSERT INTO `sys_user_role` VALUES ('335', '32', '57');
INSERT INTO `sys_user_role` VALUES ('336', '32', '60');
INSERT INTO `sys_user_role` VALUES ('337', '35', '60');
