#!/usr/bin/env bash

mpd="$(player-status)"
volume="󱄠  $(wpctl get-volume @DEFAULT_SINK@ | sed 's/Volume: //')"
disk="󱛟  $(df /home | awk '/^\/dev/ {print $5}')"
memory="󰍛 $(free -h | awk '/^Mem/ {print $3}')"
asc="$(asc)"
#pomo="󰔟 $(cat /tmp/timer)"
et="$(date +'%a %F %H:%M')"
utc="$(date -u +' %H:%M')"

wifi="󰖩  $(nmcli device | awk '/^wlp61s0/ {print $1}') $(nmcli device | awk '/^wlp61s0/ {print $3}') $(ip addr | grep 'inet 192' | awk '{print $2}')"
battery="󱐋 $(cat /sys/class/power_supply/BAT0/capacity)% $(cat /sys/class/power_supply/BAT0/status)"

# if [[ -f "/tmp/timer" ]]; then
# 	echo "$mpd $volume | $disk | $memory | $wifi | $battery | $asc | $et ET$utc UTC | $pomo"
# else
# 	echo "$mpd $volume | $disk | $memory | $wifi | $battery | $asc | $et ET$utc UTC"
# fi

echo "$mpd $volume | $disk | $memory | $wifi | $battery | $asc | $et ET$utc UTC"
