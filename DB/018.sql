CREATE VIEW koha.testview 
AS SELECT DISTINCT itemnumber 
FROM koha.statistics WHERE type='issue' and branch='BL';

SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN testview   ON  (items.itemnumber = testview.itemnumber)
WHERE items.itype = 'DVD'
AND   items.homebranch = 'BL'
AND   testview.itemnumber IS NOT NULL
GROUP BY items.itemnumber
ORDER BY items.dateaccessioned DESC;

SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN issues     ON  (items.itemnumber = issues.itemnumber)
LEFT JOIN old_issues ON  (items.itemnumber = old_issues.itemnumber)
WHERE items.itype = 'DVD'
AND   items.homebranch = 'BL'
AND    (issues.itemnumber IS NOT NULL OR old_issues.itemnumber IS NOT NULL)
GROUP BY items.itemnumber -- Select only distinct
ORDER BY items.dateaccessioned DESC;
