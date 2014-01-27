-- Set Home branch to Bangalore which has code as @homebranch
set @homebranch := 'BL';

-- Set item type to DVD
set @itemtype := 'DVD';

-- Set Set inventory date
set @inventoryDate = '2013-12-16';

-- Generate total stock of given item available in given Branch
SELECT items.barcode, biblio.title, biblio.author, items.datelastseen
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
ORDER BY items.datelastseen DESC;




-- List of titles issued out
SELECT items.barcode, biblio.title, biblio.author, items.onloan as 'Issued Date', items.datelastseen
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
AND   items.onloan IS NOT NULL
ORDER BY items.datelastseen DESC;

-- List of titles issued out - 2
SELECT items.barcode, biblio.title, biblio.author, items.datelastseen, old_issues.issuedate, old_issues.returndate
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN old_issues ON  (items.itemnumber = old_issues.itemnumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
AND   items.onloan IS NULL
AND   old_issues.issuedate < @inventoryDate
AND   @inventoryDate < old_issues.returndate
ORDER BY items.datelastseen DESC;


-- List of items in the library
SELECT items.barcode, biblio.title, biblio.author, items.datelastseen
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
AND   items.onloan IS NULL
ORDER BY items.datelastseen DESC;

-- List of items scanned
SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
AND   items.datelastseen =  @inventoryDate
ORDER BY items.dateaccessioned DESC;

-- List of items not scanned
SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
AND   items.datelastseen !=  @inventoryDate
AND   items.onloan IS NULL
ORDER BY items.dateaccessioned DESC;


-- List of titles missing
SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
AND   items.itemlost = 4
ORDER BY items.dateaccessioned DESC;


-- List of duplicate titles
SELECT GROUP_CONCAT(biblionumber SEPARATOR ', ') AS biblionumbers, title, author
FROM biblio LEFT JOIN biblioitems USING (biblionumber) 
LEFT JOIN items USING (biblionumber)
WHERE items.homebranch = @homebranch
AND   items.itype = @itemtype 
GROUP BY CONCAT(title,"/",author) 
HAVING COUNT(CONCAT(title,"/",author)) > 1;


-- Final list of DVD’s available in library
SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
AND   items.datelastseen >= @inventoryDate
UNION
SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
AND   items.datelastseen < @inventoryDate
AND	  items.onloan IS NOT NULL;


