#!/usr/bin/env bash

# Mason (Created Winter 2025)

# Script for using rsync to setup backups

backupDir=""
src=""
# Reads the directory to backup
read -r -p "(1) backup directory or (2) restore directory " choice

case "$choice" in
    1)
        read -r -p "Enter src to backup: " src
        
        if [ ! -d "$src" ]; then
            echo "invalid src"
            exit 1
        fi
        
        # reads the directory you want to save src to
        read -r -p "Enter directory to place backup : " backupDir
        
        # makes directory
        if  [ ! -d "$HOME/$backupDir" ]; then
            mkdir "$HOME/$backupDir"
        fi
        # makes backup
        sudo rsync -aAXv "$src" "$HOME/$backupDir"
        
        # adjust ownerhsip of backup to root
        chown  -R root:root "$HOME/$backupDir"
        
        # restricts access to root
        chmod -R 500 "$HOME/$backupDir"
        
        echo "Backup of $src created at $HOME/$backupDir"
        exit 0
    ;;
    2)
        read -r -p "Enter directory you want to restore: " src
        
        if [ ! -d "$src" ]; then
            echo "invalid src"
            exit 1
        fi
        
        read -r -p "Enter directoy where your backup is: " backupDir
        
        if [ ! -d "$backupDir" ]; then
            echo "invalid backupDir"
            exit 1
        fi
        
        sudo rsync -aAXv --delete "$HOME/$backupDir" "$src"
        
        echo "Restored $src!"
        exit 0
    ;;
    *)
        echo "Invalid input"
        exit 1
    ;;
esac