-- alter table reviews add ( title varchar(256) NOT NULL DEFAULT '', rating int(2) NOT NULL DEFAULT '0', name varchar(30) DEFAULT NULL, location varchar(30) DEFAULT NULL);

-- alter table biblioitems add (`is_present` tinyint(1) NOT NULL DEFAULT '0');
-- Took 19 mins

CREATE TABLE `showcase` (
  `isbn` varchar(30) NOT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `title` varchar(30) DEFAULT NULL,
  UNIQUE KEY `isbn` (`isbn`)
);

CREATE TABLE `popbook` (
  `isbn` varchar(30) NOT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Unix timestamp',
  `title` varchar(30) DEFAULT NULL,
  UNIQUE KEY `isbn` (`isbn`)
);

CREATE TABLE `popdvd` (
  `isbn` varchar(30) NOT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Unix timestamp',
  `title` varchar(30) DEFAULT NULL,
  UNIQUE KEY `isbn` (`isbn`)
);


CREATE TABLE `award` (
  `isbn` varchar(30) NOT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Unix timestamp',
  `title` varchar(30) DEFAULT NULL,
  UNIQUE KEY `isbn` (`isbn`)
);

CREATE TABLE `author` (
  `authorname` varchar(30) NOT NULL,
  `dateofbirth` date DEFAULT NULL,
  `placeofbirth` varchar(30) DEFAULT NULL,
  `description` longtext,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mimetype` varchar(15) NOT NULL,
  `imagefile` mediumblob NOT NULL
);


CREATE TABLE `book` (
  `isbn` varchar(30) NOT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `title` varchar(30) DEFAULT NULL,
  UNIQUE KEY `isbn` (`isbn`)
);


CREATE TABLE `flipslider` (
  `isbn` varchar(30) NOT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `title` varchar(30) DEFAULT NULL,
  `author` varchar(30) DEFAULT NULL,
  UNIQUE KEY `isbn` (`isbn`)
);

CREATE TABLE `content` (
  `contenttext` longtext,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cid` int(11) NOT NULL DEFAULT '1'
);


-- tables : showcase, popbook, popdvd, award, author, book, flipslider, content


-- //New modules
-- cpan -i Math::NumberCruncher
-- cpan -i Authen::Captcha



select * from showcase into outfile '/tmp/table_data/showcase.txt';
select * from popbook into outfile '/tmp/table_data/popbook.txt';
select * from popdvd into outfile '/tmp/table_data/popdvd.txt';
select * from award into outfile '/tmp/table_data/award.txt';
select * from author into outfile '/tmp/table_data/author.txt';
select * from book into outfile '/tmp/table_data/book.txt';
select * from flipslider into outfile '/tmp/table_data/flipslider.txt';
select * from content into outfile '/tmp/table_data/content.txt';


LOAD DATA INFILE '/tmp/table_data/showcase.txt' INTO TABLE showcase;
LOAD DATA INFILE '/tmp/table_data/popbook.txt' INTO TABLE popbook;
LOAD DATA INFILE '/tmp/table_data/popdvd.txt' INTO TABLE popdvd;
LOAD DATA INFILE '/tmp/table_data/award.txt' INTO TABLE award;
LOAD DATA INFILE '/tmp/table_data/author.txt' INTO TABLE author;
LOAD DATA INFILE '/tmp/table_data/book.txt' INTO TABLE book;
LOAD DATA INFILE '/tmp/table_data/flipslider.txt' INTO TABLE flipslider;
LOAD DATA INFILE '/tmp/table_data/content.txt' INTO TABLE content;

-- export PERL5LIB=/opt/tohaclone
-- export KOHA_CONF=/root/toha-dev/etc/koha-conf.xml
-- nohup perl misc/migration_tools/rebuild_zebra.pl -b -r -v -x > zebra-index.out &
-- zebrasrv -f /root/toha-dev/etc/koha-conf.xml &


SELECT * FROM action_logs WHERE 1 AND (1 = 2 or module = 'MEMBERS') AND action LIKE 'MODIFY' AND object = '309789';

SELECT * FROM action_logs WHERE 1 AND (1 = 2 or module = 'MEMBERS') AND action LIKE 'MODIFY' AND object = '309789';


create index action_log_index on action_logs (module(10),action(10),object);
create index action_log_index on action_logs (module(10),action(10),object);

SELECT * FROM borrowers WHERE userid='kohaadmin'
