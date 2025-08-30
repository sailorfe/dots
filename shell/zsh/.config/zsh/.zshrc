#          __
# ___ ___ / /  ________
#/_ /(_-</ _ \/ __/ __/
#/__/___/_//_/_/  \__/
#
export ZDOTDIR=$HOME/.config/zsh

for config (~/.config/zsh/*.zsh)
	source $config

# ------------------------------------------------------------------ // history

HISTFILE=~/.local/state/zsh/history
HISTSIZE=10000
SAVEHIST=12000

# --------------------------------------------------------------- // completion

zstyle :compinstall filename '/home/sailorfe/.config/zsh/.zshrc'

autoload -Uz compinit
compinit

# ------------------------------------------------------- // syntax highligting

if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f $HOME/s/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source $HOME/s/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
