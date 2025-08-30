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
alias la='ls -A --color=auto'
alias ll='ls -lahF --color=auto'
alias l='ls -hF --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# -*- conjunctions
alias cp='cp -r'
alias scp='scp -r'
alias mkdir='mkdir -p'
#alias wc='wc -w <'

# -*- shortcuts
alias c='clear'
alias e='$EDITOR'
alias ZZ='exit'
alias ..='cd ..'
alias ....='cd ....'
alias ~='cd ~'

# -*- git
alias ga='git add'
alias gb='git branch'
alias gc='git clone'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcs='git commit -S -m'
alias gd='git difftool'
alias gdc='git difftool --cached'
alias gf='git fetch'
alias gg='git graph'
alias ggg='git graphgpg'
alias gm='git merge'
alias gp='git push'
alias gpr='gh pr create'
alias gr='git rebase -i'
alias gs='git status -sb'
alias gt='git tag'
alias gu='git reset @ --' #think git unstage
alias gx='git reset --hard @'
