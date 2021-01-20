#!/bin/bash
# Copyright 2021 Mark Juers
# Create user accounts for students via ssh.
#
# Usage: ./addUsers.sh < <ip_roster.csv>
# -----------------------------------------------------------------------------

# Determine platform. You must use gsed on macOS because it has BSD sed by def.
wplatform='unknown'
unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
   sed='sed'
elif [ "$unamestr" = 'Darwin' ]; then
   sed=gsed
fi

while read line; do
    # Get rid of newlines at end of line.
    IFS=$',' read -a line_array < <("$sed" 's/\r//g' <<< "$line")
    # Create array of users for the read line.
    IFS=$' ' read -a users <<< ${line_array[2]}
    ip_addy=${line_array[0]}
    for user in "${users[@]}"; do
        # Build the ssh command.
        cmd='/usr/bin/sudo /usr/sbin/useradd -m '"$user"' || true'
        cmd+=' && /bin/echo '\'"$user"':learningR'\'' | /usr/bin/sudo /usr/sbin/chpasswd'
        cmd+=' && /usr/bin/sudo /usr/sbin/usermod -a -G users '"$user"
        # Do the work.
        echo creating "$user"'@'"$ip_addy" && \
            ssh -i ~/.ssh/id_rsa_work -ntt 'mpjuers@'"$ip_addy" "$cmd"
    done
done
