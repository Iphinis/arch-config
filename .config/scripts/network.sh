#!/bin/bash

wlan0=$(</sys/class/net/wlan0/operstate)
eno1=$(</sys/class/net/eno1/operstate)

wlan0_text='<u>wlan0</u>'
eno1_text='<u>eno1</u>'

if [ $eno1 = "up" ]; then
	if [ $wlan0 = "up" ]; then 
		echo "$wlan0_text,$eno1_text:<b>up</b>"
	else
		echo "$eno1_text:<b>$eno1</b>"
	fi
else
	echo "$wlan0_text:<b>$wlan0</b>"
fi
