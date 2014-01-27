
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
AND i.notforloan = 0
AND i.wthdrawn = 0
AND i.damaged = 0
AND i.itemlost = 0
ORDER BY i.dateaccessioned DESC;



