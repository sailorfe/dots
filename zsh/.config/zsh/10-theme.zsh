# set theme per host

case "$(hostname)" in
  goingmerry) THEME=perona ;;
  thousandsunny) THEME=luna ;;
  minimerry) THEME=moonqueen ;;
  *) THEME=rose-pine ;;
esac

export THEME

# env vars
source "$HOME/.config/themes/$THEME.sh"
# tty colors
source "$HOME/.config/themes/$THEME.conf"

# change background when ssh'd(!)
if [[ -n $SSH_CONNECTION ]]; then
  echo -ne "\033]11;$COLOR_BACKGROUND\007"
fi

trap 'echo -ne "\033]111\007"' EXIT
