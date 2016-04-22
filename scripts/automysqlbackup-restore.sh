#!/usr/bin/env bash

echo ">>> Restoring last database backup..."

[[ -z $1 ]] && { echo "!!! DB backup folder not set, aborting."; exit 1; }
[[ -z $2 ]] && { echo "!!! MySQL root password not set. Check the Vagrant file."; exit 1; }

if [ -e ${1}/latest/latest.sql ]; then
    mysql -u root -p$2 < ${1}/latest/latest.sql
	echo "${1}/latest/latest.sql imported."
else
	echo "${1}/latest/latest.sql not found, not restoring."
fi
