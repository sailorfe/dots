#!/usr/bin/env bash

source "$HOME/.config/themes/init.sh"

if [ $THEME_NAME == "perona" ]; then
  ACCENT="$COLOR_CYAN"
else
  ACCENT="$COLOR_MAGENTA"
fi

BEMENU_ARGS=(
  --tb "$ACCENT"
  --tf "$COLOR_BACKGROUND"
  --fb "$COLOR_BACKGROUND"
  --ff "$COLOR_FOREGROUND"
  --nb "$COLOR_BACKGROUND"
  --nf "$COLOR_FOREGROUND"
  --ab "$COLOR_BACKGROUND"
  --af "$COLOR_FOREGROUND"
  --hb "$COLOR_BRIGHT_BLACK"
  --hf "$COLOR_FOREGROUND"
  --sb "$COLOR_BRIGHT_BLACK"
  --sf "$COLOR_FOREGROUND"
  --fn "Cozette 11"
  --hp 6
  --line-height 20
)
