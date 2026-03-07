#!/usr/bin/env bash

volume="Volume:  $(wpctl get-volume @DEFAULT_SINK@ | sed 's/Volume: //')"
disk="Disk:  $(df /home | awk '/^\/dev/ {print $5}')"
memory="Mem: $(free -h | awk '/^Mem/ {print $3}')"
et="$(date +'%a %F %H:%M') ET"
utc="$(date -u +'%H:%M') UTC"

echo "$volume | $disk | $memory | $et $utc"
