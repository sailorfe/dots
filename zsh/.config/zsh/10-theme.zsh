# set theme per host

case "$(hostname)" in
  northblue)
    THEME=perona
    TERM_FONT_SIZE=10.0
    ;;
  thousandsunny)
    THEME=ulti
    TERM_FONT_SIZE=12.0
    ;;
  minimerry)
    THEME=luna ;;
  *) THEME=moonqueen ;;
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
