#!/bin/bash

path=$(dirname "$0")

network=$($path/network.sh 2>/dev/null || "No info")

battery=$($path/battery.sh 2>/dev/null || "No info")

date=$(date +"<u>%a %d/%m</u> <b>%H:%M:%S</b> <i>(week %V)</i>")

	titles=('d[ o_0 ]b' '⌐(ಠ۾ಠ)¬' '~(‾▿‾)~' '‹(•_•)›' '(◣_◢)' 'd(^o^)b' '\(^-^)/' '╰(◣‿◢)╯' 'i use arch btw' 'ʕ•ᴥ•ʔ' '(◕‿◕)' '(⌐■_■)' 'ᕦ(ò_ó)ᕤ' '(ಠ_ಠ)' '(◢_◣)' '(ಠ_x)' '(╯°□°)╯ ┻━┻')
rnd_idx=$((RANDOM % ${#titles[@]}))
title=${titles[$rnd_idx]}
body="\n$date\n\n$battery\n\n$network"

notify-send "$title" "$body" -t 5000 --hint=string:x-dunst-stack-tag:informations-notification
