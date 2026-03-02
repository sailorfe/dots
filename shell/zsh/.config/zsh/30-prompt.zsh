#          __
# ___ ___ / /  ________
#/_ /(_-</ _ \/ __/ __/
#/__/___/_//_/_/  \__/
#
# ------------------------------------------------------------- // shell prompt
FG_TIME=$(theme_color magenta)
FG_DIR=$(theme_color white)
FG_VENV=$(theme_color brightCyan)
FG_GIT=$(theme_color brightMagenta)
FG_GLYPH=$(theme_color magenta)
NEWLINE=$'\n'

# helper for colors
colorize() {
  local type=$1; shift
  local code=$1; shift
  echo "%${type}{${code}}$*%${type,,}"
}

# get git info efficiently
git_info() {
  local branch git_status symbol
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  git_status=$(git status --porcelain 2>/dev/null)
  [[ -n $git_status ]] && symbol="*" || symbol=""
  echo " %F{$FG_GIT}$branch$symbol%f"
}

# helper for virtualenv
venv_info() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "%F{$FG_VENV}($(basename $VIRTUAL_ENV))%f "
  fi
}

set_prompt() {
  local clock prompt_user current_dir fun_glyph venv gitinfo

	clock="%B%F{$FG_TIME}$(date +%H:%M:%S)%f%b "
  venv=$(venv_info)
  current_dir="%F{$FG_DIR}%2~%f"
  gitinfo=$(git_info)
  fun_glyph=" %F{$FG_GLYPH}%f "

  PROMPT="$NEWLINE${venv}${clock}${current_dir}${gitinfo}${fun_glyph}"
}

precmd_functions+=(set_prompt)

if uptime -p >/dev/null 2>&1; then
  up="$(uptime -p | cut -c 4-)"
else
  up="$(uptime | sed 's/.* up \([^,]*\),.*/\1/')"
fi

echo -e "\e[1;40m $(hostname) \e[0m\e[0;46m\e[30m $up \e[0m \e[0m\e[1;36m$(uname -r)\e[0m"
