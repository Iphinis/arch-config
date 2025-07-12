#!/bin/bash

minutes="${1:-1}"

sleep $(( 60 * $minutes ))
notify-send "Time's up" "$minutes minutes elapsed."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
paplay $SCRIPT_DIR/ding-dong.mp3 &

