#!/usr/bin/env bash
#   __            __
#  / /  ___ ____ / /
# / _ \/ _ `(_-</ _ \
#/_.__/\_,_/___/_//_/
#
# -------------------------------------------------------------- // load config

for file in ~/.config/bash/*.bash; do
		[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# ------------------------------------------------------------------ // history

HISTFILE=~/.local/state/bash/history
HISTFILESIZE=1000

# --------------------------------------------------------------- // completion

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
		source /usr/share/bash-completion/bash_completion
fi

. "$HOME/.local/share/../bin/env"
. "/home/sailorfe/.local/lib/cargo/env"
