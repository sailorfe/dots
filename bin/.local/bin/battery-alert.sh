#!/usr/bin/env bash

THRESHOLD=20
CHECK_INTERVAL=60

while true; do
    BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

    if [ "$BATTERY_LEVEL" -le "$THRESHOLD" ] && [ "$STATUS" = "Discharging" ]; then
        notify-send -u critical "Battery Low" "Level: ${BATTERY_LEVEL}%"
    fi

    sleep "$CHECK_INTERVAL"
done
