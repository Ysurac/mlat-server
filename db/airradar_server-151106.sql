DROP TABLE IF EXISTS `feed`;
CREATE TABLE `feed` (
  `feed_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `urlip` varchar(999) NOT NULL,
  `port` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `errors` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`feed_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `spotter_temp`;
CREATE TABLE `spotter_temp` (
  `id_data` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `hex` varchar(20) DEFAULT NULL,
  `ident` varchar(20) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `verticalrate` int(11) DEFAULT NULL,
  `speed` int(11) DEFAULT NULL,
  `squawk` int(11) DEFAULT NULL,
  `altitude` int(11) DEFAULT NULL,
  `heading` int(11) DEFAULT NULL,
  `registration` varchar(255) DEFAULT NULL,
  `aircraft_icao` varchar(255) DEFAULT NULL,
  `waypoints` varchar(999) DEFAULT NULL,
  `id_source` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_data`)
) ENGINE=MEMORY AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `stats`;
CREATE TABLE `stats` (
  `user_id` int(11) NOT NULL,
  `packets` int(11) NOT NULL,
  `datetime` date NOT NULL,
  UNIQUE KEY `userdate` (`user_id`,`datetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto incrementing user_id of each user, unique index',
  `user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'user''s name, unique',
  `user_password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'user''s password in salted and hashed format',
  `user_email` varchar(254) COLLATE utf8_unicode_ci NOT NULL COMMENT 'user''s email, unique',
  `user_access_level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'user''s access level (between 0 and 255, 255 = administrator)',
  `user_active` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'user''s activation status',
  `user_activation_hash` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'user''s email verification hash string',
  `user_password_reset_hash` char(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'user''s password reset code',
  `user_password_reset_timestamp` bigint(20) DEFAULT NULL COMMENT 'timestamp of the password reset request',
  `user_failed_logins` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'user''s failed login attemps',
  `user_last_failed_login` int(10) DEFAULT NULL COMMENT 'unix timestamp of last failed login attempt',
  `user_registration_datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_registration_ip` varchar(39) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.0.0.0',
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `user_key` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `user_email` (`user_email`),
  UNIQUE KEY `user_key` (`user_key`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='user data';

