#!/usr/bin/env bash

# --------------------------------------------------------------- // tty colors

source $HOME/.config/themes/${THEME}-colors

# ------------------------------------------------------------- // shell colors
# load palette
theme_color() {
  local key=$1
  jq -r ".$key" "$HOME/.config/themes/${THEME}.json"
}

# convert hex to R;G;B
hex2rgb() {
  local hex=${1#"#"}
  printf "%d;%d;%d" "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

# fg escape
color_fg() {
  echo -e "\[\e[38;2;$(hex2rgb "$1")m\]"
}

# bg escape
color_bg() {
  echo -e "\[\e[48;2;$(hex2rgb "$1")m\]"
}

# reset
color_reset() {
  echo -e "\[\e[0m\]"
}
