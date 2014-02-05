SELECT 
    items.itemnumber,
    barcode,
    itype,
    itemcallnumber,
    title,
    author,
    biblio.biblionumber,
    datelastseen
FROM
items
LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
LEFT JOIN biblioitems ON items.biblionumber = biblioitems.biblionumber
WHERE (datelastseen < '2013-10-14' OR datelastseen IS NULL)
AND items.homebranch = 'BL'
AND items.itype = 'DVD'
AND items.wthdrawn = 0
ORDER BY items.cn_sort , itemcallnumber , title;