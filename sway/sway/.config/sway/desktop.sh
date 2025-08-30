#!/usr/bin/env bash

mpd="$(player-status) | "
volume="󱄠  $(wpctl get-volume @DEFAULT_SINK@ | sed 's/Volume: //')"
disk="󱛟  $(df /home | awk '/^\/dev/ {print $5}')"
memory="󰍛 $(free -h | awk '/^Mem/ {print $3}')"
et="$(date +'%a %F %H:%M')"
utc="$(date -u +' %H:%M')"
asc="$(asc)"
pomo="󰔟 $(cat /tmp/timer)"
ethernet="󰈁 $(nmcli device | grep 'enp0s25' | awk '{print $1}') $(nmcli device | grep 'enp0s25' | awk '{print $3}') $(ip addr | grep 'inet 192' | awk '{print $2}')"

if [[ -f "/tmp/timer" ]]; then
	echo "$mpd$volume | $disk | $memory | $ethernet | $asc | $et ET$utc UTC | $pomo"
else
	echo "$mpd$volume | $disk | $memory | $ethernet | $asc | $et ET$utc UTC"
fi
