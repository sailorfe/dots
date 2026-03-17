#!/usr/bin/env bash

mpd="$(player-status)"
volume="󱄠  $(wpctl get-volume @DEFAULT_SINK@ | sed 's/Volume: //')"
disk="󱛟  $(df /home | awk '/^\/dev/ {print $5}')"
memory="󰍛 $(free -h | awk '/^Mem/ {print $3}')"
asc="$(asc)"
et="$(date +'%a %F %H:%M') ET"
utc="$(date -u +'%H:%M') UTC"
wifi="󰖩  $(nmcli device | awk '/^wlan0/ {print $1}') $(nmcli device | awk '/^wlan0/ {print $3}') $(ip addr | grep 'inet 192' | awk '{print $2}')"

BATTERY=$(acpi -b)
STATUS=$(echo "$BATTERY" | awk -F '[, ]' '{print $3}')
PERCENT=$(echo "$BATTERY" | awk -F '[, %]' '{print $5}')
REMAINING=$(echo "$BATTERY" | awk -F '[, ]' '{print $7}')

if [ "$PERCENT" -gt 90 ]; then
  ICON="󰁹"
elif [ "$PERCENT" -gt 70 ]; then
  ICON="󰂀"
elif [ "$PERCENT" -gt 50 ]; then
  ICON="󰁾"
elif [ "$PERCENT" -gt 30 ]; then
  ICON="󰁼"
else
  ICON="󰁺"
fi

case "$STATUS" in
Charging)
  ICON="󱐋"
  LABEL="$ICON $PERCENT% $REMAINING until full"
  ;;
Full)
  ICON="󰂄"
  LABEL="$ICON Full"
  ;;
"Not charging")
  ICON=""
  LABEL="$ICON $PERCENT% (not charging)"
  ;;
Discharging)
  LABEL="$ICON $PERCENT% $REMAINING remaining"
  ;;
Unknown)
  LABEL="$ICON $PERCENT% (unknown)"
  ;;
*)
  LABEL="$ICON $PERCENT% ($STATUS)"
  ;;
esac

juice="$LABEL"

echo "$mpd | $volume | $disk | $memory | $wifi | $juice | $asc | $et | $utc"
