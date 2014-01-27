SELECT * FROM koha.old_issues WHERE itemnumber = '927560';

SELECT * FROM koha.issues WHERE itemnumber = '927560';

-- '2011-11-21'


SELECT count(i.barcode), b.title, b.author, i.dateaccessioned 
FROM items i
LEFT JOIN biblio b USING (biblionumber)
LEFT JOIN  issues USING (itemnumber)
LEFT JOIN old_issues  USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND issues.itemnumber IS NULL 
AND old_issues.itemnumber IS NULL
AND i.issues IS NULL
AND i.onloan IS NULL
AND i.notforloan = 0
AND i.wthdrawn = 0
AND i.damaged = 0
AND i.itemlost = 0
ORDER BY i.dateaccessioned DESC;



SELECT count(*), i.barcode, b.title, b.author, i.dateaccessioned, i.issues AS 'Total checkouts',
YEAR(NOW())-YEAR(i.datelastborrowed) AS 'Not used since (Yrs)', 
CASE WHEN i.onloan IS NULL THEN 'No' ELSE 'Yes' END AS 'Is checked out'
FROM items i
LEFT JOIN biblio b USING (biblionumber)
LEFT JOIN  issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan = 0 -- Could be issues
AND i.wthdrawn = 0   -- sOn Shelf
AND i.damaged = 0    -- Not damaged
AND i.itemlost = 0   -- Not missing, long overdue, lost 
AND i.datelastseen = i.datelastborrowed
AND YEAR(NOW())-YEAR(i.datelastborrowed) >= 2
ORDER BY i.dateaccessioned DESC;
