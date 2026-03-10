#!/usr/bin/env bash

if [ $THEME_NAME != "perona" ]; then
  ACCENT="$COLOR_MAGENTA"
else
  ACCENT="$COLOR_CYAN"
fi

WMENU_ARGS=(
  -f 'Cozette 11'
  -N "$COLOR_BACKGROUND"
  -n "$COLOR_FOREGROUND"
  -S "$COLOR_BRIGHT_BLACK"
  -s "$COLOR_FOREGROUND"
  -M "$ACCENT"
  -m "$COLOR_BACKGROUND"
)
