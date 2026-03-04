#          __
# ___ ___ / /  ________
#/_ /(_-</ _ \/ __/ __/
#/__/___/_//_/_/  \__/
#
# ---------------------------------------------------------- // per-host colors
case "$HOST" in
  goingmerry)
    THEME_FILE="$HOME/.config/themes/current-theme.txt"
    if [[ -f "$THEME_FILE" ]]; then
      THEME=$(cat "$THEME_FILE")
    else
      THEME=perona
    fi
    ;;
  thousandsunny) THEME=luna ;;
  *) THEME=moonqueen ;;
esac

source "$HOME/.config/themes/generated/$THEME.sh"
