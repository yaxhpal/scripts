SELECT  items.barcode as Barcode, biblio.title as Title, 
biblio.author as Auther, issues.date_due as "Due Date" 
FROM issues
LEFT JOIN items USING (itemnumber)
LEFT JOIN biblio USING (biblionumber)
WHERE items.homebranch = 'BL' AND items.itype = 'DVD'
ORDER BY issues.date_due DESC;

SELECT  i.barcode, c.branchcode, i.homebranch, c.issuedate
FROM issues c
LEFT JOIN items i USING (itemnumber)
LEFT JOIN biblio b USING (biblionumber)
WHERE i.itype = 'DVD' AND i.barcode = 'BL85037'
ORDER BY i.barcode ASC;

SELECT  i.barcode, c.branchcode, c.issuedate
FROM issues c
LEFT JOIN items i USING (itemnumber)
WHERE c.branchcode = 'BL' AND i.itype = 'DVD' AND i.barcode = 'BL85037'
ORDER BY i.barcode ASC;