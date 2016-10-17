#!/usr/bin/env bash

echo ">>> Running remote share scripts"

[[ -z $1 ]] && { echo "!!! Vagrant script folder not set, aborting."; exit 1; }

$1/local-script-nopriv.sh
