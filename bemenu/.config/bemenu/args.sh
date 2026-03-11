#!/usr/bin/env bash

source "$HOME/.config/themes/init.sh"

if [ $THEME_NAME == "perona" ]; then
  ACCENT="$COLOR_CYAN"
else
  ACCENT="$COLOR_MAGENTA"
fi

BEMENU_ARGS=(
  --tb "$COLOR_BLACK"
  --tf "$COLOR_BRIGHT_WHITE"
  --fb "$COLOR_BACKGROUND"
  --ff "$COLOR_FOREGROUND"
  --nb "$COLOR_BACKGROUND"
  --nf "$COLOR_FOREGROUND"
  --ab "$COLOR_BACKGROUND"
  --af "$COLOR_FOREGROUND"
  --hb "$ACCENT"
  --hf "$COLOR_BLACK"
  --sb "$ACCENT"
  --sf "$COLOR_BLACK"
  --fn "Cozette 11"
  --hp 6
  --line-height 20
)
