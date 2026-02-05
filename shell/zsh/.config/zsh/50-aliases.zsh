#          __
# ___ ___ / /  ________
#/_ /(_-</ _ \/ __/ __/
#/__/___/_//_/_/  \__/
#
# -*- colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto --group-directories-first'
alias la='ls -A --color=auto --group-directories-first'
alias ll='ls -lahF --color=auto --group-directories-first'
alias l='ls -hF --color=auto --group-directories-first'
alias dir='dir --color=auto --group-directories-first'
alias vdir='vdir --color=auto --group-directories-first'

# -*- conjunctions
alias cp='cp -r'
alias scp='scp -r'
alias mkdir='mkdir -p'

# -*- shortcuts
alias c='clear'
alias e='$EDITOR'
alias ZZ='exit'
alias ..='cd ..'
alias ....='cd ....'
alias ~='cd ~'

# -*-- tmux -*-
alias tl="tmux list-sessions"
alias tv="tmux new -s vault -c /home/sailorfe/d/flor"
