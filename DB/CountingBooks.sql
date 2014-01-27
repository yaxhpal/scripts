
-- Total number of items i.e. Books at Delhi Library
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
LEFT JOIN biblio b USING (biblionumber)
LEFT JOIN  issues USING (itemnumber)
LEFT JOIN old_issues  USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND issues.itemnumber IS NULL 
AND old_issues.itemnumber IS NULL;

SELECT count(1)
FROM items i
LEFT JOIN  issues USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND issues.itemnumber IS NOT NULL 
UNION
SELECT count(1)
FROM items i
LEFT JOIN old_issues  USING (itemnumber)
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND old_issues.itemnumber IS NOT NULL;





SELECT count(1)
FROM items i
WHERE i.itype='BK'
AND i.homebranch = 'DL'
AND itemnumber not in (
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









