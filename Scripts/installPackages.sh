#!/bin/bash
# Install additional R packages.
# Usage: ./installPackages.sh hosts

path="$HOME/Dropbox/Documents/Teaching/S318/Spring2021"

# Determine platform. You must use gsed on macOS because it has BSD sed by def.
wplatform='unknown'
unamestr=$(uname)
if [ $unamestr = 'Linux' ]; then
    awk='awk'
    sed='sed'
elif [ "$unamestr" = 'Darwin' ]; then
    awk='gawk'
    sed='gsed'
fi


# Convert newline-delimited file to comma-separated, quoted string.
packages=\"$("$awk" -vORS=, '{ print }' ../DataFiles/packages.txt | "$sed" 's/,$//g; s/,/","/g')\"
# packages=$("$sed" '$ ! s/.*/"&",/; $ s/.*/"&"/' ../DataFiles/packages.txt) 
echo "$packages"
# echo 'Installing packages: c('"$packages"')'

# Build the command.
cmd="Rscript -e 'install.packages(c($packages), repos=\"https://cloud.r-project.org\")'"
echo "$cmd"
# Here, screen is running the commands in the background so that we don't have
# to stay connected while tidyverse compiles.
# screen -d -m "$cmd"
while read line; do
    ssh root@"$line" screen -d -m "$cmd";
done < <(awk -F, 'NR>1 {print $1}' "$path/DataFiles/ip_roster.csv")
