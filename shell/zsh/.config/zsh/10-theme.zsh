#          __
# ___ ___ / /  ________
#/_ /(_-</ _ \/ __/ __/
#/__/___/_//_/_/  \__/
#
# ---------------------------------------------------------- // per-host colors
case "$HOST" in
  goingmerry) THEME=perona ;;
  thousandsunny) THEME=luna ;;
  minimerry) THEME=moonqueen ;;
  *) THEME=luna ;;
esac

source "$HOME/.config/themes/generated/$THEME.sh"
