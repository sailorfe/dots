#!/usr/bin/env bash
set -e

username="$(logname)"
user_home="/home/$username"

# ------------------------------------------------------ // detect distribution
detect_distro() {
    if command -v apt >/dev/null 2>&1; then
        DISTRO="debian"
        PKG_UPDATE="apt update && apt upgrade -y"
        PKG_INSTALL="apt install -y"
    elif command -v pacman >/dev/null 2>&1; then
        DISTRO="arch"
        PKG_UPDATE="pacman -Syu --noconfirm"
        PKG_INSTALL="pacman -S --noconfirm"
    else
        echo "Unsupported distribution. This script supports Debian/Ubuntu and Arch/EndeavourOS."
        exit 1
    fi
    echo "Detected distro: $DISTRO"
}


# --------------------------------------------------------- // helper functions
check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        echo "This script must be run with sudo."
        exit 1
    fi
}

# Base dev packages
packages_base() {
    echo "Installing base dev packages..."
    $PKG_UPDATE

    if [ "$DISTRO" = "debian" ]; then
        $PKG_INSTALL \
            bash-completion jq rsync sshfs \
            git curl ninja-build gettext cmake build-essential \
            gnupg pass stow tmux \
            python3 python3-pip python3-venv pipx \
            btop ranger fastfetch \
            fonts-jetbrains-mono fonts-font-awesome fonts-unifont fonts-noto-color-emoji fonts-3270
    elif [ "$DISTRO" = "arch" ]; then
        $PKG_INSTALL \
            bash-completion jq rsync sshfs \
            git curl ninja cmake base-devel \
            gnupg pass stow tmux \
            python python-pip python-pipx uv \
            btop ranger fastfetch \
            ttf-jetbrains-mono ttf-font-awesome unifont noto-fonts-emoji ttf-3270-nerd
    fi
}

# Optional sway desktop
packages_sway() {
    echo "Installing sway + desktop extras..."

    if [ "$DISTRO" = "debian" ]; then
        $PKG_INSTALL \
            brightnessctl cliphist wl-clipboard \
            foot sway swaybg swayidle swaylock wmenu \
            gimp grim slurp mako-notifier \
            mpd mpc mpv ncmpcpp \
            qutebrowser \
            wayland-protocols wayland-utils \
            xdg-desktop-portal-wlr xwayland
    elif [ "$DISTRO" = "arch" ]; then
        $PKG_INSTALL \
            brightnessctl cliphist wl-clipboard \
            foot sway swaybg swayidle swaylock wmenu \
            gimp grim slurp mako \
            mpd mpc mpv ncmpcpp \
            qutebrowser \
            wayland-protocols wayland-utils \
            xdg-desktop-portal-wlr xorg-xwayland \
						ghostty rio wezterm alacritty
    fi
}

# Create file tree
filetree() {
    echo "Creating file tree..."

    # main directories
    mkdir -p "$user_home"/{a,d,m,p,s,v,w}

    # XDG-compliant local directories
    mkdir -p "$user_home/.config"
    mkdir -p "$user_home/.local/{bin,lib,share,cache,state}"
    mkdir -p "$user_home/.local/state/{bash,zsh}"

    chown -R "${username}:${username}" "$user_home"/{a,d,m,p,s,v,.config,.local}
    echo "File tree created!"
}

# Clone and stow dotfiles
setup_dotfiles() {
    echo "Cloning and setting up dotfiles..."

    # Switch to regular user for git operations
    sudo -u "$username" bash << 'EOF'
    cd "$HOME/p"

    # Clone repo if it doesn't exist
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

# Move zsh home
zdotdir() {
    if [ "$DISTRO" = "debian" ]; then
        echo "export ZDOTDIR='$HOME/.config/zsh'" >> /etc/zsh/zshenv
    elif [ "$DISTRO" = "arch" ]; then
        echo "export ZDOTDIR='$HOME/.config/zsh'" >> /etc/zsh/zshenv
    fi
}

# -------------------------------------------------------------- // parse flags
install_minimal=false
install_sway=false
install_full=false

for arg in "$@"; do
    case "$arg" in
        --minimal) install_minimal=true ;;
        --sway) install_sway=true ;;
        --full) install_full=true; install_sway=true ;;
        *) echo "Unknown option: $arg"; exit 1 ;;
    esac
done

# ---------------------------------------------------------------- // run setup
check_sudo
detect_distro
filetree

if [ "$install_minimal" = true ] || [ "$install_full" = true ]; then
    packages_base
fi

if [ "$install_sway" = true ]; then
    packages_sway
    zdotdir
fi

# Always set up shell dotfiles, conditionally set up sway
setup_dotfiles "$install_sway"

echo
echo "Setup complete for $DISTRO! File tree includes:"
echo "  a/    -> .deb packages and pre-built binaries"
echo "  d/    -> personal documents"
echo "  m/    -> media library"
echo "  p/    -> projects (dotfiles cloned here)"
echo "  s/    -> source code"
echo "  v/    -> volume mount points"
echo "  .config/                            -> XDG_CONFIG_HOME"
echo "  .local/bin                          -> built binaries and pipx apps"
echo "  .local/{lib,share,cache,state}      -> standard XDG dirs"
echo
echo "Dotfiles have been stowed! Your shell configs are ready."
if [ "$install_sway" = true ]; then
    echo "Sway configs are also stowed and ready to go."
fi
