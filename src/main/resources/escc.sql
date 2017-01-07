-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: ecss
-- ------------------------------------------------------
-- Server version	5.7.10-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_token`
--

DROP TABLE IF EXISTS `access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_token` (
  `uid` int(10) NOT NULL,
  `token` varchar(64) NOT NULL COMMENT 'app用户登陆凭证',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `im_token` varchar(64) DEFAULT NULL COMMENT '第三方IM登陆凭证',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_token`
--

LOCK TABLES `access_token` WRITE;
/*!40000 ALTER TABLE `access_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `access_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_version`
--

DROP TABLE IF EXISTS `app_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_version`
--

LOCK TABLES `app_version` WRITE;
/*!40000 ALTER TABLE `app_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `as_aftersaleod`
--

DROP TABLE IF EXISTS `as_aftersaleod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `as_aftersaleod`
--

LOCK TABLES `as_aftersaleod` WRITE;
/*!40000 ALTER TABLE `as_aftersaleod` DISABLE KEYS */;
INSERT INTO `as_aftersaleod` VALUES ('AS10041','10017','dsf',NULL,'dasf',NULL,'adsf12',0.00,'adsf',2);
/*!40000 ALTER TABLE `as_aftersaleod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `as_aftersaleod_de`
--

DROP TABLE IF EXISTS `as_aftersaleod_de`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `as_aftersaleod_de`
--

LOCK TABLES `as_aftersaleod_de` WRITE;
/*!40000 ALTER TABLE `as_aftersaleod_de` DISABLE KEYS */;
INSERT INTO `as_aftersaleod_de` VALUES (1,'AS10041','1001',1,0,NULL);
/*!40000 ALTER TABLE `as_aftersaleod_de` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `console_sequence`
--

DROP TABLE IF EXISTS `console_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `console_sequence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(10) DEFAULT NULL,
  `code` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `console_sequence`
--

LOCK TABLES `console_sequence` WRITE;
/*!40000 ALTER TABLE `console_sequence` DISABLE KEYS */;
INSERT INTO `console_sequence` VALUES (2,'类目',100018),(3,'商家',10024),(4,'入库',100026),(5,'订单',10053);
/*!40000 ALTER TABLE `console_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_rated`
--

DROP TABLE IF EXISTS `customer_rated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_rated` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer` varchar(45) DEFAULT NULL COMMENT '销售人员',
  `orderID` varchar(45) DEFAULT NULL COMMENT '计提月份',
  `amount` decimal(12,2) DEFAULT NULL COMMENT '提成金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工提成表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_rated`
--

LOCK TABLES `customer_rated` WRITE;
/*!40000 ALTER TABLE `customer_rated` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_rated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_rated_de`
--

DROP TABLE IF EXISTS `customer_rated_de`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_rated_de` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ratedID` int(11) DEFAULT NULL,
  `orderDeID` int(11) DEFAULT NULL,
  `sku` varchar(45) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL COMMENT '提成金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工提成表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_rated_de`
--

LOCK TABLES `customer_rated_de` WRITE;
/*!40000 ALTER TABLE `customer_rated_de` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_rated_de` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dict_data`
--

DROP TABLE IF EXISTS `dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dict_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '名称',
  `value` varchar(255) NOT NULL COMMENT '对应的值',
  `remark` varchar(32) DEFAULT NULL,
  `seq` int(11) NOT NULL COMMENT '排序，由小到大',
  `update_time` int(10) NOT NULL,
  `dict_type_id` int(11) NOT NULL COMMENT '字典类型ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dict_data`
--

LOCK TABLES `dict_data` WRITE;
/*!40000 ALTER TABLE `dict_data` DISABLE KEYS */;
INSERT INTO `dict_data` VALUES (1,'支付宝账号','123456','',1,1483712033,1),(2,'支付宝账号','111111',NULL,2,1483712033,1),(3,'微信账号','222222',NULL,3,1483712033,1),(4,'工商银行','333333',NULL,4,1483712033,1);
/*!40000 ALTER TABLE `dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dict_type`
--

DROP TABLE IF EXISTS `dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dict_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `remark` varchar(32) DEFAULT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dict_type`
--

LOCK TABLES `dict_type` WRITE;
/*!40000 ALTER TABLE `dict_type` DISABLE KEYS */;
INSERT INTO `dict_type` VALUES (1,'支付信息','',1483712011);
/*!40000 ALTER TABLE `dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mall_cart`
--

DROP TABLE IF EXISTS `mall_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mall_cart` (
  `cusCode` varchar(50) NOT NULL,
  `totalCount` smallint(5) unsigned DEFAULT '0',
  `amount` decimal(12,2) DEFAULT '0.00',
  PRIMARY KEY (`cusCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_cart`
--

LOCK TABLES `mall_cart` WRITE;
/*!40000 ALTER TABLE `mall_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `mall_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mall_cart_de`
--

DROP TABLE IF EXISTS `mall_cart_de`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_cart_de`
--

LOCK TABLES `mall_cart_de` WRITE;
/*!40000 ALTER TABLE `mall_cart_de` DISABLE KEYS */;
/*!40000 ALTER TABLE `mall_cart_de` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mall_category`
--

DROP TABLE IF EXISTS `mall_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mall_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cateName` varchar(50) DEFAULT NULL,
  `cateCode` varchar(50) DEFAULT NULL,
  `parentCode` varchar(50) DEFAULT NULL,
  `remare` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cate_code` (`cateCode`),
  KEY `idx_cate_pcode` (`parentCode`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_category`
--

LOCK TABLES `mall_category` WRITE;
/*!40000 ALTER TABLE `mall_category` DISABLE KEYS */;
INSERT INTO `mall_category` VALUES (1,'A1001','100013',NULL,NULL),(2,'A100101','100014','100013',NULL),(3,'A100102','100015','100013',NULL),(4,'A100103','100016','100013',NULL),(5,'A2001','100017',NULL,NULL),(6,'A200101','100018','100017',NULL);
/*!40000 ALTER TABLE `mall_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mall_customer`
--

DROP TABLE IF EXISTS `mall_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_customer`
--

LOCK TABLES `mall_customer` WRITE;
/*!40000 ALTER TABLE `mall_customer` DISABLE KEYS */;
INSERT INTO `mall_customer` VALUES (4,'10024','韩磊','14837c5d51101922a894852397eb0316',1,'M','2017-01-01','jesse.18@163.com','18615267773','18615267773','','36',0,NULL,'A','0',1);
/*!40000 ALTER TABLE `mall_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mall_customer_addr`
--

DROP TABLE IF EXISTS `mall_customer_addr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mall_customer_addr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer` varchar(50) DEFAULT NULL,
  `addr` varchar(200) DEFAULT NULL,
  `recipient` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `used` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cusaddr_cus` (`customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_customer_addr`
--

LOCK TABLES `mall_customer_addr` WRITE;
/*!40000 ALTER TABLE `mall_customer_addr` DISABLE KEYS */;
/*!40000 ALTER TABLE `mall_customer_addr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mall_customer_shop`
--

DROP TABLE IF EXISTS `mall_customer_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mall_customer_shop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer` varchar(50) DEFAULT NULL,
  `category` char(1) DEFAULT NULL,
  `shopName` varchar(50) DEFAULT NULL,
  `shopAddr` varchar(200) DEFAULT NULL,
  `shopPic` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_shop_cus` (`customer`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_customer_shop`
--

LOCK TABLES `mall_customer_shop` WRITE;
/*!40000 ALTER TABLE `mall_customer_shop` DISABLE KEYS */;
INSERT INTO `mall_customer_shop` VALUES (1,'10024','1','啊啊啊','阿迪斯发大师傅大师傅','10024100241483780500024');
/*!40000 ALTER TABLE `mall_customer_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mall_customer_sku`
--

DROP TABLE IF EXISTS `mall_customer_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mall_customer_sku` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer` varchar(50) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cusasku_cus` (`customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_customer_sku`
--

LOCK TABLES `mall_customer_sku` WRITE;
/*!40000 ALTER TABLE `mall_customer_sku` DISABLE KEYS */;
/*!40000 ALTER TABLE `mall_customer_sku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mall_sku`
--

DROP TABLE IF EXISTS `mall_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_sku`
--

LOCK TABLES `mall_sku` WRITE;
/*!40000 ALTER TABLE `mall_sku` DISABLE KEYS */;
INSERT INTO `mall_sku` VALUES (1,'A10010101','A10010101','100014',NULL,NULL,'A100101',NULL,'b3.jpg',NULL);
/*!40000 ALTER TABLE `mall_sku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mall_sku_nprice`
--

DROP TABLE IF EXISTS `mall_sku_nprice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_sku_nprice`
--

LOCK TABLES `mall_sku_nprice` WRITE;
/*!40000 ALTER TABLE `mall_sku_nprice` DISABLE KEYS */;
INSERT INTO `mall_sku_nprice` VALUES ('A10010101','A',NULL,NULL,10,150.00,20,140.00,30,130.00),('A10010101','B',NULL,NULL,10,160.00,20,150.00,30,140.00),('A10010101','C',NULL,NULL,10,170.00,20,160.00,30,150.00),('A10010101','D',NULL,NULL,10,180.00,20,170.00,30,160.00);
/*!40000 ALTER TABLE `mall_sku_nprice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mall_sku_sprice`
--

DROP TABLE IF EXISTS `mall_sku_sprice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mall_sku_sprice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(50) DEFAULT NULL,
  `customer` varchar(50) DEFAULT NULL,
  `firstbuy` char(1) DEFAULT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_spri_pri` (`customer`,`sku`,`price`),
  KEY `idx_spri_1stby` (`customer`,`sku`,`firstbuy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_sku_sprice`
--

LOCK TABLES `mall_sku_sprice` WRITE;
/*!40000 ALTER TABLE `mall_sku_sprice` DISABLE KEYS */;
/*!40000 ALTER TABLE `mall_sku_sprice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `od_order`
--

DROP TABLE IF EXISTS `od_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `od_order`
--

LOCK TABLES `od_order` WRITE;
/*!40000 ALTER TABLE `od_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `od_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `od_order_addr`
--

DROP TABLE IF EXISTS `od_order_addr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `od_order_addr` (
  `orderID` varchar(50) NOT NULL,
  `addr` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`orderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `od_order_addr`
--

LOCK TABLES `od_order_addr` WRITE;
/*!40000 ALTER TABLE `od_order_addr` DISABLE KEYS */;
/*!40000 ALTER TABLE `od_order_addr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `od_order_de`
--

DROP TABLE IF EXISTS `od_order_de`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `od_order_de` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orderID` varchar(50) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  `allcost` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_odde_odID` (`orderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `od_order_de`
--

LOCK TABLES `od_order_de` WRITE;
/*!40000 ALTER TABLE `od_order_de` DISABLE KEYS */;
/*!40000 ALTER TABLE `od_order_de` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sk_stock`
--

DROP TABLE IF EXISTS `sk_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sk_stock` (
  `sku` varchar(50) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sk_stock`
--

LOCK TABLES `sk_stock` WRITE;
/*!40000 ALTER TABLE `sk_stock` DISABLE KEYS */;
INSERT INTO `sk_stock` VALUES ('A10010101',100);
/*!40000 ALTER TABLE `sk_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sku_inbound`
--

DROP TABLE IF EXISTS `sku_inbound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sku_inbound` (
  `inboundID` varchar(50) NOT NULL,
  `executor` varchar(50) DEFAULT NULL,
  `extime` datetime DEFAULT NULL,
  PRIMARY KEY (`inboundID`),
  KEY `idx_in_exer` (`executor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sku_inbound`
--

LOCK TABLES `sku_inbound` WRITE;
/*!40000 ALTER TABLE `sku_inbound` DISABLE KEYS */;
INSERT INTO `sku_inbound` VALUES ('100026','admin','2017-01-07 17:23:44');
/*!40000 ALTER TABLE `sku_inbound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sku_inbound_de`
--

DROP TABLE IF EXISTS `sku_inbound_de`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sku_inbound_de`
--

LOCK TABLES `sku_inbound_de` WRITE;
/*!40000 ALTER TABLE `sku_inbound_de` DISABLE KEYS */;
INSERT INTO `sku_inbound_de` VALUES (1,'100026',1,'A10010101',100,90.00,100);
/*!40000 ALTER TABLE `sku_inbound_de` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sku_outbound`
--

DROP TABLE IF EXISTS `sku_outbound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sku_outbound` (
  `outboundID` varchar(50) NOT NULL,
  `executor` varchar(50) DEFAULT NULL,
  `extime` datetime DEFAULT NULL,
  PRIMARY KEY (`outboundID`),
  KEY `idx_in_exer` (`executor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sku_outbound`
--

LOCK TABLES `sku_outbound` WRITE;
/*!40000 ALTER TABLE `sku_outbound` DISABLE KEYS */;
/*!40000 ALTER TABLE `sku_outbound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sku_outbound_de`
--

DROP TABLE IF EXISTS `sku_outbound_de`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sku_outbound_de`
--

LOCK TABLES `sku_outbound_de` WRITE;
/*!40000 ALTER TABLE `sku_outbound_de` DISABLE KEYS */;
/*!40000 ALTER TABLE `sku_outbound_de` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_log`
--

DROP TABLE IF EXISTS `sys_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_log`
--

LOCK TABLES `sys_log` WRITE;
/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
INSERT INTO `sys_log` VALUES (1,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/rate',NULL,'',0,'com.fruit.controller.mall.RateController','index','2016-12-29 23:47:01',6,NULL),(2,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/rate/view',NULL,'',0,'com.fruit.controller.mall.RateController','view','2016-12-29 23:47:08',1,NULL),(3,1,'http://localhost:9000/mall/rate/view','0:0:0:0:0:0:0:1','/mall/rate/getRatedData',NULL,'',0,'com.fruit.controller.mall.RateController','getRatedData','2016-12-29 23:47:26',4,NULL),(4,NULL,'http://localhost:9000/login','0:0:0:0:0:0:0:1','/image/getCode',NULL,'',0,'com.fruit.controller.ImageController','getCode','2017-01-06 22:06:53',753,NULL),(5,1,'http://localhost:9000/login','0:0:0:0:0:0:0:1','/image/getCode',NULL,'',0,'com.fruit.controller.ImageController','getCode','2017-01-06 22:07:00',27,NULL),(6,1,'http://localhost:9000/login','0:0:0:0:0:0:0:1','/image/getCode',NULL,'',0,'com.fruit.controller.ImageController','getCode','2017-01-06 22:07:07',17,NULL),(7,1,'http://localhost:9000/login','0:0:0:0:0:0:0:1','/image/getCode',NULL,'',0,'com.fruit.controller.ImageController','getCode','2017-01-06 22:07:29',18,NULL),(8,1,'http://localhost:9000/login','0:0:0:0:0:0:0:1','/image/getCode',NULL,'',0,'com.fruit.controller.ImageController','getCode','2017-01-06 22:09:45',20,NULL),(9,1,'http://localhost:9000/login','0:0:0:0:0:0:0:1','/image/getCode',NULL,'',0,'com.fruit.controller.ImageController','getCode','2017-01-06 22:11:01',68623,NULL),(10,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/dict',NULL,'',0,'com.fruit.controller.sys.DictController','index','2017-01-06 22:13:14',2,NULL),(11,1,'http://localhost:9000/dict','0:0:0:0:0:0:0:1','/dict/getTypeListData',NULL,'',0,'com.fruit.controller.sys.DictController','getTypeListData','2017-01-06 22:13:14',27,NULL),(12,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/dict/add_type',NULL,'',0,'com.fruit.controller.sys.DictController','add_type','2017-01-06 22:13:19',1,NULL),(13,1,'http://localhost:9000/dict/add_type','0:0:0:0:0:0:0:1','/dict/saveType',NULL,'',0,'com.fruit.controller.sys.DictController','saveType','2017-01-06 22:13:31',15,NULL),(14,1,'http://localhost:9000/dict','0:0:0:0:0:0:0:1','/dict/getTypeListData',NULL,'',0,'com.fruit.controller.sys.DictController','getTypeListData','2017-01-06 22:13:33',3,NULL),(15,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/dict/data_index',NULL,'',0,'com.fruit.controller.sys.DictController','data_index','2017-01-06 22:13:36',0,NULL),(16,1,'http://localhost:9000/dict/data_index?typeId=4','0:0:0:0:0:0:0:1','/dict/getListData',NULL,'',0,'com.fruit.controller.sys.DictController','getListData','2017-01-06 22:13:37',4,NULL),(17,1,'http://localhost:9000/dict/data_index?typeId=4','0:0:0:0:0:0:0:1','/dict/add_data',NULL,'',0,'com.fruit.controller.sys.DictController','add_data','2017-01-06 22:13:39',0,NULL),(18,1,'http://localhost:9000/dict/add_data?typeId=4','0:0:0:0:0:0:0:1','/dict/saveData',NULL,'',0,'com.fruit.controller.sys.DictController','saveData','2017-01-06 22:13:53',10,NULL),(19,1,'http://localhost:9000/dict/data_index?typeId=4','0:0:0:0:0:0:0:1','/dict/getListData',NULL,'',0,'com.fruit.controller.sys.DictController','getListData','2017-01-06 22:13:55',3,NULL),(20,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/dict/data_index',NULL,'',0,'com.fruit.controller.sys.DictController','data_index','2017-01-06 22:14:31',0,NULL),(21,1,'http://localhost:9000/dict/data_index?typeId=4','0:0:0:0:0:0:0:1','/dict/getListData',NULL,'',0,'com.fruit.controller.sys.DictController','getListData','2017-01-06 22:14:31',6,NULL),(22,1,'http://localhost:9000/dict/data_index?typeId=4','0:0:0:0:0:0:0:1','/dict/add_data',NULL,'',0,'com.fruit.controller.sys.DictController','add_data','2017-01-06 22:14:34',0,NULL),(23,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/res',NULL,'',0,'com.fruit.controller.sys.ResController','index','2017-01-07 15:38:27',2,NULL),(24,1,'http://localhost:9000/sys/res','0:0:0:0:0:0:0:1','/sys/res/getTreeGridView',NULL,'',0,'com.fruit.controller.sys.ResController','getTreeGridView','2017-01-07 15:38:27',89,NULL),(25,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/res/add',NULL,'',0,'com.fruit.controller.sys.ResController','add','2017-01-07 15:38:32',15,NULL),(26,1,'http://localhost:9000/sys/res/add','0:0:0:0:0:0:0:1','/sys/res/saveRes',NULL,'',0,'com.fruit.controller.sys.ResController','saveRes','2017-01-07 15:39:17',16,NULL),(27,1,'http://localhost:9000/sys/res','0:0:0:0:0:0:0:1','/sys/res/getTreeGridView',NULL,'',0,'com.fruit.controller.sys.ResController','getTreeGridView','2017-01-07 15:39:19',54,NULL),(28,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/res',NULL,'',0,'com.fruit.controller.sys.ResController','index','2017-01-07 15:39:25',0,NULL),(29,1,'http://localhost:9000/sys/res','0:0:0:0:0:0:0:1','/sys/res/getTreeGridView',NULL,'',0,'com.fruit.controller.sys.ResController','getTreeGridView','2017-01-07 15:39:26',57,NULL),(30,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/res',NULL,'',0,'com.fruit.controller.sys.ResController','index','2017-01-07 15:39:30',0,NULL),(31,1,'http://localhost:9000/sys/res','0:0:0:0:0:0:0:1','/sys/res/getTreeGridView',NULL,'',0,'com.fruit.controller.sys.ResController','getTreeGridView','2017-01-07 15:39:30',47,NULL),(32,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/res',NULL,'',0,'com.fruit.controller.sys.ResController','index','2017-01-07 15:39:32',0,NULL),(33,1,'http://localhost:9000/sys/res','0:0:0:0:0:0:0:1','/sys/res/getTreeGridView',NULL,'',0,'com.fruit.controller.sys.ResController','getTreeGridView','2017-01-07 15:39:32',51,NULL),(34,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/res',NULL,'',0,'com.fruit.controller.sys.ResController','index','2017-01-07 15:39:35',1,NULL),(35,1,'http://localhost:9000/sys/res','0:0:0:0:0:0:0:1','/sys/res/getTreeGridView',NULL,'',0,'com.fruit.controller.sys.ResController','getTreeGridView','2017-01-07 15:39:35',56,NULL),(36,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/res',NULL,'',0,'com.fruit.controller.sys.ResController','index','2017-01-07 15:50:04',0,NULL),(37,1,'http://localhost:9000/sys/res','0:0:0:0:0:0:0:1','/sys/res/getTreeGridView',NULL,'',0,'com.fruit.controller.sys.ResController','getTreeGridView','2017-01-07 15:50:04',69,NULL),(38,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/customerRate',NULL,'',0,'com.fruit.controller.mall.CustomerRateController','index','2017-01-07 15:50:07',0,NULL),(39,1,'http://localhost:9000/mall/customerRate','0:0:0:0:0:0:0:1','/mall/customerRate/getListData',NULL,'java.lang.NullPointerException\r\n	at com.jfinal.plugin.activerecord.Model.paginate(Model.java:292)\r\n	at com.fruit.core.model.BaseModel.getPage(BaseModel.java:106)\r\n	at com.fruit.controller.mall.CustomerRateController.getListData(CustomerRateController.java:41)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:497)\r\n	at com.jfinal.aop.Invocation.invoke(Invocation.java:73)\r\n	at com.fruit.core.auth.interceptor.AuthorityInterceptor.intercept(AuthorityInterceptor.java:92)\r\n	at com.jfinal.aop.Invocation.invoke(Invocation.java:67)\r\n	at com.fruit.core.auth.interceptor.SysLogInterceptor.intercept(SysLogInterceptor.java:44)\r\n	at com.jfinal.aop.Invocation.invoke(Invocation.java:67)\r\n	at com.jfinal.core.ActionHandler.handle(ActionHandler.java:74)\r\n	at com.fruit.core.handler.ResourceHandler.handle(ResourceHandler.java:26)\r\n	at com.jfinal.plugin.druid.DruidStatViewHandler.handle(DruidStatViewHandler.java:75)\r\n	at com.jfinal.core.JFinalFilter.doFilter(JFinalFilter.java:72)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:192)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:165)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:198)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:474)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:140)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:79)\r\n	at org.apache.catalina.valves.AbstractAccessLogValve.invoke(AbstractAccessLogValve.java:624)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:87)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:349)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:783)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:789)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1437)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\n',-1,'com.fruit.controller.mall.CustomerRateController','getListData','2017-01-07 15:50:08',6,NULL),(40,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/dict',NULL,'',0,'com.fruit.controller.sys.DictController','index','2017-01-07 15:58:07',7,NULL),(41,1,'http://localhost:9000/dict','0:0:0:0:0:0:0:1','/dict/getTypeListData',NULL,'',0,'com.fruit.controller.sys.DictController','getTypeListData','2017-01-07 15:58:07',9,NULL),(42,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/dict/add_type',NULL,'',0,'com.fruit.controller.sys.DictController','add_type','2017-01-07 15:58:10',2,NULL),(43,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/dict/data_index',NULL,'',0,'com.fruit.controller.sys.DictController','data_index','2017-01-07 15:58:12',1,NULL),(44,1,'http://localhost:9000/dict/data_index?typeId=1','0:0:0:0:0:0:0:1','/dict/getListData',NULL,'',0,'com.fruit.controller.sys.DictController','getListData','2017-01-07 15:58:13',4,NULL),(45,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/order',NULL,'',0,'com.fruit.controller.mall.OrderController','index','2017-01-07 16:07:43',2,NULL),(46,1,'http://localhost:9000/mall/order','0:0:0:0:0:0:0:1','/mall/order/getListData',NULL,'',0,'com.fruit.controller.mall.OrderController','getListData','2017-01-07 16:07:44',42,NULL),(47,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/order',NULL,'',0,'com.fruit.controller.mall.OrderController','index','2017-01-07 16:11:47',0,NULL),(48,1,'http://localhost:9000/mall/order','0:0:0:0:0:0:0:1','/mall/order/getListData',NULL,'',0,'com.fruit.controller.mall.OrderController','getListData','2017-01-07 16:11:47',9,NULL),(49,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/user',NULL,'',0,'com.fruit.controller.sys.UserController','index','2017-01-07 16:12:15',1,NULL),(50,1,'http://localhost:9000/sys/user','0:0:0:0:0:0:0:1','/sys/user/getListData',NULL,'',0,'com.fruit.controller.sys.UserController','getListData','2017-01-07 16:12:15',13,NULL),(51,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/user',NULL,'',0,'com.fruit.controller.sys.UserController','index','2017-01-07 16:13:23',0,NULL),(52,1,'http://localhost:9000/sys/user','0:0:0:0:0:0:0:1','/sys/user/getListData',NULL,'',0,'com.fruit.controller.sys.UserController','getListData','2017-01-07 16:13:23',4,NULL),(53,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/user/add',NULL,'',0,'com.fruit.controller.sys.UserController','add','2017-01-07 16:13:27',2,NULL),(54,1,'http://localhost:9000/sys/user/add','0:0:0:0:0:0:0:1','/sys/user/save',NULL,'',0,'com.fruit.controller.sys.UserController','save','2017-01-07 16:14:15',14,NULL),(55,1,'http://localhost:9000/sys/user','0:0:0:0:0:0:0:1','/sys/user/getListData',NULL,'',0,'com.fruit.controller.sys.UserController','getListData','2017-01-07 16:14:15',3,NULL),(56,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/role',NULL,'',0,'com.fruit.controller.sys.RoleController','index','2017-01-07 16:14:21',0,NULL),(57,1,'http://localhost:9000/sys/role','0:0:0:0:0:0:0:1','/sys/role/getListData',NULL,'',0,'com.fruit.controller.sys.RoleController','getListData','2017-01-07 16:14:22',6,NULL),(58,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/role/add',NULL,'',0,'com.fruit.controller.sys.RoleController','add','2017-01-07 16:14:27',0,NULL),(59,1,'http://localhost:9000/sys/role/add','0:0:0:0:0:0:0:1','/sys/role/save',NULL,'',0,'com.fruit.controller.sys.RoleController','save','2017-01-07 16:14:35',4,NULL),(60,1,'http://localhost:9000/sys/role','0:0:0:0:0:0:0:1','/sys/role/getListData',NULL,'',0,'com.fruit.controller.sys.RoleController','getListData','2017-01-07 16:14:37',3,NULL),(61,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/role/getZtree',NULL,'',0,'com.fruit.controller.sys.RoleController','getZtree','2017-01-07 16:14:40',21,NULL),(62,1,'http://localhost:9000/sys/role/getZtree?roleId=62&type=1','0:0:0:0:0:0:0:1','/sys/role/saveMenuAssign',NULL,'',0,'com.fruit.controller.sys.RoleController','saveMenuAssign','2017-01-07 16:15:03',42,NULL),(63,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/role/add',NULL,'',0,'com.fruit.controller.sys.RoleController','add','2017-01-07 16:15:12',8,NULL),(64,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/role/getZtree',NULL,'',0,'com.fruit.controller.sys.RoleController','getZtree','2017-01-07 16:15:15',7,NULL),(65,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/sys/user/userRoleSetting',NULL,'',0,'com.fruit.controller.sys.UserController','userRoleSetting','2017-01-07 16:15:22',6,NULL),(66,1,'http://localhost:9000/sys/user/userRoleSetting?uid=36','0:0:0:0:0:0:0:1','/sys/user/saveUserRoles',NULL,'',0,'com.fruit.controller.sys.UserController','saveUserRoles','2017-01-07 16:15:25',10,NULL),(67,1,'http://localhost:9000/sys/user','0:0:0:0:0:0:0:1','/sys/user/getListData',NULL,'',0,'com.fruit.controller.sys.UserController','getListData','2017-01-07 16:15:27',10,NULL),(68,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/customer',NULL,'',0,'com.fruit.controller.mall.CustomerController','index','2017-01-07 16:18:01',0,NULL),(69,1,'http://localhost:9000/mall/customer','0:0:0:0:0:0:0:1','/mall/customer/getListData',NULL,'',0,'com.fruit.controller.mall.CustomerController','getListData','2017-01-07 16:18:01',6,NULL),(70,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/customer/audit',NULL,'',0,'com.fruit.controller.mall.CustomerController','audit','2017-01-07 16:18:04',10,NULL),(71,NULL,'http://localhost:9000/login','0:0:0:0:0:0:0:1','/image/getCode',NULL,'',0,'com.fruit.controller.ImageController','getCode','2017-01-07 17:15:35',906,NULL),(72,1,'http://localhost:9000/login','0:0:0:0:0:0:0:1','/image/getCode',NULL,'',0,'com.fruit.controller.ImageController','getCode','2017-01-07 17:15:45',24,NULL),(73,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/customer',NULL,'',0,'com.fruit.controller.mall.CustomerController','index','2017-01-07 17:16:32',2,NULL),(74,1,'http://localhost:9000/mall/customer','0:0:0:0:0:0:0:1','/mall/customer/getListData',NULL,'',0,'com.fruit.controller.mall.CustomerController','getListData','2017-01-07 17:16:33',24,NULL),(75,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/customer/audit',NULL,'',0,'com.fruit.controller.mall.CustomerController','audit','2017-01-07 17:16:35',6,NULL),(76,1,'http://localhost:9000/mall/customer/audit?id=4','0:0:0:0:0:0:0:1','/mall/customer/saveAudit',NULL,'',0,'com.fruit.controller.mall.CustomerController','saveAudit','2017-01-07 17:17:58',20,NULL),(77,1,'http://localhost:9000/mall/customer','0:0:0:0:0:0:0:1','/mall/customer/getListData',NULL,'',0,'com.fruit.controller.mall.CustomerController','getListData','2017-01-07 17:18:00',3,NULL),(78,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/category',NULL,'',0,'com.fruit.controller.mall.CategoryController','index','2017-01-07 17:18:14',1,NULL),(79,1,'http://localhost:9000/mall/category','0:0:0:0:0:0:0:1','/mall/category/getTreeGridView',NULL,'',0,'com.fruit.controller.mall.CategoryController','getTreeGridView','2017-01-07 17:18:15',6,NULL),(80,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/category/add',NULL,'',0,'com.fruit.controller.mall.CategoryController','add','2017-01-07 17:18:17',2,NULL),(81,1,'http://localhost:9000/mall/category/add','0:0:0:0:0:0:0:1','/mall/category/save',NULL,'',0,'com.fruit.controller.mall.CategoryController','save','2017-01-07 17:18:31',17,NULL),(82,1,'http://localhost:9000/mall/category','0:0:0:0:0:0:0:1','/mall/category/getTreeGridView',NULL,'',0,'com.fruit.controller.mall.CategoryController','getTreeGridView','2017-01-07 17:18:33',5,NULL),(83,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/category/add',NULL,'',0,'com.fruit.controller.mall.CategoryController','add','2017-01-07 17:18:36',3,NULL),(84,1,'http://localhost:9000/mall/category/add','0:0:0:0:0:0:0:1','/mall/category/save',NULL,'',0,'com.fruit.controller.mall.CategoryController','save','2017-01-07 17:18:43',14,NULL),(85,1,'http://localhost:9000/mall/category','0:0:0:0:0:0:0:1','/mall/category/getTreeGridView',NULL,'',0,'com.fruit.controller.mall.CategoryController','getTreeGridView','2017-01-07 17:18:45',7,NULL),(86,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/category/add',NULL,'',0,'com.fruit.controller.mall.CategoryController','add','2017-01-07 17:18:46',3,NULL),(87,1,'http://localhost:9000/mall/category/add','0:0:0:0:0:0:0:1','/mall/category/save',NULL,'',0,'com.fruit.controller.mall.CategoryController','save','2017-01-07 17:18:51',15,NULL),(88,1,'http://localhost:9000/mall/category','0:0:0:0:0:0:0:1','/mall/category/getTreeGridView',NULL,'',0,'com.fruit.controller.mall.CategoryController','getTreeGridView','2017-01-07 17:18:53',6,NULL),(89,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/category/add',NULL,'',0,'com.fruit.controller.mall.CategoryController','add','2017-01-07 17:19:06',3,NULL),(90,1,'http://localhost:9000/mall/category/add','0:0:0:0:0:0:0:1','/mall/category/save',NULL,'',0,'com.fruit.controller.mall.CategoryController','save','2017-01-07 17:19:12',10,NULL),(91,1,'http://localhost:9000/mall/category','0:0:0:0:0:0:0:1','/mall/category/getTreeGridView',NULL,'',0,'com.fruit.controller.mall.CategoryController','getTreeGridView','2017-01-07 17:19:14',6,NULL),(92,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/category/add',NULL,'',0,'com.fruit.controller.mall.CategoryController','add','2017-01-07 17:19:22',3,NULL),(93,1,'http://localhost:9000/mall/category/add','0:0:0:0:0:0:0:1','/mall/category/save',NULL,'',0,'com.fruit.controller.mall.CategoryController','save','2017-01-07 17:19:36',25,NULL),(94,1,'http://localhost:9000/mall/category','0:0:0:0:0:0:0:1','/mall/category/getTreeGridView',NULL,'',0,'com.fruit.controller.mall.CategoryController','getTreeGridView','2017-01-07 17:19:38',7,NULL),(95,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/category/add',NULL,'',0,'com.fruit.controller.mall.CategoryController','add','2017-01-07 17:19:39',3,NULL),(96,1,'http://localhost:9000/mall/category/add','0:0:0:0:0:0:0:1','/mall/category/save',NULL,'',0,'com.fruit.controller.mall.CategoryController','save','2017-01-07 17:19:56',9,NULL),(97,1,'http://localhost:9000/mall/category','0:0:0:0:0:0:0:1','/mall/category/getTreeGridView',NULL,'',0,'com.fruit.controller.mall.CategoryController','getTreeGridView','2017-01-07 17:19:58',11,NULL),(98,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/category',NULL,'',0,'com.fruit.controller.mall.CategoryController','index','2017-01-07 17:20:29',0,NULL),(99,1,'http://localhost:9000/mall/category','0:0:0:0:0:0:0:1','/mall/category/getTreeGridView',NULL,'',0,'com.fruit.controller.mall.CategoryController','getTreeGridView','2017-01-07 17:20:29',7,NULL),(100,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/category',NULL,'',0,'com.fruit.controller.mall.CategoryController','index','2017-01-07 17:20:40',1,NULL),(101,1,'http://localhost:9000/mall/category','0:0:0:0:0:0:0:1','/mall/category/getTreeGridView',NULL,'',0,'com.fruit.controller.mall.CategoryController','getTreeGridView','2017-01-07 17:20:41',10,NULL),(102,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/category',NULL,'',0,'com.fruit.controller.mall.CategoryController','index','2017-01-07 17:20:49',0,NULL),(103,1,'http://localhost:9000/mall/category','0:0:0:0:0:0:0:1','/mall/category/getTreeGridView',NULL,'',0,'com.fruit.controller.mall.CategoryController','getTreeGridView','2017-01-07 17:20:50',12,NULL),(104,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/category',NULL,'',0,'com.fruit.controller.mall.CategoryController','index','2017-01-07 17:21:23',0,NULL),(105,1,'http://localhost:9000/mall/category','0:0:0:0:0:0:0:1','/mall/category/getTreeGridView',NULL,'',0,'com.fruit.controller.mall.CategoryController','getTreeGridView','2017-01-07 17:21:23',8,NULL),(106,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/sku',NULL,'',0,'com.fruit.controller.mall.SkuController','index','2017-01-07 17:22:32',1,NULL),(107,1,'http://localhost:9000/mall/sku','0:0:0:0:0:0:0:1','/mall/sku/getListData',NULL,'',0,'com.fruit.controller.mall.SkuController','getListData','2017-01-07 17:22:32',4,NULL),(108,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/sku/add',NULL,'',0,'com.fruit.controller.mall.SkuController','add','2017-01-07 17:22:35',10,NULL),(109,1,'http://localhost:9000/mall/sku/add','0:0:0:0:0:0:0:1','/mall/sku',NULL,'',0,'com.fruit.controller.mall.SkuController','index','2017-01-07 17:22:35',0,NULL),(110,1,'http://localhost:9000/mall/sku/add','0:0:0:0:0:0:0:1','/mall/sku/uploadImage',NULL,'',0,'com.fruit.controller.mall.SkuController','uploadImage','2017-01-07 17:23:03',154,NULL),(111,1,'http://localhost:9000/mall/sku/add','0:0:0:0:0:0:0:1','/mall/sku/save',NULL,'',0,'com.fruit.controller.mall.SkuController','save','2017-01-07 17:23:10',23,NULL),(112,1,'http://localhost:9000/mall/sku','0:0:0:0:0:0:0:1','/mall/sku/getListData',NULL,'',0,'com.fruit.controller.mall.SkuController','getListData','2017-01-07 17:23:13',3,NULL),(113,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/stock/inbound',NULL,'',0,'com.fruit.controller.stock.InboundController','index','2017-01-07 17:23:21',0,NULL),(114,1,'http://localhost:9000/stock/inbound','0:0:0:0:0:0:0:1','/stock/inbound/getListData',NULL,'',0,'com.fruit.controller.stock.InboundController','getListData','2017-01-07 17:23:22',7,NULL),(115,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/stock/inbound/add',NULL,'',0,'com.fruit.controller.stock.InboundController','add','2017-01-07 17:23:23',0,NULL),(116,1,'http://localhost:9000/stock/inbound/add','0:0:0:0:0:0:0:1','/stock/inbound/getDetailData',NULL,'',0,'com.fruit.controller.stock.InboundController','getDetailData','2017-01-07 17:23:24',11,NULL),(117,1,'http://localhost:9000/stock/inbound/add','0:0:0:0:0:0:0:1','/mall/sku/get',NULL,'',0,'com.fruit.controller.mall.SkuController','get','2017-01-07 17:23:27',1,NULL),(118,1,'http://localhost:9000/stock/inbound/add','0:0:0:0:0:0:0:1','/stock/inbound/save',NULL,'',0,'com.fruit.controller.stock.InboundController','save','2017-01-07 17:23:44',164,NULL),(119,1,'http://localhost:9000/stock/inbound','0:0:0:0:0:0:0:1','/stock/inbound/getListData',NULL,'',0,'com.fruit.controller.stock.InboundController','getListData','2017-01-07 17:23:46',4,NULL),(120,1,'http://localhost:9000/stock/inbound/add','0:0:0:0:0:0:0:1','/stock/inbound/getDetailData',NULL,'',0,'com.fruit.controller.stock.InboundController','getDetailData','2017-01-07 17:23:46',13,NULL),(121,1,'http://localhost:9000/electroinc-cigarette-console','0:0:0:0:0:0:0:1','/mall/sku/setting',NULL,'',0,'com.fruit.controller.mall.SkuController','setting','2017-01-07 17:24:16',13,NULL),(122,1,'http://localhost:9000/mall/sku/setting?id=1','0:0:0:0:0:0:0:1','/mall/sku/saveSkuPrice',NULL,'',0,'com.fruit.controller.mall.SkuController','saveSkuPrice','2017-01-07 17:25:13',37,NULL),(123,1,'http://localhost:9000/mall/sku','0:0:0:0:0:0:0:1','/mall/sku/getListData',NULL,'',0,'com.fruit.controller.mall.SkuController','getListData','2017-01-07 17:25:15',2,NULL);
/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_login_record`
--

DROP TABLE IF EXISTS `sys_login_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_login_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_uid` int(11) NOT NULL,
  `login_date` datetime NOT NULL COMMENT '登陆时间',
  `login_err_times` int(11) NOT NULL COMMENT '1天内连续出错次数',
  `login_status` tinyint(4) NOT NULL COMMENT '1-成功  0-失败',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='后台系统登陆记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_login_record`
--

LOCK TABLES `sys_login_record` WRITE;
/*!40000 ALTER TABLE `sys_login_record` DISABLE KEYS */;
INSERT INTO `sys_login_record` VALUES (1,1,'2017-01-06 22:07:00',0,1),(2,1,'2017-01-06 22:07:07',0,1),(3,1,'2017-01-06 22:07:29',0,1),(4,1,'2017-01-06 22:09:39',0,1),(5,1,'2017-01-06 22:10:58',0,1),(6,1,'2017-01-07 17:15:44',0,1);
/*!40000 ALTER TABLE `sys_login_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_res`
--

DROP TABLE IF EXISTS `sys_res`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_res`
--

LOCK TABLES `sys_res` WRITE;
/*!40000 ALTER TABLE `sys_res` DISABLE KEYS */;
INSERT INTO `sys_res` VALUES (1,NULL,'系统管理','系统管理','','fa-cogs',10,1,NULL,1,0),(2,1,'资源管理',NULL,'/sys/res','fa-list',1,1,NULL,1,1),(3,1,'角色管理',NULL,'/sys/role','fa-list',10,1,NULL,1,1),(4,1,'用户管理',NULL,'/sys/user','fa-list',11,1,NULL,1,1),(9,4,'用户删除',NULL,'/sys/user/delete','fa-list',1,2,NULL,1,2),(12,4,'搜索用户',NULL,'/sys/user/serach','fa-list',1,2,NULL,1,2),(18,2,'资源删除',NULL,'/sys/res/delete','fa-list',11,2,NULL,1,0),(19,2,'资源保存',NULL,'/sys/res/save','fa-list',11,2,NULL,1,0),(28,3,'角色删除',NULL,'/sys/role/delete','fa-list',11,2,NULL,1,0),(29,3,'角色保存',NULL,'/sys/role/save','fa-list',11,2,NULL,1,0),(63,4,'冻结用户',NULL,'/sys/user/freeze','fa-list',11,2,NULL,1,0),(146,4,'用户列表',NULL,'/sys/user/list','fa-list',8,2,NULL,1,0),(147,4,'用户保存',NULL,'/sys/user/save','fa-list',10,2,NULL,1,0),(150,1,'操作日志',NULL,'/sys/log','fa-list',11,1,NULL,1,0),(152,NULL,'控制台','1234','/','fa-desktop',1,1,'2015-02-10 08:09:40',1,0),(181,1,'数据字典',NULL,'/dict','fa-list',12,1,NULL,1,0),(182,181,'数据字典列表',NULL,'/dict/list','fa-list',1,2,NULL,1,0),(192,NULL,'APP管理',NULL,'','fa-android',9,1,NULL,1,0),(193,192,'App版本管理',NULL,'/app','',1,1,NULL,1,0),(194,NULL,'商城管理',NULL,'','',2,1,NULL,1,0),(195,194,'类目管理',NULL,'/mall/category','',1,1,NULL,1,0),(196,194,'商品管理',NULL,'/mall/sku','',2,1,NULL,1,0),(197,194,'商户管理',NULL,'/mall/customer','',3,1,NULL,1,0),(198,NULL,'库存管理',NULL,'','',4,1,NULL,1,0),(199,198,'入库管理',NULL,'/stock/inbound','',1,1,NULL,1,0),(200,198,'出库管理',NULL,'/stock/outbound','',2,1,NULL,1,0),(201,194,'订单管理',NULL,'/mall/order','',4,1,NULL,1,0),(202,198,'库存查询',NULL,'/stock/stock','',3,1,NULL,1,0),(203,194,'返修单管理',NULL,'/mall/aftersale','',5,1,NULL,1,0),(204,NULL,'提成管理',NULL,'','',5,1,NULL,1,0),(205,204,'员工提成',NULL,'/mall/rate','',1,1,NULL,1,0),(206,204,'查询本人提成',NULL,'/mall/rate/view','',2,1,NULL,1,0),(207,204,'查询全员提成',NULL,'/mall/rate/viewRoot','',3,1,NULL,1,0),(208,204,'商家提成审核',NULL,'/mall/customerRate','',4,1,NULL,1,0);
/*!40000 ALTER TABLE `sys_res` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL DEFAULT '',
  `des` varchar(55) DEFAULT NULL,
  `seq` int(11) DEFAULT '1',
  `createdate` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '0-禁用  1-启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'admin','超级管理员',1,'2015-05-05 14:24:26',1),(62,'销售人员','',1,'2017-01-07 16:14:35',1);
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_res`
--

DROP TABLE IF EXISTS `sys_role_res`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_res` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `res_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sys_ROLE_RES_RES_ID` (`res_id`),
  KEY `FK_sys_ROLE_RES_ROLE_ID` (`role_id`),
  CONSTRAINT `sys_role_res_ibfk_1` FOREIGN KEY (`res_id`) REFERENCES `sys_res` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_role_res_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4221 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_res`
--

LOCK TABLES `sys_role_res` WRITE;
/*!40000 ALTER TABLE `sys_role_res` DISABLE KEYS */;
INSERT INTO `sys_role_res` VALUES (4141,1,1),(4142,2,1),(4143,18,1),(4144,19,1),(4145,3,1),(4146,28,1),(4147,29,1),(4148,4,1),(4149,9,1),(4150,12,1),(4151,63,1),(4152,146,1),(4153,147,1),(4154,150,1),(4155,181,1),(4156,182,1),(4157,152,1),(4162,192,1),(4163,193,1),(4175,194,1),(4176,195,1),(4200,196,1),(4201,197,1),(4202,198,1),(4203,199,1),(4204,200,1),(4205,201,1),(4206,202,1),(4207,203,1),(4208,204,1),(4209,205,1),(4210,206,1),(4211,207,1),(4212,208,1),(4213,194,62),(4214,195,62),(4215,196,62),(4216,197,62),(4217,201,62),(4218,203,62),(4219,204,62),(4220,206,62);
/*!40000 ALTER TABLE `sys_role_res` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'admin','6fc3b9ada8c1e50b400cd6998ff7be76ea3ae312','1289',1,'/sys/static/i/9.jpg','admin@admin.com','2015-07-15 18:00:27','1234567','UzNk7MKbVABao0I275SAs9ShzyYtLQooG42fkoDcL9QtkuFP1Xm7QOtIMrbvxbLc','234324324','管理员'),(36,'wangxingang','6fc3b9ada8c1e50b400cd6998ff7be76ea3ae312','',1,'/images/guest.jpg','88655817@qq.com','2017-01-07 16:14:15','18600365471',NULL,'18600365471','王新刚');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_SYSTME_USER_ROLE_USER_ID` (`user_id`),
  KEY `FK_SYSTME_USER_ROLE_ROLE_ID` (`role_id`),
  CONSTRAINT `sys_user_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_user_role_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=339 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (315,1,1),(338,36,62);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_rated`
--

DROP TABLE IF EXISTS `user_rated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_rated` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saler` int(11) DEFAULT NULL COMMENT '销售人员',
  `rated` varchar(45) DEFAULT NULL COMMENT '计提月份',
  `amount` decimal(12,2) DEFAULT NULL COMMENT '提成金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工提成表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_rated`
--

LOCK TABLES `user_rated` WRITE;
/*!40000 ALTER TABLE `user_rated` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_rated` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-07 17:37:14
