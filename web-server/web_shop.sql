/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : web_shop

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2022-09-08 16:25:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for administrators
-- ----------------------------
DROP TABLE IF EXISTS `administrators`;
CREATE TABLE `administrators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pwd` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of administrators
-- ----------------------------
INSERT INTO `administrators` VALUES ('1', 'admin', '63814a82384f9faca8bcca0f08d86eb9');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `goods_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `thumb_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `buy_count` int(11) DEFAULT NULL,
  `is_pay` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `counts` int(11) DEFAULT NULL,
  `pay_time` datetime DEFAULT NULL,
  `addr_info` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES ('20', '6747539', '磨刀神器5秒快速磨菜刀磨剪刀多功能', 'http://t00img.yangkeduo.com/t02img/images/2018-05-29/98041a372a4d16c17f23a3863b8da038.jpeg', '850', '1', '1', '12', '50', '2022-05-01 00:41:04', '广东省深圳市宝安区 / 12312312312 / sbsbsb');
INSERT INTO `cart` VALUES ('21', '7451457', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '990', '1', '2', '13', '50', '2022-09-01 10:20:48', '123 /  / 123');
INSERT INTO `cart` VALUES ('22', '55009139', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '3500', '1', '2', '13', '50', '2022-09-01 10:21:01', '123 /  / 123');
INSERT INTO `cart` VALUES ('23', '621723438', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '955', '1', '2', '13', '50', '2022-09-05 20:41:13', '123 /  / 123');
INSERT INTO `cart` VALUES ('24', '10519372', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '990', '1', '2', '13', '50', '2022-09-05 21:18:38', '123 /  / 123');
INSERT INTO `cart` VALUES ('25', '14213769', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '500', '1', '2', '13', '50', '2022-09-05 21:26:18', '123 /  / 123');
INSERT INTO `cart` VALUES ('26', '6225284', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '921', '1', '2', '13', '50', '2022-09-05 21:33:23', '123 /  / 123');
INSERT INTO `cart` VALUES ('27', '7292301', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '690', '5', '2', '13', '50', '2022-09-05 21:33:23', '123 /  / 123');
INSERT INTO `cart` VALUES ('28', '7292301', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '690', '8', '2', '13', '50', '2022-09-05 21:36:37', '123 /  / 123');
INSERT INTO `cart` VALUES ('29', '50783155', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '1990', '7', '2', '13', '50', '2022-09-05 21:37:34', '123 /  / 123');
INSERT INTO `cart` VALUES ('30', '54853852', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '3990', '8', '2', '13', '50', '2022-09-05 21:38:04', '123 /  / 123');
INSERT INTO `cart` VALUES ('31', '7292301', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '690', '5', '2', '13', '50', '2022-09-05 21:39:51', '123 /  / 123');
INSERT INTO `cart` VALUES ('32', '621723438', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '955', '1', '2', '13', '50', '2022-09-05 22:04:38', '123 /  / 123');
INSERT INTO `cart` VALUES ('33', '54853852', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '3990', '5', '2', '13', '50', '2022-09-05 22:25:17', '123 /  / 123');
INSERT INTO `cart` VALUES ('34', '621723438', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '955', '5', '2', '13', '50', '2022-09-05 22:26:26', '123 /  / 123');
INSERT INTO `cart` VALUES ('35', '6747539', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', '850', '5', '1', '13', '50', '2022-09-05 22:27:20', '123 /  / 123');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `cate_id` int(11) NOT NULL,
  `cate_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cate_icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cate_counts` int(11) DEFAULT NULL,
  PRIMARY KEY (`cate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '爱情鲜花', 'el-icon-reading', '5');
INSERT INTO `category` VALUES ('2', '生日鲜花', 'el-icon-box', '19');
INSERT INTO `category` VALUES ('3', '鲜花花材', 'el-icon-present', '20');
INSERT INTO `category` VALUES ('4', '商务鲜花', 'el-icon-mobile-phone', '9');
INSERT INTO `category` VALUES ('5', '婚庆鲜花', 'el-icon-ice-cream', '17');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `comment_detail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_rating` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES ('1', '136590526', 'good', '5', '5');
INSERT INTO `comments` VALUES ('16', '136590526', 'nice', '5', '5');
INSERT INTO `comments` VALUES ('17', '136590526', 'bad', '1', '8');
INSERT INTO `comments` VALUES ('20', '65676090', 'success', '5', '5');
INSERT INTO `comments` VALUES ('21', '65676090', 'error', '5', '5');
INSERT INTO `comments` VALUES ('22', '6225284', '不好用', '2', '5');
INSERT INTO `comments` VALUES ('23', '6225284', '还可以', '4', '5');
INSERT INTO `comments` VALUES ('24', '8836407', '好吃', '5', '5');
INSERT INTO `comments` VALUES ('25', '621723438', '强烈推荐', '5', '5');
INSERT INTO `comments` VALUES ('26', '621723438', '毒鸡汤', '2', '9');
INSERT INTO `comments` VALUES ('27', '50783155', '111', '5', '12');
INSERT INTO `comments` VALUES ('28', '8491943', '好', '5', '13');
INSERT INTO `comments` VALUES ('29', '55009139', '123', '0', '13');
INSERT INTO `comments` VALUES ('30', '10519372', '1', '5', '13');
INSERT INTO `comments` VALUES ('31', '10519372', '1', '5', '13');

-- ----------------------------
-- Table structure for homecasual
-- ----------------------------
DROP TABLE IF EXISTS `homecasual`;
CREATE TABLE `homecasual` (
  `id` int(11) NOT NULL,
  `imgurl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `detail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of homecasual
-- ----------------------------
INSERT INTO `homecasual` VALUES ('1', '/api/images/home/s1.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6153');
INSERT INTO `homecasual` VALUES ('2', '/api/images/home/s2.png', 'http://mobile.yangkeduo.com/promotion_op.html?type=12&id=228');
INSERT INTO `homecasual` VALUES ('3', '/api/images/home/s3.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6242');
INSERT INTO `homecasual` VALUES ('4', '/api/images/home/s4.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6153');
INSERT INTO `homecasual` VALUES ('5', '/api/images/home/s5.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6230');
INSERT INTO `homecasual` VALUES ('6', '/api/images/home/s6.png', 'http://mobile.yangkeduo.com/promotion_op.html?type=12&id=190');
INSERT INTO `homecasual` VALUES ('7', '/api/images/home/s7.png', 'http://mobile.yangkeduo.com/promotion_op.html?type=12&id=229');
INSERT INTO `homecasual` VALUES ('8', '/api/images/home/s8.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6153');
INSERT INTO `homecasual` VALUES ('9', '/api/images/home/s9.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6242');

-- ----------------------------
-- Table structure for recommend
-- ----------------------------
DROP TABLE IF EXISTS `recommend`;
CREATE TABLE `recommend` (
  `goods_id` bigint(20) NOT NULL,
  `goods_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `short_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `thumb_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hd_thumb_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `normal_price` int(11) DEFAULT NULL,
  `market_price` int(11) DEFAULT NULL,
  `sales_tip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `counts` int(11) DEFAULT NULL,
  `comments_count` int(11) DEFAULT NULL,
  `details` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of recommend
-- ----------------------------
INSERT INTO `recommend` VALUES ('123', '123', '123', 'http://localhost:3000/uploads/upload_d0eb44f90cd028c96543137d18446f4e.jpg', 'http://localhost:3000/uploads/upload_d0eb44f90cd028c96543137d18446f4e.jpg', 'http://localhost:3000/uploads/upload_d0eb44f90cd028c96543137d18446f4e.jpg', '123', '123300', '123500', '123', '1', '123', '0', null);
INSERT INTO `recommend` VALUES ('1031855', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-30/41793c7556c00d972886f53de1bd58f5.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-30/177c3a7ebdffad8a008976988322ba8f.jpeg', '990', '1680', '6950', '已售10万+件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('2316452', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t10img/images/2018-07-15/aa4c5248112bdc08cc2faec10b1ad2a7.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-06-25/667b2fcd41a6a1450cc29aac5bb8507f.jpeg', '2800', '3200', '26900', '已售2万件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('6096094', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t02img/images/2018-05-16/f2171b871216528c66388163024bb5fc.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-23/ed5a60f13860e5f52c21a97125c8f72a.jpeg', '490', '790', '5500', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('6225284', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://omsproductionimg.yangkeduo.com/images/2018-01-04/52e6e647972439a498cc56e5b920bc81.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-23/6b585866513b27e5921352c931bfa917.jpeg', '921', '1290', '2000', '已售10万+件', '2', '50', '2', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('6747539', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t11img/images/2018-05-29/dd18cf918d01aefd7e357eeaa28d1442.jpeg', 'http://t00img.yangkeduo.com/t03img/images/2018-06-19/f2a07e3c2e7904561ff51edf0117e869.jpeg', '850', '1200', '3800', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('7292301', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-31/9e21bd51c712bb20f7e2e71c4e9b6253.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-31/a63104e9d0b650a3d2ee16d327a67a15.jpeg', '690', '990', '9900', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('7451457', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-09-03/f69def6bfc1e8ce2f465afbf1bd7cae0.jpeg', 'http://t00img.yangkeduo.com/t04img/images/2018-04-11/64b21c92e31fafdb3589b3ea1461508b.jpeg', '990', '1990', '9360', '已售10万+件', '4', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('7657775', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t10img/images/2018-05-23/8ed65c8ec9bb7e996d9050a307edb8cc.jpeg', 'http://t00img.yangkeduo.com/t07img/images/2018-03-09/7549b857a65b32de5924b044d1c6c760.jpeg', '1390', '1990', '16900', '已售8万件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('7780946', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://omsproductionimg.yangkeduo.com/images/2017-11-03/010c949b1b70b73f4441e9a377aaf8bd.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-03-13/91dd25b14013abf8e749de035d23a5a5.jpeg', '405', '800', '3490', '已售5万件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('8491943', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-11/af6928d63d45342d289aaf0e53bd8ed3.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-11/4a22b8378371a8efd6ee95e3326932f7.jpeg', '5800', '6800', '26800', '已售2万件', '4', '50', '1', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('8836407', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-01/0fc75856ec4319da959a50bf2dd4f7d5.jpeg', 'http://t00img.yangkeduo.com/t03img/images/2018-05-17/4d989c8d2f7af53c1de70b0e32640d8f.jpeg', '850', '1080', '2990', '已售10万+件', '5', '50', '1', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('9692939', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://omsproductionimg.yangkeduo.com/images/2017-09-04/5b0a2069ff6aca5fd25d158f81c13039.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-07-24/4ea20537b4628e5a40447cb086e39750.jpeg', '598', '730', '3599', '已售10万+件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('9948390', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-26/fdc627f0f3895356f75235ca5490b7da.jpeg', 'http://t00img.yangkeduo.com/t11img/images/2018-05-23/56b04110f8907a71e5f29ee92168ca93.jpeg', '3390', '6100', '58800', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('10519372', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t10img/images/2018-06-21/f39609e97b16487951cacfaa349619e6.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-06-12/29c1a24e3ba385d6fa08d8312bdb269f.jpeg', '990', '1180', '5120', '已售3万件', '1', '50', '2', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('14213769', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://omsproductionimg.yangkeduo.com/images/2018-05-26/4e037a3abb20b8bd9816a0e5cf8bebbd.jpeg', 'http://t00img.yangkeduo.com/t02img/images/2018-06-25/16b63fa711ecee9aef7d74424e219283.jpeg', '500', '680', '8800', '已售10万+件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('34732343', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t07img/images/2018-06-15/d4b9d0cc9528381fc9ddbd34bb8a4a34.jpeg', 'http://t00img.yangkeduo.com/t04img/images/2018-07-09/9fcad55f1f373fc7cfad8c2fd771dd49.jpeg', '1290', '1590', '1790', '已售63万件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('48367210', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t05img/images/2018-05-27/672d9e4bf34e8faa83054460446bcbe3.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-03-11/81675d6ce75437c9a490d5f233df4141.jpeg', '990', '1490', '6690', '已售10万+件', '2', '60', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('50783155', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t01img/images/2018-06-01/1a984c0b71d4b3f5dd3e9a4a38a2429c.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-10/6db1b848614c4b8730c0ad5507c7637f.jpeg', '1990', '4990', '9900', '已售10万+件', '3', '50', '1', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('54853852', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t07img/images/2018-06-13/7441b1a6bdaac1713b70e7017935522a.jpeg', 'http://t00img.yangkeduo.com/t04img/images/2018-02-14/320be003e9c459d84b03f72237c5f2b2.jpeg', '3990', '8900', '29800', '已售3万件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('55009139', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t03img/images/2018-05-26/143ada7bcba873d2071a16222c8e68c6.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-02-07/da678439178197585038e88066da6883.jpeg', '3500', '5500', '35900', '已售10万+件', '3', '50', '1', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('55984768', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-24/38ac3c070da5bd1313b0c9786cc5c417.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-12-21/d8605ac847d59bbb7c03e657f912df0a.jpeg', '80500', '80800', '129900', '已售1万件', '4', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('56042191', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-09-02/ae74303d081f5e38ec7cf8e8a2e7490d.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-09-20/4a3d46c9c4b5a0469afd7add0a558075.jpeg', '660', '990', '9900', '已售10万+件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('56060042', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-07-22/0aa3e616cf6312b5ccb8e47b7f897141.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-07-26/c36da96f2bde3aa27cedbe9b9191d266.jpeg', '990', '1090', '7900', '已售11万件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('58131537', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t02img/images/2018-07-13/2cd3462538d6219c93cf837fb7ab185b.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-08-18/4f301b2e2e87408723c59f6280095c29.jpeg', '4900', '8990', '39900', '已售4万件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('59306445', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t04img/images/2018-06-11/89ba323331445a252bbf0626978a0486.jpeg', 'http://t00img.yangkeduo.com/t08img/images/2018-03-24/6f03d1dff66a4555ce26771ba4e661cb.jpeg', '1990', '2990', '25500', '已售7万件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('63894890', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-15/7a939ee1ec4562e81568ad5dffef8a66.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-05-25/b2bb35efb07173160aef2e5a3867e422.jpeg', '950', '1090', '3990', '已售10万+件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('65676090', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t08img/images/2018-06-15/b47b12272db838b8c72eb4b9a938aaac.jpeg', 'http://t00img.yangkeduo.com/t08img/images/2018-04-18/fc603bad27947c7adcdf1baae828cb34.jpeg', '1240', '3500', '16800', '已售10万+件', '2', '50', '2', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('68725206', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t07img/images/2018-04-16/1cd1e0e0dcfc40510cde2c786d431017.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-03/ed4584725c895237ea2929b81a250607.jpeg', '990', '2990', '6800', '已售10万+件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('71626520', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t10img/images/2018-06-03/62b8daef311570dd6af813b0806d24dd.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-06-03/8b9ba274d34c022053e6b4daceb7c1de.jpeg', '1590', '1890', '2700', '已售10万+件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('73318400', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://omsproductionimg.yangkeduo.com/images/2018-06-15/1991b1568cac46fcb8cc56c3431d1993.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-10-29/b52afaddb84c46ac6551a072692b42b0.jpeg', '990', '1290', '6900', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('75594360', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t04img/images/2018-06-05/a1d3badb9114252db836de215387a6d5.jpeg', 'http://t00img.yangkeduo.com/t04img/images/2018-07-13/1d70421e5e8485e39cff7c06da56631c.jpeg', '980', '1690', '1790', '已售10万+件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('88041009', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t08img/images/2018-05-24/a0245e792950a61b6022f821d9a976b0.jpeg', 'http://t00img.yangkeduo.com/t05img/images/2018-06-27/65bc426358e301a96cffd4ffa5383ec6.jpeg', '1450', '1650', '5900', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('93803460', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t01img/images/2018-06-10/8fd1f6304fc4aeb050a453624a46547b.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-04/bf467cf7227aca2592b60c19d493ece0.jpeg', '2900', '3200', '19900', '已售4万件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('94353420', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t09img/images/2018-07-18/45f30a9c054482564ec5d2265ba01697.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-07-18/57cfbc1d42639d4b8d9960fe8c31213c.jpeg', '2360', '4990', '16800', '已售6万件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('101758846', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-07/aefad6b3f63045e5f2a4caa40fd9818b.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-12-18/15c2f12dc4be7d6bc84fd33d59a6ef01.jpeg', '3960', '5200', '6900', '已售10万+件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('118241846', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t03img/images/2018-06-30/eadbefbbb7a958d9d277920a21307238.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-10-13/d4e000de29a2db3dc24622e2682a24bb.jpeg', '2980', '3480', '5500', '已售1万件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('136590526', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t02img/images/2018-06-22/45cee30308baa4995bc4686720423705.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-01/68b91521e1a01573e101b15abcae9793.jpeg', '1380', '4990', '14900', '已售10万+件', '3', '50', '3', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('169295119', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://omsproductionimg.yangkeduo.com/images/2018-01-14/3ff694d98f06f1db6978b7fbe83d16a4.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-06/16689ceb93d0e167097f16452e7106d2.jpeg', '2980', '3680', '5900', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('178134109', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t01img/images/2018-02-26/52d6a1c1c23dc89cd451fbf362f896c3.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-11-06/c493dc4c067481beaa3d153cc943f146.png', '3990', '4990', '10800', '已售4万件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('228942174', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-09-02/9d2fadb5b9ac0ba847f361248ad15494.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-31/b94868b99fbe4bef85c58e83f1e4e8fd.jpeg', '990', '1390', '3990', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('344112935', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t03img/images/2018-05-05/5175ccf0a7b569aea93396c2b2ad697d.jpeg', 'http://t00img.yangkeduo.com/t11img/images/2018-06-19/cd59c6af23ef22afd5baa8f86b6fbc9b.jpeg', '990', '1300', '19900', '已售8万件', '4', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('482053513', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-03/69425cc7135b2ba75c099ff23724ded1.jpeg', 'http://t00img.yangkeduo.com/t05img/images/2018-03-26/744cc6062d93a415fa5012c6c0e65e3d.jpeg', '4980', '7900', '27900', '已售2万件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('554370312', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t01img/images/2018-05-14/9ff4f3612bd095e0d769a38b1ee32b65.jpeg', 'http://t00img.yangkeduo.com/t02img/images/2018-05-03/c454d9a35960004d644e3ff9b1a16f3a.jpeg', '486', '1550', '1990', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('586250323', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t01img/images/2018-06-21/7fd4c2ee6e53e1ad7ab8e323c1e03d25.jpeg', 'http://t00img.yangkeduo.com/t07img/images/2018-05-22/2f4e4fcc3362b8730d4a89b6ad3d3aa1.jpeg', '71800', '74800', '369900', '已售3275件', '4', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('590417883', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-09-12/30d8d7a0ad6324419436fcd8fb5ecc0c.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-12/d91497c08d5455fd09405fe8553f5abc.jpeg', '690', '1000', '5000', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('621723438', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-07-20/1cd421b6d97de18dcfb0d3f7e6e5de94.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-07-20/671c3d632d8a08804d754d423f3d1f11.jpeg', '955', '1280', '13380', '已售1000+件', '1', '50', '2', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('626593225', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t10img/images/2018-07-01/f707607f1ce19b8bcdb3682af9c88d51.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-07-10/7080de753cfc72201e67191f2f5383d4.jpeg', '850', '1090', '3999', '已售10万+件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('659359942', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t04img/images/2018-06-14/c4275e1311450df9d34df69ecc2731a3.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-22/ae0aef0f366813879bcf811610d40005.jpeg', '666', '10800', '28800', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('676035553', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-17/7ad3d2295fa7eea185dc07b10df1dd1f.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-08/b9ccfdb67d3480a83786b63814fc4be9.jpeg', '457', '650', '5800', '已售10万+件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('692909163', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-09-05/0af1bdd3b2220743626855bb6d859cdf.jpeg', 'http://t00img.yangkeduo.com/t05img/images/2018-03-14/f39381065db0c2eb6b8dfa4696b9dc05.jpeg', '1689', '2490', '4900', '已售5万件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('724403210', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t05img/images/2018-06-14/c3f3b9d44f9a55a483b4b939bbb4a9dd.jpeg', 'http://t00img.yangkeduo.com/t05img/images/2018-05-14/463e2b59fb9385576fb6cac6250fb6f4.jpeg', '610', '790', '2800', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('726060346', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-09-12/f7f317044e5881caf3e025d7ea2d0f99.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-10/5211143d22f4328931632fc03407b0fb.jpeg', '490', '590', '1990', '已售10万+件', '4', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('745340365', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-02/6522620b12f472e52c09ad2fd0d7c43a.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-04-16/2b4f92a7e7c7047d0fa8c7295f7b2c62.jpeg', '4720', '9900', '88800', '已售10万+件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('787864129', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-07-29/74ce1f8136f9e1f61634d2137ab28fd9.jpeg', 'http://t00img.yangkeduo.com/t02img/images/2018-06-12/c649793769fb2b477c7f68b457ca16dc.jpeg', '552', '1200', '4900', '已售10万+件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('844359129', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-07/29f7bae076e9b106928f05174c91af02.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-06-08/67cd5333f0a6ac2e763feab5a2eb8d17.jpeg', '3590', '3890', '19900', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('852030706', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t07img/images/2018-03-30/aaa81c3e30f306164bb24ce50fea70fd.jpeg', 'http://t00img.yangkeduo.com/t11img/images/2018-04-17/d89f9f2218e739fb936321882d77f13f.jpeg', '1290', '1890', '3900', '已售10万+件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('863231799', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-09-02/c2a0deff15467cc7b5fe5f28c3170559.jpeg', 'http://t00img.yangkeduo.com/t07img/images/2018-04-19/51f2570747b64b42cf20a8fcd0bb948e.jpeg', '273800', '276900', '539000', '已售1239件', '4', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('863726260', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-30/27c806d7a283f8184096d93f76f3aac0.jpeg', 'http://t00img.yangkeduo.com/t05img/images/2018-03-29/4662f2d2f126959d32443a1ad28f6081.jpeg', '980', '1290', '10000', '已售2万件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('875385046', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-09-12/7adb65531ef71184f7e703ac5e28999a.jpeg', 'http://t00img.yangkeduo.com/t01img/images/2018-07-12/98e04ba5e26ee6212162d5d8548624a5.jpeg', '2850', '3500', '6501', '已售10万+件', '4', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('882888828', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t07img/images/2018-06-06/d6adb7a168fbcf37fc56832a6cd106c4.jpeg', 'http://t00img.yangkeduo.com/t02img/images/2018-03-31/ab85553637fdddcc295cec711a4a0913.jpeg', '760', '990', '3880', '已售10万+件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('949987702', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t03img/images/2018-06-21/97cacf16358cd3d1c7136d216a81137e.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-04-06/a4a6577dc60b5df16edf238a0e1cd243.jpeg', '117500', '117800', '169900', '已售1万件', '4', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('976604348', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/t10img/images/2018-05-19/4332646b1171f2c7352a864585e0bf36.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-07-12/8854d14fb9ca09bb2f39099fe8894593.jpeg', '1720', '2079', '3000', '已售6万件', '5', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('2351564694', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-07-24/4a726b21574206f83c37d1c4f68b4856.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-02/88b3127aea77f4b2281213f74cd2578e.jpeg', '590', '690', '4800', '已售1万件', '2', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('2459679200', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-15/54fe60fbb8e2f79f6e8d0d919909f2dd.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-21/384a84088457fe98b3d451b169440b69.jpeg', '2690', '6990', '12900', '已售10万+件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('2491622905', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-09-09/f1a8e44dfc8249a164bfbeafcd0dad25.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-13/07b2f91dc858621176bcc473e97293f0.jpeg', '5680', '7500', '18800', '已售1万件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('2570072250', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-26/2c5c90fc139d0b3f562e50d98a3afa6f.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-26/c4b8dce28810d4ebedae438158ed4f0c.jpeg', '4990', '19900', '20000', '已售2万件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');
INSERT INTO `recommend` VALUES ('2635286942', '爱心永生花礼盒', '爱心永生花礼盒/尊享版', 'http://i.miaosu.bid/data/f_38311020.jpg', 'http://t00img.yangkeduo.com/goods/images/2018-08-17/091d8f7dbfad772ab2843351516a364d.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-27/f3947b680054d0f30cf6ba45bc70cf93.jpeg', '2980', '4500', '15800', '已售10万+件', '3', '50', '0', 'https://tuchuangs.com/imgs/2022/09/05/66c66103dbf0bdab.jpg');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_pwd` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_sex` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_birthday` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_sign` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_nickname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('5', '13666666666', null, '13666666666', '女', '福州', '2000-01-01', '买买买！！！', '', 'http://localhost:3000/avatar_uploads/avatar_default.jpg');
INSERT INTO `user_info` VALUES ('8', '15666666666', null, '15666666666', '女', '', '', '', '莫得感情的机器人', 'http://localhost:3000/avatar_uploads/avatar_default.jpg');
INSERT INTO `user_info` VALUES ('9', '来来来', 'a163a36c731d1ac664841b6d196a05e3', '18666666666', '男', '', '', '', 'HS', 'http://localhost:3000/avatar_uploads/upload_5a67435fbb680332a6a3aa62014f5aa2.jpg');
INSERT INTO `user_info` VALUES ('12', 'sbsbsb', '6ff9140a5f436778a86095325f6c6524', '12312312312', '', '广东省深圳市宝安区', '', '', '', 'http://localhost:3000/avatar_uploads/avatar_default.jpg');
INSERT INTO `user_info` VALUES ('13', '123', 'a163a36c731d1ac664841b6d196a05e3', null, '', '123', '', '', '', 'http://localhost:3000/avatar_uploads/avatar_default.jpg');
INSERT INTO `user_info` VALUES ('14', '234', 'b454aaf536cbe16e0afa44fc2f9c5752', null, null, null, null, null, null, 'http://localhost:3000/avatar_uploads/avatar_default.jpg');
