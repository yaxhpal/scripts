SELECT  items.barcode as Barcode, biblio.title as Title, 
biblio.author as Auther, issues.date_due as "Due Date" 
FROM issues
LEFT JOIN items USING (itemnumber)
LEFT JOIN biblio USING (biblionumber)
WHERE items.homebranch = 'BL' AND items.itype = 'DVD'
ORDER BY issues.date_due DESC;