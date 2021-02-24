
bash-3.2$ pssh --user root -h <(awk -F, 'NR>2 {print $1}' ~/Dropbox/Documents/Teaching/S3
8/Spring2021/DataFiles/ip_roster.csv) 'printf "%s\n" new_pass new_pass | passwd'8
