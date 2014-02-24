#!/bin/bash

# Tasks
# 1. Copy files to a directory with name as DDMYYYY
# 2. Tar them into file DDMYYYY.tgz
# 3. Copy this archive to server

filename="$1"
while read -r line
do
   itemnumber=$line
   mysqldump -ukohaadmin -ppkoha koha items -w"itemnumber=$itemnumber" |grep INSERT >>inserts.sql
done < "$filename"
echo "Done with it"
