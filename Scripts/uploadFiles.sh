#!/bin/bash
# Usage: ./uploadFiles.sh < ips_no_header.csv

rootpath="/Users/mpjuers/Desktop/ServerBackupsPush"
# adminname=$1

while IFS=, read ip _ users; do
    for user in ${users[@]}; do
        echo "Syncing files in $rootpath/$user/ to $ip:/home/$user."
        rsync --chown="$user:users" --exclude=".*" -avhuR \
            "$rootpath/$user/" "root@$ip:/home/$user"
        # ssh -n "$adminname@$ip" chown -R "$user" "/home/$user/Labs"
    done
done < <(awk 'NR>1' ~/Dropbox/Documents/Teaching/S318/Spring2021/DataFiles/ip_roster.2.csv)
