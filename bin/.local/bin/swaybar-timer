#!/usr/bin/env bash
set -euo pipefail

source "$HOME/.config/wmenu/colors.sh"

WMENU_SCHEME="${WMENU_SCHEME:-perona}"
declare -n scheme="$WMENU_SCHEME"

# use per-user runtime file
TIMER_FILE="${XDG_RUNTIME_DIR}/timer-$UID"

# cleanup on exit
trap 'rm -f "$TIMER_FILE"' EXIT

# remove stale timer file if it exists
[ -f "$TIMER_FILE" ] && rm -f "$TIMER_FILE"

timer() {
  while [ $TOTAL_SECONDS -gt 0 ]; do
    MIN=$(printf "%02d" $((TOTAL_SECONDS / 60)))
    SEC=$(printf "%02d" $((TOTAL_SECONDS % 60)))
    echo -ne "$MIN:$SEC" >"$TIMER_FILE"
    sleep 1
    ((TOTAL_SECONDS--))
  done
  # final display
  echo "00:00" >"$TIMER_FILE"
  pw-play /usr/share/sounds/freedesktop/stereo/bell.oga
  #  espeak -p 99 "Timer ended"
  notify-send --wait "Timer ended"
}

prompt() {
  MINUTES=$(wmenu -i -f 'Cozette 11' "${scheme[@]}" -p "Timer (minutes):" <&-) || exit 0

  # validate numeric input
  if ! [[ "$MINUTES" =~ ^[0-9]+$ ]]; then
    echo "Invalid input: must be a number" >&2
    exit 1
  fi

  TOTAL_SECONDS=$((MINUTES * 60))
  timer &
}

prompt
