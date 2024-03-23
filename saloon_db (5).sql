-- Adminer 4.8.1 MySQL 8.0.36-0ubuntu0.22.04.1 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `activities`;
CREATE TABLE `activities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` text NOT NULL,
  `data` text,
  `client` int DEFAULT NULL,
  `admin` int DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `device` varchar(255) DEFAULT NULL,
  `browser` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `admin` (`admin`),
  KEY `client` (`client`),
  CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`admin`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  CONSTRAINT `activities_ibfk_2` FOREIGN KEY (`client`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


SET NAMES utf8mb4;

DROP TABLE IF EXISTS `activity_log`;
CREATE TABLE `activity_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int DEFAULT NULL,
  `log_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_uuid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `properties` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `causer` (`causer_type`,`causer_id`),
  KEY `activity_log_log_name_index` (`log_name`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `activity_log_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `addresses` (`id`, `user_id`, `title`, `address`, `city`, `state`, `pincode`, `latitude`, `longitude`, `created_by`, `created`, `modified`, `deleted_at`) VALUES
(29,	2,	'Home',	'9-F KItclu Nagar',	'Ludhiana',	'Punjab',	'Kitchlu Nagar',	99.99999999,	444.00000000,	NULL,	NULL,	'2023-12-30 06:42:45',	NULL),
(32,	2,	'foo',	'foo',	'foo',	'foo',	'foo',	99.99999999,	444.00000000,	NULL,	'2024-01-05 15:46:12',	'2024-01-05 10:16:12',	'2024-01-05 10:16:34'),
(33,	NULL,	'foo',	'The address field is required.',	'The city field is required.',	'The state field is required.',	'The area field is required.',	99.99999999,	444.00000000,	NULL,	'2024-01-05 15:46:34',	'2024-01-05 10:16:34',	'2024-01-05 10:16:46'),
(34,	NULL,	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'2024-01-05 15:46:46',	'2024-01-05 10:17:02'),
(35,	NULL,	'foo',	'The address field is required.',	'The city field is required.',	'The state field is required.',	'The area field is required.',	99.99999999,	444.00000000,	NULL,	NULL,	'2024-01-05 15:47:02',	'2024-01-05 10:18:25'),
(36,	NULL,	'foo',	'The address field is required.',	'The city field is required.',	'The state field is required.',	'The area field is required.',	99.99999999,	444.00000000,	NULL,	'2024-01-05 15:48:25',	'2024-01-05 10:18:25',	'2024-01-05 10:18:27'),
(37,	NULL,	'foo',	'The address field is required.',	'The city field is required.',	'The state field is required.',	'The area field is required.',	99.99999999,	444.00000000,	NULL,	'2024-01-05 15:48:27',	'2024-01-05 10:18:27',	'2024-01-05 10:18:27'),
(38,	NULL,	'foo',	'The address field is required.',	'The city field is required.',	'The state field is required.',	'The area field is required.',	99.99999999,	444.00000000,	NULL,	'2024-01-05 15:48:27',	'2024-01-05 10:18:27',	'2024-02-03 23:40:18'),
(39,	NULL,	'foo',	'The address field is required.',	'The city field is required.',	'The state field is required.',	'The area field is required.',	99.99999999,	444.00000000,	NULL,	'2024-02-04 05:10:19',	'2024-02-03 23:40:19',	NULL),
(40,	4,	NULL,	'Chawni Mohalla, St. No. 4,  Manna Singh Nagar',	'Ludhiana',	NULL,	'141008',	NULL,	NULL,	NULL,	'2024-03-14 09:14:25',	'2024-03-14 09:14:25',	'2024-03-14 23:01:44'),
(41,	4,	NULL,	'Aaaa',	'Ludhiana',	NULL,	'1111',	NULL,	NULL,	NULL,	'2024-03-14 23:01:55',	'2024-03-14 23:01:55',	NULL),
(42,	9,	NULL,	'Fffff',	'Ludhiana',	NULL,	'141001',	NULL,	NULL,	NULL,	'2024-03-16 13:55:02',	'2024-03-16 13:55:02',	NULL),
(43,	9,	NULL,	'you',	'Panchkula',	NULL,	'141002',	NULL,	NULL,	NULL,	'2024-03-16 14:13:43',	'2024-03-16 14:13:43',	NULL),
(44,	15,	NULL,	'Chawni Mohalla, St. No. 4,  Manna Singh Nagar',	'Ludhiana',	NULL,	'141008',	NULL,	NULL,	NULL,	'2024-03-19 16:23:52',	'2024-03-19 16:23:52',	NULL),
(45,	8,	NULL,	'480,sector-9',	'Panchkula',	NULL,	'134109',	NULL,	NULL,	NULL,	'2024-03-19 18:10:56',	'2024-03-19 18:10:56',	NULL),
(46,	4,	NULL,	'AAASSS',	'Panchkula',	NULL,	'112233',	NULL,	NULL,	NULL,	'2024-03-23 19:42:25',	'2024-03-23 19:42:25',	NULL);

DROP TABLE IF EXISTS `admin_permissions`;
CREATE TABLE `admin_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permission_id` int NOT NULL,
  `admin_id` int NOT NULL,
  `mode` enum('listing','create','update','delete') CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `created_by` int NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `permission_id` (`permission_id`),
  KEY `admin_id` (`admin_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `admin_permissions_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `admin_permissions_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  CONSTRAINT `admin_permissions_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;


DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `otp` varchar(50) DEFAULT NULL,
  `otp_sent_on` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `address` tinytext,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `admins` (`id`, `first_name`, `last_name`, `email`, `password`, `phonenumber`, `last_login`, `is_admin`, `otp`, `otp_sent_on`, `token`, `image`, `created_by`, `status`, `deleted_at`, `created`, `address`, `modified`) VALUES
(7,	'Super',	'Admin',	'admin@laravel.com',	'$2y$10$RIGjhyvuyhJf.Kkjrcx/teILNFrgC.6v5Dw36LDFCuWZHOhGXCnCq',	NULL,	'2024-03-23 20:34:56',	1,	NULL,	NULL,	NULL,	'/uploads/admins/1707670612357-group-1000001967-1.png',	NULL,	1,	NULL,	'0000-00-00 00:00:00',	NULL,	'2024-03-23 15:04:56');

DROP TABLE IF EXISTS `blog_categories`;
CREATE TABLE `blog_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `image` text,
  `slug` varchar(255) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `parent_id` (`parent_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `blog_categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `blog_categories_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `blog_category_relation`;
CREATE TABLE `blog_category_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `blog_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_id` (`blog_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `blog_category_relation_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_category_relation_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `blogs`;
CREATE TABLE `blogs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `image` text,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `blogs_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `brand_product`;
CREATE TABLE `brand_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `brand_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `brand_id` (`brand_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `brand_product_ibfk_3` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `brand_product_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `brand_product` (`id`, `brand_id`, `product_id`, `created`, `modified`) VALUES
(264,	21,	102,	'2024-02-16 12:19:50',	'2024-02-16 12:19:50'),
(265,	21,	98,	'2024-02-16 12:20:47',	'2024-02-16 12:20:47'),
(275,	18,	107,	'2024-03-01 00:07:42',	'2024-03-01 00:07:42'),
(413,	33,	131,	'2024-03-13 16:51:31',	'2024-03-13 16:51:31'),
(414,	33,	136,	'2024-03-13 16:54:59',	'2024-03-13 16:54:59'),
(415,	16,	138,	'2024-03-13 16:56:24',	'2024-03-13 16:56:24'),
(416,	33,	139,	'2024-03-13 16:57:35',	'2024-03-13 16:57:35'),
(418,	16,	141,	'2024-03-13 16:59:17',	'2024-03-13 16:59:17'),
(419,	16,	142,	'2024-03-13 17:01:17',	'2024-03-13 17:01:17'),
(420,	33,	144,	'2024-03-13 17:02:45',	'2024-03-13 17:02:45'),
(421,	16,	147,	'2024-03-13 17:06:47',	'2024-03-13 17:06:47'),
(423,	33,	149,	'2024-03-13 17:13:29',	'2024-03-13 17:13:29'),
(424,	16,	151,	'2024-03-13 17:14:10',	'2024-03-13 17:14:10'),
(425,	33,	152,	'2024-03-13 17:15:32',	'2024-03-13 17:15:32'),
(426,	16,	154,	'2024-03-13 17:16:26',	'2024-03-13 17:16:26'),
(427,	33,	155,	'2024-03-13 17:18:18',	'2024-03-13 17:18:18'),
(428,	16,	156,	'2024-03-13 17:19:13',	'2024-03-13 17:19:13'),
(429,	16,	158,	'2024-03-13 17:20:56',	'2024-03-13 17:20:56'),
(431,	33,	160,	'2024-03-13 17:24:10',	'2024-03-13 17:24:10'),
(432,	16,	162,	'2024-03-13 17:24:44',	'2024-03-13 17:24:44'),
(433,	16,	164,	'2024-03-13 17:25:34',	'2024-03-13 17:25:34'),
(435,	16,	165,	'2024-03-13 17:28:46',	'2024-03-13 17:28:46'),
(436,	16,	167,	'2024-03-13 17:29:17',	'2024-03-13 17:29:17'),
(437,	16,	168,	'2024-03-13 17:32:32',	'2024-03-13 17:32:32'),
(438,	16,	169,	'2024-03-13 17:33:02',	'2024-03-13 17:33:02'),
(440,	18,	175,	'2024-03-13 17:38:35',	'2024-03-13 17:38:35'),
(441,	19,	112,	'2024-03-13 17:39:19',	'2024-03-13 17:39:19'),
(442,	18,	109,	'2024-03-13 17:40:02',	'2024-03-13 17:40:02'),
(444,	18,	108,	'2024-03-13 17:41:33',	'2024-03-13 17:41:33'),
(445,	17,	103,	'2024-03-13 17:42:47',	'2024-03-13 17:42:47'),
(446,	22,	113,	'2024-03-13 17:44:05',	'2024-03-13 17:44:05'),
(447,	20,	114,	'2024-03-13 17:44:53',	'2024-03-13 17:44:53'),
(448,	19,	115,	'2024-03-13 17:45:43',	'2024-03-13 17:45:43'),
(449,	21,	116,	'2024-03-13 17:46:12',	'2024-03-13 17:46:12'),
(450,	26,	95,	'2024-03-13 17:48:07',	'2024-03-13 17:48:07'),
(451,	26,	99,	'2024-03-13 17:49:40',	'2024-03-13 17:49:40'),
(453,	24,	117,	'2024-03-13 17:52:16',	'2024-03-13 17:52:16'),
(454,	23,	117,	'2024-03-13 17:52:16',	'2024-03-13 17:52:16'),
(459,	26,	123,	'2024-03-13 17:55:57',	'2024-03-13 17:55:57'),
(460,	26,	126,	'2024-03-13 18:01:17',	'2024-03-13 18:01:17'),
(463,	26,	130,	'2024-03-13 18:03:39',	'2024-03-13 18:03:39'),
(465,	24,	121,	'2024-03-13 18:07:55',	'2024-03-13 18:07:55'),
(466,	23,	121,	'2024-03-13 18:07:55',	'2024-03-13 18:07:55'),
(467,	24,	119,	'2024-03-13 18:08:30',	'2024-03-13 18:08:30'),
(468,	23,	119,	'2024-03-13 18:08:30',	'2024-03-13 18:08:30'),
(469,	19,	111,	'2024-03-13 18:11:08',	'2024-03-13 18:11:08'),
(473,	16,	140,	'2024-03-16 22:40:08',	'2024-03-16 22:40:08'),
(474,	16,	146,	'2024-03-16 22:42:58',	'2024-03-16 22:42:58'),
(475,	33,	161,	'2024-03-16 22:49:39',	'2024-03-16 22:49:39'),
(476,	16,	166,	'2024-03-16 22:50:19',	'2024-03-16 22:50:19'),
(477,	16,	170,	'2024-03-16 22:50:57',	'2024-03-16 22:50:57'),
(478,	16,	171,	'2024-03-16 22:53:18',	'2024-03-16 22:53:18'),
(479,	16,	172,	'2024-03-16 22:53:50',	'2024-03-16 22:53:50'),
(480,	17,	104,	'2024-03-16 22:54:39',	'2024-03-16 22:54:39'),
(481,	17,	105,	'2024-03-16 22:55:16',	'2024-03-16 22:55:16'),
(482,	19,	110,	'2024-03-16 22:55:45',	'2024-03-16 22:55:45'),
(483,	17,	106,	'2024-03-16 22:56:28',	'2024-03-16 22:56:28'),
(484,	26,	97,	'2024-03-16 22:58:17',	'2024-03-16 22:58:17'),
(486,	19,	100,	'2024-03-16 22:59:55',	'2024-03-16 22:59:55'),
(487,	26,	101,	'2024-03-16 23:00:36',	'2024-03-16 23:00:36'),
(491,	26,	128,	'2024-03-16 23:06:22',	'2024-03-16 23:06:22'),
(492,	24,	122,	'2024-03-16 23:07:14',	'2024-03-16 23:07:14'),
(493,	23,	122,	'2024-03-16 23:07:14',	'2024-03-16 23:07:14'),
(494,	19,	96,	'2024-03-16 23:08:16',	'2024-03-16 23:08:16'),
(495,	16,	163,	'2024-03-16 23:09:56',	'2024-03-16 23:09:56'),
(496,	24,	118,	'2024-03-16 23:12:05',	'2024-03-16 23:12:05'),
(497,	23,	118,	'2024-03-16 23:12:05',	'2024-03-16 23:12:05'),
(498,	24,	120,	'2024-03-16 23:12:53',	'2024-03-16 23:12:53'),
(499,	23,	120,	'2024-03-16 23:12:53',	'2024-03-16 23:12:53'),
(500,	26,	124,	'2024-03-16 23:13:35',	'2024-03-16 23:13:35'),
(501,	16,	133,	'2024-03-16 23:16:41',	'2024-03-16 23:16:41'),
(502,	16,	134,	'2024-03-16 23:17:32',	'2024-03-16 23:17:32'),
(503,	16,	135,	'2024-03-16 23:18:09',	'2024-03-16 23:18:09'),
(504,	16,	148,	'2024-03-16 23:18:58',	'2024-03-16 23:18:58'),
(505,	16,	157,	'2024-03-16 23:20:29',	'2024-03-16 23:20:29'),
(506,	33,	174,	'2024-03-17 11:50:48',	'2024-03-17 11:50:48'),
(507,	26,	125,	'2024-03-22 12:32:36',	'2024-03-22 12:32:36');

DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `brands_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `brands` (`id`, `title`, `slug`, `description`, `image`, `status`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(6,	'H&M',	NULL,	'<p>&nbsp;</p>\r\n\r\n<p>H&amp;M, or Hennes &amp; Mauritz, is a global fashion retailer known for its trendy and affordable clothing and accessories. Founded in 1947 in Sweden, H&amp;M has grown into one of the world&#39;s largest fashion retailers, with a presence in numerous countries.</p>',	'/uploads/brands/17027778445025-hm-logo.png',	0,	7,	NULL,	'2023-12-17 01:50:47',	'2023-12-16 20:20:47'),
(14,	'Honey Bee',	'honey-bee-MkO8V0',	NULL,	'/uploads/pages/1707748322363-honeybeelogo-200x.png',	0,	7,	NULL,	'2024-02-08 16:04:58',	'2024-02-12 14:32:05'),
(15,	'Richelon',	'richelon-KVgvk8',	NULL,	'/uploads/pages/17077482133058-logo-richelon.png',	0,	7,	NULL,	'2024-02-08 16:07:32',	'2024-02-12 14:30:14'),
(16,	'Rica',	'rica-9kY41E',	NULL,	'/uploads/pages/17076706006606-rica-logo.png',	1,	7,	NULL,	'2024-02-08 16:08:58',	'2024-02-11 16:56:42'),
(17,	'Lotus Herbals',	'lotus-herbals-o13O1z',	NULL,	'/uploads/pages/17077480782031-lotus-logo-a23a681d-2303-497c-aa08-f08ef9de97a4-140x.png',	1,	7,	NULL,	'2024-02-08 16:10:05',	'2024-02-12 14:28:00'),
(18,	'Cheryl\'s Cosmeceuticals',	'cheryls-cosmeceuticals-ZkWyaw',	NULL,	'/uploads/pages/17077478661422-logo.jpg',	1,	7,	NULL,	'2024-02-08 16:12:15',	'2024-02-12 14:24:28'),
(19,	'O3+',	'o3-AaLy1O',	NULL,	'/uploads/pages/17077477444336-o3.png',	1,	7,	NULL,	'2024-02-08 16:12:54',	'2024-02-12 14:22:26'),
(20,	'VLCC',	'vlcc-5VBYkG',	NULL,	'/uploads/pages/17077475356444-vlcc-logo.png',	1,	7,	NULL,	'2024-02-08 16:14:00',	'2024-02-12 14:19:03'),
(21,	'SARA',	'sara-XanK1r',	NULL,	'/uploads/pages/17077472395187-sara-beauty-164x.png',	1,	7,	NULL,	'2024-02-08 16:14:45',	'2024-02-12 14:14:02'),
(22,	'Aroma Treasures',	'aroma-treasures-xaMwkE',	NULL,	'/uploads/pages/17077469084805-aroma-treasures-logo.png',	1,	7,	NULL,	'2024-02-08 16:15:25',	'2024-02-12 14:08:30'),
(23,	'OxyLife',	'oxylife-JVoWVm',	NULL,	'/uploads/pages/17077484404027-android-icon-72x72.png',	1,	7,	NULL,	'2024-02-08 16:17:15',	'2024-02-12 14:34:06'),
(24,	'Ozone',	'ozone-DVz6VN',	NULL,	'/uploads/pages/17077487909041-326734689-723467489524333-2386076530513538069-n.jpg',	1,	7,	NULL,	'2024-02-08 16:17:56',	'2024-02-12 14:39:53'),
(25,	'Organica',	'organica-6a2Lk2',	NULL,	NULL,	1,	7,	NULL,	'2024-02-08 16:19:30',	'2024-02-08 16:19:30'),
(26,	'Raaga Professional',	'raaga-professional-n1rYad',	NULL,	'/uploads/pages/17076746046922-raaga-logo-01.png',	1,	7,	NULL,	'2024-02-08 16:21:43',	'2024-02-11 18:03:29'),
(33,	'None',	'none-lk04k2',	NULL,	NULL,	1,	7,	NULL,	'2024-02-15 12:28:19',	'2024-02-15 12:28:19');

DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(255) NOT NULL,
  `city_image` varchar(255) NOT NULL,
  `city_icon` varchar(255) NOT NULL,
  `state_id` char(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `state_id` (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `iso2` char(2) DEFAULT NULL,
  `short_name` varchar(80) NOT NULL DEFAULT '',
  `long_name` varchar(80) NOT NULL DEFAULT '',
  `iso3` char(3) DEFAULT NULL,
  `numcode` varchar(6) DEFAULT NULL,
  `un_member` varchar(12) DEFAULT NULL,
  `calling_code` varchar(8) DEFAULT NULL,
  `cctld` varchar(5) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `coupons`;
CREATE TABLE `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `coupon_code` varchar(255) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `max_use` int DEFAULT NULL,
  `used` int DEFAULT '0',
  `end_date` date DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `is_percentage` tinyint NOT NULL DEFAULT '0',
  `amount` decimal(10,2) NOT NULL,
  `min_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `coupon_code` (`coupon_code`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `coupons_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `coupons` (`id`, `coupon_code`, `description`, `title`, `slug`, `max_use`, `used`, `end_date`, `status`, `is_percentage`, `amount`, `min_amount`, `created_by`, `created`, `modified`, `deleted_at`) VALUES
(1,	'Welcome10',	'Use this coupon code to get 10% of discount.\r\nMinimum order value should be ₹ 600.',	'Welcome10',	'welcome10-AabNa0',	1000,	0,	'2025-02-01',	1,	1,	10.00,	600.00,	7,	'2024-03-16 14:17:43',	'2024-03-16 14:42:15',	NULL);

DROP TABLE IF EXISTS `email_logs`;
CREATE TABLE `email_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `from` varchar(100) NOT NULL,
  `to` text NOT NULL,
  `cc` text,
  `bcc` text,
  `sent` tinyint(1) NOT NULL DEFAULT '0',
  `open` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `email_logs` (`id`, `slug`, `subject`, `description`, `from`, `to`, `cc`, `bcc`, `sent`, `open`, `created`, `modified`) VALUES
(19,	'staff-assigned',	'Staff assigned to your order - #62.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 62</li>\r\n	<li><strong>Booking Date:</strong> 03-01-2025</li>\r\n	<li><strong>Order Total:</strong>  1373271.90</li>\r\n	<li><strong>Payment Type: </strong>UPI</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Myles Zulauf</li>\r\n	<li><strong>Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 1971231231</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-01-24 17:48:49',	'2024-01-24 12:18:49'),
(20,	'order-assigned',	'Order assigned to you  - #62.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear Myles Zulauf,</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Email:</strong> chaudharykiran125@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 08360445579</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 62</li>\r\n	<li><strong>Booking Date:</strong> 03-01-2025</li>\r\n	<li><strong>Order Total:</strong>  1373271.90</li>\r\n	<li><strong>Payment Type: </strong>UPI</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-01-24 17:48:49',	'2024-01-24 12:18:49'),
(21,	'order-unassigned',	'Order Unassigned - #62',	'<p>Dear Graciela Aufderhar,</p>\r\n\r\n<p>We regret to inform you that order #62 has been unassigned from you. Here are the details:</p>\r\n\r\n<p><strong>Order Number: </strong>62<br />\r\n<strong>Customer Name:</strong> Kiran Kumari<br />\r\n<strong>Customer Email: </strong>chaudharykiran125@gmail.com<br />\r\n<strong>Customer Contact:</strong> 08360445579<br />\r\n<strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab<br />\r\n<strong>Booking Date:</strong> 03-01-2025<br />\r\n<strong>Total Amount: </strong> 1373271.90<br />\r\n<strong>Payment Type:</strong> UPI</p>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-01-24 17:48:52',	'2024-01-24 12:18:52'),
(22,	'staff-reassigned',	'Staff Reassigned - Order #62',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #62 has been reassigned. Here are the updated details:</p>\r\n\r\n<p><strong>Order Number: </strong>62<br />\r\n<strong>New Staff Name:</strong> Graciela Aufderhar<br />\r\n<strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com<br />\r\n<strong>New Staff Contact:</strong> 5423333333<br />\r\n<strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab<br />\r\n<strong>Booking Date:</strong> 03-01-2025<br />\r\n<strong>Total Amount: </strong> 1373271.90<br />\r\n<strong>Payment Type:</strong> UPI</p>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-01-24 17:48:52',	'2024-01-24 12:18:52'),
(23,	'staff-reassigned',	'Staff Reassigned - Order #62',	'<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We want to inform you that the staff member for your order #62 has been reassigned. Here are the updated details:</p>\r\n\r\n<p><strong>Order Number: </strong>62<br />\r\n<strong>New Staff Name:</strong> Graciela Aufderhar<br />\r\n<strong>New Staff Email:</strong> your.email+fakedata22046@gmail.com<br />\r\n<strong>New Staff Contact:</strong> 5423333333<br />\r\n<strong>Order Address:</strong> 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab<br />\r\n<strong>Booking Date:</strong> 03-01-2025<br />\r\n<strong>Total Amount: </strong> 1373271.90<br />\r\n<strong>Payment Type:</strong> UPI</p>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing Admin.</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin<br />\r\n&nbsp;</p>',	'noreply@saloon.com',	'your.email+fakedata22046@gmail.com',	NULL,	NULL,	0,	0,	'2024-01-24 17:48:52',	'2024-01-24 12:18:52'),
(24,	'staff-assigned',	'Staff assigned to your order - #92.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear Kiran Kumari,</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 92</li>\r\n	<li><strong>Booking Date:</strong> 27-07-2023</li>\r\n	<li><strong>Order Total:</strong>  139645.00</li>\r\n	<li><strong>Payment Type: </strong>Credit/Debit Cards</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Myles Zulauf</li>\r\n	<li><strong>Email:</strong> your.email+fakedata88731@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 1971231231</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>',	'noreply@saloon.com',	'chaudharykiran125@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-07 17:31:39',	'2024-02-07 17:31:39'),
(25,	'order-assigned',	'Order assigned to you  - #92.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear Myles Zulauf,</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: 9-F KItclu Nagar,Kitchlu Nagar,Ludhiana,Punjab</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> Kiran Kumari</li>\r\n	<li><strong>Email:</strong> chaudharykiran125@gmail.com</li>\r\n	<li><strong>Contact Number:</strong> 08360445579</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> 92</li>\r\n	<li><strong>Booking Date:</strong> 27-07-2023</li>\r\n	<li><strong>Order Total:</strong>  139645.00</li>\r\n	<li><strong>Payment Type: </strong>Credit/Debit Cards</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\nAdmin</p>',	'noreply@saloon.com',	'your.email+fakedata88731@gmail.com',	NULL,	NULL,	0,	0,	'2024-02-07 17:31:39',	'2024-02-07 17:31:39');

DROP TABLE IF EXISTS `email_templates`;
CREATE TABLE `email_templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `type` enum('admin','client') DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `description` text,
  `short_codes` tinytext,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `email_templates` (`id`, `title`, `slug`, `type`, `subject`, `description`, `short_codes`, `created`, `modified`) VALUES
(1,	'Staff Assigned',	'staff-assigned',	NULL,	'Staff assigned to your order - #{order_number}.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<p>Dear {customer_name},</p>\r\n\r\n<p>We are excited to inform you that a staff member has been assigned to your order with the following details:<br />\r\nYour order is scheduled to be delivered at: {address}</p>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> {order_number}</li>\r\n	<li><strong>Booking Date:</strong> {booking_date}</li>\r\n	<li><strong>Order Total:</strong> {total_amount}</li>\r\n	<li><strong>Payment Type: </strong>{payment_type}</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p><strong>Assigned Staff Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> {staff_name}</li>\r\n	<li><strong>Email:</strong> {staff_email}</li>\r\n	<li><strong>Contact Number:</strong> {staff_contact}</li>\r\n	<!-- Add more staff details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need further assistance, feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing our services!</p>\r\n\r\n<p>Best regards,<br />\r\n{company_name}</p>',	'{order_number},{address},{booking_date},{total_amount},{payment_type},{company_name}, {staff_name},{staff_email},{staff_contact}, {customer_name},{customer_email},{customer_contact}',	NULL,	'2024-01-24 11:17:58'),
(2,	'Order Assigned',	'order-assigned',	NULL,	'Order assigned to you  - #{order_number}.',	'<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n<title></title>\r\n<p>Dear {staff_name},</p>\r\n\r\n<p>You have been assigned to an order for the following customer:<br />\r\nYour order is scheduled to be delivered at: {address}</p>\r\n\r\n<p><strong>Customer Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Name:</strong> {customer_name}</li>\r\n	<li><strong>Email:</strong> {customer_email}</li>\r\n	<li><strong>Contact Number:</strong> {customer_contact}</li>\r\n	<!-- Add more customer details as needed -->\r\n</ul>\r\n\r\n<p><strong>Order Details:</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Order Number:</strong> {order_number}</li>\r\n	<li><strong>Booking Date:</strong> {booking_date}</li>\r\n	<li><strong>Order Total:</strong> {total_amount}</li>\r\n	<li><strong>Payment Type: </strong>{payment_type}</li>\r\n	<!-- Add more order details as needed -->\r\n</ul>\r\n\r\n<p>If you have any questions or need additional information about this order, please contact the customer directly.</p>\r\n\r\n<p>Thank you for your dedication to providing excellent service!</p>\r\n\r\n<p>Best regards,<br />\r\n{company_name}</p>',	'{order_number},{address},{booking_date},{total_amount},{payment_type},{company_name}, {staff_name},{staff_email},{staff_contact}, {customer_name},{customer_email},{customer_contact}',	NULL,	'2024-01-24 12:06:58'),
(3,	'Order Unassigned',	'order-unassigned',	NULL,	'Order Unassigned - #{order_number}',	'<p>Dear {staff_name},</p>\r\n\r\n<p>We regret to inform you that order #{order_number} has been unassigned from you. Here are the details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>{order_number}</li>\r\n	<li><strong>Customer Name:</strong> {customer_name}</li>\r\n	<li><strong>Customer Email: </strong>{customer_email}</li>\r\n	<li><strong>Customer Contact:</strong> {customer_contact}</li>\r\n	<li><strong>Order Address:</strong> {address}</li>\r\n	<li><strong>Booking Date:</strong> {booking_date}</li>\r\n	<li><strong>Total Amount: </strong>{total_amount}</li>\r\n	<li><strong>Payment Type:</strong> {payment_type}</li>\r\n</ul>\r\n\r\n<p>We appreciate your efforts and understanding. If you have any questions or concerns, please feel free to contact us.</p>\r\n\r\n<p>Thank you,<br />\r\n{company_name}<br />\r\n&nbsp;</p>',	'{order_number},{address},{booking_date},{total_amount},{payment_type},{company_name}, {staff_name},{staff_email},{staff_contact}, {customer_name},{customer_email},{customer_contact}',	NULL,	'2024-01-24 12:21:10'),
(4,	'Staff Reassigned',	'staff-reassigned',	NULL,	'Staff Reassigned - Order #{order_number}',	'<p>Dear {customer_name},</p>\r\n\r\n<p>We want to inform you that the staff member for your order #{order_number} has been reassigned. Here are the updated details:</p>\r\n\r\n<ul>\r\n	<li><strong>Order Number: </strong>{order_number}</li>\r\n	<li><strong>New Staff Name:</strong> {staff_name}</li>\r\n	<li><strong>New Staff Email:</strong> {staff_email}</li>\r\n	<li><strong>New Staff Contact:</strong> {staff_contact}</li>\r\n	<li><strong>Order Address:</strong> {address}</li>\r\n	<li><strong>Booking Date:</strong> {booking_date}</li>\r\n	<li><strong>Total Amount: </strong>{total_amount}</li>\r\n	<li><strong>Payment Type:</strong> {payment_type}</li>\r\n</ul>\r\n\r\n<p>If you have any questions or concerns regarding this change, please feel free to contact us.</p>\r\n\r\n<p>Thank you for choosing {company_name}.</p>\r\n\r\n<p>Best regards,<br />\r\n{company_name}<br />\r\n&nbsp;</p>',	'{order_number},{address},{booking_date},{total_amount},{payment_type},{company_name}, {staff_name},{staff_email},{staff_contact}, {customer_name},{customer_email},{customer_contact}',	NULL,	'2024-01-24 12:21:49');

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `from_id` int NOT NULL,
  `to_id` int NOT NULL,
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message_id` varchar(255) NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` datetime DEFAULT NULL,
  `notify` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `from_id` (`from_id`),
  KEY `to_id` (`to_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(5,	'2014_10_12_000000_create_users_table',	1),
(6,	'2014_10_12_100000_create_password_resets_table',	1),
(7,	'2019_08_19_000000_create_failed_jobs_table',	1),
(8,	'2023_12_09_113020_create_brands_table',	1),
(9,	'2023_12_09_182202_create_products_table',	2),
(10,	'2023_12_25_071344_create_activity_log_table',	3),
(11,	'2023_12_26_071345_add_event_column_to_activity_log_table',	3);

DROP TABLE IF EXISTS `order_comments`;
CREATE TABLE `order_comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_id` int NOT NULL,
  `admin_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `admin_id` (`admin_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `order_comments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_comments_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_comments_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `order_products`;
CREATE TABLE `order_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_title` varchar(255) NOT NULL,
  `product_description` text,
  `amount` decimal(10,0) NOT NULL,
  `quantity` int DEFAULT NULL,
  `duration_of_service` time DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_products_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `order_products` (`id`, `order_id`, `product_id`, `product_title`, `product_description`, `amount`, `quantity`, `duration_of_service`, `deleted_at`, `created_at`, `updated_at`) VALUES
(242,	131,	131,	'Full Body Wax | Honey',	'<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n</ul>',	1077,	1,	'02:00:00',	NULL,	NULL,	'2024-03-22 00:24:05'),
(243,	131,	87,	'Eyebrows',	'<ul>\r\n	<li>Achieving the desired shape of eyebrows using high-quality thread</li>\r\n	<li>Prevents ingrown hairs</li>\r\n</ul>',	33,	1,	'00:05:00',	NULL,	NULL,	'2024-03-22 00:24:05'),
(244,	131,	103,	'Lotus Radiant pearl facial',	'<ul>\r\n	<li>For all skin types</li>\r\n	<li>Suitable for sun damaged and sun tanned skin</li>\r\n</ul>',	760,	1,	'01:05:00',	NULL,	NULL,	'2024-03-22 00:24:05'),
(245,	133,	131,	'Full Body Wax | Honey',	'<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n</ul>',	1077,	1,	'02:00:00',	NULL,	NULL,	'2024-03-22 12:44:59'),
(246,	133,	90,	'Lower Lip',	'<ul>\r\n	<li>Eliminates unwanted hair from the lower lip area</li>\r\n	<li>It prevents ingrown hairs&nbsp;</li>\r\n</ul>',	33,	1,	'00:05:00',	NULL,	NULL,	'2024-03-22 12:44:59'),
(247,	133,	103,	'Lotus Radiant pearl facial',	'<ul>\r\n	<li>For all skin types</li>\r\n	<li>Suitable for sun damaged and sun tanned skin</li>\r\n</ul>',	760,	1,	'01:05:00',	NULL,	NULL,	'2024-03-22 12:44:59'),
(248,	132,	131,	'Full Body Wax | Honey',	'<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n</ul>',	1077,	1,	'02:00:00',	NULL,	NULL,	'2024-03-22 12:44:59'),
(249,	132,	90,	'Lower Lip',	'<ul>\r\n	<li>Eliminates unwanted hair from the lower lip area</li>\r\n	<li>It prevents ingrown hairs&nbsp;</li>\r\n</ul>',	33,	1,	'00:05:00',	NULL,	NULL,	'2024-03-22 12:44:59'),
(250,	132,	103,	'Lotus Radiant pearl facial',	'<ul>\r\n	<li>For all skin types</li>\r\n	<li>Suitable for sun damaged and sun tanned skin</li>\r\n</ul>',	760,	1,	'01:05:00',	NULL,	NULL,	'2024-03-22 12:44:59'),
(251,	134,	87,	'Eyebrows',	'<ul>\r\n	<li>Achieving the desired shape of eyebrows using high-quality thread</li>\r\n	<li>Prevents ingrown hairs</li>\r\n</ul>',	33,	1,	'00:05:00',	NULL,	NULL,	'2024-03-23 19:42:57'),
(252,	134,	132,	'Full Body Wax | Chocolate',	'<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Oil-based wax for tan removal, exfoliation, and moisturization</li>\r\n</ul>',	1410,	1,	'02:00:00',	NULL,	NULL,	'2024-03-23 19:42:57'),
(253,	134,	93,	'Full Face',	'<ul>\r\n	<li>Eliminates unwanted hair from the full face</li>\r\n	<li>This method prevents ingrown hairs&nbsp;</li>\r\n</ul>',	198,	1,	'00:30:00',	NULL,	NULL,	'2024-03-23 19:42:57'),
(254,	135,	88,	'Upper lip',	'<ul>\r\n	<li>Eliminates unwanted hair from the upper lip area</li>\r\n	<li>preventing ingrown hairs</li>\r\n</ul>',	33,	1,	'00:05:00',	NULL,	NULL,	'2024-03-23 19:45:26'),
(255,	135,	131,	'Full Body Wax | Honey',	'<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n</ul>',	1077,	1,	'02:00:00',	NULL,	NULL,	'2024-03-23 19:45:26'),
(256,	135,	103,	'Lotus Radiant pearl facial',	'<ul>\r\n	<li>For all skin types</li>\r\n	<li>Suitable for sun damaged and sun tanned skin</li>\r\n</ul>',	760,	1,	'01:05:00',	NULL,	NULL,	'2024-03-23 19:45:26'),
(257,	136,	87,	'Eyebrows',	'<ul>\r\n	<li>Achieving the desired shape of eyebrows using high-quality thread</li>\r\n	<li>Prevents ingrown hairs</li>\r\n</ul>',	33,	1,	'00:05:00',	NULL,	NULL,	'2024-03-23 19:46:34'),
(258,	136,	131,	'Full Body Wax | Honey',	'<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n</ul>',	1077,	1,	'02:00:00',	NULL,	NULL,	'2024-03-23 19:46:34'),
(259,	136,	103,	'Lotus Radiant pearl facial',	'<ul>\r\n	<li>For all skin types</li>\r\n	<li>Suitable for sun damaged and sun tanned skin</li>\r\n</ul>',	760,	1,	'01:05:00',	NULL,	NULL,	'2024-03-23 19:46:34');

DROP TABLE IF EXISTS `order_status_history`;
CREATE TABLE `order_status_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staff_id` int DEFAULT NULL,
  `old_value` int DEFAULT NULL,
  `new_value` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `field` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `created_by` (`created_by`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `order_status_history_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_status_history_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  CONSTRAINT `order_status_history_ibfk_4` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `order_status_history` (`id`, `order_id`, `status`, `staff_id`, `old_value`, `new_value`, `field`, `created_by`, `created`, `modified`) VALUES
(131,	133,	'accepted',	NULL,	NULL,	NULL,	NULL,	7,	'2024-03-22 12:56:41',	'2024-03-22 12:56:41'),
(132,	133,	'accepted',	NULL,	NULL,	NULL,	NULL,	7,	'2024-03-22 12:56:42',	'2024-03-22 12:56:42'),
(133,	133,	'on_the_way',	NULL,	NULL,	NULL,	NULL,	7,	'2024-03-22 12:56:42',	'2024-03-22 12:56:42'),
(134,	133,	'accepted',	NULL,	NULL,	NULL,	NULL,	7,	'2024-03-22 12:56:42',	'2024-03-22 12:56:42'),
(135,	133,	'on_the_way',	NULL,	NULL,	NULL,	NULL,	7,	'2024-03-22 22:05:32',	'2024-03-22 22:05:32'),
(136,	133,	'reached_at_location',	NULL,	NULL,	NULL,	NULL,	7,	'2024-03-22 22:05:35',	'2024-03-22 22:05:35'),
(137,	133,	'completed',	NULL,	NULL,	NULL,	NULL,	7,	'2024-03-22 22:05:38',	'2024-03-22 22:05:38'),
(138,	132,	'in_progress',	NULL,	NULL,	NULL,	NULL,	7,	'2024-03-22 22:10:41',	'2024-03-22 22:10:41'),
(139,	131,	'reached_at_location',	NULL,	NULL,	NULL,	NULL,	7,	'2024-03-22 22:10:45',	'2024-03-22 22:10:45');

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `prefix_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `manual_address` tinyint(1) DEFAULT '0',
  `address_id` int DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `booking_time` time DEFAULT NULL,
  `payment_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shaguna_margin` decimal(10,2) DEFAULT NULL,
  `travel_charges` decimal(10,2) DEFAULT NULL,
  `partner_margin` decimal(10,2) DEFAULT NULL,
  `platform_charges` decimal(10,2) DEFAULT NULL,
  `buffer_margin_percent` decimal(10,2) DEFAULT NULL,
  `buffer_margin_amount` decimal(10,2) DEFAULT NULL,
  `shaguna_margin_percent` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `cgst` decimal(10,2) DEFAULT NULL,
  `sgst` decimal(10,2) DEFAULT NULL,
  `igst` decimal(10,2) DEFAULT NULL,
  `tax` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `our_profit` decimal(10,2) DEFAULT NULL,
  `staff_payment` decimal(10,2) DEFAULT NULL,
  `coupon` json DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_by_admin` tinyint(1) DEFAULT NULL,
  `status_by` int DEFAULT NULL,
  `status_at` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `address_id` (`address_id`),
  KEY `customer_id` (`customer_id`),
  KEY `status_by` (`status_by`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`status_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_ibfk_5` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `orders` (`id`, `customer_id`, `customer_name`, `prefix_id`, `staff_id`, `manual_address`, `address_id`, `address`, `city`, `area`, `state`, `latitude`, `longitude`, `booking_date`, `booking_time`, `payment_type`, `shaguna_margin`, `travel_charges`, `partner_margin`, `platform_charges`, `buffer_margin_percent`, `buffer_margin_amount`, `shaguna_margin_percent`, `subtotal`, `discount`, `cgst`, `sgst`, `igst`, `tax`, `total_amount`, `our_profit`, `staff_payment`, `coupon`, `status`, `created_by`, `created_by_admin`, `status_by`, `status_at`, `created`, `modified`, `deleted_at`) VALUES
(131,	4,	'dsdss',	'2132',	NULL,	1,	NULL,	'Aaaa, Ludhiana 1111',	'Ludhiana',	NULL,	NULL,	'30.7176535',	'76.6697667',	'2024-03-22',	'09:30:00',	NULL,	1.20,	50.00,	4.80,	0.00,	10.00,	0.00,	20.00,	1870.05,	187.01,	9.00,	9.00,	NULL,	49.69,	1732.73,	276.05,	1407.00,	'{\"id\": 1, \"title\": \"Welcome10\", \"amount\": \"10.00\", \"min_amount\": \"600.00\", \"coupon_code\": \"Welcome10\", \"description\": \"Use this coupon code to get 10% of discount.\\r\\nMinimum order value should be ₹ 600.\", \"is_percentage\": 1}',	'reached_at_location',	NULL,	NULL,	7,	'2024-03-22 22:10:45',	'2024-03-22 00:24:05',	'2024-03-21 18:54:05',	NULL),
(132,	8,	'Amita',	'2133',	NULL,	1,	NULL,	'480,sector-9, Panchkula 134109',	'Panchkula',	NULL,	NULL,	'30.710684',	'76.8129765',	'2024-03-22',	'13:30:00',	NULL,	1.20,	50.00,	4.80,	0.00,	10.00,	0.00,	20.00,	1870.05,	0.00,	NULL,	NULL,	18.00,	83.35,	1953.40,	463.05,	1407.00,	NULL,	'in_progress',	NULL,	NULL,	7,	'2024-03-22 22:10:41',	'2024-03-22 12:44:59',	'2024-03-22 07:14:59',	NULL),
(133,	8,	'Amita',	'2134',	NULL,	1,	NULL,	'480,sector-9, Panchkula 134109',	'Panchkula',	NULL,	NULL,	'30.710684',	'76.8129765',	'2024-03-22',	'13:30:00',	NULL,	1.20,	50.00,	4.80,	0.00,	10.00,	0.00,	20.00,	1870.05,	0.00,	NULL,	NULL,	18.00,	83.35,	1953.40,	463.05,	1407.00,	NULL,	'completed',	NULL,	NULL,	7,	'2024-03-22 22:05:38',	'2024-03-22 12:44:59',	'2024-03-22 07:14:59',	NULL),
(134,	4,	'dsdss',	'2135',	NULL,	1,	NULL,	'Aaaa, Ludhiana 1111',	'Ludhiana',	NULL,	NULL,	'30.8658365',	'75.8325356',	'2024-03-24',	'09:30:00',	NULL,	1.20,	50.00,	4.80,	0.00,	10.00,	0.00,	20.00,	1640.70,	0.00,	9.00,	9.00,	NULL,	62.41,	1703.11,	346.70,	1294.00,	NULL,	'pending',	NULL,	NULL,	NULL,	'2024-03-23 19:42:57',	'2024-03-23 19:42:57',	'2024-03-23 14:12:57',	NULL),
(135,	4,	'dsdss',	'2136',	NULL,	1,	NULL,	'AAASSS, Panchkula 112233',	'Panchkula',	NULL,	NULL,	'30.8658381',	'75.8325694',	'2024-03-24',	'09:30:00',	NULL,	1.20,	50.00,	4.80,	0.00,	10.00,	0.00,	20.00,	1870.05,	0.00,	NULL,	NULL,	18.00,	83.35,	1953.40,	463.05,	1407.00,	NULL,	'pending',	NULL,	NULL,	NULL,	'2024-03-23 19:45:26',	'2024-03-23 19:45:26',	'2024-03-23 14:15:26',	NULL),
(136,	4,	'dsdss',	'2137',	NULL,	1,	NULL,	'Aaaa, Ludhiana 1111',	'Ludhiana',	NULL,	NULL,	'30.8658384',	'75.8325535',	'2024-03-24',	'10:00:00',	NULL,	1.20,	50.00,	4.80,	0.00,	10.00,	0.00,	20.00,	1870.05,	0.00,	9.00,	9.00,	NULL,	83.35,	1953.40,	463.05,	1407.00,	NULL,	'pending',	NULL,	NULL,	NULL,	'2024-03-23 19:46:34',	'2024-03-23 19:46:34',	'2024-03-23 14:16:34',	NULL);

DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `slug` varchar(255) DEFAULT NULL,
  `image` text,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `pages_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `pages` (`id`, `title`, `description`, `slug`, `image`, `meta_title`, `meta_description`, `meta_keywords`, `status`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(1,	'Zara',	'<p>Zara is a renowned global fashion brand that has become synonymous with contemporary style and accessibility. Established with a commitment to delivering the latest fashion trends at affordable prices, Zara has become a favorite destination for fashion enthusiasts worldwide.</p>\r\n\r\n<p>Known for its agile approach to fashion, Zara quickly adapts to emerging styles and customer preferences. The brand offers a diverse range of clothing and accessories, blending quality craftsmanship with on-trend designs. Zara&#39;s collections cater to a broad audience, providing a seamless blend of elegance and modernity.</p>\r\n\r\n<p>With a keen eye on innovation and a dedication to sustainability, Zara continues to redefine the fashion landscape. From chic casual wear to sophisticated formal attire, Zara remains at the forefront of the fashion industry, making style accessible to all.&quot;</p>\r\n\r\n<p>Feel free to customize and modify this description according to your specific requirements or to better align with the unique aspects of Zara that you want to highlight.</p>',	NULL,	'/uploads/pages/17027386825949-zara.png',	NULL,	NULL,	NULL,	1,	7,	NULL,	'2023-12-16 15:11:01',	'2023-12-16 09:41:01'),
(2,	'Customer Solutions Designer',	'<p>3521331</p>',	NULL,	'/uploads/pages/17027405889424-screenshot-from-2023-10-09-21-43-33.png',	'Corporate Communications Designer',	'Molestias soluta consectetur aliquam doloribus consectetur rem.',	'quam fugit placeat',	1,	7,	NULL,	'2023-12-16 15:29:50',	'2023-12-16 09:59:50'),
(3,	'Regional Security Producer',	'<p>You asked, Font Awesome delivers with 41 shiny new icons in version 4.7. Want to request new icons?&nbsp;<a href=\"https://fontawesome.com/v4/community/#requesting-new-icons\">Here&#39;s how</a>.&nbsp;Need vectors or want to use on the desktop? Check the&nbsp;<a href=\"https://fontawesome.com/v4/cheatsheet/\">cheatsheet</a>.</p>',	NULL,	'/uploads/pages/17027438998532-screenshot-from-2023-10-28-12-47-08.png',	'Human Group Consultant',	'Quas sunt dolorem ea necessitatibus veniam optio quasi atque necessitatibus.',	'modi cumque sint',	1,	7,	NULL,	'2023-12-16 16:25:01',	'2023-12-16 10:55:01');

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `permissions` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `permissions` (`id`, `title`, `type`, `permissions`) VALUES
(1,	'Staff',	'staff',	'{\"listing\":\"1\",\"create\":\"1\",\"update\":\"1\",\"delete\":\"1\"}');

DROP TABLE IF EXISTS `product_categories`;
CREATE TABLE `product_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `product_categories_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `product_categories` (`id`, `parent_id`, `title`, `image`, `slug`, `status`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(7,	NULL,	'Threading',	'/uploads/categories/17079184798517-close-up-young-woman-getting-eyebrow-treatment-removebg-preview-1.png',	'threading',	1,	7,	NULL,	'2024-02-08 16:27:21',	'2024-03-10 07:10:07'),
(8,	NULL,	'Waxing',	'/uploads/categories/1707919366857-wepik-export-20240214140229ya7k.png',	'waxing',	1,	7,	NULL,	'2024-02-08 16:27:34',	'2024-03-10 07:10:07'),
(9,	NULL,	'Facials',	'/uploads/categories/17079196566021-wepik-export-20240214140724y4t6.png',	'facials',	1,	7,	NULL,	'2024-02-08 16:29:09',	'2024-03-10 07:10:07'),
(10,	NULL,	'Cleanups',	'/uploads/categories/17079191908982-wepik-export-20240214135903lbwc.png',	'cleanups',	1,	7,	NULL,	'2024-02-08 16:29:27',	'2024-03-10 07:10:07'),
(11,	NULL,	'Manicure',	'/uploads/categories/17079189304785-manicure-16238755371.png',	'manicure',	1,	7,	NULL,	'2024-02-08 16:29:55',	'2024-03-10 07:10:07'),
(12,	NULL,	'Pedicure',	'/uploads/categories/17079186006046-rectangle-1132.png',	'pedicure',	1,	7,	NULL,	'2024-02-08 16:30:14',	'2024-03-10 07:10:07'),
(13,	NULL,	'Bleach & Detan',	NULL,	'bleach-detan',	0,	7,	NULL,	'2024-02-08 16:31:15',	'2024-03-10 07:10:07'),
(14,	NULL,	'Bleach',	'/uploads/categories/17079185506576-rectangle-1131.png',	'bleach-MkO8V0',	1,	7,	NULL,	'2024-02-11 13:02:11',	'2024-03-22 16:39:48'),
(15,	NULL,	'De-tan',	'/uploads/categories/1707920179406-wepik-export-20240214135703zusm.png',	'de-tan',	1,	7,	NULL,	'2024-02-11 13:02:27',	'2024-03-10 07:10:07'),
(16,	NULL,	'Face wax',	NULL,	'face-wax',	0,	7,	NULL,	'2024-02-12 10:17:29',	'2024-03-10 07:10:07');

DROP TABLE IF EXISTS `product_category_relation`;
CREATE TABLE `product_category_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_category_relation_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_category_relation_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `product_category_relation` (`id`, `product_id`, `category_id`) VALUES
(272,	102,	12),
(273,	98,	11),
(285,	107,	9),
(420,	131,	8),
(421,	136,	8),
(422,	138,	8),
(423,	139,	8),
(425,	141,	8),
(426,	142,	8),
(427,	144,	8),
(428,	147,	8),
(430,	149,	8),
(431,	151,	8),
(432,	152,	8),
(433,	154,	8),
(434,	155,	8),
(435,	156,	8),
(436,	158,	8),
(438,	160,	8),
(439,	162,	8),
(440,	164,	8),
(442,	165,	8),
(443,	167,	8),
(444,	168,	8),
(445,	169,	8),
(447,	175,	9),
(448,	112,	9),
(449,	109,	9),
(451,	108,	9),
(452,	103,	9),
(453,	113,	10),
(454,	114,	10),
(455,	115,	10),
(456,	116,	10),
(457,	95,	11),
(458,	99,	12),
(460,	117,	14),
(463,	123,	15),
(464,	126,	15),
(467,	130,	15),
(469,	121,	14),
(470,	119,	14),
(471,	111,	9),
(475,	87,	7),
(476,	88,	7),
(477,	89,	7),
(478,	90,	7),
(479,	91,	7),
(480,	92,	7),
(481,	93,	7),
(482,	94,	7),
(484,	140,	8),
(485,	146,	8),
(486,	143,	8),
(487,	150,	8),
(488,	153,	8),
(489,	145,	8),
(490,	137,	8),
(491,	159,	8),
(492,	161,	8),
(493,	166,	8),
(494,	170,	8),
(495,	171,	8),
(496,	172,	8),
(497,	104,	9),
(498,	105,	9),
(499,	110,	9),
(500,	106,	9),
(501,	97,	11),
(504,	100,	12),
(505,	101,	12),
(512,	128,	15),
(513,	122,	14),
(514,	96,	11),
(515,	163,	8),
(516,	118,	14),
(517,	120,	14),
(518,	124,	15),
(519,	132,	8),
(520,	133,	8),
(521,	134,	8),
(522,	135,	8),
(523,	148,	8),
(524,	157,	8),
(525,	174,	11),
(527,	176,	12),
(528,	173,	12),
(529,	177,	11),
(530,	125,	15);

DROP TABLE IF EXISTS `product_reports`;
CREATE TABLE `product_reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `reasons` text NOT NULL,
  `ip` varchar(30) NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `product_reports_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_reports_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shop_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `title` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `image` text,
  `cropped_area` text,
  `postcode` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `duration_of_service` time DEFAULT NULL,
  `base_price` decimal(10,2) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `service_price` decimal(10,2) DEFAULT NULL,
  `sold` tinyint(1) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `shop_id` (`shop_id`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `products` (`id`, `shop_id`, `user_id`, `tags`, `title`, `slug`, `description`, `image`, `cropped_area`, `postcode`, `phonenumber`, `address`, `duration_of_service`, `base_price`, `price`, `sale_price`, `service_price`, `sold`, `status`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(87,	NULL,	NULL,	NULL,	'Eyebrows',	'eyebrows-R1mBAk',	'<ul>\r\n	<li>Achieving the desired shape of eyebrows using high-quality thread</li>\r\n	<li>Prevents ingrown hairs</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103280137123-eyebrows.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:05:00',	NULL,	33.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-08 16:38:19',	'2024-03-16 13:57:43'),
(88,	NULL,	NULL,	NULL,	'Upper lip',	'upper-lip-pk9MOk',	'<ul>\r\n	<li>Eliminates unwanted hair from the upper lip area</li>\r\n	<li>preventing ingrown hairs</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103280603276-upper-lip.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:05:00',	NULL,	33.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-08 16:41:45',	'2024-03-16 13:57:48'),
(89,	NULL,	NULL,	NULL,	'Forehead',	'forehead-Aab5NV',	'<ul>\r\n	<li>Eliminates unwanted hair from the forehead area</li>\r\n	<li>This method prevents ingrown hairs</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103284379498-forehead.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:05:00',	NULL,	33.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-08 16:52:24',	'2024-03-16 13:57:58'),
(90,	NULL,	NULL,	NULL,	'Lower Lip',	'lower-lip-5V8GGk',	'<ul>\r\n	<li>Eliminates unwanted hair from the lower lip area</li>\r\n	<li>It prevents ingrown hairs&nbsp;</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103285123531-lower-lip.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:05:00',	NULL,	33.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-08 16:56:25',	'2024-03-16 13:58:03'),
(91,	NULL,	NULL,	NULL,	'Chin',	'chin-p1A9X1',	'<ul>\r\n	<li>Eliminates unwanted hair from the chin area</li>\r\n	<li>It prevents ingrown hairs&nbsp;</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103285879924-chin.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:05:00',	NULL,	33.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-08 17:08:07',	'2024-03-16 13:58:07'),
(92,	NULL,	NULL,	NULL,	'Side Lock',	'side-lock-p1xmLk',	'<ul>\r\n	<li>Eliminates unwanted hair from the side lock&nbsp;&nbsp;</li>\r\n	<li>Prevents ingrown hairs</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103286275749-side-lock.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:10:00',	NULL,	66.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-08 17:10:49',	'2024-03-16 13:58:11'),
(93,	NULL,	NULL,	NULL,	'Full Face',	'full-face-LVe2Na',	'<ul>\r\n	<li>Eliminates unwanted hair from the full face</li>\r\n	<li>This method prevents ingrown hairs&nbsp;</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103286747712-full-face.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:30:00',	NULL,	198.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-08 17:14:06',	'2024-03-16 13:58:16'),
(94,	NULL,	NULL,	NULL,	'Neck',	'neck-m1ZbM1',	'<ul>\r\n	<li>Eliminates unwanted hair from the neck&nbsp;area</li>\r\n	<li>Prevents ingrown hairs</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103286092798-neck.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:10:00',	NULL,	66.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 08:42:05',	'2024-03-16 13:58:20'),
(95,	NULL,	NULL,	NULL,	'Rosy glam manicure',	'rosy-glam-manicure-gVKE81',	'<ul>\r\n	<li>Makes the skin soft and smooth</li>\r\n	<li>Contains properties that remove dead skin cells&nbsp;</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103322849739-rosy-glam-manicure.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:45:00',	225.00,	600.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 10:22:32',	'2024-03-13 17:48:07'),
(96,	NULL,	NULL,	NULL,	'Bubblegum manicure',	'bubblegum-manicure-q1p6vV',	'<ul>\r\n	<li>Cleanses, moisturizes, and smoothens skin on hands&nbsp;</li>\r\n	<li>Provides a cooling sensation to relieve stress and fatigue</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106106928508-bubblegum-manicure.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:50:00',	245.00,	655.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 10:57:34',	'2024-03-16 23:08:16'),
(97,	NULL,	NULL,	NULL,	'Chocolate manicure',	'chocolate-manicure-xV5Gm1',	'<ul>\r\n	<li>cleanse, exfoliate and restore the natural softness of the skin</li>\r\n	<li>Cocoa butter softens cracked heels and palms</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106100936360-chocolate-manicure.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:50:00',	225.00,	633.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 10:58:33',	'2024-03-16 22:58:17'),
(98,	NULL,	NULL,	NULL,	'De-tan delight manicure',	'de-tan-delight-manicure-A16Gdk',	'<ul>\r\n	<li>Immediately makes skin soft and supple</li>\r\n	<li>Effectively removes tan from hands</li>\r\n</ul>',	NULL,	NULL,	NULL,	NULL,	NULL,	'00:45:00',	200.00,	549.00,	NULL,	NULL,	0,	0,	7,	NULL,	'2024-02-09 11:00:04',	'2024-03-07 10:21:29'),
(99,	NULL,	NULL,	NULL,	'Rosy glam pedicure',	'rosy-glam-pedicure-9aDA51',	'<ul>\r\n	<li>Makes the skin soft and smooth</li>\r\n	<li>Contains properties that remove dead skin cells&nbsp;</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103323777172-bubble-gum-pedicure.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:50:00',	225.00,	633.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 11:02:07',	'2024-03-13 17:49:40'),
(100,	NULL,	NULL,	NULL,	'Bubble gum pedicure',	'bubble-gum-pedicure-pk9MPk',	'<ul>\r\n	<li>Removes tan from feet</li>\r\n	<li>Exfoliates dull layers of dead skin on legs and smooths skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106101873647-bubble-gum-pedicure-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:00:00',	245.00,	721.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 11:06:57',	'2024-03-16 22:59:55'),
(101,	NULL,	NULL,	NULL,	'Chocolate Pedicure',	'chocolate-pedicure-Aab5gV',	'<ul>\r\n	<li>Gets rid of foot odour</li>\r\n	<li>Cocoa butter softens cracked heels and palms</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106102301851-chocolate-pedicure-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:00:00',	225.00,	699.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 11:07:53',	'2024-03-16 23:00:36'),
(102,	NULL,	NULL,	NULL,	'De-tan Delight pedicure',	'de-tan-delight-pedicure-5V8Ggk',	'<ul>\r\n	<li>Immediately makes skin soft and supple</li>\r\n	<li>Effectively removes tan from feet</li>\r\n</ul>',	NULL,	NULL,	NULL,	NULL,	NULL,	'00:45:00',	200.00,	699.00,	NULL,	NULL,	0,	0,	7,	NULL,	'2024-02-09 11:09:40',	'2024-03-07 10:21:28'),
(103,	NULL,	NULL,	NULL,	'Lotus Radiant pearl facial',	'lotus-radiant-pearl-facial-p1A9z1',	'<ul>\r\n	<li>For all skin types</li>\r\n	<li>Suitable for sun damaged and sun tanned skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103319655179-lotus-radiant-pearl-facial.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:05:00',	245.00,	754.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 11:12:04',	'2024-03-13 17:42:47'),
(104,	NULL,	NULL,	NULL,	'Lotus Radiant diamond facial',	'lotus-radiant-diamond-facial-p1xmBk',	'<ul>\r\n	<li>Contains diamond dust to give your face a youthful appearance</li>\r\n	<li>Ideal for normal to dry skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106098674899-lotus-radiant-diamond-facial.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:05:00',	301.00,	815.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 11:13:35',	'2024-03-16 22:54:39'),
(105,	NULL,	NULL,	NULL,	'Lotus Radiant gold facial',	'lotus-radiant-gold-facial-LVe2za',	'<ul>\r\n	<li>For all skin types</li>\r\n	<li>Provides an instant golden glow</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106099126179-lotus-radiant-gold-facial-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:05:00',	285.00,	798.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 11:33:52',	'2024-03-16 22:55:16'),
(106,	NULL,	NULL,	NULL,	'Lotus Radiant platinum facial',	'lotus-radiant-platinum-facial-m1ZbG1',	'<ul>\r\n	<li>For all skin types</li>\r\n	<li>Targets wrinkles, fine lines, spots, and sagging skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106099848119-lotus-radiant-platinum-facial.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:05:00',	350.00,	869.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 11:36:26',	'2024-03-16 22:56:28'),
(107,	NULL,	NULL,	NULL,	'Cheryl\'s sensi glow facial',	'cheryls-sensi-glow-facial-gVKEJ1',	'<ul>\r\n	<li>Reduces irritation and rashes in sensitive skin</li>\r\n	<li>Instantly lightens and brightens skin by removing dead cells</li>\r\n</ul>',	NULL,	NULL,	NULL,	NULL,	NULL,	'01:10:00',	NULL,	899.00,	NULL,	NULL,	0,	0,	7,	NULL,	'2024-02-09 11:59:02',	'2024-03-06 06:36:38'),
(108,	NULL,	NULL,	NULL,	'Cheryl\'s Tan Removing facial',	'cheryls-tan-removing-facial-q1p6PV',	'<ul>\r\n	<li>Instantly removes tan for lighter, clear, and even-toned skin</li>\r\n	<li>Suitable for all skin types except sensitive, rosacea, and acne-prone skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103318911663-cheryls-tan-removing-facial.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:20:00',	345.00,	963.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 12:00:13',	'2024-03-13 17:41:33'),
(109,	NULL,	NULL,	NULL,	'Cheryl\'s glovite facial',	'cheryls-glovite-facial-xV5Gz1',	'<ul>\r\n	<li>Removes dead cells for radiant, glowing skin</li>\r\n	<li>Suitable for all skin types except sensitive, rosacea, and acne-prone skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103318004650-cheryls-glovite-facial.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:20:00',	300.00,	913.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 12:02:38',	'2024-03-13 17:40:02'),
(110,	NULL,	NULL,	NULL,	'O3+Bridal Glow facial',	'o3bridal-glow-facial-A16G2k',	'<ul>\r\n	<li>Gently repairs and brightens skin</li>\r\n	<li>Suitable for all skin types</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103318298696-o3bridal-glow-facial.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:40:00',	885.00,	2129.00,	NULL,	10.00,	0,	1,	7,	NULL,	'2024-02-09 12:04:35',	'2024-03-16 22:55:45'),
(111,	NULL,	NULL,	NULL,	'O3+ feel youthful facial',	'o3-feel-youthful-facial-9aDAn1',	'<ul>\r\n	<li>Boost collagen, improve skin elasticity for a youthful look.</li>\r\n	<li>Ideal for dull, ageing skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103336633215-lotus-radiant-gold-facial.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:20:00',	600.00,	1595.00,	NULL,	10.00,	0,	1,	7,	NULL,	'2024-02-09 12:06:01',	'2024-03-13 18:05:31'),
(112,	NULL,	NULL,	NULL,	'O3+shine & glow facial',	'o3shine-glow-facial-6kq7ba',	'<ul>\r\n	<li>Fades acne marks and dark spots</li>\r\n	<li>Perfect for dry skin that needs a boost of radiance</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103317509227-glow-facial-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:20:00',	650.00,	1650.00,	NULL,	10.00,	0,	1,	7,	NULL,	'2024-02-09 12:07:22',	'2024-03-13 18:05:31'),
(113,	NULL,	NULL,	NULL,	'Aroma Treasure orange cleanup',	'aroma-treasure-orange-cleanup-eajm9V',	'<ul>\r\n	<li>Hydrating, free from petrochemicals.</li>\r\n	<li>Suitable for all skin types.</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/1710332040831-dt-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:30:00',	140.00,	407.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 12:13:25',	'2024-03-13 17:44:05'),
(114,	NULL,	NULL,	NULL,	'Papaya nourishing cleanup',	'papaya-nourishing-cleanup-MkO3Kk',	'<ul>\r\n	<li>Hydrates, adds natural luminosity</li>\r\n	<li>Reduces acne, blemishes, smoothens texture</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103320925341-papaya-nourishing-cleanup.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:45:00',	102.00,	464.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 12:14:50',	'2024-03-13 17:44:53'),
(115,	NULL,	NULL,	NULL,	'O3+ Tan Clear Cleanup',	'o3-tan-clear-cleanup-KVgAK1',	'<ul>\r\n	<li>Remove tan, control face oil</li>\r\n	<li>Suitable for acne-prone skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103321418529-o3-tan-clear-cleanup.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:45:00',	500.00,	902.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 12:19:11',	'2024-03-13 17:45:43'),
(116,	NULL,	NULL,	NULL,	'Fruit Cleanup',	'fruit-cleanup-9kY9bk',	'<ul>\r\n	<li>For skin cleansing and brightening</li>\r\n	<li>Suitable for all skin types</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103321669278-fruit-cleanup.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:45:00',	185.00,	556.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-09 12:20:05',	'2024-03-13 17:46:12'),
(117,	NULL,	NULL,	NULL,	'Face and Neck',	'face-and-neck-o13m8V',	'<ul>\r\n	<li>Helps in lightening the color of hair</li>\r\n	<li>Gives naturally radiant skin instantly</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103325339543-face-and-neck.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	95.00,	325.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 13:11:22',	'2024-03-13 17:52:16'),
(118,	NULL,	NULL,	NULL,	'Full Arms',	'full-arms-ZkWLjV',	'<ul>\r\n	<li>Helps in lightening the color of hair</li>\r\n	<li>Gives naturally radiant skin instantly</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106109179711-full-arms-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:40:00',	125.00,	457.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 13:13:29',	'2024-03-16 23:12:05'),
(119,	NULL,	NULL,	NULL,	'Full Legs',	'full-legs-AaLEd1',	'<ul>\r\n	<li>Helps in lightening the color of hair</li>\r\n	<li>Gives naturally radiant skin instantly</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103335073824-full-legs.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:40:00',	149.00,	483.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 13:14:24',	'2024-03-13 18:08:30'),
(120,	NULL,	NULL,	NULL,	'Chest',	'chest-5VBbjV',	'<ul>\r\n	<li>Helps in lightening the color of hair</li>\r\n	<li>Gives naturally radiant skin instantly</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106109704003-chest-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:30:00',	169.00,	439.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 13:15:56',	'2024-03-16 23:12:53'),
(121,	NULL,	NULL,	NULL,	'Back',	'back-Xan62a',	'<ul>\r\n	<li>Helps in lightening the color of hair</li>\r\n	<li>Gives naturally radiant skin instantly</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103334733164-back-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:50:00',	125.00,	523.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 13:16:51',	'2024-03-13 18:07:55'),
(122,	NULL,	NULL,	NULL,	'Full Body',	'full-body-xaMLGV',	'<ul>\r\n	<li>Removes dark spots, uneven tone, dullness, and dead cells</li>\r\n	<li>Excludes face and neck</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106106305659-full-body-2.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:10:00',	500.00,	1067.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 13:24:03',	'2024-03-16 23:07:14'),
(123,	NULL,	NULL,	NULL,	'Face and Neck',	'face-and-neck-JVoDza',	'<ul>\r\n	<li>Skin lightening and brightening products</li>\r\n	<li>Evens skin tone and reduces tanning effect</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103327541053-face-and-neck-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	99.00,	329.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 13:25:35',	'2024-03-13 17:55:57'),
(124,	NULL,	NULL,	NULL,	'Full Arms',	'full-arms-DVzlE1',	'<ul>\r\n	<li>Skin lightening and brightening products</li>\r\n	<li>Evens skin tone and reduces tanning effect</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106110128275-full-arms-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:30:00',	189.00,	461.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 13:44:50',	'2024-03-16 23:13:35'),
(125,	NULL,	NULL,	NULL,	'Full Legs',	'full-legs-6a2n0a',	'<ul>\r\n	<li>Skin lightening and brightening products</li>\r\n	<li>Evens skin tone and reduces tanning effect</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17110909538841-feets-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:30:00',	150.00,	418.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 13:45:45',	'2024-03-22 12:32:36'),
(126,	NULL,	NULL,	NULL,	'Chest',	'chest-n1rO7k',	'<ul>\r\n	<li>Skin lightening and brightening products</li>\r\n	<li>Evens skin tone and reduces tanning effect</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103330753769-chest.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:30:00',	125.00,	391.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 13:46:44',	'2024-03-13 18:01:17'),
(128,	NULL,	NULL,	NULL,	'Back',	'back-M1dEpk',	'<ul>\r\n	<li>Skin lightening and brightening products</li>\r\n	<li>Evens skin tone and reduces tanning effect</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106105805448-back-2.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:30:00',	99.00,	362.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 13:53:41',	'2024-03-16 23:06:22'),
(130,	NULL,	NULL,	NULL,	'Full Body',	'full-body-Ok779k',	'<ul>\r\n	<li>Skin lightening and brightening products</li>\r\n	<li>&nbsp;Face &amp; Neck not included</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103331802708-full-body-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:00:00',	498.00,	999.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 14:02:36',	'2024-03-13 18:03:39'),
(131,	NULL,	NULL,	NULL,	'Full Body Wax | Honey',	'full-body-wax-honey-MaP3PV',	'<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103288097910-full-body-wax-honey.png\"]',	NULL,	NULL,	NULL,	NULL,	'02:00:00',	200.00,	1067.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 16:59:18',	'2024-03-13 16:51:31'),
(132,	NULL,	NULL,	NULL,	'Full Body Wax | Chocolate',	'full-body-wax-chocolate-laG0y1',	'<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Oil-based wax for tan removal, exfoliation, and moisturization</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106111294016-full-body-wax-chocolate.png\"]',	NULL,	NULL,	NULL,	NULL,	'02:00:00',	500.00,	1397.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-11 17:10:31',	'2024-03-16 23:15:32'),
(133,	NULL,	NULL,	NULL,	'Full Body Wax | Chocolate roll-on',	'full-body-wax-chocolate-roll-on-lk07n1',	'<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Low-heat application for gentle treatment</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106111983497-full-body-wax-chocolate-roll-on-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'02:00:00',	885.00,	1821.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 07:26:24',	'2024-03-16 23:16:41'),
(134,	NULL,	NULL,	NULL,	'Full Body Wax | Rica - roll-on',	'full-body-wax-rica-roll-on-KVX37k',	'<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>Especially recommended for sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106112481269-full-body-wax-rica-roll-on.png\"]',	NULL,	NULL,	NULL,	NULL,	'02:00:00',	999.00,	1946.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 07:43:33',	'2024-03-16 23:17:32'),
(135,	NULL,	NULL,	NULL,	'Full Body Wax | Rica',	'full-body-wax-rica-2kvzzk',	'<ul>\r\n	<li>Full body waxing doesn&#39;t cover bikini waxing</li>\r\n	<li>&nbsp;Oil-based wax for tan removal and delayed hair growth&nbsp;</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106112869281-full-body-wax-rica-roll-on.png\"]',	NULL,	NULL,	NULL,	NULL,	'02:00:00',	813.00,	1963.59,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 07:45:48',	'2024-03-19 10:41:06'),
(136,	NULL,	NULL,	NULL,	'Half leg | Honey',	'half-leg-honey-BVRZ0V',	'<ul>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n	<li>Not suitable for sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103290897487-half-leg-honey.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:12:00',	109.00,	254.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 07:47:32',	'2024-03-13 16:54:59'),
(137,	NULL,	NULL,	NULL,	'Half leg | Chocolate',	'half-leg-chocolate-oaJg31',	'<ul>\r\n	<li>Oil-based wax for tan removal, exfoliation, and moisturization</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106094611149-half-leg-chocolate.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:12:00',	149.00,	298.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 07:48:59',	'2024-03-16 22:47:45'),
(138,	NULL,	NULL,	NULL,	'Half leg | Rica',	'half-leg-rica-j1NLYV',	'<ul>\r\n	<li>&nbsp;Oil-based wax for tan removal and delayed hair growth&nbsp;</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103291815750-half-leg-rica.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:12:00',	200.00,	354.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 07:50:25',	'2024-03-13 16:56:24'),
(139,	NULL,	NULL,	NULL,	'Full leg | Honey',	'full-leg-honey-PalLwa',	'<ul>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n	<li>Not suitable for sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103292515435-full-leg-honey.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:28:00',	108.00,	359.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 07:51:51',	'2024-03-13 16:57:35'),
(140,	NULL,	NULL,	NULL,	'Full legs | Chocolate roll-on',	'full-legs-chocolate-roll-on-zkQg7a',	'<ul>\r\n	<li>Low-heat application for gentle treatment</li>\r\n	<li>suitable for all skin type</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106090057874-full-legs-chocolate-roll-on-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:28:00',	295.00,	564.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 07:52:50',	'2024-03-16 22:40:08'),
(141,	NULL,	NULL,	NULL,	'Full legs | Rica roll-on',	'full-legs-rica-roll-on-6VED7k',	'<ul>\r\n	<li>Bikini or bikini line waxing is not included</li>\r\n	<li>Especially recommended for sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103293535852-full-legs-rica-roll-on.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:28:00',	300.00,	570.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 07:54:09',	'2024-03-13 16:59:17'),
(142,	NULL,	NULL,	NULL,	'Full leg | Rica',	'full-leg-rica-2ayrG1',	'<ul>\r\n	<li>Bikini or bikini line waxing is not included</li>\r\n	<li>Suitable for all skin types, especially sensitive skin\r\n	<p style=\"line-height:1.38; margin-left:48px; margin-top:16px; margin-bottom:16px\">&nbsp;</p>\r\n	</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103293962123-full-leg-rica.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:30:00',	264.00,	543.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 07:55:48',	'2024-03-13 17:01:17'),
(143,	NULL,	NULL,	NULL,	'Full legs | Chocolate',	'full-legs-chocolate-R1movV',	'<ul>\r\n	<li>Bikini or bikini line waxing is not included.</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106092134687-full-legs-chocolate.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:30:00',	200.00,	473.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 07:57:25',	'2024-03-16 22:43:36'),
(144,	NULL,	NULL,	NULL,	'Full arms | Honey',	'full-arms-honey-pk97Pa',	'<ul>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n	<li>Not suitable for sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103295522098-full-arms-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	109.00,	340.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 07:58:43',	'2024-03-13 17:02:45'),
(145,	NULL,	NULL,	NULL,	'Full arms | Chocolate',	'full-arms-chocolate-Aab2ga',	'<ul>\r\n	<li>Oil-based wax for tan removal, exfoliation, and moisturization</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106094097937-full-arms-chocolate.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	129.00,	362.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:00:07',	'2024-03-16 22:46:52'),
(146,	NULL,	NULL,	NULL,	'Full arms | Chocolate Roll-on',	'full-arms-chocolate-roll-on-5V8jg1',	'<ul>\r\n	<li>Minimizes redness and rashes</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106091736005-full-arms-chocolate-roll-on.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	295.00,	545.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:01:21',	'2024-03-16 22:42:58'),
(147,	NULL,	NULL,	NULL,	'Full arms | Rica',	'full-arms-rica-p1AXza',	'<ul>\r\n	<li>Oil-based wax for tan removal and delayed hair growth&nbsp;</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103298033871-full-arms-rica.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	230.00,	473.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:02:16',	'2024-03-13 17:06:47'),
(148,	NULL,	NULL,	NULL,	'Full arms | Rica roll-on',	'full-arms-rica-roll-on-p1x5Bk',	'<ul>\r\n	<li>&nbsp;Premium quality wax,low-heat application</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106113353074-full-arms-chocolate-roll-on-2.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	300.00,	550.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:03:52',	'2024-03-16 23:18:58'),
(149,	NULL,	NULL,	NULL,	'Half arms | Honey',	'half-arms-honey-LVebza',	'<ul>\r\n	<li>It covers the area from the hand to the elbow</li>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103298586448-half-arms-honey.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:15:00',	69.00,	230.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:05:11',	'2024-03-13 17:13:29'),
(150,	NULL,	NULL,	NULL,	'Half arms | Chocolate',	'half-arms-chocolate-m1Z3Gk',	'<ul>\r\n	<li>Oil-based wax for tan removal, exfoliation, and moisturization</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106092722943-half-arms-chocolate.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:15:00',	109.00,	274.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:31:45',	'2024-03-16 22:44:37'),
(151,	NULL,	NULL,	NULL,	'Half arms | Rica',	'half-arms-rica-gVK5J1',	'<ul>\r\n	<li>Oil-based wax for tan removal and delayed hair growth</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103302454682-half-arms-rica.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:15:00',	159.00,	329.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:33:28',	'2024-03-13 17:14:10'),
(152,	NULL,	NULL,	NULL,	'Underarms | Honey',	'underarms-honey-q1pNPV',	'<ul>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n	<li>Not suitable for sensitive skin</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>',	'[\"\\/uploads\\/products\\/17103303294206-half-arms-honey-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:08:00',	1.00,	109.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:35:02',	'2024-03-13 17:15:32'),
(153,	NULL,	NULL,	NULL,	'Underarms | Chocolate',	'underarms-chocolate-xV53z1',	'<ul>\r\n	<li>This wax with oil helps remove tan and slows down hair growth</li>\r\n	<li>It&#39;s suitable for all skin types</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/1710609325551-underarms-chocolate.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:08:00',	12.00,	121.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:36:53',	'2024-03-16 22:45:33'),
(154,	NULL,	NULL,	NULL,	'Underarms | Rica',	'underarms-rica-A1672k',	'<ul>\r\n	<li>Peel-off wax will be used for underarms</li>\r\n	<li>This wax with oil helps remove tan and slows down hair growth</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103303835548-underarms-rica.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:08:00',	32.00,	143.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:37:52',	'2024-03-13 17:16:26'),
(155,	NULL,	NULL,	NULL,	'Back | Honey',	'back-honey-9aD6nk',	'<ul>\r\n	<li>Smooth hair removal with sugar-based wax</li>\r\n	<li>Not suitable for sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103304943891-back-honey.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:30:00',	100.00,	363.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:40:04',	'2024-03-13 17:18:18'),
(156,	NULL,	NULL,	NULL,	'Back | Rica',	'back-rica-6kqzbV',	'<ul>\r\n	<li>This wax has oil in it, which helps remove tan and slows down hair growth</li>\r\n	<li>Good for all skin types, especially if your skin is sensitive</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103305519810-back-rica.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:30:00',	200.00,	473.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:41:43',	'2024-03-13 17:19:13'),
(157,	NULL,	NULL,	NULL,	'Back | Chocolate roll-on',	'back-chocolate-roll-on-eajZ9a',	'<ul>\r\n	<li>Low-heat application for gentle treatment</li>\r\n	<li>Suitable for all skin types</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106114275486-back-chocolate-roll-on-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	295.00,	545.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:42:57',	'2024-03-16 23:20:29'),
(158,	NULL,	NULL,	NULL,	'Back | Rica roll-on',	'back-rica-roll-on-MkOyKa',	'<ul>\r\n	<li>Covers area from shoulder to pelvis</li>\r\n	<li>Especially recommended for sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103306542685-back-chocolate-roll-on.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	325.00,	578.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:44:10',	'2024-03-13 17:20:56'),
(159,	NULL,	NULL,	NULL,	'Back | Chocolate',	'back-chocolate-KVgQK1',	'<ul>\r\n	<li>Covers area from shoulder to pelvis</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106095419133-back-chocolate.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:30:00',	200.00,	473.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:45:29',	'2024-03-16 22:49:04'),
(160,	NULL,	NULL,	NULL,	'Stomach | Honey',	'stomach-honey-9kYrbV',	'<ul>\r\n	<li>Sugar-based wax for smooth hair removal</li>\r\n	<li>Not suitable for sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103307068275-stomach-honey.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	99.00,	329.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:46:49',	'2024-03-13 17:24:10'),
(161,	NULL,	NULL,	NULL,	'Stomach | Chocolate',	'stomach-chocolate-o13E8V',	'<ul>\r\n	<li>Oil-based wax for tan removal, exfoliation, and moisturization</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106095765010-stomac-stomach-chocolate-roll-onh-rica.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	120.00,	352.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:47:38',	'2024-03-16 22:49:39'),
(162,	NULL,	NULL,	NULL,	'Stomach | Rica',	'stomach-rica-ZkWMja',	'<ul>\r\n	<li>&nbsp;Oil-based wax for tan removal and delayed hair growth&nbsp;</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103308828693-stomach-rica.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	139.00,	373.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:48:59',	'2024-03-13 17:24:44'),
(163,	NULL,	NULL,	NULL,	'Stomach | Chocolate roll-on',	'stomach-chocolate-roll-on-AaL3dV',	'<ul>\r\n	<li>Minimizes redness and rashes</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106107926965-stomac-stomach-chocolate-roll-onh-rica-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:20:00',	295.00,	512.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:50:15',	'2024-03-16 23:09:56'),
(164,	NULL,	NULL,	NULL,	'Stomach | Rica roll-on',	'stomach-rica-roll-on-5VBgja',	'<ul>\r\n	<li>&nbsp;Premium quality wax,low-heat application</li>\r\n	<li>Suitable for all skin types, especially sensitive skin</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103309326768-stomach-rica-roll-on.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:20:00',	300.00,	517.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 08:52:10',	'2024-03-13 17:25:34'),
(165,	NULL,	NULL,	NULL,	'Upper Lip',	'upper-lip-Xang21',	'<ul>\r\n	<li>Uses Rica Brazilian (Peel-Off) Wax</li>\r\n	<li>Removes all unwanted upper lip&nbsp;hair</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103309615812-upper-lip-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:05:00',	19.00,	109.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 10:27:23',	'2024-03-13 17:28:46'),
(166,	NULL,	NULL,	NULL,	'Lower Lip',	'lower-lip-xaMNG1',	'<ul>\r\n	<li>Uses Rica Brazilian (Peel-Off) Wax</li>\r\n	<li>Removes all unwanted lower lip&nbsp;hair</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106096167002-lower-lip-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:05:00',	10.00,	99.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 10:28:12',	'2024-03-16 22:50:19'),
(167,	NULL,	NULL,	NULL,	'Chin',	'chin-JVoNzk',	'<ul>\r\n	<li>Uses Rica Brazilian (Peel-Off) Wax</li>\r\n	<li>Removes all unwanted chin&nbsp;hair</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103311547968-chin-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:05:00',	32.00,	123.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 10:29:13',	'2024-03-13 17:29:17'),
(168,	NULL,	NULL,	NULL,	'Nose',	'nose-DVzwEa',	'<ul>\r\n	<li>Uses Rica Brazilian (Peel-Off) Wax</li>\r\n	<li>Removes all unwanted nose&nbsp;hair</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103311977015-nose.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:05:00',	1.00,	89.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 10:30:17',	'2024-03-13 17:32:32'),
(169,	NULL,	NULL,	NULL,	'Sidelock',	'sidelock-6a2m0V',	'<ul>\r\n	<li>Uses Rica Brazilian (Peel-Off) Wax</li>\r\n	<li>Removes all unwanted side lock&nbsp;hair</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103313795026-sidelock.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:10:00',	62.00,	189.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 10:31:27',	'2024-03-13 17:33:02'),
(170,	NULL,	NULL,	NULL,	'Forehead',	'forehead-n1rz71',	'<ul>\r\n	<li>Uses Rica Brazilian (Peel-Off) Wax</li>\r\n	<li>Removes all unwanted forehead&nbsp;hair</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106096529159-forehead-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:05:00',	32.00,	123.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 10:32:39',	'2024-03-16 22:50:57'),
(171,	NULL,	NULL,	NULL,	'Neck',	'neck-3VwzDk',	'<ul>\r\n	<li>Uses Rica Brazilian (Peel-Off) Wax</li>\r\n	<li>Removes all unwanted neck&nbsp;hair</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106097947914-neck-3.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:10:00',	115.00,	248.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 10:33:32',	'2024-03-16 22:53:18'),
(172,	NULL,	NULL,	NULL,	'Full Face',	'full-face-M1d9pk',	'<ul>\r\n	<li>Uses Rica Brazilian (Peel-Off) Wax</li>\r\n	<li>Removes all unwanted facial hair</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106098269143-full-face-2.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:25:00',	180.00,	418.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-12 10:34:23',	'2024-03-16 22:53:50'),
(173,	NULL,	NULL,	NULL,	'Cut, file & polish',	'cut-file-polish-Dk4Xmk',	'<ul>\r\n	<li>Our cut and file service includes basic nail grooming and nail polish application.</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106102882502-cut-file-polish.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:20:00',	NULL,	132.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-15 12:31:06',	'2024-03-17 11:54:13'),
(174,	NULL,	NULL,	NULL,	'Change of polish',	'change-of-polish-Ok7L9V',	'<ul>\r\n	<li>Refresh your look with our polish change service.</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106101236276-rosy-glam-manicure-1.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:10:00',	NULL,	66.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-02-15 12:33:50',	'2024-03-17 11:50:48'),
(175,	NULL,	NULL,	NULL,	'Cheryl\'s OxyBlast Facial',	'cheryls-oxyblast-facial-MaPgPV',	'<ul>\r\n	<li>Energises and hydrates skin for a radiant glow</li>\r\n	<li>It&#39;s suitable for all skin type</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17103317129171-cheryls-oxyblast-facial.png\"]',	NULL,	NULL,	NULL,	NULL,	'01:20:00',	315.00,	930.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-03-06 12:35:49',	'2024-03-13 17:38:35'),
(176,	NULL,	NULL,	NULL,	'Change of Polish',	'change-of-polish-laGqyk',	'<ul>\r\n	<li>Refresh your look with our polish change service.</li>\r\n</ul>',	'[\"\\/uploads\\/products\\/17106565995004-change-of-polish.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:10:00',	NULL,	66.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-03-17 11:52:40',	'2024-03-17 11:53:25'),
(177,	NULL,	NULL,	NULL,	'Cut, File & Polish',	'cut-file-polish-lk0enV',	'<ul>\r\n	<li>Our cut and file service includes basic nail grooming and nail polish application.</li>\r\n</ul>',	'[\"/uploads/products/17106568248975-rosy-glam-manicure.png\",\"/uploads/products/17106568089517-rosy-glam-manicure.png\"]',	NULL,	NULL,	NULL,	NULL,	'00:20:00',	NULL,	132.00,	NULL,	NULL,	0,	1,	7,	NULL,	'2024-03-17 11:57:16',	'2024-03-17 06:27:16');

DROP TABLE IF EXISTS `search_keywords`;
CREATE TABLE `search_keywords` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `keywords` varchar(255) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `search_keywords_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `search_sugessions`;
CREATE TABLE `search_sugessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `search_sugessions_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `settings` (`id`, `name`, `value`) VALUES
(1,	'company_name',	'Admin'),
(2,	'company_address',	'Admin'),
(3,	'pagination_method',	'scroll'),
(4,	'admin_second_auth_factor',	''),
(5,	'admin_notification_email',	'admin@admin.com'),
(6,	'currency_code',	'INR'),
(7,	'currency_symbol',	'₹'),
(8,	'date_format',	'd-m-Y'),
(9,	'time_format',	'h:iA'),
(10,	'tax_percentage',	'10'),
(11,	'order_prefix',	'2001'),
(12,	'from_email',	'noreply@saloon.com'),
(13,	'email_method',	'smtp'),
(14,	'max_orders_per_hour',	'2'),
(15,	'duration',	'[\"09:30\", \"18:00\"]'),
(16,	'cgst',	'9'),
(17,	'sgst',	'9'),
(18,	'igst',	'18'),
(19,	'shaguna_margin',	'1.2'),
(20,	'travel_charges',	'50'),
(21,	'partner_margin',	'4.8'),
(22,	'platform_charges',	'0'),
(23,	'buffer_margin_percent',	'10'),
(24,	'buffer_margin_amount',	'0'),
(25,	'shaguna_margin_percent',	'20');

DROP TABLE IF EXISTS `shops`;
CREATE TABLE `shops` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `bio` text,
  `website` text,
  `social_links` text,
  `image` varchar(255) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `lat` varchar(50) DEFAULT NULL,
  `lng` varchar(50) DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `shops_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  CONSTRAINT `shops_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` bigint NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aadhar_card_number` bigint DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `created_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `staff` (`id`, `first_name`, `last_name`, `phone_number`, `email`, `aadhar_card_number`, `image`, `status`, `created_by`, `deleted_at`, `created`, `modified`) VALUES
(1,	'Graciela',	'Aufderhar',	5423333333,	'your.email+fakedata22046@gmail.com',	1273456789012,	'/uploads/brands/17056795676115-screenshot-from-2024-01-10-00-32-27.png',	1,	7,	'2024-03-01 15:13:01',	'2024-01-19 15:54:40',	'2024-01-19 10:24:40'),
(2,	'Myles',	'Zulauf',	1971231231,	'your.email+fakedata88731@gmail.com',	494123123123,	'/uploads/brands/17056795676115-screenshot-from-2024-01-10-00-32-27.png',	1,	7,	'2024-03-01 15:12:56',	'2024-01-20 01:46:46',	'2024-01-19 20:16:46'),
(3,	'Manisha',	'Kanwar',	7018822593,	'manisha90chandel@gmail.com',	263355571779,	NULL,	1,	7,	NULL,	'2024-03-01 15:12:47',	'2024-03-01 15:12:47'),
(4,	'Neha',	'.',	9779996291,	'neha123@gmail.com',	863515348371,	'/uploads/brands/1709383839179-whatsapp-image-2024-03-02-at-6.jpg',	1,	7,	NULL,	'2024-03-02 18:24:07',	'2024-03-02 18:24:07'),
(5,	'Suman',	'Kaur',	7889409948,	'gazleenkour@gmail.com',	507169846069,	NULL,	1,	7,	NULL,	'2024-03-06 10:46:13',	'2024-03-06 10:46:13'),
(6,	'shobhana',	'.',	9988990950,	'shobhanav786@gmail.com',	296033557159,	NULL,	1,	7,	NULL,	'2024-03-10 20:04:04',	'2024-03-10 20:04:04'),
(7,	'Gomti',	'Verma',	7901751615,	'gomtiverma087@gmail.com',	788494991429,	NULL,	1,	7,	NULL,	'2024-03-10 20:05:51',	'2024-03-10 20:05:51'),
(8,	'Divjot',	'Kaur',	6239285811,	'divjotrajpal13@gmail.com',	219944689925,	'/uploads/brands/17101474397437-divjot-staff-ldh.jpg',	1,	7,	NULL,	'2024-03-11 14:29:43',	'2024-03-11 14:29:43'),
(9,	'sd',	NULL,	2222,	NULL,	NULL,	NULL,	1,	7,	'2024-03-23 20:31:22',	'2024-03-23 20:31:18',	'2024-03-23 20:31:18');

DROP TABLE IF EXISTS `staff_documents`;
CREATE TABLE `staff_documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `staff_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `file` text,
  `slug` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `created_by` int DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `staff_documents_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_documents_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `staff_documents` (`id`, `staff_id`, `title`, `file`, `slug`, `created`, `created_by`, `modified`) VALUES
(11,	2,	'njkjjk',	'[\"/uploads/staff-documents/17061526554871-zara.png\",\"/uploads/staff-documents/17061526509131-hm-logo.png\"]',	NULL,	'2024-01-25 03:17:37',	7,	'2024-01-24 21:47:37'),
(12,	2,	'iugyyu',	'[\"/uploads/staff-documents/17070249119068-zara.png\",\"/uploads/staff-documents/17070248966657-hm-logo.png\"]',	NULL,	'2024-02-04 05:35:13',	7,	'2024-02-04 00:05:13');

DROP TABLE IF EXISTS `states`;
CREATE TABLE `states` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `state_code` varchar(50) NOT NULL,
  `country_id` int NOT NULL,
  `status` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `dob` date DEFAULT NULL,
  `address` text,
  `image` text,
  `bio` longtext,
  `last_login` datetime DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_expiry` datetime DEFAULT NULL,
  `otp` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `seller` tinyint(1) NOT NULL DEFAULT '0',
  `facebook_id` varchar(200) DEFAULT NULL,
  `google_id` varchar(200) DEFAULT NULL,
  `google_email` varchar(200) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phonenumber`, `dob`, `address`, `image`, `bio`, `last_login`, `token`, `token_expiry`, `otp`, `gender`, `email`, `password`, `status`, `verified_at`, `seller`, `facebook_id`, `google_id`, `google_email`, `deleted_at`, `created_by`, `created`, `modified`) VALUES
(1,	'Divya',	'Chaudhary',	'8360445579',	'2023-12-15',	'HOUSE NO 9-F KITCHLU NAGAR NEAR RAM SHARNAM',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'female',	'chaudharydivya125@gmail.com',	'$2y$10$frqo8wY/h/iHj5Mt7ZAojehFnkhecYkJoXGWDi8gjVtY8zUzoU7fa',	1,	'2023-12-16 08:26:47',	1,	NULL,	NULL,	NULL,	NULL,	7,	'2023-12-16 08:26:47',	'2023-12-16 02:56:47'),
(2,	'Kiran',	'Kumari',	'08360445579',	'2001-11-15',	'HOUSE NO 9F KITCHLU NAGAR NEAR RAM',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'female',	'chaudharykiran125@gmail.com',	'$2y$10$BAZmu5zyp9.S6XwmHt0j6.YYYdwT2BJDV0rHdBp4ebPt83S6lTaKy',	1,	'2023-12-25 07:15:15',	1,	NULL,	NULL,	NULL,	NULL,	7,	'2023-12-25 07:15:15',	'2023-12-25 01:45:15'),
(3,	'Himani',	'Mehta',	'8360445574',	'1999-02-15',	'HOUSE NO 9-F KITCHLU NAGAR NEAR RAM SHARNAM',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'female',	'chaudharsfserfydivya125@gmail.com',	'$2y$10$eVNGd1WdnfEsDGk6kSvAzu7iC8NR1TnBiG5qSL8OU94NXaS4uPRPy',	0,	'2024-01-07 16:52:04',	1,	NULL,	NULL,	NULL,	NULL,	7,	'2024-01-07 16:52:04',	'2024-01-07 11:22:04'),
(4,	'dsdss',	NULL,	'9988225144',	NULL,	NULL,	NULL,	NULL,	NULL,	'81Rwf6bpMz0Q90x29NXxyxS6GnFUUO5trDcxNPPaP8mqhPplPDCnJtUQqFJYaPo4',	'2024-04-20 00:00:00',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(5,	'Shikha',	NULL,	'734099509',	NULL,	NULL,	NULL,	NULL,	NULL,	'Z60EwzSo9JMCFomzlFKbDkyf28VPu77dS7jBnmF3jEp67zu6DpPJHI4fxL6w1elG',	NULL,	'1749',	NULL,	NULL,	NULL,	1,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(6,	'DDD',	NULL,	'9988225144',	NULL,	NULL,	NULL,	NULL,	NULL,	'xJTbTC7y9oUeL4YUQzxi4zHXhK0dtBkqHJhpgY7f4GbI27BZQIKhNdM0FlGZiRod',	NULL,	'6922',	NULL,	NULL,	NULL,	1,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(7,	'Shikha',	NULL,	'7340990509',	NULL,	NULL,	NULL,	NULL,	NULL,	'FKJPv3CXRemfaMmEGYcliMwaiN4Df5A0avQ5JqW8g1P1HqlzJtAYKCB9fjNj2aRk',	NULL,	'7304',	NULL,	NULL,	NULL,	1,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(8,	'Amita',	NULL,	'9501583011',	NULL,	NULL,	NULL,	NULL,	NULL,	'iaTSIX3gj7uQPLoSD4SUJ4yUnpCJMVr7UfRP9Y1hSozHE5aZldCDAcm9BVAwOfKX',	'2024-04-20 00:00:00',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(9,	'Raja Karan',	NULL,	'8198815002',	NULL,	NULL,	NULL,	NULL,	NULL,	'ZjmZZyaGZ1ZksTgr28tPfuvYnI5NqHJy4vlYNCcT8dbbSV30t3UomuIHZP63xbx0',	'2024-04-16 00:00:00',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(10,	'radha',	NULL,	'7348987407',	NULL,	NULL,	NULL,	NULL,	NULL,	'u8zyTTXvxzibp1NMqKh0pUD1lhgQscKBzmL5NZc5ibjY8ydkWCKQHGPezMNbfXDh',	'2024-04-26 00:00:00',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(11,	'Ritish',	NULL,	'9988225143',	NULL,	NULL,	NULL,	NULL,	NULL,	'HK5vrjrnpHXehWTFaobPBGkVokr1rj7yyrPbk3sYiIkFAnZGJpAp1vgWauWsIlk0',	NULL,	'8183',	NULL,	NULL,	NULL,	1,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(12,	'Tamanna Sharma',	NULL,	'7710516464',	NULL,	NULL,	NULL,	NULL,	NULL,	'EDOe4IsE9dywFkpssh2pJBsyvw2p7WTRYTeyJ3zkIQkk518AWSx9OmZGWNrzAKIP',	'2024-03-29 00:00:00',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(13,	'Ghh',	NULL,	'8542878841',	NULL,	NULL,	NULL,	NULL,	NULL,	'qtkPxcxVDbgGeEXLX4xvkZrsXV9N95b8Y1mespebGQhFKDcTBGLYgHgQU3E5YtpE',	NULL,	'9832',	NULL,	NULL,	NULL,	1,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(14,	NULL,	NULL,	'6376906516',	NULL,	NULL,	NULL,	NULL,	NULL,	'ZfDHUJKTz6R60jLgEmsxUekE5n9I4Bddr92wI7p3Hzs0YWS9VxQxaMIXrFvh7q2o',	NULL,	'3689',	NULL,	NULL,	NULL,	1,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(15,	'dsdss',	NULL,	'1122331122',	NULL,	NULL,	NULL,	NULL,	NULL,	'G2G1zDbhzieCKTgQ2rbgXI4Rqr7MfRLgulLXsB30LLlNLMUkPCv2gSVFk6oXeOVN',	'2024-04-19 00:00:00',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `users_matches`;
CREATE TABLE `users_matches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `match_id` int NOT NULL,
  `last_message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_message_date` datetime DEFAULT NULL,
  `last_message_id` int DEFAULT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `last_delete_id` int DEFAULT NULL,
  `is_mute` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `match_id` (`match_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `users_matches_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_matches_ibfk_2` FOREIGN KEY (`match_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_matches_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `users_permissions`;
CREATE TABLE `users_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `users_permissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `users_permissions` (`id`, `user_id`, `permission`, `status`, `created`) VALUES
(1,	1,	'email_buyer_message',	1,	'2023-12-16 02:56:47'),
(2,	1,	'email_seller_message',	1,	'2023-12-16 02:56:47'),
(3,	1,	'text_buyer_message',	1,	'2023-12-16 02:56:48'),
(4,	1,	'text_seller_message',	1,	'2023-12-16 02:56:48'),
(5,	2,	'email_buyer_message',	1,	'2023-12-25 01:45:15'),
(6,	2,	'email_seller_message',	1,	'2023-12-25 01:45:15'),
(7,	2,	'text_buyer_message',	1,	'2023-12-25 01:45:15'),
(8,	2,	'text_seller_message',	1,	'2023-12-25 01:45:15'),
(9,	3,	'email_buyer_message',	1,	'2024-01-07 11:22:04'),
(10,	3,	'email_seller_message',	1,	'2024-01-07 11:22:04'),
(11,	3,	'text_buyer_message',	1,	'2024-01-07 11:22:04'),
(12,	3,	'text_seller_message',	1,	'2024-01-07 11:22:04');

DROP TABLE IF EXISTS `users_tokens`;
CREATE TABLE `users_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token` varchar(200) NOT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `device_type` enum('android','ios','web') DEFAULT NULL,
  `device_name` varchar(255) DEFAULT NULL,
  `fcm_token` text,
  `expire_on` datetime NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `users_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


DROP TABLE IF EXISTS `users_wishlist`;
CREATE TABLE `users_wishlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `users_wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_wishlist_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- 2024-03-23 15:10:19
