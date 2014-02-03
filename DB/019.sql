SELECT * FROM koha.items where barcode = 'BL84345'; -- itemnumber = 1001793

SELECT * FROM koha.issues where itemnumber = '1001793';

SELECT * FROM koha.old_issues where itemnumber = '1001793';

SELECT * FROM koha.statistics where itemnumber = '1001793' and type='issue' and branch='BL';

SELECT count(1) FROM koha.statistics;

CREATE VIEW koha.testview AS SELECT DISTINCT itemnumber FROM koha.statistics where type='issue' and branch='BL';

SELECT count(1) FROM koha.statistics;

SELECT count(1) FROM koha.items WHERE items.itemnumber between 80001 and 82000;
