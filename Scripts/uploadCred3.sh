#!/bin/bash
# Upload ssh keys to VMs.

# Usage: ./uploadCred.sh <admin name> < admins.csv
#

read -a ips <<< $(awk -F, 'NR > 1 { print $1 }' ../DataFiles/ip_roster.csv)

# Determine platform. You must use gsed on macOS because it has BSD sed by def.
wplatform='unknown'
unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
   awk='awk'
elif [ "$unamestr" = 'Darwin' ]; then
   awk='gawk'
fi

while read line; do
    IFS=',' read -a linearr <<< "$line"
        username="${linearr[0]}"
    if [ -z ${adminname} ]; then
        adminname="$username"
        echo Admin name not supplied. Set to "$adminname".
    else
        tmp=$(mktemp)
        tmp+=.pub
        echo "$publickey" > "$tmp"
        for ip in "${ips[@]}"; do
            echo Creating "$username" on "$ip" using admin account "$adminname".
            cmd="sudo useradd -m -G users $username "
            ssh  "$adminname"@"$ip" -ntt "$cmd"

            echo "$publickey": $([[ "$publickey" != none ]])
            if [[ "$publickey" != "none" ]]; then
                echo Copying "$username"\'s public key to "$ip".
                ssh-copy-id -i "$tmp" "$username"'@'"$ip" || true
            fi
            
            echo Setting default password \'my_password\' for user "$username".
            ssh -ntt root@"$ip" 'printf "%s\n" my_password my_password | passwd' "$username" 
        done
    fi 
done
