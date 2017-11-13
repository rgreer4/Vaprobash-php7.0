#!/usr/bin/env bash

echo ">>> Running remote share scripts"

[[ -z $1 ]] && { echo "!!! Vagrant script folder not set, aborting."; exit 1; }
[[ -z $2 ]] && { echo "!!! Vagrant local script folder not set, aborting."; exit 1; }

$1/local-script-nopriv.sh
$2/localprivate-script-nopriv.sh
