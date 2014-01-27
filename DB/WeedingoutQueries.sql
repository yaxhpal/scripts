
-- It gives all the books at Delhi Library which have never been checked out
-- also these items are not (a) Withdrawn (b) damaged (c) Not for Loan 
-- (d) lost i.e. they are idle.
-- Items are sorted by Item accession date in descending order


SELECT i.barcode, b.title, b.author, i.dateaccessioned 
FROM items i
LEFT JOIN biblio b USING (biblionumber)
LEFT JOIN  issues USING (itemnumber)
LEFT JOIN old_issues  USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND issues.itemnumber IS NULL 
AND old_issues.itemnumber IS NULL
AND i.notforloan = 0
AND i.wthdrawn = 0
AND i.damaged = 0
AND i.itemlost = 0
ORDER BY i.dateaccessioned DESC;


-- Following query returns all the items of particular category and belonging to
-- particular Library which haven't been in circulation for given X (for example
-- 2 or more years ) years Or they have not been returned in those years
-- Items are sorted by Item accession date in descending order
-- items are not (a) Withdrawn (b) damaged (c) Not for Loan 
-- (d) lost

SELECT i.barcode, b.title, b.author, i.dateaccessioned, i.issues AS 'Total checkouts',
YEAR(NOW())-YEAR(i.datelastborrowed) AS 'Not used since (Yrs)', 
CASE WHEN i.onloan IS NULL THEN 'No' ELSE 'Yes' END AS 'Is checked out'
FROM items i
LEFT JOIN biblio b USING (biblionumber)
LEFT JOIN  issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan = 0 -- Could be issues
AND i.wthdrawn = 0   -- On Shelf
AND i.damaged = 0    -- Not damaged
AND i.itemlost = 0   -- Not missing, long overdue, lost 
AND i.datelastseen = i.datelastborrowed
AND YEAR(NOW())-YEAR(i.datelastborrowed) >= 2
ORDER BY i.dateaccessioned DESC;


