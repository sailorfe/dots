#!/usr/bin/env bash
set -e

username="$(logname)"
user_home="/home/$username"

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
        fonts-jetbrains-mono fonts-font-awesome fonts-unifont fonts-noto-color-emoji \
				zip unzip \
				zsh zsh-autosuggestions zsh-syntax-highlighting \
    curl -fsSL https://tailscale.com/install.sh | sh \
    sudo -u "$username" curl -LsSf https://astral.sh/uv/install.sh | sh
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
				pipewire \
				extrepo \
    extrepo enable librewolf \
    apt install librewolf -y
}

# only for fresh installs!

zdotdir() {
	echo "export ZDOTDIR='$HOME/.config/zsh'" >> /etc/zsh/zshenv
}

filetree() {
	echo "Creating file tree..."
	mkdir -p "$user_home/.config"
	mkdir -p "$user_home/.local/{bin,cache,doc,media,share,src,state}"
	mkdir -p "$user_home/.local/state/{bash,zsh}"
	mkdir -p "$user_home/.local/src/{p,s}"
	chown -R "${username}:${username}" "$user_home"/{.config,.local}
	echo "File tree created!"
}

stow_dotfiles() {
	echo "Cloning and setting up dotfiles..."
	sudo -u "$username" bash << 'EOF'
		cd "$HOME/.local/src/p"

		if [ ! -d "dots" ]; then
			git clone https://codeberg.org/sailorfe/dots.git
		fi

		cd dots

		# Always stow shell configs
		cd shell && stow -t "$HOME" *

		# Stow sway if flag is set
		if [ "$1" = "true" ]; then
			cd ../sway && stow -t "$HOME" *
		fi
EOF
}

install_minimal=false
install_sway=false
install_full=false
setup_homedir=false

for arg in "$@"; do
	case "$arg" in
		--minimal) install_minimal=true ;;
		--sway) install_sway=true ;;
		--homedir) setup_homedir=true ;;
		--full) install_full=true; install_sway=true ;;
		*) echo "Unknown option: $arg"; exit 1 ;;
	esac
done

check_sudo

if [ "$install_minimal" = true ] || [ "$install_full" = true ]; then
    packages_base
fi

if [ "$install_sway" = true ]; then
    packages_sway
fi

if [ "$setup_homedir"] = true ]; then
    zdotdir
		filetree
		stow_dotfiles
fi

echo
echo "Setup complete! Reboot or log out/in."
