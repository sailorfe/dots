#!/usr/bin/env bash
# this is frankensteined from my zsh config

# == path =====================================================================

source "$HOME/.profile"

# == history ==================================================================

HISTFILE=~/.local/state/bash/history
HISTFILESIZE=1000
HISTSIZE=1000

# == completion ===============================================================

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
fi

# == theme ====================================================================

case "$HOST" in
goingmerry) THEME=perona ;;
thousandsunny) THEME=luna ;;
*) THEME=moonqueen ;;
esac

# source theme generated from json
source "$HOME/.config/themes/$THEME.sh"

source "$HOME/.config/themes/$THEME.conf"

# change background when ssh'd(!)
if [[ -n $SSH_CONNECTION ]]; then
  echo -ne "\033]11;$COLOR_BACKGROUND\007"
fi

trap 'echo -ne "\033]111\007"' EXIT

# == prompt ===================================================================

PS1='\[\e[96m\]\W\[\e[0m\] \\$ '

# == exports ==================================================================

# create $HOSTNAME because $HOST is elusive sometimes
case "$HOST" in
goingmerry) export HOSTNAME=merrygo ;;
thousandsunny) export HOSTNAME=sunnygo ;;
localhost) export HOSTNAME=termux ;;
*) export HOSTNAME="$HOST" ;;
esac

# xdg dirs
export XDG_CACHE_HOME=$HOME/.local/cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway

export XDG_DOCUMENTS_DIR=$HOME/d
export XDG_DOWNLOAD_DIR=$HOME/m
export XDG_MUSIC_DIR=$HOME/m/mus
export XDG_PICTURES_DIR=$HOME/m/img
export XDG_VIDEOS_DIR=$HOME/m/vid
export GRIM_DEFAULT_DIR=$HOME/m/img/cap

# default programs
export BROWSER=qutebrowser
export EDITOR=vim
export VISUAL=vim

# libraries
export GNUPGHOME=$XDG_DATA_HOME/gpg

if command -v cargo >/dev/null 2>&1; then
  export CARGO_HOME=$HOME/.local/lib/cargo
fi

if command -v rustup >/dev/null 2>&1; then
  export RUSTUP_HOME=$HOME/.local/lib/rustup
fi

if command -v go >/dev/null 2>&1; then
  export GOPATH=$HOME/.local/lib/go
fi

# == aliases ==================================================================

# just colors and grouping dirs first
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto --group-directories-first'
alias la='ls -A --color=auto --group-directories-first'
alias ll='ls -lahF --color=auto --group-directories-first'
alias l='ls -hF --color=auto --group-directories-first'
alias dir='dir --color=auto --group-directories-first'
alias vdir='vdir --color=auto --group-directories-first'

# tmux
alias tl="tmux list-sessions"
