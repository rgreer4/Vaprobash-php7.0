#!/usr/bin/env bash

echo ">>> Running remote share scripts"

[[ -z $1 ]] && { echo "!!! Vagrant script folder not set, aborting."; exit 1; }
[[ -z $2 ]] && { echo "!!! Vagrant local script folder not set, aborting."; exit 1; }

sudo $1/local-script.sh
sudo $2/localprivate-script.sh
