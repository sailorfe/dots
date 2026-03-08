# set theme per host
case "$HOST" in
  goingmerry) THEME=perona ;;
  thousandsunny) THEME=luna ;;
  minimerry) THEME=moonqueen ;;
  *) THEME=rose-pine ;;
esac

# env vars
source "$HOME/.config/themes/$THEME.sh"
# tty colors
source "$HOME/.config/themes/$THEME.conf"

# create theme color function
theme_color() {
  local varname="COLOR_$1"
  echo "${(P)varname}"
}

# change background when ssh'd(!)
if [[ -n $SSH_CONNECTION ]]; then
  echo -ne "\033]11;$COLOR_BACKGROUND\007"
fi

trap 'echo -ne "\033]111\007"' EXIT
