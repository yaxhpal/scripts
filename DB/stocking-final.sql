-- Set Home branch 
set @homebranch := 'CH';

-- Set item type
set @itemtype := 'BK';

-- Set inventory date
set @inventoryDate = '2013-11-10';


CREATE TEMPORARY TABLE IF NOT EXISTS onloanOnInventoryDate AS (
SELECT DISTINCT itemnumber
FROM   old_issues 
WHERE  old_issues.branchcode = @homebranch 
AND    old_issues.issuedate  < @inventoryDate 
AND    old_issues.returndate > @inventoryDate);

CREATE TEMPORARY TABLE IF NOT EXISTS issuedAndNotReturned AS (
SELECT DISTINCT itemnumber
FROM   issues 
WHERE  issues.branchcode = @homebranch  
AND    issues.issuedate  < @inventoryDate );

-- Generate total stock of given item available in given Branch
SELECT /* General stock */ items.barcode, biblioitems.isbn, items.biblionumber, biblio.title, 
biblio.author, items.datelastseen
FROM items 
LEFT JOIN biblio      ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN biblioitems ON  (items.biblionumber = biblioitems.biblionumber)
WHERE items.itype = @itemtype 
AND   items.homebranch = @homebranch
ORDER BY items.datelastseen DESC;


-- List of titles issued out
SELECT /* Issued out */ items.barcode, biblioitems.isbn, items.biblionumber, biblio.title, 
biblio.author, items.datelastseen
FROM items 
LEFT JOIN biblio                ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN biblioitems           ON  (items.biblionumber = biblioitems.biblionumber)
LEFT JOIN issuedAndNotReturned  ON  (items.itemnumber = issuedAndNotReturned.itemnumber)
LEFT JOIN onloanOnInventoryDate ON  (items.itemnumber = onloanOnInventoryDate.itemnumber)
WHERE items.itype = @itemtype
AND   items.homebranch = @homebranch
AND   ((issuedAndNotReturned.itemnumber IS NOT NULL) OR (onloanOnInventoryDate.itemnumber IS NOT NULL) )
GROUP BY items.itemnumber
ORDER BY items.datelastseen DESC;


-- List of items in the library
SELECT /* In the Library */ items.barcode, biblio.title, biblio.author, items.datelastseen
FROM items
LEFT JOIN biblio ON  (items.biblionumber = biblio.biblionumber)
LEFT JOIN issuedAndNotReturned ON  (items.itemnumber = issuedAndNotReturned.itemnumber)
LEFT JOIN onloanOnInventoryDate ON (items.itemnumber = onloanOnInventoryDate.itemnumber)
WHERE items.itype      = @itemtype
AND   items.homebranch = @homebranch
AND   issuedAndNotReturned.itemnumber IS NULL
AND   onloanOnInventoryDate.itemnumber IS NULL
GROUP BY items.itemnumber
ORDER BY 1;

DROP TABLE onloanOnInventoryDate;
DROP TABLE issuedAndNotReturned;
