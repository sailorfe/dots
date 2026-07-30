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

wifi_state=$(ip -o link show wlp4s0 | awk '{print $9}')
wifi_ip=$(ip -4 -o addr show wlp4s0 | awk '{print $4}' | cut -d'/' -f1)

wifi="󰖩  wlp4s0 $wifi_state $wifi_ip"

echo "$mpd | $volume | $disk | $memory | $wifi | $asc | $et / $utc"
