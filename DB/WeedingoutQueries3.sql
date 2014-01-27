
-- It gives all the books at Delhi Library which have never been checked out
-- also these items are not (a) Withdrawn (b) damaged (c) Not for Loan 
-- (d) lost i.e. they are idle.
-- Items are sorted by Item accession date in descending order

SELECT b.title, b.author, i.dateaccessioned 
FROM items i
LEFT JOIN biblio b USING (biblionumber)
LEFT JOIN  issues USING (itemnumber)
LEFT JOIN old_issues  USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND issues.itemnumber IS NULL 
AND old_issues.itemnumber IS NULL
AND i.notforloan = 0 -- Could be issues
AND i.wthdrawn = 0   -- On Shelf
AND i.damaged = 0    -- Not damaged
AND i.itemlost = 0   -- Not missing, long overdue, lost 
ORDER BY i.dateaccessioned DESC;


-- Following query is all the items of particular category and belonging to
-- particular Library which haven't been in circulation for given X years

SELECT i.barcode, b.title, b.author, i.dateaccessioned, i.issues AS totalcheckouts,
YEAR(NOW())-YEAR(i.datelastborrowed) AS inactivity_period  FROM items i
LEFT JOIN biblio b USING (biblionumber)
LEFT JOIN  issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan = 0 -- Could be issues
AND i.wthdrawn = 0   -- On Shelf
AND i.damaged = 0    -- Not damaged
AND i.itemlost = 0   -- Not missing, long overdue, lost 
AND i.datelastseen = i.datelastborrowed
-- AND issues.itemnumber IS NULL
AND YEAR(NOW())-YEAR(i.datelastborrowed) >= 2

UNION

SELECT i.barcode, b.title, b.author, i.dateaccessioned, i.issues AS totalcheckouts,
YEAR(NOW())-YEAR(i.datelastborrowed) AS inactivity_period  FROM items i
LEFT JOIN biblio b USING (biblionumber)
LEFT JOIN  issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan = 0 -- Could be issues
AND i.wthdrawn = 0   -- On Shelf
AND i.damaged = 0    -- Not damaged
AND i.itemlost = 0   -- Not missing, long overdue, lost 
AND i.datelastseen = i.datelastborrowed
AND issues.itemnumber IS NOT NULL
AND YEAR(NOW())-YEAR(i.datelastborrowed) >= 2
ORDER BY totalcheckouts ASC;





SELECT b.title, b.author, b.copyrightdate, i.itemcallnumber,
       i.barcode, i.datelastborrowed, i.issues AS totalcheckouts,
       i.dateaccessioned
FROM items i
LEFT JOIN issues
USING (itemnumber)
LEFT JOIN biblio b
USING (biblionumber)
WHERE i.itemnumber NOT IN (SELECT issues.itemnumber FROM issues) 
      AND  YEAR(NOW())-YEAR(i.datelastborrowed) > 2
UNION 
SELECT b.title, b.author, b.copyrightdate, i.itemcallnumber,
       i.barcode, i.datelastborrowed, i.issues AS totalcheckouts,
       i.dateaccessioned
FROM items i
LEFT JOIN issues
USING (itemnumber)
LEFT JOIN biblio b
USING (biblionumber)
WHERE i.itemnumber NOT IN (SELECT old_issues.itemnumber FROM old_issues) 
      AND YEAR(NOW())-YEAR(i.datelastborrowed) > 2;

