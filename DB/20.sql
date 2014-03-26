DROP TABLE IF EXISTS `hulk`.`jobfeeds`;

CREATE TABLE `hulk`.`jobfeeds` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `jobid` varchar(128) DEFAULT NULL,
  `source` varchar(128) DEFAULT NULL,
  `category` varchar(128) DEFAULT NULL,
  `title` varchar(512) DEFAULT NULL,
  `description` text,
  `link` varchar(2083) DEFAULT NULL,
  `pubdate` datetime DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `scrores` text,
  `publisher` varchar(512) DEFAULT NULL,
  `location`  varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jobid_UNIQUE` (`jobid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

