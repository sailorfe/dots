#!/usr/bin/env bash

case "$HOST" in
	goingmerry) THEME=perona ;;
	thousandsunny) THEME=luna ;;
	minimerry) THEME=moonqueen ;;
	*) THEME=moonqueen;;
esac

source "$HOME/.config/themes/generated/$THEME.sh"
