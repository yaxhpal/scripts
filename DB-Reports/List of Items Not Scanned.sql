-- SELECT i.barcode, i.datelastseen,  b.title, IF (i.onloan IS NULL, '', 'checked out') AS onloan
-- FROM biblio b LEFT JOIN items i USING (biblionumber)
-- WHERE ( datelastseen < '2013-12-16' OR  i.onloan IS NOT NULL ) AND i.homebranch='BL'
-- ORDER BY datelastseen DESC;

SELECT i.barcode, i.datelastseen,  b.title
FROM biblio b LEFT JOIN items i USING (biblionumber)
WHERE ( datelastseen < '2013-12-16' AND  i.onloan IS NULL ) AND i.homebranch='BL'
ORDER BY datelastseen DESC;