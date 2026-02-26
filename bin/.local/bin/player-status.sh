#!/usr/bin/env bash
set -euo pipefail

players=(firefox chromium mpv mpd)
paused_player="mpd"

get_track_info() {
  local p=$1
  local status=$2
  local icon=$3

  local artist
  local title

  artist=$(playerctl --player="$p" metadata artist 2>/dev/null || echo "")
  title=$(playerctl --player="$p" metadata title 2>/dev/null || echo "Unknown Track")

  if [[ -z "$artist" ]]; then
    echo "$icon $title"
  else
    echo "$icon $artist - $title"
  fi
}

track_shown=false

for player in "${players[@]}"; do
  status=$(playerctl --player="$player" status 2>/dev/null || echo "Stopped")
  if [[ "$status" == "Playing" ]]; then
    get_track_info "$player" "$status" "󰐊"
    track_shown=true
    break
  fi
done

if ! $track_shown; then
  status=$(playerctl --player="$paused_player" status 2>/dev/null || echo "Stopped")
  if [[ "$status" == "Paused" || "$status" == "Stopped" ]]; then
    if playerctl --player="$paused_player" metadata title &>/dev/null; then
      get_track_info "$paused_player" "$status" "󰏤"
    else
      echo "󰎇"
    fi
  else
    echo "󰎇"
  fi
fi
