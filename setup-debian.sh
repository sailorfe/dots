#!/usr/bin/env bash
# usage: sudo ./setup-debian.sh [--sway] [--homedir]

set -e

USERNAME="$(logname)"
USER_HOME="/home/$USERNAME"

check_sudo() {
  if [ "$EUID" -ne 0 ]; then
    echo "This script must be run with sudo."
    exit 1
  fi
}

packages_base() {
  echo "Installing base dev packages..."
  apt update && apt upgrade -y
  apt install -y \
    aptitude \
    flatpak \
    bash-completion jq rsync sshfs \
    git curl ninja-build gettext cmake build-essential \
    gnupg pass stow tmux \
    python3-full \
    btop ranger fastfetch \
    zip unzip \
    zsh zsh-autosuggestions zsh-syntax-highlighting \
    curl -fsSL https://tailscale.com/install.sh | sh \
    sudo -u "$USERNAME" curl -LsSf https://astral.sh/uv/install.sh | sh
}

packages_sway() {
  echo "Installing sway + desktop extras..."
  apt install -y \
    brightnessctl cliphist wl-clipboard \
    foot sway swaybg swayidle swaylock wmenu \
    gimp grim slurp mako-notifier libnotify-bin \
    mpd mpc mpv ncmpcpp \
    wayland-protocols wayland-utils \
    xdg-desktop-portal-wlr xwayland xwaylandvideobridge \
    fonts-3270 fonts-jetbrains-mono fonts-font-awesome fonts-unifont fonts-noto-color-emoji \
    pipewire \
    extrepo \
    extrepo enable librewolf \
    apt install librewolf -y
}

# only for fresh installs!

zdotdir() {
  echo "export ZDOTDIR='$HOME/.config/zsh'" >>/etc/zsh/zshenv
}

filetree() {
  echo "Creating file tree..."
  mkdir -p "$USER_HOME/.config"
  mkdir -p "$USER_HOME/.local/{bin,cache,lib,share,state}"
  mkdir -p "$USER_HOME/.local/state/{bash,zsh}"
  mkdir -p "$USER_HOME/{d,m,p,s}"
  chown -R "${USERNAME}:${USERNAME}" "$USER_HOME"/{.config,.local,d,m,p,s}
  echo "File tree created!"
}

stow_dotfiles() {
  echo "Cloning and setting up dotfiles..."
  sudo -u "$USERNAME" bash <<'EOF'
		cd "$HOME/p"

		if [ ! -d "dots" ]; then
			git clone https://codeberg.org/sailorfe/dots.git
		fi

		cd dots

		cd shell && stow -t "$HOME" bash git nvim shell themes tmux vim zsh

		if [ "$1" = "true" ]; then
			cd ../sway && stow -t "$HOME" beets foot mako mpd mpv ncmpcpp qutebrowser sway swaylock wmenu
		fi
EOF
}

install_sway=false
setup_homedir=false

for arg in "$@"; do
  case "$arg" in
  --sway) install_sway=true ;;
  --homedir) setup_homedir=true ;;
  *)
    echo "Unknown option: $arg"
    exit 1
    ;;
  esac
done

check_sudo

packages_base

if [ "$install_sway" = true ]; then
  packages_sway
fi

if [ "$setup_homedir" = true ]; then
  zdotdir
  filetree
  stow_dotfiles
fi

echo
echo "Setup complete! Reboot or log out/in."
