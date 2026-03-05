# set theme per host
case "$HOST" in
  goingmerry) THEME=perona ;;
  thousandsunny) THEME=luna ;;
  *) THEME=moonqueen ;;
esac

# source theme generated from json
source "$HOME/.config/themes/generated/$THEME.sh"

# create theme color function
theme_color() {
  local varname="COLOR_$1"
  echo "${(P)varname}"
}

# change background when ssh'd(!)
if [[ -n $SSH_CONNECTION ]]; then
  echo -ne "\033]11;$(COLOR_BACKGROUND)\007"
fi

trap 'echo -ne "\033]111\007"' EXIT
