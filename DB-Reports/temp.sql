SELECT items.barcode, biblio.title, biblio.author 
FROM items LEFT JOIN biblio USING (biblionumber) 
LEFT JOIN authorised_values ON (items.itemlost=authorised_values.authorised_value)
LEFT JOIN biblioitems USING (biblionumber) 
WHERE items.itemlost != 0 
AND authorised_values.category='LOST'
AND authorised_values.authorised_value = '4'
AND biblioitems.itemtype = 'DVD'
AND items.homebranch = 'BL';