#!/usr/bin/env bash
#
# sailorfe's debian 13 trixie recipe for 2026.
#
# 1. log in as root, install sudo, usermod -aG sudo user
# 2. log in as user, run this script with sudo
#
# i cannot get `sudo -u "$USERNAME" [COMMAND]` working in this for the life of me, which is useful for enabling user-level systemd services. you'll have to do this manually:
# - wireplumber.service
# - mpd.service
# - emacs.service
# - syncthing.service

set -euox pipefail

USERNAME="$(logname)"
USER_HOME="/home/$USERNAME"

check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        echo "this script must be run with sudo."
        exit 1
    fi
}

setup_homedir() {
    echo "creating home directory file tree..."
    mkdir -p "$USER_HOME"/{.local,.config}
    mkdir -p "$USER_HOME"/.local/{bin,cache,lib,share,state}
    mkdir -p "$USER_HOME"/.local/lib/{go,cargo}
    mkdir -p "$USER_HOME"/{d,m,p,s}
    mkdir -p "$USER_HOME"/.local/state/{bash,zsh,emacs}
    chown -R "$USERNAME":"$USERNAME" "$USER_HOME"/{.config,.local,d,m,p,s}
}

# apt packages

packages_base() {
    echo "installing base packages..."
    apt update && apt upgrade -y
    apt install -y \
        curl git mercurial stow \
        zsh zsh-autosuggestions zsh-syntax-highlighting \
        rsync sshfs zip unzip \
        build-essential cmake \
        emacs-nox libenchant-2-dev libvterm-dev \
        gnupg pass \
        python3-full \
        btop fastfetch lf \
        ufw
    echo "moving zdotdir..."
    echo "export ZDOTDIR=$HOME/.config/zsh" >>/etc/zsh/zshenv
    chsh -s /bin/zsh "$USERNAME"
    # sudo -u "$USERNAME" systemctl --user enable emacs.service
}

packages_sway() {
    echo "installing wayland with sway..."
    apt install -y \
        xdg-desktop-portal-wlr xwayland xwaylandvideobridge \
        wayland-protocols wayland-utils \
        cliphist wl-clipboard \
        sway swaybg swayidle swaylock bemenu \
        foot xterm foot-terminfo terminfo \
        grim slurp mako-notifier libnotify-bin \
        fonts-3270 fonts-unifont fonts-noto-color-emoji fonts-noto-cjk fonts-noto-cjk-extra \
        pipewire bluetooth libspa-0.2-bluetooth \
        kdeconnect \
        emacs-pgtk qutebrowser
    local user_services
    user_services="$USER_HOME"/.config/systemd/user
    mkdir -p "$user_services"
    cat << 'EOF' >> "$user_services/kdeconnect.service"
[Unit]
Description=KDE Connect Daemon

[Service]
ExecStart=/usr/bin/kdeconnectd
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=default.target
EOF
    chown -R "$USERNAME":"$USERNAME" "$user_services"
    systemctl enable bluetooth
    # sudo -u "$USERNAME" systemctl --user enable wireplumber.service
    # sudo -u "$USERNAME" systemctl --user enable kdeconnect.service
}

packages_audio() {
    printf "\a"
    echo "installing advanced audio packages. jack will prompt you..."
    apt install -y jackd
}

packages_media() {
    echo "installing media playback packages..."
    apt install -y mpd mpc mpv ncmpcpp playerctl mpv-mpris
    mkdir -p "$USER_HOME"/.local/{share,state}/mpd
    mkdir -p "$USER_HOME"/.config/mpv/scripts
    ln -s /usr/lib/mpv-mpris/mpris.so "$USER_HOME"/.config/mpv/scripts/
    chown -R "$USERNAME":"$USERNAME" "$USER_HOME"/.config/mpv "$USER_HOME"/.local/{share,state}/mpd
    # sudo -u "$USERNAME" systemctl --user enable mpd.service
}

packages_laptop() {
    echo "installing laptop-specific packages..."
    apt install -y acpi brightnessctl network-manager
    sed -i 's|managed=false|managed=true|' /etc/NetworkManager/NetworkManager.conf
    systemctl enable NetworkManager
    systemctl restart NetworkManager
}

packages_web_server() {
    echo "installing web server packages..."
    apt install -y fail2ban caddy
    systemctl enable --now fail2ban
}

