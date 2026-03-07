#!/bin/sh
#
# enable community repo: setup-apkrepos -o
# make this script executable: `chmod +x setup-alpine.sh`
# usage: `doas sh ./setup-alpine.sh [--sway] [--dotfiles] [--laptop]`

set -euo

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
    dbus \
    zsh zsh-syntax-highlighting zsh-autosuggestions zsh-completions \
    bash bash-completion \
    shadow \
    vim \
    npm \
    tmux stow \
    rsync sshfs \
    btop fastfetch \
    python3 python3-dev py3-pip py3-uv \
    tailscale \
    zip unzip \
    gnupg pass \
    uuidgen \
    syncthing \
    mandoc man-pages mandoc-apropos \
    build-base cmake coreutils gettext-tiny-dev neovim tree-sitter-lua # neovim deps

  # enable unicode
  sed -i 's/#unicode="NO"/#unicode="NO"\nunicode="YES"/' /etc/rc.conf

  # change shell
  chsh -s /bin/zsh "$USERNAME"
}

packages_sway() {
  echo "Installing sway desktop..."
  # this is just ripped from setup-wayland-base.in
  setup-devd udev

  for service in cgroups dbus; do
    rc-service "$service" start
    rc-update add "$service"
  done

  # modified from setup-desktop.in sway
  apk add --no-cache \
    elogind polkit-elogind \
    foot \
    grim slurp \
    swaybar \
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
    font-noto font-iosevka font-unifont font-noto-cjk font-noto-emoji font-terminus-nerd \
    zathura zathura-pdf-mupdf zathura-cb \
    flatpak

  # start pipewire with "exec openrc -U gui" in .config/sway/config
  mkdir -p "$USER_HOME/.config/rc/runlevels/gui"
  doas -u "$USERNAME" rc-service -U add pipewire gui
  doas -u "$USERNAME" rc-service -U add pipewire-wireplumber gui

  # enable bitmap fonts
  ln -s /usr/share/fontconfig/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d/70-yes-bitmaps.conf
  rm /etc/fonts/conf.d/70-no-bitmaps.conf
}

packages_laptop() {
  echo "Installing laptop-specific packages..."
  apk add acpi brightnessctl networkmanager networkmanager-wifi networkmanager-cli
  adduser "$USERNAME" plugdev
  printf "[main]\n
dhcp=internal\n
plugins=ifupdown,keyfile\n\n
[ifupdown]\n
managed=true\n\n
[device]\n
wifi.scan-rand-mac-address=yes\n
wifi.backend=wpa_supplicant" >>/etc/NetworkManager/NetworkManager.conf
  # stop default networking services
  rc-service networking stop
  rc-service wpa_supplicant stop
  # start networkmanager + add to openrc
  rc-update add networkmanager default
  rc-service networkmanager restart
  # clean default networking services
  rc-update del networking boot
  rc-update del wpa_supplicant boot
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
  doas -u "$USERNAME" git -C "$USER_HOME/p" clone https://codeberg.org/sailorfe/dots.git 2>/dev/null || true

  doas -u "$USERNAME" stow --adopt -d "$USER_HOME/p/dots/shell" -t "$USER_HOME" \
    bash git nvim shell themes tmux vim zsh

  if [ "$install_sway" = "true" ]; then
    doas -u "$USERNAME" stow --adopt -d "$USER_HOME/p/dots/sway" -t "$USER_HOME" \
      beets foot mako mpd mpv ncmpcpp qutebrowser sway swaylock wmenu
  fi
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

check_doas

packages_base

if [ "$install_sway" = "true" ]; then
  packages_sway
fi

if [ "$clone_dotfiles" = "true" ]; then
  filetree
  stow_dotfiles
fi

if [ "$setup_laptop" = "true" ]; then
  packages_laptop
fi

echo "Setup complete! Reboot or log out/in."
