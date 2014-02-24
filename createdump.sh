mysqldump --skip-extended-insert -ukohaadmin -ppkoha koha items -w"itemnumber=13278"




awk '{print "mysqldump --skip-extended-insert -ukohaadmin -ppkoha koha items -w\"itemnumber=$0\" | grep INSERT"}' deletedItems.txt >tmp.sql
