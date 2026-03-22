#!/usr/bin/env bash

if [ "$THEME" != "perona" ]; then
  BEMENU_ARGS=(
    --tb "${COLOR_BLACK}"
    --tf "${COLOR_BRIGHT_WHITE}"
    --fb "${COLOR_BACKGROUND}"
    --ff "${COLOR_FOREGROUND}"
    --nb "${COLOR_BACKGROUND}"
    --nf "${COLOR_FOREGROUND}"
    --ab "${COLOR_BACKGROUND}"
    --af "${COLOR_FOREGROUND}"
    --hb "${COLOR_MAGENTA}"
    --hf "${COLOR_BLACK}"
    --sb "${COLOR_MAGENTA}"
    --sf "${COLOR_BLACK}"
    --fn "Cozette 11"
    --hp 6
    --line-height 25
  )
else
  BEMENU_ARGS=(
    --tb "${COLOR_BLACK}"
    --tf "${COLOR_BRIGHT_WHITE}"
    --fb "${COLOR_BACKGROUND}"
    --ff "${COLOR_FOREGROUND}"
    --nb "${COLOR_BACKGROUND}"
    --nf "${COLOR_FOREGROUND}"
    --ab "${COLOR_BACKGROUND}"
    --af "${COLOR_FOREGROUND}"
    --hb "${COLOR_CYAN}"
    --hf "${COLOR_BLACK}"
    --sb "${COLOR_CYAN}"
    --sf "${COLOR_BLACK}"
    --fn "Cozette 11"
    --hp 6
    --line-height 22
  )
fi
