#!/bin/bash

BAT0=$(</sys/class/power_supply/BAT0/capacity)

CHR=$(</sys/class/power_supply/AC/online)

CHR_TEXT=""
[[ $CHR = '1' ]] && CHR_TEXT=' (CHR)'

echo "<u>BAT0</u>:<b>$BAT0%</b><i>$CHR_TEXT</i>"
