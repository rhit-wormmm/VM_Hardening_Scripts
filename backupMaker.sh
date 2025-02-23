#!/usr/bin/env bash

# Mason (Created Winter 2025)

# Script for using rsync to setup backups

backupDir=""
src=""

# Reads the directory to backup
read -r -p "Enter src to backup: " src

if ! src then
    echo "invalid src"
    exit 1
fi

# reads the directory you want to save src to
read -r -p "Enter backup directory: " backupDir

# makes directory
if !backupDir then
    mkdir "$HOME/$backupDir"
fi
# makes backup
if ["$src" ="/"]; then
    sudo rsync -aAXv --delete --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / "$HOME/$backupDir"
fi
# rsync -av $src "$HOME/$backupDir"

# adjust ownerhsip of backup to root
chown  -R root:root "$HOME/$backupDir"

# restricts access to root
chmod -R 500 "$HOME/$backupDir"


