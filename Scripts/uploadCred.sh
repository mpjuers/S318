#!/bin/bash

while read ip; do
    ssh-copy-id -i ~/.ssh/id_rsa_work mpjuers@"$ip"
done < <(awk -F "," 'NR>1 {print $1}' ip_roster.csv)
