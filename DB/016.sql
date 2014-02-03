-- Set Home branch to Bangalore which has code as @homebranch
set @homebranch := 'BL';

-- Set item type to DVD
set @itemtype := 'DVD';

-- Set Set inventory date
set @inventoryDate = '2013-12-16';
SELECT items.barcode, biblio.title, biblio.author, items.datelastseen  FROM items   LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)  WHERE items.itype = @itemtype   AND   items.homebranch = @homebranch  ORDER BY items.datelastseen DESC;

SELECT items.barcode, biblio.title, biblio.author, items.onloan as 'Issued Date', items.datelastseen  FROM items   LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)  WHERE items.itype = @itemtype   AND   items.homebranch = @homebranch  AND   items.onloan IS NOT NULL  ORDER BY items.datelastseen DESC;  

SELECT items.barcode, biblio.title, biblio.author, items.datelastseen  FROM items   LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)  WHERE items.itype = @itemtype   AND   items.homebranch = @homebranch  AND   items.onloan IS NULL  ORDER BY items.datelastseen DESC; 

SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned  FROM items   LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)  WHERE items.itype = @itemtype   AND   items.homebranch = @homebranch  AND   items.itemnumber NOT IN ( SELECT items.itemnumber  	FROM items   	LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)  	WHERE items.itype = @itemtype   	AND   items.homebranch = @homebranch  	AND   items.datelastseen =  @inventoryDate)  ORDER BY items.dateaccessioned DESC; 

SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned  FROM items   LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)  WHERE items.itype = @itemtype   AND   items.homebranch = @homebranch  AND   items.datelastseen =  @inventoryDate  ORDER BY items.dateaccessioned DESC;

SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned  FROM items   LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)  WHERE items.itype = @itemtype   AND   items.homebranch = @homebranch  AND   items.itemlost = 4  ORDER BY items.dateaccessioned DESC; 

SELECT GROUP_CONCAT(biblionumber SEPARATOR ', ') AS biblionumbers, title, author  FROM biblio LEFT JOIN biblioitems USING (biblionumber)   LEFT JOIN items USING (biblionumber)  WHERE items.homebranch = @homebranch  AND   items.itype = @itemtype   GROUP BY CONCAT(title,"/",author)   HAVING COUNT(CONCAT(title,"/",author)) > 1;

SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned  FROM items   LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)  WHERE items.itype = @itemtype   AND   items.homebranch = @homebranch  AND   items.datelastseen >= @inventoryDate  UNION SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned  FROM items   LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)  WHERE items.itype = @itemtype   AND   items.homebranch = @homebranch  AND   items.datelastseen < @inventoryDate  AND	  items.onloan IS NOT NULL; 