#!/usr/bin/env bash

mpd="$(player-status)"

raw_vol=$(wpctl get-volume @DEFAULT_SINK@ | sed 's/Volume: //')

int_vol=$(echo "$raw_vol" | awk '{print $1 * 100}' | cut -d'.' -f1)

if [ "$int_vol" -ge 60 ]; then
  vol_icon="󰕾"
elif [ "$int_vol" -ge 30 ]; then
  vol_icon="󰖀"
elif [ "$int_vol" -ge 1 ]; then
  vol_icon="󰕿"
fi

if [[ "$raw_vol" == *"[MUTED]"* ]]; then
  vol_icon="󰝟"
  volume="$vol_icon $raw_vol"
else
  volume="$vol_icon $raw_vol"
fi

disk="󱛟  $(df /home | awk '/^\/dev/ {print $5}')"
memory="󰍛 $(free -h | awk '/^Mem/ {print $3}')"
et="$(date +'%a %F %H:%M') ET"
utc="$(date -u +'%H:%M') UTC"
asc="$(asc)"
wifi="󰖩  $(nmcli device | awk '/^wlx7419f816d5c2/ {print $1}') $(nmcli device | awk '/^wlx7419f816d5c2/ {print $3}') $(ip addr | grep 'inet 192' | awk '{print $2}')"

echo "$mpd | $volume | $disk | $memory | $wifi | $asc | $et / $utc"
