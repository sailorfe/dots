#!/usr/bin/env bash

mpd="$(player-status)"
volume="󱄠  $(wpctl get-volume @DEFAULT_SINK@ | sed 's/Volume: //')"
disk="󱛟  $(df /home | awk '/^\/dev/ {print $5}')"
memory="󰍛 $(free -h | awk '/^Mem/ {print $3}')"
asc="$(asc)"
et="$(date +'%a %F %H:%M') ET"
utc="$(date -u +'%H:%M') UTC"

wifi="󰖩  $(nmcli device | awk '/^wlan0/ {print $1}') $(nmcli device | awk '/^wlan0/ {print $3}') $(ip addr | grep 'inet 192' | awk '{print $2}')"
battery="󱐋 $(cat /sys/class/power_supply/BAT0/capacity)% $(cat /sys/class/power_supply/BAT0/status)"

echo "$mpd | $volume | $disk | $memory | $wifi | $battery | $asc | $et ($utc)"
