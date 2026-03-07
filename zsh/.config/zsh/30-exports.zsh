# paths; also used for bashrc
source $HOME/.profile

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
