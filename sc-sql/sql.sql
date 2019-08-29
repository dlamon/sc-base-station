# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 192.168.99.108 (MySQL 5.7.24)
# Database: sc-db
# Generation Time: 2019-08-29 03:21:56 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table order_detail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `order_detail`;

CREATE TABLE `order_detail` (
  `order_detail_id` varchar(20) NOT NULL DEFAULT '' COMMENT '子订单编号',
  `order_master_id` varchar(20) NOT NULL DEFAULT '' COMMENT '主订单编号',
  `product_id` int(11) unsigned NOT NULL COMMENT '产品编号',
  `product_name` varchar(11) NOT NULL DEFAULT '' COMMENT '产品名称',
  `buy_amount` decimal(10,2) NOT NULL COMMENT '购买金额',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`order_detail_id`),
  KEY `fk_product_id` (`product_id`),
  KEY `fk_order_master_id` (`order_master_id`),
  CONSTRAINT `fk_order_master_id` FOREIGN KEY (`order_master_id`) REFERENCES `order_master` (`order_master_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `product_info` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table order_master
# ------------------------------------------------------------

DROP TABLE IF EXISTS `order_master`;

CREATE TABLE `order_master` (
  `order_master_id` varchar(20) NOT NULL DEFAULT '' COMMENT '订单编号',
  `customer_name` varchar(11) NOT NULL DEFAULT '' COMMENT '客户姓名',
  `customer_id_type` tinyint(1) unsigned NOT NULL COMMENT '客户证件类型 0身份证 1其他',
  `customer_id_no` varchar(18) NOT NULL DEFAULT '' COMMENT '客户证件号码',
  `order_amount` decimal(11,2) NOT NULL COMMENT '订单总金额',
  `order_status` tinyint(1) unsigned NOT NULL COMMENT '订单状态 0正常 1-取消 2-完结',
  `payment_account` varchar(16) DEFAULT '' COMMENT '支付账号',
  `payment_status` tinyint(1) unsigned NOT NULL COMMENT '支付状态 0未支付 1支付成功 2支付失败',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`order_master_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table product_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_category`;

CREATE TABLE `product_category` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '类别编号',
  `category_name` varchar(11) NOT NULL DEFAULT '' COMMENT '类别名称',
  `category_type` tinyint(1) unsigned NOT NULL COMMENT '类别类型 1定期 2理财 3贷款',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;

INSERT INTO `product_category` (`category_id`, `category_name`, `category_type`, `create_time`, `update_time`)
VALUES
	(1,'定期',1,'2019-05-07 16:52:00','2019-05-07 16:52:17'),
	(2,'理财',2,'2019-05-07 16:52:59','2019-05-08 09:09:41'),
	(3,'贷款',3,'2019-05-07 16:53:14','2019-05-08 09:09:45');

/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_info`;

CREATE TABLE `product_info` (
  `product_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '产品编号',
  `product_name` varchar(11) NOT NULL DEFAULT '' COMMENT '产品名称',
  `category_type` tinyint(1) unsigned NOT NULL COMMENT '产品类别',
  `rate` float DEFAULT NULL COMMENT '利率',
  `sale_begin_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `sale_end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `min_buy_amt` decimal(11,2) DEFAULT NULL COMMENT '最小购买金额',
  `max_buy_amt` decimal(11,2) DEFAULT NULL COMMENT '最大购买金额',
  `remain_quota` decimal(11,2) DEFAULT NULL COMMENT '剩余额度',
  `description` varchar(11) DEFAULT NULL COMMENT '产品描述',
  `status` tinyint(1) unsigned NOT NULL COMMENT '产品状态  0在售 1停售',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `product_info` WRITE;
/*!40000 ALTER TABLE `product_info` DISABLE KEYS */;

INSERT INTO `product_info` (`product_id`, `product_name`, `category_type`, `rate`, `sale_begin_time`, `sale_end_time`, `min_buy_amt`, `max_buy_amt`, `remain_quota`, `description`, `status`, `create_time`, `update_time`)
VALUES
	(1,'定期001型',1,3.2,NULL,NULL,NULL,NULL,NULL,'通用型定期产品',0,'2019-05-07 17:14:28','2019-05-07 17:14:48'),
	(2,'定期002型',1,4.5,'2019-05-11 00:00:00','2019-08-11 00:00:00',NULL,NULL,NULL,'时间限定型定期产品',0,'2019-05-07 17:15:39','2019-05-07 17:16:56'),
	(3,'定期003型',1,4.8,NULL,NULL,50000.00,1000000.00,79000000.00,'金额限定型定期产品',0,'2019-05-07 17:17:20','2019-05-07 17:17:57'),
	(4,'定期004型',1,5.5,'2019-05-11 00:00:00','2019-07-10 00:00:00',200000.00,500000.00,10000000.00,'时间金额限定型定期产品',0,'2019-05-07 17:18:39','2019-05-07 17:19:15'),
	(5,'定期005型',1,4.9,NULL,NULL,NULL,NULL,NULL,'通用型定期产品',1,'2019-05-07 17:19:20','2019-05-07 17:20:05'),
	(6,'理财001型',2,5.5,'2019-01-01 00:00:00','2019-12-30 00:00:00',50000.00,NULL,2820000.00,'通用型理财产品',0,'2019-05-07 17:22:26','2019-05-07 17:23:43'),
	(7,'理财002型',2,6,'2019-11-01 00:00:00','2019-12-30 00:00:00',100000.00,200000.00,5000000.00,'通用型理财产品',0,'2019-05-07 17:24:04','2019-05-07 17:26:16'),
	(8,'理财003型',2,5.1,'2018-04-11 00:00:00','2018-08-10 00:00:00',80000.00,NULL,5000000.00,'通用型理财产品',1,'2019-05-07 17:25:36','2019-05-07 17:26:53'),
	(9,'贷款001型',3,8.1,NULL,NULL,NULL,NULL,NULL,'通用型贷款',0,'2019-05-07 17:27:24','2019-05-07 17:28:25'),
	(10,'贷款002型',3,10.5,NULL,NULL,100000.00,1000000.00,40000000.00,'金额限定型贷款',0,'2019-05-07 17:28:05','2019-05-07 17:29:30'),
	(11,'贷款003型',3,8.8,NULL,NULL,NULL,NULL,NULL,'通用型贷款',1,'2019-05-07 17:29:27','2019-05-07 17:29:52');

/*!40000 ALTER TABLE `product_info` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
