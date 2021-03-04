#!/bin/bash

for user in ~/Desktop/ServerBackups/*; do
    echo "Syncing $user to $HOME/Desktop/ServerBackupsPush/${user##*/}"
    rsync -avhu "$user/" "$HOME/Desktop/ServerBackupsPush/${user##*/}"
done
