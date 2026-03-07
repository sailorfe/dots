#!/usr/bin/env bash
TIMER_FILE="${XDG_RUNTIME_DIR}/timer-$UID"

while true; do
    if [ -f "$TIMER_FILE" ]; then
        cat "$TIMER_FILE"
    else
        echo "⏱"  # Default icon when no timer is running
    fi
    sleep 1
done
