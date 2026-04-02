#!/usr/bin/env bash
# usage: sudo ./setup-debian.sh [--homedir] [--dotfiles] [--web] [--syncthing] [--sway] [--laptop]

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
    bash-completion jq rsync sshfs \
    git curl ninja-build gettext cmake build-essential \
    gnupg pass stow tmux \
    python3-full \
    btop ranger fastfetch \
    ufw \
    zip unzip \
    zsh zsh-autosuggestions zsh-syntax-highlighting

  curl -fsSL https://tailscale.com/install.sh | sh
  sudo -u "$USERNAME" curl -LsSf https://astral.sh/uv/install.sh | sh
}

syncthing() {
  echo "Installing Syncthing..."
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
    flatpak \
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
  echo "Setting ZDOTDIR..."
  echo "export ZDOTDIR=$HOME/.config/zsh" >>/etc/zsh/zshenv
  chsh -s /bin/zsh "$USERNAME"
}

homedir() {
  echo "Creating home directory file tree..."
  mkdir -p "$USER_HOME"/{.local,.config}
  mkdir -p "$USER_HOME"/.local/{bin,cache,lib,share,state}
  mkdir -p "$USER_HOME"/{d,m,p,s}
  mkdir -p "$USER_HOME"/.local/share/{nvim/site,nvim/spell,nvim/undo,vim/autoload,vim/pack,vim/spell}
  mkdir -p "$USER_HOME"/.local/state/{bash,zsh,nvim,vim/backup,vim/swap,vim/undo}
  chown -R "${USERNAME}:${USERNAME}" "$USER_HOME"/{.config,.local,d,m,p,s}
}

dotfiles() {
  echo "Cloning dotfiles..."
  echo "(stow them manually, I can't be bothered/this is really dealer's choice)"
  sudo -u "$USERNAME" git -C "$USER_HOME/p" clone https://codeberg.org/sailorfe/dots.git 2>/dev/null || true
}

setup_server() {
  echo "Setting up server..."
  apt install -y \
    fail2ban \
    caddy
  systemctl enable --now fail2ban
}

install_sway=false
setup_homedir=false
clone_dotfiles=false
setup_laptop=false
install_syncthing=false
setup_server=false

for arg in "$@"; do
  case "$arg" in
  --dotfiles) clone_dotfiles=true ;;
  --homedir) setup_homedir=true ;;
  --sway) install_sway=true ;;
  --laptop) setup_laptop=true ;;
  --syncthing) install_syncthing=true ;;
  --web) setup_server=true ;;
  *)
    echo "Unknown option: $arg"
    exit 1
    ;;
  esac
done

check_sudo

packages_base

if [ "$setup_homedir" = true ]; then
  setup_homedir
  zdotdir
fi

if [ "$clone_dotfiles" = true ]; then
  zdotdir
  homedir
  dotfiles
fi

if [ "$install_sway" = true ]; then
  packages_sway
fi

if [ "$setup_laptop" = true ]; then
  packages_laptop
fi

if [ "$install_syncthing" = true ]; then
  syncthing
fi

if [ "$setup_server" = true ]; then
  setup_server
fi

echo
echo "Setup complete! Reboot or log out/in."
