SELECT DISTINCT * FROM `koha`.`authorised_values` WHERE category = 'LOST' ORDER BY authorised_value;

SELECT items.barcode, biblio.title, biblio.author, items.dateaccessioned
FROM items 
LEFT JOIN biblio     ON  (items.biblionumber = biblio.biblionumber)
WHERE items.itype = 'DVD'
AND   items.homebranch = 'BL'
ORDER BY items.dateaccessioned DESC;