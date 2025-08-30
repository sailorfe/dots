#          __
# ___ ___ / /  ________
#/_ /(_-</ _ \/ __/ __/
#/__/___/_//_/_/  \__/
#
# ------------------------------------------------------------- // shell prompt
BG_TIME=$(theme_color black)
BG_USER=$(theme_color bright_black)
BG_DIR=$(theme_color magenta)
FG_DIR=$(theme_color fg)
FG_GIT=$(theme_color white)
FG_GLYPH=$(theme_color cyan)
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
  echo "%F{$FG_GIT}$branch$symbol%f"
}

set_prompt() {
  local hostname prompt_user current_dir fun_glyph

  hostname="%K{$BG_TIME} $HOSTNAME %k"
  prompt_user="%K{$BG_USER} %n %k"
  current_dir="%K{$BG_DIR} %F{$FG_DIR}%~%f %k"
  fun_glyph="%F{$FG_GLYPH}  %f"

  PROMPT="${NEWLINE}$hostname$prompt_user$current_dir $(git_info)$fun_glyph"
}

precmd_functions+=(set_prompt)

# Host info banner (runs once)
echo -e "\e[1;40m $(hostname) \e[0m\e[1;46m\e[30m $(uptime -p | cut -c 4-) \e[0m \e[0m\e[1;36m$(uname -r)\e[0m"
