#!/bin/bash
# Copyright 2021 Mark Juers
# Create user accounts for students via ssh.
#
# Usage: ./addUsers.sh adminname < <ip_roster.csv>
# -----------------------------------------------------------------------------

# Determine platform. You must use gsed on macOS because it has BSD sed by def.
wplatform='unknown'
unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
   sed='sed'
elif [ "$unamestr" = 'Darwin' ]; then
   sed=gsed
fi

while IFS=, read ip server users; do
    echo "$ip" "$users"
    for username in ${users[@]}; do
        ssh -n "$1@$ip" "sudo useradd -m -G users $username || true &&" \
            "echo '$username:learningR' | sudo chpasswd"
            # The below line fixes my mistake above.
            # "&& sudo mkhomedir_helper $username"
    done
done
