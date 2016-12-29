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
INSERT INTO `console_sequence` VALUES (2,'类目',100012),(3,'商家',10020),(4,'入库',100025),(5,'订单',10053);
/*!40000 ALTER TABLE `console_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `del_mall_customer_olineshop`
--

DROP TABLE IF EXISTS `del_mall_customer_olineshop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `del_mall_customer_olineshop`
--

LOCK TABLES `del_mall_customer_olineshop` WRITE;
/*!40000 ALTER TABLE `del_mall_customer_olineshop` DISABLE KEYS */;
/*!40000 ALTER TABLE `del_mall_customer_olineshop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `del_mall_staff`
--

DROP TABLE IF EXISTS `del_mall_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `del_mall_staff`
--

LOCK TABLES `del_mall_staff` WRITE;
/*!40000 ALTER TABLE `del_mall_staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `del_mall_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `del_sk_stock_log`
--

DROP TABLE IF EXISTS `del_sk_stock_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `del_sk_stock_log`
--

LOCK TABLES `del_sk_stock_log` WRITE;
/*!40000 ALTER TABLE `del_sk_stock_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `del_sk_stock_log` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dict_data`
--

LOCK TABLES `dict_data` WRITE;
/*!40000 ALTER TABLE `dict_data` DISABLE KEYS */;
INSERT INTO `dict_data` VALUES (4,'诽谤辱骂','1','',1,1467514812,3),(5,'淫秽色情','2','',2,1467514834,3),(6,'垃圾广告','3','',3,1467514907,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dict_type`
--

LOCK TABLES `dict_type` WRITE;
/*!40000 ALTER TABLE `dict_type` DISABLE KEYS */;
INSERT INTO `dict_type` VALUES (1,'兴趣爱好','用户选择兴趣爱好',0),(3,'举报内容','举报内容2',1473167795);
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
INSERT INTO `mall_cart` VALUES ('10017',1,55.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_cart_de`
--

LOCK TABLES `mall_cart_de` WRITE;
/*!40000 ALTER TABLE `mall_cart_de` DISABLE KEYS */;
INSERT INTO `mall_cart_de` VALUES (1,'10017','ABC1001','S',1,55.00,55.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_category`
--

LOCK TABLES `mall_category` WRITE;
/*!40000 ALTER TABLE `mall_category` DISABLE KEYS */;
INSERT INTO `mall_category` VALUES (1,'类目1','1001',NULL,NULL),(2,'类目1-1','1002','1001',NULL),(3,'类目1-2','1003','1001',NULL),(4,'类目2','2001',NULL,NULL),(5,'类目2-1','2002','2001',NULL),(11,'类目3','100004',NULL,NULL),(12,'类目2-2-1','100005','2001',NULL),(13,'类目3-1','100008','100004',NULL),(14,'类目3-2','100011','100004',NULL),(15,'类目2-3','100012','2001',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_customer`
--

LOCK TABLES `mall_customer` WRITE;
/*!40000 ALTER TABLE `mall_customer` DISABLE KEYS */;
INSERT INTO `mall_customer` VALUES (16,'10017','hanlei','10fa0ba0c063c50e69c941e22c509c62',1,'M','2016-10-26','jesse.18@163.com','18660791231','18615267773','1212','1',0,NULL,'A','0',1),(17,'10018','王心刚','bb61b2bb7b36f5db6d79d2dc3ec42c20',0,'M','2016-12-25','jesse.18@163.com','18615267773','18615267773',NULL,NULL,0,NULL,NULL,'0',1),(19,'10020','郭丽娜','20c737b5f9d6ec6ccb856445ccc10464',1,'F','2016-12-31','jesse.18@163.com','18615267773','18615267773','10017','sdf',0,NULL,'A','1',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_customer_addr`
--

LOCK TABLES `mall_customer_addr` WRITE;
/*!40000 ALTER TABLE `mall_customer_addr` DISABLE KEYS */;
INSERT INTO `mall_customer_addr` VALUES (1,'10017','山东省济南市青岛路演马家苑7号楼2单元1703室','张三','18615267773','1'),(2,'10017','北京市大兴区亦庄经济开发区朝林广场','韩磊','18615267773','0');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_customer_shop`
--

LOCK TABLES `mall_customer_shop` WRITE;
/*!40000 ALTER TABLE `mall_customer_shop` DISABLE KEYS */;
INSERT INTO `mall_customer_shop` VALUES (1,'10017',NULL,'张三的店','山东省济南市青岛路演马家苑7号楼2单元1703室','hanlei.jpg'),(2,'10017','1','李四的店',' 山东省济南市青岛路演马家苑7号楼2单元1703室','韩磊.JPG');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_customer_sku`
--

LOCK TABLES `mall_customer_sku` WRITE;
/*!40000 ALTER TABLE `mall_customer_sku` DISABLE KEYS */;
INSERT INTO `mall_customer_sku` VALUES (1,'10017','1001'),(2,'10017','1002');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_sku`
--

LOCK TABLES `mall_sku` WRITE;
/*!40000 ALTER TABLE `mall_sku` DISABLE KEYS */;
INSERT INTO `mall_sku` VALUES (4,'烟嘴','1001','1002',NULL,NULL,'黑色','','1001.jpg','1'),(5,'烟嘴01','1002','1002',NULL,NULL,'棕色',NULL,'1002.jpg','0'),(6,'烟嘴2','1003','1002',NULL,NULL,'白色',NULL,'1003.jpg','0'),(9,'电子烟','ABC1001','2002',NULL,NULL,'ABC',NULL,'event.jpg','1');
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
INSERT INTO `mall_sku_nprice` VALUES ('1001','A',NULL,NULL,5,10.00,5,10.00,5,10.00),('1001','B',NULL,NULL,5,10.00,5,10.00,5,10.00),('1001','C',NULL,NULL,5,10.00,5,10.00,5,10.00),('1001','D',NULL,NULL,5,10.00,5,10.00,5,10.00),('1002','A',NULL,NULL,5,10.00,5,10.00,5,10.00),('1002','B',NULL,NULL,5,10.00,5,10.00,5,10.00),('1002','C',NULL,NULL,5,10.00,5,10.00,5,10.00),('1002','D',NULL,NULL,5,10.00,5,10.00,5,10.00),('1003','A',NULL,NULL,5,10.00,5,10.00,5,10.00),('1003','B',NULL,NULL,5,10.00,5,10.00,5,10.00),('1003','C',NULL,NULL,5,10.00,5,10.00,5,10.00),('1003','D',NULL,NULL,5,10.00,5,10.00,5,10.00),('ABC1001','A',NULL,NULL,10,80.00,50,70.00,100,60.00),('ABC1001','B',NULL,NULL,10,90.00,50,80.00,100,70.00),('ABC1001','C',NULL,NULL,10,100.00,50,90.00,100,80.00),('ABC1001','D',NULL,NULL,10,110.00,50,100.00,100,90.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_sku_sprice`
--

LOCK TABLES `mall_sku_sprice` WRITE;
/*!40000 ALTER TABLE `mall_sku_sprice` DISABLE KEYS */;
INSERT INTO `mall_sku_sprice` VALUES (1,'1001','10017',NULL,2.00),(2,'1003','10017',NULL,1.00),(3,'ABC1001','10017',NULL,55.00),(4,'1001','10020',NULL,9.00);
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
INSERT INTO `od_order` VALUES ('O10024','10017','',1,64.00,'1111',3,'2016-11-05 14:38:58','啊啊啊','home.png',NULL,NULL,NULL),('O10025','10017','',1,64.00,'1111',3,'2016-11-05 14:38:58','啊啊啊',NULL,NULL,NULL,NULL),('O10044','10017',NULL,NULL,20.00,NULL,0,'2016-12-24 14:51:21',NULL,'',NULL,NULL,NULL),('O10045','10017',NULL,1,0.00,NULL,1,'2016-12-25 23:18:27',NULL,'100171482933411930',2.00,'2016-12-29',NULL),('O10046','10017',NULL,1,0.00,NULL,1,'2016-12-25 23:19:58',NULL,'100171482933020363',2.00,'2016-12-29',NULL),('O10050','10017',NULL,1,2.00,NULL,1,'2016-12-25 23:29:22',NULL,'fc3.jpg',2.00,'2016-12-29',NULL),('O10052','10017',NULL,1,2.00,NULL,1,'2016-12-26 00:03:12',NULL,'event.jpg',NULL,'2016-12-29',NULL),('O10053','10017',NULL,1,4.00,NULL,1,'2016-12-26 00:04:22',NULL,'3.jpg',NULL,'2016-12-29',NULL);
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
INSERT INTO `od_order_addr` VALUES ('O10024','山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773'),('O10025','山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773'),('O10044','adsfadsf'),('O10045','山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773'),('O10046','山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773'),('O10050','山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773'),('O10052','山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773'),('O10053','山东省济南市青岛路演马家苑7号楼2单元1703室 张三 18615267773');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `od_order_de`
--

LOCK TABLES `od_order_de` WRITE;
/*!40000 ALTER TABLE `od_order_de` DISABLE KEYS */;
INSERT INTO `od_order_de` VALUES (1,'O10024','1001',22,2.00,2600.00),(2,'O10024','1002',2,10.00,400.00),(3,'O10025','1002',2,10.00,400.00),(4,'O10044','1002',2,10.00,NULL),(5,'O10045','1001',1,2.00,NULL),(6,'O10046','1001',1,2.00,NULL),(10,'O10050','1001',1,2.00,NULL),(11,'O10052','1001',2,2.00,NULL),(12,'O10053','1001',2,2.00,NULL);
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
INSERT INTO `sk_stock` VALUES ('1001',15),('1002',3),('1003',0),('ABC1001',100);
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
INSERT INTO `sku_inbound` VALUES ('100021','admin','2016-11-05 14:36:56'),('100022','admin','2016-11-05 14:38:15'),('100025','admin','2016-12-27 21:32:31');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sku_inbound_de`
--

LOCK TABLES `sku_inbound_de` WRITE;
/*!40000 ALTER TABLE `sku_inbound_de` DISABLE KEYS */;
INSERT INTO `sku_inbound_de` VALUES (1,'100021',0,'1001',20,100.00,20),(2,'100021',0,'1002',5,200.00,5),(3,'100022',0,'1001',2,300.00,2),(4,'100025',1,'ABC1001',100,50.00,100);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_log`
--

LOCK TABLES `sys_log` WRITE;
/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台系统登陆记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_login_record`
--

LOCK TABLES `sys_login_record` WRITE;
/*!40000 ALTER TABLE `sys_login_record` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_res`
--

LOCK TABLES `sys_res` WRITE;
/*!40000 ALTER TABLE `sys_res` DISABLE KEYS */;
INSERT INTO `sys_res` VALUES (1,NULL,'系统管理','系统管理','','fa-cogs',10,1,NULL,1,0),(2,1,'资源管理',NULL,'/sys/res','fa-list',1,1,NULL,1,1),(3,1,'角色管理',NULL,'/sys/role','fa-list',10,1,NULL,1,1),(4,1,'用户管理',NULL,'/sys/user','fa-list',11,1,NULL,1,1),(9,4,'用户删除',NULL,'/sys/user/delete','fa-list',1,2,NULL,1,2),(12,4,'搜索用户',NULL,'/sys/user/serach','fa-list',1,2,NULL,1,2),(18,2,'资源删除',NULL,'/sys/res/delete','fa-list',11,2,NULL,1,0),(19,2,'资源保存',NULL,'/sys/res/save','fa-list',11,2,NULL,1,0),(28,3,'角色删除',NULL,'/sys/role/delete','fa-list',11,2,NULL,1,0),(29,3,'角色保存',NULL,'/sys/role/save','fa-list',11,2,NULL,1,0),(63,4,'冻结用户',NULL,'/sys/user/freeze','fa-list',11,2,NULL,1,0),(146,4,'用户列表',NULL,'/sys/user/list','fa-list',8,2,NULL,1,0),(147,4,'用户保存',NULL,'/sys/user/save','fa-list',10,2,NULL,1,0),(150,1,'操作日志',NULL,'/sys/log','fa-list',11,1,NULL,1,0),(152,NULL,'控制台','1234','/','fa-desktop',1,1,'2015-02-10 08:09:40',1,0),(181,1,'数据字典',NULL,'/dict','fa-list',12,1,NULL,1,0),(182,181,'数据字典列表',NULL,'/dict/list','fa-list',1,2,NULL,1,0),(192,NULL,'APP管理',NULL,'','fa-android',9,1,NULL,1,0),(193,192,'App版本管理',NULL,'/app','',1,1,NULL,1,0),(194,NULL,'商城管理',NULL,'','',2,1,NULL,1,0),(195,194,'类目管理',NULL,'/mall/category','',1,1,NULL,1,0),(196,194,'商品管理',NULL,'/mall/sku','',2,1,NULL,1,0),(197,194,'商户管理',NULL,'/mall/customer','',3,1,NULL,1,0),(198,NULL,'库存管理',NULL,'','',4,1,NULL,1,0),(199,198,'入库管理',NULL,'/stock/inbound','',1,1,NULL,1,0),(200,198,'出库管理',NULL,'/stock/outbound','',2,1,NULL,1,0),(201,194,'订单管理',NULL,'/mall/order','',4,1,NULL,1,0),(202,198,'库存查询',NULL,'/stock/stock','',3,1,NULL,1,0),(203,194,'返修单管理',NULL,'/mall/aftersale','',5,1,NULL,1,0),(204,NULL,'提成管理',NULL,'','',5,1,NULL,1,0),(205,204,'员工提成',NULL,'/mall/rate','',1,1,NULL,1,0),(206,204,'查询本人提成',NULL,'/mall/rate/view','',2,1,NULL,1,0),(207,204,'查询全员提成',NULL,'/mall/rate/viewRoot','',3,1,NULL,1,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'admin','超级管理员',1,'2015-05-05 14:24:26',1),(56,'内容编辑','内容编辑4',1,NULL,1),(57,'客服人员','客服人员',1,NULL,1),(60,'dd','ss ',1,NULL,1),(61,'销售人员','销售人员',1,'2016-12-28 22:10:00',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=4212 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_res`
--

LOCK TABLES `sys_role_res` WRITE;
/*!40000 ALTER TABLE `sys_role_res` DISABLE KEYS */;
INSERT INTO `sys_role_res` VALUES (4141,1,1),(4142,2,1),(4143,18,1),(4144,19,1),(4145,3,1),(4146,28,1),(4147,29,1),(4148,4,1),(4149,9,1),(4150,12,1),(4151,63,1),(4152,146,1),(4153,147,1),(4154,150,1),(4155,181,1),(4156,182,1),(4157,152,1),(4162,192,1),(4163,193,1),(4168,1,56),(4169,2,56),(4170,18,56),(4171,19,56),(4172,3,56),(4173,28,56),(4174,29,56),(4175,194,1),(4176,195,1),(4179,1,60),(4180,2,60),(4181,18,60),(4182,19,60),(4183,3,60),(4184,28,60),(4185,29,60),(4186,4,60),(4187,9,60),(4188,12,60),(4189,63,60),(4190,146,60),(4191,147,60),(4192,150,60),(4193,181,60),(4194,182,60),(4195,152,60),(4196,192,60),(4197,193,60),(4198,194,60),(4199,195,60),(4200,196,1),(4201,197,1),(4202,198,1),(4203,199,1),(4204,200,1),(4205,201,1),(4206,202,1),(4207,203,1),(4208,204,1),(4209,205,1),(4210,206,1),(4211,207,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'admin','6fc3b9ada8c1e50b400cd6998ff7be76ea3ae312','1289',1,'/sys/static/i/9.jpg','admin@admin.com','2015-07-15 18:00:27','1234567','UzNk7MKbVABao0I275SAs9ShzyYtLQooG42fkoDcL9QtkuFP1Xm7QOtIMrbvxbLc','234324324','管理员'),(32,'eason','5d46f91596dc2f24c1535148f778af0a25612289','sfsf',1,'/images/guest.jpg','569165857@qq.com','2016-06-12 23:54:24','13332892938',NULL,NULL,'医生'),(34,'test','6fc3b9ada8c1e50b400cd6998ff7be76ea3ae312','dfsdfsdfddf ',1,'/images/guest.jpg','569165857@qq.com','2016-07-02 22:24:50','13332892938','hDEflmnlVituFC6hbfTzeze8RVSRseIfdgBAGkAU2RRh4c4kIrIYXTTuwEG2Caem',NULL,NULL),(35,'liubotest','250778b614cb9de3273881f2be42cc8b28e83c6a','测试',1,'/images/guest.jpg','','2016-10-12 16:27:49','',NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=338 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (315,1,1),(333,32,1),(334,32,56),(335,32,57),(336,32,60),(337,35,60);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='员工提成表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_rated`
--

LOCK TABLES `user_rated` WRITE;
/*!40000 ALTER TABLE `user_rated` DISABLE KEYS */;
INSERT INTO `user_rated` VALUES (1,1,'2016-12',8.00);
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

-- Dump completed on 2016-12-29 23:46:09
