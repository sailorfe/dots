#!/usr/bin/env bash

get_mpris() {
    player-status
}

get_volume() {
    local raw_vol vol_num vol_icon
    raw_vol="$(wpctl get-volume @DEFAULT_SINK@)"
    vol_num=$(awk '{print int($2 * 100)}' <<< "$raw_vol")

    if [[ "$raw_vol" == *"[MUTED]"* ]]; then
        echo "󰝟 muted"
        return
    fi

    if (( vol_num >= 60 )); then
        vol_icon="󰕾"
    elif (( vol_num >= 30 )); then
        vol_icon="󰖀"
    elif (( vol_num >= 1 )); then
        vol_icon="󰕿"
    else
        vol_icon="󰝟"
    fi

    echo "$vol_icon ${vol_num}%"
}

get_cpu_temp() {
    local raw_temp temp_icon
    raw_temp="$(cat /sys/class/hwmon/hwmon2/temp1_input 2>/dev/null)" || { echo "󰔏 N/A"; return; }

    if (( raw_temp >= 75000 )); then
        temp_icon="󰸁"
    else
        temp_icon="󰔏"
    fi

    echo "$temp_icon $(( raw_temp / 1000 ))°C ($(( (raw_temp * 9 / 5000) + 32 ))°F)"
}

get_disk() {
    echo "󱛟 $(df /home | awk '/^\/dev/ {print $5}')"
}

get_memory() {
    echo "󰐰 $(free -h | awk '/^Mem/ {print $3}')"
}

get_wifi() {
    local wifi_state wifi_ip

    case "$(hostname)" in
        northblue)
            local iface="wlp4s0"
            ;;
        thousandsunny)
            local iface="wlan0"
            ;;
    esac

    wifi_state=$(ip -o link show "$iface" | awk '{print $9}')
    wifi_ip=$(ip -4 -o addr show "$iface" | awk '{print $4}' | cut -d'/' -f1)
    echo "󰖩  $iface $wifi_state $wifi_ip"
}

get_time() {
    local et utc
    et="$(date +'%a %F %H:%M') ET"
    utc="$(date -u +'%H:%M') UTC"
    echo "$et / $utc"
}

get_ascendant() {
    if ! command -v asc &> /dev/null; then
        echo "Install sailorfe/ascendant from PyPI or Codeberg."
    else
        echo "$(asc)"
    fi
}

get_battery() {
    local battery status percent remaining icon label

    battery=$(acpi -b 2>/dev/null) || { echo "󰂑 N/A"; return; }
    status=$(awk -F '[, ]' '{print $3}' <<< "$battery")
    percent=$(awk -F '[, %]' '{print $5}' <<< "$battery")
    remaining=$(awk -F '[, ]' '{print $7}' <<< "$battery")

    if (( percent > 90 )); then
        icon="󰁹"
    elif (( percent > 70 )); then
        icon="󰂀"
    elif (( percent > 50 )); then
        icon="󰁾"
    elif (( percent > 30 )); then
        icon="󰁼"
    else
        icon="󰁺"
    fi

    case "$status" in
        Charging)
            icon="󱐋"
            label="$icon $percent% $remaining until full"
            ;;
        Full)
            icon="󰂄"
            label="$icon Full"
            ;;
        "Not charging")
            icon=""
            label="$icon $percent% (not charging)"
            ;;
        Discharging)
            label="$icon $percent% $remaining remaining"
            ;;
        Unknown)
            label="$icon $percent% (unknown)"
            ;;
        *)
            label="$icon $percent% ($status)"
            ;;
    esac

    echo "$label"
}

main() {
    local i=0
    local disk_cache wifi_cache

    while true; do
        local mpris volume cpu_temp et_utc battery ascendant
        mpris="$(get_mpris)"
        volume="$(get_volume)"
        cpu_temp="$(get_cpu_temp)"
        et_utc="$(get_time)"
        battery="$(get_battery)"
        ascendant="$(get_ascendant)"

        if (( i % 10 == 0 )); then
            disk_cache="$(get_disk)"
            wifi_cache="$(get_wifi)"
        fi

        case "$(hostname)" in
            northblue)
                echo "$mpris | $volume | $disk_cache | $(get_memory) | $cpu_temp | $wifi_cache | $ascendant | $et_utc"
                ((i++))
                sleep 1
                ;;
            thousandsunny)
                echo "$mpris | $volume | $disk_cache | $(get_memory) | $cpu_temp | $wifi_cache | $battery | $ascendant | $et_utc"
                ((i++))
                sleep 1
                ;;
        esac

    done
}

main
