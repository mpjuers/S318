#!/bin/bash
# Upload ssh keys to VMs.

# Usage: ./uploadCred.sh <admin-username> < admins.csv

# Determine platform. You must use gsed on macOS because it has BSD sed by def.
wplatform='unknown'
unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
   awk='awk'
elif [ "$unamestr" = 'Darwin' ]; then
   awk='gawk'
fi

read -a ips <<< $("$awk" -F, 'NR > 1 {print $1}' ../DataFiles/ip_roster.csv)

while IFS=\n read line; do
    # echo "$line"
    IFS=$',' read -a line_array <<< "${line}"
    publickey="${line_array[0]}"
    username="${line_array[1]}"
    echo Copying publickey for "$publickey"
    echo User Key: "$username"
    for ip in "${ips[@]}"; do
        # echo "$ip"
        tmp=$(mktemp)
        tmp+=.pub
        echo "$publickey" > "$tmp"
        ssh-copy-id -i "$tmp" "$username"'@'"$ip"
    done
done
