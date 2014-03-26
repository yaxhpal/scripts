delimiter $$

CREATE TABLE `jobfeeds` (
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
) ENGINE=InnoDB AUTO_INCREMENT=2027 DEFAULT CHARSET=utf8$$

select marc from biblioitems where isbn='9780297852735'  limit 1 INTO OUTFILE "/tmp/sample.mrc" ;

-- Error Code: 1086. File '/home/yashpal/sample.mrc' already exists
select * from externaldata;

delete from externaldata where isbn13='9780750644716';
update externaldata set title=null where isbn13='9781408409725';

SELECT frameworkcode FROM biblio where frameworkcode is not null and frameworkcode<>'';

SHOW COLUMNS FROM externaldata;