DROP TABLE IF EXISTS `externaldata`;

CREATE TABLE `externaldata` (
    `id`                SERIAL, 
    `isbn10`            VARCHAR(13) DEFAULT NULL,
    `isbn13`            VARCHAR(17) DEFAULT NULL,
    `vendor_id`         VARCHAR(30) DEFAULT NULL,
    `type`              VARCHAR(10) DEFAULT NULL,
    `title`             MEDIUMTEXT      DEFAULT NULL,
    `authors`           MEDIUMTEXT DEFAULT NULL,
    `publisher`         MEDIUMTEXT DEFAULT NULL,
    `publishing_place`  VARCHAR(256) DEFAULT NULL,
    `date_published`    DATE DEFAULT NULL,
    `description`       MEDIUMTEXT DEFAULT NULL,
    `subjects`          MEDIUMTEXT DEFAULT NULL,
    `edition`           TINYINT DEFAULT 1,
    `number_of_pages`   SMALLINT DEFAULT NULL,
    `product_format`    VARCHAR(128) DEFAULT NULL,
    `thumbnail_url`     MEDIUMTEXT DEFAULT NULL,
    `image_url`         MEDIUMTEXT DEFAULT NULL,
    `imageflag`         TINYINT DEFAULT 0,
    `marc`              LONGBLOB DEFAULT NULL,
    `timestamp`         TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `isbn13_UNIQUE` (`isbn13`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8;