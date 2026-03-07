#!/usr/bin/env bash

mpd="$(player-status)"
volume="󱄠  $(wpctl get-volume @DEFAULT_SINK@ | sed 's/Volume: //')"
disk="󱛟  $(df /home | awk '/^\/dev/ {print $5}')"
memory="󰍛 $(free -h | awk '/^Mem/ {print $3}')"
et="$(date +'%a %F %H:%M') ET"
utc="$(date -u +'%H:%M') UTC"
asc="$(asc)"
wifi="󰖩  $(nmcli device | awk '/^wlx7419f816d5c2/ {print $1}') $(nmcli device | awk '/^wlx7419f816d5c2/ {print $3}') $(ip addr | grep 'inet 192' | awk '{print $2}')"

echo "$mpd | $volume | $disk | $memory | $wifi | $asc | $et ($utc)"
