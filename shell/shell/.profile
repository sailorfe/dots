export PATH=$PATH:/usr/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.local/lib/go/bin

. "$HOME/.local/share/../bin/env"
. "/home/sailorfe/.local/lib/cargo/env"

if test -z "${XDG_RUNTIME_DIR}"; then
  export XDG_RUNTIME_DIR=/tmp/xdg/"${UID}"-xdg-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"; then
      mkdir -p "${XDG_RUNTIME_DIR}"
      chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi
