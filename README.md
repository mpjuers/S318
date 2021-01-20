    Copyright 2021 Mark Juers
    Assorted Scripts for S318 VM setup.
    Usage: ./vmsetup.sh

# Assorted scripts for setting up S318 VMs.

## Data Files
- ip_roster.csv: Mapping between ip addresses and users. Servers do not have
  to be named, but, students must be in the third column
  *delimited by spaces rather than commas*.
- admins.csv: Comma-delimited text file containing the names of all admins
  and their associated ssh public keys, with a '>' between entries.

## Scripts
- addUsers.sh: Add student users, according to ip_roster.csv
    - Usage: ./addUsers.sh < ip_roster.csv
- addAdmins.sh: Add instructor and TA sudo accounts.
    - Usage: ./addAdmins.sh < admins.txt
