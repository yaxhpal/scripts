-- Set Home branch to Bangalore which has code as @homebranch
set @homebranch := 'BL';

-- Set item type to DVD
set @itemtype := 'DVD';

-- Set Set inventory date
set @inventoryDate = '2013-12-16';

SELECT 
    items.barcode,
    biblio.title,
    biblio.author,
    items.datelastseen,
    old_issues.issuedate,
    old_issues.returndate,
    items.onloan
FROM
    items
        LEFT JOIN
    biblio ON (items.biblionumber = biblio.biblionumber)
        LEFT JOIN
    issues ON (items.itemnumber = issues.itemnumber)
        LEFT JOIN
    old_issues ON (items.itemnumber = old_issues.itemnumber)
WHERE
    items.itype = @itemtype
        AND items.homebranch = @homebranch
        AND ((issues.itemnumber IS NOT NULL
        AND issues.issuedate < @inventoryDate)
        OR (old_issues.itemnumber IS NOT NULL
        AND old_issues.issuedate < @inventoryDate
        AND @inventoryDate < old_issues.returndate))
GROUP BY items.itemnumber
ORDER BY items.datelastseen DESC;


SELECT items.barcode, biblio.title, biblio.author, items.datelastseen, 
old_issues.issuedate, old_issues.returndate, items.onloan
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN issues     ON  (items.itemnumber = issues.itemnumber)
LEFT JOIN old_issues ON  (items.itemnumber = old_issues.itemnumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
AND   ((issues.itemnumber IS NOT NULL AND issues.issuedate > @inventoryDate) 
      OR 
      (old_issues.itemnumber IS NOT NULL AND (old_issues.issuedate > @inventoryDate OR  @inventoryDate > old_issues.returndate)))
GROUP BY items.itemnumber
ORDER BY items.datelastseen DESC;



SELECT items.barcode, biblio.title, biblio.author, items.datelastseen, 
old_issues.issuedate, old_issues.returndate, items.onloan
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN issues     ON  (items.itemnumber = issues.itemnumber)
LEFT JOIN old_issues ON  (items.itemnumber = old_issues.itemnumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
AND  ( old_issues.itemnumber IS NOT NULL AND (old_issues.issuedate < @inventoryDate OR  old_issues.returndate <  @inventoryDate))
GROUP BY items.itemnumber
ORDER BY items.datelastseen DESC;


SELECT items.barcode, biblio.title, biblio.author, items.datelastseen, items.onloan
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
AND   items.onloan IS NOT NULL 
AND   items.onloan < @inventoryDate
GROUP BY items.itemnumber;


-- IN LIBRARY
SELECT items.barcode, biblio.title, biblio.author, items.datelastseen, old_issues.issuedate, old_issues.returndate, items.onloan
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN old_issues ON  (items.itemnumber = old_issues.itemnumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
AND   ( (items.onloan is null OR items.onloan > @inventoryDate)
        OR ( old_issues.issuedate > @inventoryDate OR @inventoryDate > old_issues.returndate))
GROUP BY items.itemnumber
ORDER BY items.onloan DESC;