#!/bin/bash

# Tasks
# 1. Copy files to a directory with name as DDMYYYY
# 2. Tar them into file DDMYYYY.tgz
# 3. Copy this archive to server



filename="$1"
while read -r line
do
   name=$line
   echo "cp $name"
done < "$filename"

echo "Done with it"
