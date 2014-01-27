
SELECT count(1) FROM koha.items WHERE itype='BK' AND homebranch = 'DL';

-- Items which are only  not-for-loan
select count(1) 
from items i 
where i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan != 0  -- Could be issued
AND i.wthdrawn = 0     -- On Shelf
AND i.damaged = 0      -- Not damaged
AND i.itemlost = 0;    -- Not missing, long overdue, lost 

-- Items which are only  withdrawn
select count(1) 
from items i 
where i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan = 0   -- Could be issued
AND i.wthdrawn != 0    -- On Shelf
AND i.damaged = 0      -- Not damaged
AND i.itemlost = 0;    -- Not missing, long overdue, lost 

-- Items which are only damaged
select count(1) 
from items i 
where i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan = 0   -- Could be issued
AND i.wthdrawn = 0     -- On Shelf
AND i.damaged != 0     -- Not damaged
AND i.itemlost = 0;    -- Not missing, long overdue, lost 

-- Items which are only lost
select count(1) 
from items i 
where i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan = 0   -- Could be issued
AND i.wthdrawn = 0     -- On Shelf
AND i.damaged = 0      -- Not damaged
AND i.itemlost != 0;   -- Not missing, long overdue, lost 


SELECT count(1)
FROM items i
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan = 0
AND i.wthdrawn = 0
AND i.damaged = 0
AND i.itemlost = 0;

SELECT count(1)
FROM items i
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan = 0
AND i.wthdrawn = 0
AND i.damaged = 0
AND i.itemlost = 0
AND i.datelastborrowed IS NULL;

SELECT count(1)
FROM items i
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan = 0
AND i.wthdrawn = 0
AND i.damaged = 0
AND i.itemlost = 0
AND i.datelastborrowed IS NOT NULL;


SELECT count(1)
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


SELECT count(1)
FROM items i
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND i.datelastborrowed IS NULL;


SELECT count(1)
FROM items i
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND itemnumber  in (
	SELECT DISTINCT itemnumber
	FROM items i
	LEFT JOIN  issues USING (itemnumber)
	WHERE i.itype='BK'
	AND i.homebranch = 'DL'
	AND issues.itemnumber IS NOT NULL
Union
	SELECT DISTINCT itemnumber
	FROM items i
	LEFT JOIN old_issues  USING (itemnumber)
	WHERE i.itype='BK'
	AND i.homebranch = 'DL'
	AND old_issues.itemnumber IS NOT NULL);

SELECT count(1)
FROM items i
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND itemnumber NOT IN
( SELECT DISTINCT issues.itemnumber FROM issues WHERE issues.branchcode = 'DL' 
  UNION SELECT DISTINCT old_issues.itemnumber FROM old_issues WHERE old_issues.branchcode = 'DL');




SELECT count(DISTINCT itemnumber)
FROM items i
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan = 0
AND i.wthdrawn = 0
AND i.damaged = 0
AND i.itemlost = 0
AND itemnumber IN 
(
SELECT itemnumber
FROM items i
LEFT JOIN  issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND issues.itemnumber IS NOT NULL
UNION
SELECT itemnumber
FROM items i
LEFT JOIN  old_issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND old_issues.itemnumber IS NOT NULL);



SELECT count(DISTINCT itemnumber)
FROM items i
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND i.notforloan = 0
AND i.wthdrawn = 0
AND i.damaged = 0
AND i.itemlost = 0
AND itemnumber NOT IN 
(
SELECT itemnumber
FROM items i
LEFT JOIN  issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND issues.itemnumber IS NOT NULL
UNION
SELECT itemnumber
FROM items i
LEFT JOIN  old_issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND old_issues.itemnumber IS NOT NULL);







SELECT count(DISTINCT itemnumber)
FROM items i
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND itemnumber IN 
(
SELECT itemnumber
FROM items i
LEFT JOIN  issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND issues.itemnumber IS NOT NULL
UNION
SELECT itemnumber
FROM items i
LEFT JOIN  old_issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND old_issues.itemnumber IS NOT NULL);



SELECT count(DISTINCT itemnumber)
FROM items i
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND itemnumber NOT IN 
(
SELECT itemnumber
FROM items i
LEFT JOIN  issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND issues.itemnumber IS NOT NULL
UNION
SELECT itemnumber
FROM items i
LEFT JOIN  old_issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND old_issues.itemnumber IS NOT NULL);



SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned 
FROM items 
LEFT JOIN biblio     USING (biblionumber)
LEFT JOIN issues     USING (itemnumber)
LEFT JOIN old_issues USING (itemnumber)
WHERE items.itype = 'BK'
AND   items.homebranch = 'DL'
AND   (issues.itemnumber IS NOT NULL OR old_issues.itemnumber IS NOT NULL)
GROUP BY items.itemnumber
ORDER BY items.dateaccessioned DESC;

SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     USING (biblionumber)
LEFT JOIN issues     USING (itemnumber)
LEFT JOIN old_issues USING (itemnumber)
WHERE items.itype = 'BK'
AND   items.homebranch = 'DL'
AND   (issues.itemnumber IS NULL AND old_issues.itemnumber IS NULL)
GROUP BY items.itemnumber
ORDER BY items.dateaccessioned DESC;

SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN issues     ON  (items.itemnumber = issues.itemnumber)
LEFT JOIN old_issues  ON  (items.itemnumber = old_issues.itemnumber)
WHERE items.itype = 'BK'
AND   items.homebranch = 'DL'
AND   (issues.itemnumber IS NULL AND old_issues.itemnumber IS NULL)
GROUP BY items.itemnumber -- Select only distinct
ORDER BY items.dateaccessioned DESC;

-- '925560', 'DL104679', 'Foundations of language: brain, meaning, grammer, evolution', 'Ray Jackendoff', '2011-08-04'
-- '1020372', 'DL133814', 'Human Resources Management: The Key Concepts', 'Rowley, Chris', '2012-10-20'
