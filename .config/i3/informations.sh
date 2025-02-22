#!/bin/bash

path=$(dirname "$0")

network=$($path/network.sh 2>/dev/null || echo "No network info or bash script error")

battery=$($path/battery.sh 2>/dev/null || echo "No battery info available or bash script error")

date=$(date +"%A %H:%M:%S %d/%m (week %V of %Y)")

title='Infos'
body="\n$network\n\n$battery\n\n$date"

notify-send "$title" "$body" -t 3000
