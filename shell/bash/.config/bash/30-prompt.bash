#!/usr/bin/env bash

BG_HOST=$(theme_color black)
BG_USER=$(theme_color bright_black)
BG_DIR=$(theme_color magenta)
FG_HOST=$(theme_color fg)
FG_DIR=$(theme_color bg)
FG_GIT=$(theme_color white)
FG_GLYPH=$(theme_color cyan)

venv_prompt() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo " ($(basename "$VIRTUAL_ENV")) "
  fi
}

git_info() {
  local branch git_status symbol
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  git_status=$(git status --porcelain 2>/dev/null)
  [[ -n $git_status ]] && symbol="*" || symbol=""
  echo -n "$(color_fg $FG_GIT)$branch$symbol$(color_reset)"
}

set_prompt() {
  PS1="\n"
	PS1+=$(venv_prompt)
	PS1+=$(color_bg $BG_HOST)$(color_fg $FG_HOST)" $(hostname) "$(color_reset)
  PS1+=$(color_bg $BG_USER)$(color_fg $FG_HOST)" \u "$(color_reset)
  PS1+=$(color_bg $BG_DIR)$(color_fg $FG_DIR)" \w "$(color_reset)
  PS1+=" $(git_info) "
  PS1+=$(color_fg $FG_GLYPH)"$ "$(color_reset)
}

PROMPT_COMMAND=set_prompt
