#!/bin/bash

while read line; do
    IFS=$',' read -a line_array < <(gsed 's/\r//g' <<< "$line")
    IFS=$' ' read -a users <<< ${line_array[2]}
    ip_addy=${line_array[0]}
    for user in "${users[@]}"; do
        cmd='/usr/bin/sudo /usr/sbin/useradd -m '"$user"' || true'
        cmd+=' && /bin/echo '\'"$user"':learningR'\'' | /usr/bin/sudo /usr/sbin/chpasswd'
        cmd+=' && /usr/bin/sudo /usr/sbin/usermod -a -G users '"$user"
        echo creating "$user"'@'"$ip_addy" && \
            ssh -i ~/.ssh/id_rsa_work -ntt 'mpjuers@'"$ip_addy" "$cmd"
    done
done < <(awk 'NR>1' ip_roster.csv | gsed 's/,/ /3g')
