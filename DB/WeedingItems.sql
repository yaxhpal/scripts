-- Items which are never checked out for the given type and given branch
SELECT count(b.title), b.author, b.datecreated 
FROM items i
LEFT JOIN biblio b USING (biblionumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND i.itemnumber 
NOT IN (SELECT itemnumber FROM issues WHERE itemnumber IS NOT NULL)
AND i.itemnumber NOT IN (SELECT itemnumber FROM old_issues WHERE itemnumber IS NOT NULL)
ORDER BY i.dateaccessioned DESC;

-- Testing 

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

-- Testing ------



-- Items which are never checked out for the given type and given branch

SELECT b.title, b.author, c.issuedate 
FROM items i
LEFT JOIN biblio b USING (biblionumber)
LEFT JOIN issues c USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND c.returndate IS NULL
ORDER BY c.issuedate DESC;

SELECT b.title, b.author, oc.issuedate 
FROM items i
LEFT JOIN biblio b USING (biblionumber)
LEFT JOIN old_issues oc USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND oc.returndate < '2012-01-01'
ORDER BY oc.issuedate DESC;


SELECT count(b.title), b.author, oc.issuedate 
FROM items i
LEFT JOIN biblio b USING (biblionumber)
LEFT JOIN old_issues oc USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND i.itemnumber NOT IN (SELECT itemnumber FROM issues WHERE itemnumber IS NOT NULL)
ORDER BY oc.issuedate DESC;




-- IN (SELECT itemnumber FROM issues WHERE itemnumber IS NOT NULL)
-- OR i.itemnumber IN (SELECT itemnumber FROM old_issues WHERE itemnumber IS NOT NULL)
-- ORDER BY b.datecreated DESC;




SELECT b.title, b.author, i.barcode, i.itemcallnumber 
FROM items i
LEFT JOIN biblio b USING (biblionumber)
WHERE i.itemnumber 
NOT IN (SELECT itemnumber FROM issues WHERE itemnumber IS NOT NULL)
AND i.itemnumber NOT IN (SELECT itemnumber FROM old_issues WHERE itemnumber IS NOT NULL)
ORDER BY i.dateaccessioned DESC;

SELECT count(i.barcode), b.title, b.author, b.datecreated
FROM items i
LEFT JOIN biblio b USING (biblionumber)
WHERE i.itemnumber 
NOT IN (SELECT itemnumber FROM old_issues WHERE itemnumber IS NOT NULL)
ORDER BY b.datecreated ASC;
