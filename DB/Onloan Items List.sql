SELECT i.barcode, b.title FROM biblio b LEFT JOIN items i USING (biblionumber) 
LEFT JOIN biblioitems m USING (biblionumber) WHERE i.onloan IS NOT NULL AND i.homebranch = 'BL';