/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : wiki

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2017-11-08 11:05:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adminName` varchar(16) NOT NULL,
  `pwd` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '156650ad747cfb25fcb9a7a2f8a02bdc');

-- ----------------------------
-- Table structure for `draft`
-- ----------------------------
DROP TABLE IF EXISTS `draft`;
CREATE TABLE `draft` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appList` varchar(100) DEFAULT NULL,
  `title` varchar(60) DEFAULT NULL,
  `author` varchar(40) DEFAULT NULL,
  `articleUrl` varchar(255) DEFAULT NULL,
  `summary` varchar(240) DEFAULT NULL,
  `content` text,
  `cover` varchar(255) DEFAULT NULL,
  `date` varchar(40) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of draft
-- ----------------------------
INSERT INTO `draft` VALUES ('1', '真情科干/天天喝喝/', '测试', '测试', '测试', '测试', '测试内容', 'upload/1509933562178.jpg', '2017-11-03 17:17:00', '1');
INSERT INTO `draft` VALUES ('2', '测试/测试2号/', '20171104', 'chen', 'www.baidu.com', '这是一个日期', '哈哈', 'upload/1509798770575.jpg', '2017-11-04 08:37:35', '1');
INSERT INTO `draft` VALUES ('3', '测试4号/', 'sdf', 'sdf', 'sdf', 'sdf', 'sdfsdf', 'upload/1510109170036.jpg', '2017-11-04 20:18:11', '1');
INSERT INTO `draft` VALUES ('4', '测试3号/测试/', '20171104', 'chen', 'www.baidu.com', 'hello', 'hello', 'upload/1509933562178.jpg', '2017-11-04 20:23:20', '1');
INSERT INTO `draft` VALUES ('5', '真情科干/', 'hello', 'chen', 'sdf', 'sdf', 'sdf', 'upload/1510109170036.jpg', '2017-11-04 20:24:50', '1');
INSERT INTO `draft` VALUES ('6', '测试8号/', '今天', 'chen', 'www.baidu.com', '今天是美好的一天', 'hello', 'upload/1509798770575.jpg', '2017-11-04 20:29:23', '1');
INSERT INTO `draft` VALUES ('7', '测试7号/', '你好', 'li', 'www.icat.com', '打招呼', '你好，脸带微笑', 'upload/1510109170036.jpg', '2017-11-04 20:32:50', '1');
INSERT INTO `draft` VALUES ('8', '测试2号/', '20171105', 'chen', 'www.icast.com', 'hello', 'hello java', 'upload/1509864856582.jpg', '2017-11-05 14:54:16', '1');
INSERT INTO `draft` VALUES ('9', '真情科干/天天喝喝/', '201711052200', 'chen', 'www.baidu.com', 'hello', 'hello', 'upload/1509933334204.jpg', '2017-11-05 22:00:46', '1');
INSERT INTO `draft` VALUES ('10', '纵梦广科/', '今天星期一', 'sdf', 'sdf', 'sdf', 'sdf', 'upload/1509933562178.jpg', '2017-11-06 09:59:22', '1');
INSERT INTO `draft` VALUES ('11', '测试3号/测试4号/', '201711081033', 'chen', '就差一个了', 'sdf', 'sdf', 'upload/1510109170036.jpg', '2017-11-08 10:33:26', '1');
INSERT INTO `draft` VALUES ('12', '纵梦广科/', '睡觉3', 'sdf', 'sdf', 'sdf', 'sdfsd', 'upload/1509933334204.jpg', '2017-11-05 23:26:42', '1');
INSERT INTO `draft` VALUES ('13', '测试2号/测试3号/', '准备睡觉了', 'chen', 'sdf', 'sdf', 'sdf', 'upload/1510109170036.jpg', '2017-11-05 23:25:21', '1');
INSERT INTO `draft` VALUES ('14', '张大狼烧饼/', '卖饼', 'zhang', 'www.baidu.com', '四块钱一个', '快来快来', 'upload/1510109170036.jpg', '2017-11-08 10:46:53', '3');

-- ----------------------------
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appList` varchar(100) NOT NULL,
  `title` varchar(60) NOT NULL,
  `author` varchar(40) NOT NULL,
  `articleUrl` varchar(255) DEFAULT NULL,
  `summary` varchar(240) NOT NULL,
  `content` text NOT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `date` varchar(40) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', '真情科干/天天喝喝/', '测试', '测试', '测试', '测试', '测试', 'upload/1509933562178.jpg', '2017-11-03 17:17:00', '1');
INSERT INTO `message` VALUES ('2', '天天喝喝/', 'hello', 'chen', 'www.kyzg.com', 'hello', 'hello', 'upload/1509933562178.jpg', '2017-11-06 09:59:22', '1');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(16) NOT NULL,
  `pwd` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'chen', '156650ad747cfb25fcb9a7a2f8a02bdc');
INSERT INTO `user` VALUES ('2', 'wang', '156650ad747cfb25fcb9a7a2f8a02bdc');
INSERT INTO `user` VALUES ('3', 'zhang', '156650ad747cfb25fcb9a7a2f8a02bdc');

-- ----------------------------
-- Table structure for `wiki`
-- ----------------------------
DROP TABLE IF EXISTS `wiki`;
CREATE TABLE `wiki` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appName` varchar(40) NOT NULL,
  `appId` varchar(50) NOT NULL,
  `appSecret` varchar(100) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQ_appId` (`appId`),
  UNIQUE KEY `UQ_appName` (`appName`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wiki
-- ----------------------------
INSERT INTO `wiki` VALUES ('1', '真情科干', '123', '123456', '1');
INSERT INTO `wiki` VALUES ('2', '天天喝喝', '1234', '456', '1');
INSERT INTO `wiki` VALUES ('3', '纵梦广科', '7498', '467', '1');
INSERT INTO `wiki` VALUES ('4', '爱在吴川', '12345', '01041504', '2');
INSERT INTO `wiki` VALUES ('5', '测试1号', '1653245', '15465123', '1');
INSERT INTO `wiki` VALUES ('6', '测试2号', '16532', '13524', '1');
INSERT INTO `wiki` VALUES ('7', '测试3号', '15421', '15145', '1');
INSERT INTO `wiki` VALUES ('8', '测试4号', '02165', '16415', '1');
INSERT INTO `wiki` VALUES ('9', '测试5号', '015468', '154871', '1');
INSERT INTO `wiki` VALUES ('10', '测试6号', '154855', '15481', '1');
INSERT INTO `wiki` VALUES ('11', '测试7号', '488751', '15456', '1');
INSERT INTO `wiki` VALUES ('13', '张大狼烧饼', '156424545', '154265445', '3');
