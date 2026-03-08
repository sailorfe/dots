#!/usr/bin/env bash

case "$(hostname)" in
  goingmerry) THEME=perona ;;
  thousandsunny) THEME=luna ;;
  minimerry) THEME=moonqueen ;;
  *) THEME=rose-pine ;;
esac

source "$HOME/.config/themes/$THEME.sh"
