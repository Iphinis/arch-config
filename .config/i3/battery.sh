#!/bin/bash

BAT0=$(</sys/class/power_supply/BAT0/capacity)

CHR=$(</sys/class/power_supply/AC/online)

CHR_TEXT=""
[[ $CHR = '1' ]] && CHR_TEXT=' (CHARGING)'

echo "BAT0:$BAT0%$CHR_TEXT"
