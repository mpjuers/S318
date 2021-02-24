#!/bin/bash

# Usage: ./setupServers.sh < <adminsfile>

awk -F, 'NR>1 {print $1}' ../DataFiles/ip_roster.csv | read -a ips
echo "${ips[@]}"

while read line; do
    read -a line_array <<< "$line"
    pubkeyfile=$(mktemp)
    user="${line_array[0]}"
    pubkey="${line_array[1]}"
    echo "$pubkey" > "$pubkeyfile"
    for ip in "${ips[@]}"; do
        echo uploading "$user"'@'"$ip" public key.
        ssh-copy-id -i "$pubkeyfile" "$user"'@'"$ip"
    done
done
