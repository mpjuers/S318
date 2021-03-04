#!/bin/bash
# Upload ssh keys to VMs.

# Usage: ./uploadCred.sh <admin name> < admins.csv
#
ips=$(awk -F, 'NR > 1 { print $1 }' ../DataFiles/ip_roster.csv)

# Determine platform. You must use gsed on macOS because it has BSD sed by def.
wplatform='unknown'
unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
   awk='awk'
elif [ "$unamestr" = 'Darwin' ]; then
   awk='gawk'
fi

read -a ips <<< $("$awk" -F, 'NR > 1 {print $1}' ../DataFiles/ip_roster.csv)
if [[ $# != 0 ]]; then
    adminname=$1
    echo Admin name supplied set to "$adminname".
fi

while read line; do
    IFS=$',' read -a line_array <<< "${line}"
    publickey="${line_array[1]}"
    username="${line_array[0]}"
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
            cmd+="&& echo \'$username:my_password\' | sudo chpasswd"

            ssh  "$adminname"@"$ip" -ntt "$cmd"

            echo "$publickey": $([[ "$publickey" != none ]])
            if [[ "$publickey" != "none" ]]; then
                echo Copying "$username"\'s public key to "$ip".
                ssh-copy-id -i "$tmp" "$username"'@'"$ip" || true
            fi
            
            echo Setting default password \'my_password\' for user "$username".
            # ssh -ntt root@"$ip" echo \'"$username":my_password\' | sudo chpasswd
            pssh -h "${ips[@]}" 'printf "%s\n" old_pass new_pass new_pass | passwd'
        done
    fi 
done
