export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:$PATH"

# check if termux
_on_termux=0
[ -n "${PREFIX-}" ] && [ -d "$PREFIX/bin" ] && _on_termux=1

# uv XDG_DATA_HOME/../bin/env
if [ "$_on_termux" -eq 0 ]; then
  _uv_env="$HOME/.local/bin/env"
  if [ -f "$_uv_env" ] && ! command -v uv >/dev/null 2>&1; then
    . "$_uv_env"
  fi
  unset _uv_env
fi

# rust my beloathed
if [ "$_on_termux" -eq 0 ]; then
  _cargo_env="$HOME/.local/lib/cargo/env"
  if [ -f "$_cargo_env" ] && ! command -v rustc >/dev/null 2>&1; then
    . "$_cargo_env"
  fi
  unset _cargo_env
fi

# go
if [ -d "$HOME/.local/lib/go/bin" ]; then
  export PATH="$PATH:$HOME/.local/lib/go/bin"
fi

# xdg_runtime_dir for wayland/pipewire
if [ -z "${XDG_RUNTIME_DIR-}" ]; then
  _xdg_tmp="/tmp/xdg/${UID}-xdg-runtime-dir"
  if [ "$_on_termux" -eq 1 ] || [ ! -w /tmp ]; then
    _xdg_tmp="${TMPDIR:-$HOME/.cache/xdg}/${UID}-xdg-runtime-dir"
  fi
  export XDG_RUNTIME_DIR="$_xdg_tmp"
  if [ ! -d "$XDG_RUNTIME_DIR" ]; then
    mkdir -p "$XDG_RUNTIME_DIR" && chmod 0700 "$XDG_RUNTIME_DIR"
  fi
  unset _xdg_tmp
fi

# launch syncthing if not already running (for alpine 3.23)
# removed 2026-03-14 because i wrote a user service!!
#if ! pgrep -x syncthing >/dev/null; then
#  syncthing >/dev/null 2>&1 &
#fi

unset _on_termux
