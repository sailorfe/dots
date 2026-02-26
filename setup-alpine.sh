#!/bin/sh
# 1. enable community repo: vi /etc/apk/repositories
# 2. make executable: `chmod +x setup-alpine.sh`
# 3. run: `doas ./setup-alpine.sh [--sway] [--homedir]`

USERNAME="${DOAS_USER:-$(logname)}"
USER_HOME="/home/$USERNAME"

check_doas() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "Error: this script must be run as root (or via doas)"
    exit 1
  fi
}

packages_base() {
  echo "Installing base dev packages..."
  apk add --no-cache \
    curl wget git \
    zsh zsh-syntax-highlighting zsh-autosuggestions jq \
    bash bash-completion \
    build-base cmake coreutils gettext-tiny-dev neovim tree-sitter-lua \
    vim \
    npm \
    tmux stow \
    rsync sshfs \
    btop fastfetch \
    python3 python3-dev py3-pip \
    zip unzip \
    gnupg pass \
    networkmanager networkmanager-wifi networkmanager-cli \
    uuidgen \
    syncthing \
    mandoc man-pages man-apropos

  doas -u "$USERNAME" sh -c "curl -LsSf https://astral.sh/uv/install.sh | sh"
  curl -fsSL https://tailscale.com/install.sh | sh
}

setup_desktop_sway() {
  echo "Installing sway desktop..."
  setup-wayland-base
  apk add --no-cache \
    brightnessctl \
    foot \
    grim slurp \
    i3status swaybar \
    sway \
    swaybg \
    swayidle \
    swaylockd \
    util-linux-login \
    wl-clipboard \
    wmenu \
    xwayland \
    xdg-desktop-portal-wlr \
    pipewire wireplumber pipewire-tools \
    mako libnotify \
    qutebrowser librewolf w3m \
    mpd mpc mpv ncmpcpp ffmpeg playerctl mpd-mpris \
    font-noto font-iosevka font-unifont font-noto-cjk font-noto-emoji \
    zathura zathura-pdf-mupdf zathura-cb

  mkdir -p "$USER_HOME/.config/rc/runlevels/gui"
  mkdir -p "$USER_HOME/.config/rc/runlevels/sysinit"
}

filetree() {
  echo "Creating filetree..."
  mkdir -p "$USER_HOME/.config"
  mkdir -p "$USER_HOME/.local/bin" "$USER_HOME/.local/cache" "$USER_HOME/.local/lib" "$USER_HOME/.local/share" "$USER_HOME/.local/state"
  mkdir -p "$USER_HOME/.local/state/bash" "$USER_HOME/.local/state/zsh"
  mkdir -p "$USER_HOME/d" "$USER_HOME/m" "$USER_HOME/p" "$USER_HOME/s"
  chown -R "$USERNAME:$USERNAME" "$USER_HOME"
  echo "File tree created!"
}

stow_dotfiles() {
  echo "Cloning and setting up dotfiles..."
  doas -u "$USERNAME" sh <<EOF
        cd "$USER_HOME/p"
        if [ ! -d "dots" ]; then
            git clone https://codeberg.org/sailorfe/dots.git
        fi
        cd dots/shell && stow -t "$USER_HOME" bash git nvim shell themes tmux vim zsh
        if [ "$install_sway" = "true" ]; then
            cd ../sway && stow -t "$USER_HOME" beets foot mako mpd mpv ncmpcpp qutebrowser sway swaylock wmenu
        fi
EOF
}

check_doas

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

packages_base

if [ "$install_sway" = "true" ]; then
  setup_desktop_sway
fi

if [ "$setup_homedir" = "true" ]; then
  filetree
  stow_dotfiles
fi

echo "Setup complete! Reboot or log out/in."
