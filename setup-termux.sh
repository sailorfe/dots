#!/data/data/com.termux/files/usr/bin/env bash
set -euo pipefail
# usage: ./setup-termux.sh
#
#   1. termux-change-repo
#      pkg update && pkg upgrade
#   2. pkg install openssh git net-tools
#   3. ifconfig
#   4. from termux: sshd
#   5. passwd
#   5. ssh in with ifconfig local ip
#   6. termx-setup-storage
#   7. scp termux:setup-termux.sh

PREFIX="/data/data/com.termux/files/usr"
HOME="/data/data/com.termux/files/home"

packages() {
    pkg install -y \
        termux-services \
        tmux \
        zsh \
        git \
        stow \
        vim \
        emacs \
        enchant \
        libvterm \
        syncthing \
        mandoc \
        build-essential \
        python \
        python-pip \
        uv \
        lf \
        fastfetch
}

filetree() {
    mkdir -p "$HOME"/{.config,.local,d,p,m,s}
    mkdir -p "$HOME"/.local/{bin,cache,lib,share,state}
    mkdir -p "$HOME"/.local/share/{emacs,vim,neovim}
    mkdir -p "$HOME"/.local/state/{bash,emacs,zsh,neovim,vim}
    mkdir -p "$HOME"/.local/state/vim/{backup,undo}
    mkdir -p "$HOME"/.local/share/vim/spell
}

symlinks() {
    local shared
    shared="$HOME"/storage/shared
    echo "setting up syminks..."
    # termux is sandboxed so
    ln -s "$shared"/calibre "$HOME/m/doc"
    ln -s "$shared"/org "$HOME/d/org"
    ln -s "$shared"/loans "$HOME/m/aud"
}

zdotdir() {
    local cfg="${XDG_CONFIG_HOME:-$HOME/.config}"
    echo "moving zdotdir to $cfg..."
    grep -q ZDOTDIR "$HOME/.zshenv" 2>/dev/null ||
        echo "export ZDOTDIR='$cfg/zsh'" >> "$HOME/.zshenv"
    chsh -s zsh
}

dotfiles() {
    echo "cloning dotfiles..."
    git clone ssh://softserve/dotfiles.git "$HOME"/p/dots
}

syncthing() {
    local syncthing_dir syncthing_run
    syncthing_dir="$PREFIX"/var/service/syncthing
    syncthing_run="$syncthing_dir"/run

    echo "setting up Syncthing..."

    mkdir -p "$syncthing_dir"
    cat << EOF > "$syncthing_run"
#!/data/data/com.termux/files/usr/bin/env bash

exec syncthing --no-browser --no-restart --logflags=0
EOF
    chmod +x "$syncthing_run"
}

mercurial() {
    # for p314
    echo "installing mercurial 7.2..."
    python -m pip install --no-cache-dir "mercurial>=7.2"
}

services() {
    sv enable ssh-agent
    sv enable sshd
    sv enable emacsd
    sv enable syncthing
}

packages
filetree
symlinks
zdotdir
syncthing
services
mercurial
