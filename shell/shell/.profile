export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:$PATH"

# uv: $HOME/.local/share/../bin/env
_uv_env="$HOME/.local/bin/env"
if [ -f "$_uv_env" ] && ! command -v uv >/dev/null 2>&1; then
  # shellcheck source=/dev/null
  . "$_uv_env"
fi
unset _uv_env

# only source if the env file exists AND rustc isn't already on PATH
_cargo_env="$HOME/.local/lib/cargo/env"
if [ -f "$_cargo_env" ] && ! command -v rustc >/dev/null 2>&1; then
  # shellcheck source=/dev/null
  . "$_cargo_env"
fi
unset _cargo_env

# only extend PATH if the go binary tree actually exists
if [ -d "$HOME/.local/lib/go/bin" ]; then
  export PATH="$PATH:$HOME/.local/lib/go/bin"
fi

# xdg runtime dir for wayland + pipewire
if [ -z "${XDG_RUNTIME_DIR-}" ]; then
  export XDG_RUNTIME_DIR="/tmp/xdg/${UID}-xdg-runtime-dir"
  if [ ! -d "$XDG_RUNTIME_DIR" ]; then
    mkdir -p "$XDG_RUNTIME_DIR" && chmod 0700 "$XDG_RUNTIME_DIR"
  fi
fi

# launch syncthing if not already running (for alpine)
if ! pgrep -x syncthing >/dev/null; then
  syncthing >/dev/null 2>&1 &
fi
