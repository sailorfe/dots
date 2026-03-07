#!/usr/bin/env bash
# usage: sudo ./setup-debian.sh [--sway] [--dotfiles] [--laptop]

set -euo pipefail

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
    zsh zsh-autosuggestions zsh-syntax-highlighting

  curl -fsSL https://tailscale.com/install.sh | sh
  sudo -u "$USERNAME" curl -LsSf https://astral.sh/uv/install.sh | sh

  mkdir -p /etc/apt/keyrings
  curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
  echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable-v2" | tee /etc/apt/sources.list.d/syncthing.list
  apt-get update
  apt-get install syncthing
  sudo -u "$USERNAME" systemctl --user enable --now syncthing
}

packages_sway() {
  echo "Installing sway + desktop extras..."
  apt install -y \
    cliphist wl-clipboard \
    foot sway swaybg swayidle swaylock wmenu \
    gimp grim slurp mako-notifier libnotify-bin \
    mpd mpc mpv ncmpcpp playerctl \
    wayland-protocols wayland-utils \
    xdg-desktop-portal-wlr xwayland xwaylandvideobridge \
    fonts-3270 fonts-jetbrains-mono fonts-font-awesome fonts-unifont fonts-noto-color-emoji \
    pipewire \
    extrepo \
    extrepo enable librewolf \
    apt install librewolf -y
  sudo -u "$USERNAME" systemctl --user restart wireplumber pipewire pipewire-pulse
}

packages_laptop() {
  echo "Installing laptop-specific packages..."
  apt install -y acpi brightnessctl network-manager
  sed -i 's|managed=false|managed=true|' /etc/NetworkManager/NetworkManager.conf
  systemctl enable NetworkManager
  systemctl NetworkManager restart
}

zdotdir() {
  echo "export ZDOTDIR='$HOME/.config/zsh'" >>/etc/zsh/zshenv
  chsh -s /bin/zsh "$USERNAME"
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

dotfiles() {
  echo "Cloning dotfiles..."
  echo "(stow them manually, I can't be bothered/this is really dealer's choice)"
  sudo -u "$USERNAME" git -C "$USER_HOME/p" clone https://codeberg.org/sailorfe/dots.git 2>/dev/null || true
}

install_sway=false
clone_dotfiles=false
setup_laptop=false

for arg in "$@"; do
  case "$arg" in
  --sway) install_sway=true ;;
  --dotfiles) clone_dotfiles=true ;;
  --laptop) setup_laptop=true ;;
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

if [ "$clone_dotfiles" = true ]; then
  zdotdir
  filetree
  dotfiles
fi

if [ "$setup_laptop" = true ]; then
  packages_laptop
fi

echo
echo "Setup complete! Reboot or log out/in."
