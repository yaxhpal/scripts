SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN issues     ON  (items.itemnumber = issues.itemnumber)
LEFT JOIN old_issues  ON  (items.itemnumber = old_issues.itemnumber)
WHERE items.itype = 'BK'
AND   items.homebranch = 'DL'
AND   items.notforloan != 0  -- Could be issued
AND   (issues.itemnumber IS NULL AND old_issues.itemnumber IS NULL)
GROUP BY items.itemnumber -- Select only distinct
ORDER BY items.dateaccessioned DESC;

-- 19

SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN issues     ON  (items.itemnumber = issues.itemnumber)
LEFT JOIN old_issues  ON  (items.itemnumber = old_issues.itemnumber)
WHERE items.itype = 'BK'
AND   items.homebranch = 'DL'
AND   items.wthdrawn = 0     -- On Shelf
AND   (issues.itemnumber IS NULL AND old_issues.itemnumber IS NULL)
GROUP BY items.itemnumber -- Select only distinct
ORDER BY items.dateaccessioned DESC;

-- 1368

SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN issues     ON  (items.itemnumber = issues.itemnumber)
LEFT JOIN old_issues  ON  (items.itemnumber = old_issues.itemnumber)
WHERE items.itype = 'BK'
AND   items.homebranch = 'DL'
AND   items.damaged != 0      -- Not damaged
AND   (issues.itemnumber IS NULL AND old_issues.itemnumber IS NULL)
GROUP BY items.itemnumber -- Select only distinct
ORDER BY items.dateaccessioned DESC;

-- 8

SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN issues     ON  (items.itemnumber = issues.itemnumber)
LEFT JOIN old_issues  ON  (items.itemnumber = old_issues.itemnumber)
WHERE items.itype = 'BK'
AND   items.homebranch = 'DL'
AND   items.itemlost != 0     -- Not missing, long overdue, lost 
AND   (issues.itemnumber IS NULL AND old_issues.itemnumber IS NULL)
GROUP BY items.itemnumber -- Select only distinct
ORDER BY items.dateaccessioned DESC;

-- 869


SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN issues     ON  (items.itemnumber = issues.itemnumber)
LEFT JOIN old_issues  ON  (items.itemnumber = old_issues.itemnumber)
WHERE items.itype = 'BK'
AND   items.homebranch = 'DL'
AND   items.notforloan = 0  -- Could be issued
AND   items.wthdrawn != 0     -- On Shelf
AND   items.damaged   = 0      -- Not damaged
AND   items.itemlost != 0     -- Not missing, long overdue, lost 
AND   (issues.itemnumber IS NULL AND old_issues.itemnumber IS NULL)
GROUP BY items.itemnumber -- Select only distinct
ORDER BY items.dateaccessioned DESC;