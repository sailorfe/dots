#          __
# ___ ___ / /  ________
#/_ /(_-</ _ \/ __/ __/
#/__/___/_//_/_/  \__/
#
# ------------------------------------------------------------- // shell prompt
BG_HOST=$(theme_color magenta)
FG_HOST=$(theme_color black)
FG_DIR=$(theme_color white)
FG_VENV=$(theme_color bright_cyan)
FG_GIT=$(theme_color bright_magenta)
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
  local hostname prompt_user current_dir fun_glyph venv gitinfo

	cute_host="%K{$BG_HOST} %F{$FG_HOST}%B$HOSTNAME%b%f %k "
  venv=$(venv_info)
  current_dir="%F{$FG_DIR}%2~%f"
  gitinfo=$(git_info)
  fun_glyph=" %F{$FG_GLYPH}%f "

  PROMPT="$NEWLINE${venv}${cute_host}${current_dir}${gitinfo}${fun_glyph}"
}

precmd_functions+=(set_prompt)

# Host info banner (runs once)
echo -e "\e[1;40m $(hostname) \e[0m\e[1;46m\e[30m $(uptime -p | cut -c 4-) \e[0m \e[0m\e[1;36m$(uname -r)\e[0m"
