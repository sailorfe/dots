#          __
# ___ ___ / /  ________
#/_ /(_-</ _ \/ __/ __/
#/__/___/_//_/_/  \__/
#
# ----------------------------------------------------------------- // per-host
export ME='sailorfe'

case "$HOST" in
  goingmerry) export HOSTNAME=merrygo ;;
  thousandsunny) export HOSTNAME=sunnygo ;;
  localhost) export HOSTNAME=termux ;;
  *) export HOSTNAME="$HOST" ;;
esac

# -------------------------------------------------------- // xdg specification
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

# ---------------------------------------------------------------- // libraries
export CARGO_HOME=$HOME/.local/lib/cargo
export GNUPGHOME=$XDG_DATA_HOME/gpg
export RUSTUP_HOME=$HOME/.local/lib/rustup
export GOPATH=$HOME/.local/lib/go

# --------------------------------------------------------------------- // path
. $HOME/.profile

# ----------------------------------------------------------// default programs
. $HOME/.profile
# export BROWSER=qutebrowser
export EDITOR=nvim
export VISUAL=nvim
