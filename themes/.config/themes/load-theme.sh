#!/usr/bin/env bash
# Usage: load-theme.sh key
jq -r ".$1" "$HOME/.config/themes/${THEME}.json"
