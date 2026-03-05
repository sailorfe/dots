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
  local key=$1
  jq -r ".$key" "$HOME/.config/themes/$THEME.json"
}

# change background when ssh'd(!)
if [[ -n $SSH_CONNECTION ]]; then
  echo -ne "\033]11;$(theme_color background)\007"
fi

trap 'echo -ne "\033]111\007"' EXIT
