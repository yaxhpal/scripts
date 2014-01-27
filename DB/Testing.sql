SELECT i.barcode, i.datelastseen,  b.title
FROM biblio b LEFT JOIN items i USING (biblionumber)
WHERE i.itype = 'DVD' 
AND (i.datelastseen >='2013-12-16' OR i.onloan IS NOT NULL)
AND (i.homebranch = 'BL' OR i.holdingbranch='BL') order by i.datelastseen desc;

-- SELECT count(i.barcode)
-- FROM biblio b LEFT JOIN items i USING (biblionumber)
-- WHERE i.itype = 'DVD' AND (i.datelastseen >='2013-12-16' OR i.onloan IS NOT NULL);