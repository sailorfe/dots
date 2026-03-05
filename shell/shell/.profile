export PATH=$PATH:/usr/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.local/lib/go/bin

# from uv
if [ -e "$XDG_DATA_HOME"/../bin/env ]; then
  source "$HOME"/.local/share/../bin/env
fi

# from rust
if [ -e "$XDG_DATA_HOME"/../lib/cargo/env ]; then
  source "$HOME"/.local/lib/cargo/env
fi

# so wayland + pipewire behave
# https://wiki.alpinelinux.org/wiki/XDG_RUNTIME_DIR
if test -z "${XDG_RUNTIME_DIR}"; then
  export XDG_RUNTIME_DIR=/tmp/xdg/"${UID}"-xdg-runtime-dir
  if ! test -d "${XDG_RUNTIME_DIR}"; then
    mkdir -p "${XDG_RUNTIME_DIR}"
    chmod 0700 "${XDG_RUNTIME_DIR}"
  fi
fi

# launches syncthing on alpine
if ! pgrep -x syncthing >/dev/null; then
  syncthing >/dev/null 2>&1 &
fi
