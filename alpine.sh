#!/usr/bin/env bash
# 1. INSTALL BASH: doas apk add bash
# 2. enable community repo: vi /etc/apk/repositories
# 3. make executable: `chmod +x alpine.sh`
# 3. `doas bash ./alpine.sh [--sway] [--homedir]`

username="$(logname)"
user_home="/home/$username"

check_doas() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Error: this script must be run as root"
        exit 1
    fi
}

check_shell() {
    if ! command -v bash >/dev/null 2>&1; then
        echo "Error: bash is not installed. Run 'doas apk add bash' first."
        exit 1
    fi

    if [ -z "$BASH_VERSION" ]; then
        echo "Error: This script must be run with bash, not ash/sh."
        echo "Try: doas bash ./alpine.sh"
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
		mandoc man-pages man-apropos \
	doas -u "$username" curl -LsSf https://astral.sh/uv/install.sh | sh \
	curl -fsSL https://tailscale.com/install.sh | sh
}

# this is essentially `setup-desktop wayland` with additions

setup_desktop_sway() {
	echo "Installing sway desktop..."
	setup-wayland-base
	apk add --no-cache \
			brightnessctl \
			foot \
			grim slurp \
			i3status swaybar\
			sway \
			swaybg \
			swayidle \
			swaylockd \
			util-linux-login \
			wl-clipboard \
			wmenu \
			xwayland \
			xdg-desktop-portal-wlr \
			pipewire wireplumber \
			mako libnotify \
			qutebrowser librewolf \
			mpd mpc mpv ncmpcpp ffmpeg playerctl mpd-mpris \
			font-noto font-iosevka font-unifont font-noto-cjk font-noto-emoji \
			"$@"
		mkdir -p $user_home:.config/rc/runlevels/{gui,sysinit}
}

filetree() {
	echo "Creating filetree..."
	mkdir -p "$user_home/.config"
	mkdir -p "$user_home/.local/{bin,cache,lib,share,state}"
	mkdir -p "$user_home/.local/state/{bash,zsh}"
	mkdir -p "$user_home/{d,m,p,s}"
	chown -R "${username}:${username}" "$user_home"/{.config,.local,d,m,p,s}
	echo "File tree created!"
}

stow_dotfiles() {
	echo "Cloning and setting up dotfiles..."
	doas -u "$username" bash << 'EOF'
		cd "$HOME/p"

		if [ ! -d "dots" ]; then
			git clone https://codeberg.org/sailorfe/dots.git
		fi

		cd dots

		cd shell && stow -t "$HOME" *

		if [ "$1" = "true" ]; then
			cd ../sway && stow -t "$HOME" *
		fi
EOF
}

check_shell

check_doas

packages_base

install_sway=false
setup_homedir=false

for arg in "$@"; do
	case "$arg" in
		--sway) install_sway=true ;;
		--homedir) setup_homedir=true ;;
		*) echo "Unknown option: $arg"; exit 1 ;;
	esac
done

if [ "$install_sway" = true ]; then
	setup_desktop_sway
fi

if [ "$setup_homedir" = true ]; then
	filetree
	stow_dotfiles
fi

echo "Setup complete! Reboot or log out/in."
