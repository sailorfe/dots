#!/usr/bin/env bash

FG_DIR=$(theme_color bright_magenta)
FG_VENV=$(theme_color bright_cyan)
FG_GIT=$(theme_color white)
FG_GLYPH=$(theme_color magenta)

venv_prompt() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
		echo "$(color_fg $FG_VENV)($(basename "$VIRTUAL_ENV"))$(color_reset) "
  fi
}

git_info() {
  local branch git_status symbol
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  git_status=$(git status --porcelain 2>/dev/null)
  [[ -n $git_status ]] && symbol="*" || symbol=""
  echo -n " $(color_fg $FG_GIT)$branch$symbol$(color_reset)"
}

set_prompt() {
  PS1="\n"
	PS1+=$(venv_prompt)
  PS1+=$(color_fg $FG_DIR)"\w"$(color_reset)
  PS1+=$(git_info)
  PS1+=$(color_fg $FG_GLYPH)" $ "$(color_reset)
}

PROMPT_COMMAND=set_prompt
