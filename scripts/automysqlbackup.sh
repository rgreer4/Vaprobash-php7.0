#!/usr/bin/env bash

echo ">>> Installing Automysqlbackup"

[[ -z $1 ]] && { echo "!!! DB backup folder not set, aborting."; exit 1; }
[[ -z $2 ]] && { echo "!!! MySQL root password not set. Check the Vagrant file."; exit 1; }

database_backup_folder="$1"

sudo mkdir /usr/local/src/automysqlbackup
cd /usr/local/src/automysqlbackup
sudo wget http://downloads.sourceforge.net/project/automysqlbackup/AutoMySQLBackup/AutoMySQLBackup%20VER%203.0/automysqlbackup-v3.0_rc6.tar.gz
sudo tar xvzf automysqlbackup-v3.0_rc6.tar.gz
sudo echo -en "\n\n" | sudo ./install.sh
sudo chmod a+r /etc/automysqlbackup/*

sudo bash -c "cat >> /etc/automysqlbackup/automysqlbackup.conf << EOF
CONFIG_mysql_dump_password='root'
CONFIG_backup_dir='$1'
CONFIG_mysql_dump_create_database='yes'
CONFIG_mysql_dump_use_separate_dirs='no'
CONFIG_mysql_dump_latest='no'
CONFIG_db_exclude=('information_schema' 'performance_schema')
EOF"

sudo bash -c "sudo cat > /etc/cron.daily/automysqlbackup << EOF
#!/bin/sh

/usr/local/bin/automysqlbackup /etc/automysqlbackup/automysqlbackup.conf

#do the latest here, to avoid Windows symlinks issue.
sudo rm "$1/latest/latest.sql.gz"
sudo rm "$1/latest/latest.sql"
sudo cp "$1/daily/FINDLATEST" "$1/latest/latest.sql.gz"
sudo gunzip "$1/latest/latest.sql.gz"

sudo chown vagrant.vagrant "$1" -R
sudo chmod -R a-x+X "$1"
EOF"

sudo sed -i 's/FINDLATEST/$(ls -Art \/vagrant\/sqlbackup\/daily | tail -n 1)/' /etc/cron.daily/automysqlbackup
sudo chmod +x /etc/cron.daily/automysqlbackup
