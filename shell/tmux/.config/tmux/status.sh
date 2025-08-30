#!/usr/bin/env bash

battery() {
    # works on Linux with upower, or fallback to /sys
    if command -v upower >/dev/null 2>&1; then
        upower -i $(upower -e | grep BAT) | awk '/percentage:/ {print $2}'
    elif [ -r /sys/class/power_supply/BAT0/capacity ]; then
        cat /sys/class/power_supply/BAT0/capacity | sed 's/$/%/'
    else
        echo "nobat"
    fi
}

mem() {
    free -h | awk '/Mem:/ {print $3 "/" $2}'
}

disk() {
    df -h /home | awk 'NR==2 {print $3 "/" $2}'
}

echo "🔋 $(battery) | 🐏 $(mem) | 💾 $(disk)"
