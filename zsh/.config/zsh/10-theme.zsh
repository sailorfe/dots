# set theme per host

case "$(hostname)" in
  goingmerry)
    THEME=perona
    TERM_FONT_SIZE=10.0
    ;;
  thousandsunny)
    THEME=luna
    TERM_FONT_SIZE=14.0
    ;;
  minimerry)
    THEME=moonqueen ;;
  skypiea)
    THEME=perona ;;
  localhost) THEME=rose-pine ;;
esac

export THEME
export TERM_FONT_SIZE

# env vars
source "$HOME/.config/themes/$THEME.sh"
# tty colors
source "$HOME/.config/themes/$THEME.conf"

# change background when ssh'd(!)
if [[ -n $SSH_CONNECTION ]]; then
  echo -ne "\033]11;$COLOR_BACKGROUND\007"
fi

trap 'echo -ne "\033]111\007"' EXIT
