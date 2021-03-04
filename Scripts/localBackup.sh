#!/bin/bash
# Usage: ./localBackup.sh adminname < ip_roster_no_header.csv

while IFS=, read ip servername users; do
   for username in ${users[@]}; do 
       rsync --rsh=ssh -iavrhz \
           "$1@$ip:/home/$username" "/Users/$1/Desktop/ServerBackups"
   done
done < <(awk 'NR>1' ~/Dropbox/Documents/Teaching/S318/Spring2021/DataFiles/ip_roster.2.csv)
