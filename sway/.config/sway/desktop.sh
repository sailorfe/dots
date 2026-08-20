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
    local iface="wlp4s0" wifi_state wifi_ip
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

main() {
    local i=0
    local disk_cache wifi_cache

    while true; do
        # cheap/fast metrics: refresh every iteration
        local mpd volume cpu_temp et_utc
        mpris="$(get_mpris)"
        volume="$(get_volume)"
        cpu_temp="$(get_cpu_temp)"
        et_utc="$(get_time)"

        # expensive/slow metrics: refresh every 10th iteration
        if (( i % 10 == 0 )); then
            disk_cache="$(get_disk)"
            wifi_cache="$(get_wifi)"
        fi

        echo "$mpris | $volume | $disk_cache | $(get_memory) | $cpu_temp | $wifi_cache | $(asc) | $et_utc"

        ((i++))
        sleep 1
    done
}

main
