#!/bin/bash

wlan0=$(</sys/class/net/wlan0/operstate)
eno1=$(</sys/class/net/eno1/operstate)

wlan0_text='wlan0'
eno1_text='eno1'

if [ $eno1 = "up" ]; then
	if [ $wlan0 = "up" ]; then 
		echo "$wlan0_text,$eno1_text:up"
	else
		echo "$eno1_text:$eno1"
	fi
else
	echo "$wlan0_text:$wlan0"
fi
