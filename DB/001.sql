SELECT items.barcode  as barcode, items.homebranch as branch, items.itemcallnumber as itemcallnumber, 
items.itype as itype, items.dateaccessioned as dateaccessioned,(SELECT lib FROM authorised_values
WHERE authorised_value = items.notforloan AND category = 'NOT_LOAN') as notforloan,
(SELECT lib FROM authorised_values WHERE authorised_value = items.damaged AND category = 'DAMAGED') as damaged,
(SELECT lib FROM authorised_values WHERE authorised_value = items.itemlost AND category = 'LOST') as itemlost,
(SELECT lib FROM authorised_values WHERE authorised_value = items.wthdrawn AND category = 'WITHDRAWN') as wthdrawn,
  biblio.title as title, biblio.biblionumber as biblionumber, biblio.author as author FROM items
               LEFT JOIN biblio      USING (biblionumber)
               LEFT JOIN     issues  USING (itemnumber)
               LEFT JOIN old_issues  USING (itemnumber)
               WHERE       issues.itemnumber IS NULL
               AND    old_issues.itemnumber IS NULL 
