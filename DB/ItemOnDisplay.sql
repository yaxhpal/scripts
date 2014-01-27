SELECT items.barcode as Barcode, biblio.title as Title, biblio.author as Author 
FROM items, biblio 
where items.biblionumber = biblio.biblionumber 
and items.notforloan = 3 
and items.homebranch = 'DL';