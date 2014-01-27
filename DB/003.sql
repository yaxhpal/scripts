SELECT i.barcode, b.title, b.author, i.datelastborrowed, 
i.issues AS totalcheckouts, i.dateaccessioned
FROM items i
LEFT JOIN issues s USING (itemnumber)
LEFT JOIN biblio b USING (biblionumber)
WHERE s.itemnumber IS NULL
AND  YEAR(NOW())-YEAR(i.datelastborrowed) > 2
ORDER BY i.datelastborrowed ASC;


SELECT i.barcode, b.title, b.author, i.datelastborrowed, 
i.issues AS totalcheckouts, i.dateaccessioned
FROM items i
LEFT JOIN issues s USING (itemnumber)
LEFT JOIN biblio b USING (biblionumber)
WHERE i.itemnumber NOT IN (SELECT issues.itemnumber FROM issues)
AND  YEAR(NOW())-YEAR(i.datelastborrowed) > 2
ORDER BY i.datelastborrowed ASC;


SELECT i.barcode, b.title, b.author, i.datelastborrowed, 
i.issues AS totalcheckouts, i.dateaccessioned
FROM items i
LEFT JOIN issues USING (itemnumber)
LEFT JOIN biblio b USING (biblionumber)
WHERE i.itemnumber NOT IN (SELECT old_issues.itemnumber FROM old_issues) 
AND YEAR(NOW())-YEAR(i.datelastborrowed) > 2;