# external packages
# install astral python tools as user later

install_tailscale() {
    # https://tailscale.com/download
    # https://github.com/tailscale/tailscale/blob/main/scripts/installer.sh
    echo "installing tailscale..."
    curl -fsSL https://tailscale.com/install.sh | sh
}

install_syncthing() {
    # https://apt.syncthing.net/
    echo "installing syncthing..."
    mkdir -p /etc/apt/keyrings
    curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
    echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable-v2" \
         >/etc/apt/sources.list.d/syncthing.list
    apt-get update
    apt-get install -y syncthing
    # sudo -u "$USERNAME" systemctl --user enable syncthing.service
}

install_librewolf() {
    # https://www.librewolf.net/installation/debian/
    echo "installing librewolf..."
    apt update && apt install -y extrepo
    extrepo enable librewolf && extrepo update librewolf
    apt update && apt install -y librewolf
}

install_fonts() {
    echo "installing fonts..."
    local fontdir="$USER_HOME"/.local/share/fonts
    mkdir -p "$fontdir"
    cd "$fontdir" || {
        echo "'$fontdir' not found"
        exit 1
    }
    curl -LO https://github.com/the-moonwitch/Cozette/releases/download/v.1.30.0/cozette.otb
    curl -Lo 3270-nerd.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/3270.zip
    curl -Lo recursive.zip https://github.com/arrowtype/recursive/releases/download/v1.085/ArrowType-Recursive-1.085.zip
    unzip "*.zip"
    rm recursive.zip 3270-nerd.zip
    chown -R "$USERNAME":"$USERNAME" "$fontdir"
    printf "\a"
    echo "enable bitmap fonts in fontconfig in 5s..."
    sleep 5 && dpkg-reconfigure fontconfig-config
    cd "$USER_HOME"
}

build_vim() {
    mkdir -p "$USER_HOME"/.local/share/vim/{autoload,pack,spell}
    mkdir -p "$USER_HOME"/.local/state/vim/{backup,swap,undo}
    chown -R "$USERNAME":"$USERNAME" "$USER_HOME"/.local/{share,state}/vim
    local tmpdir
    tmpdir=$(mktemp -d)
    apt install -y libncurses-dev
    curl -Lo "$tmpdir/vim-classic.tar.gz" https://git.sr.ht/~sircmpwn/vim-classic/archive/v8.3.0.tar.gz
    tar -xzf "$tmpdir/vim-classic.tar.gz" -C "$tmpdir"
    cd "$tmpdir"/vim-classic-v8.3.0
    make
    make install
    cd "$USER_HOME"
    rm -rf "$tmpdir"
}

# dotfiles

clone_dotfiles() {
    echo "cloning dotfiles. stow these by hand later."
    local dotdir
    dotdir="$USER_HOME"/p/dots
    git clone "https://codeberg.org/sailorfe/dots" "$dotdir"
    chown -R "$USERNAME":"$USERNAME" "$dotdir"
}

# cli

declare -A PROFILES=(
    [console]="setup_homedir packages_base install_tailscale install_syncthing build_vim clone_dotfiles"
    [desktop]="setup_homedir packages_base packages_sway packages_audio packages_media build_vim install_fonts install_tailscale install_syncthing install_librewolf clone_dotfiles"
    [laptop]="setup_homedir packages_base packages_laptop packages_sway packages_media build_vim install_fonts install_tailscale install_syncthing install_librewolf clone_dotfiles"
    [web]="setup_homedir packages_base packages_web_server build_vim clone_dotfiles"
)

usage() {
    echo "usage: sudo $0 [--tty|--full|--laptop|--web]"
    echo "  --tty     minimal tty-only setup"
    echo "  --full    full desktop (sway) setup"
    echo "  --laptop  full desktop setup + laptop hardware"
    echo "  --web     web server setup"
    exit 1
}

profile=""
case "${1:-}" in
    --tty) profile=console ;;
    --full) profile=desktop ;;
    --laptop) profile=laptop ;;
    --web) profile=web ;;
    *) usage ;;
esac

check_sudo

echo "running profile: $profile"
for step in ${PROFILES[$profile]}; do
    "$step"
done
echo "setup complete. reboot/log back in to see changes."
