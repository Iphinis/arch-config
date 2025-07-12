#!/usr/bin/env bash

# battery threshold
THRESHOLD=10

CAPACITY_FILE="/sys/class/power_supply/BAT0/capacity"
STATUS_FILE="/sys/class/power_supply/BAT0/status"

bat_capacity=$(cat "$CAPACITY_FILE")
bat_status=$(cat "$STATUS_FILE")

if [[ "$bat_status" == "Discharging" && "$bat_capacity" -le "$THRESHOLD" ]]; then
    FLAG_FILE="/tmp/.battery_low_notified"
    if [[ ! -f "$FLAG_FILE" ]]; then
        notify-send -u critical "Battery low" "${bat_capacity}% remaining"
        touch "$FLAG_FILE"
    fi
else
    rm -f /tmp/.battery_low_notified
fi

