#!/data/data/com.termux/files/usr/bin/env bash
set -euo pipefail

PREFIX="/data/data/com.termux/files/usr"

# termux-change-repo
# termux-setup-storage
# pkg update && pkg upgrade

packages() {
	pkg install \
		tmux \
		zsh \
    jq \
		git \
		stow \
		vim \
		syncthing \
		mandoc \
		build-essential \
		python \
		uv \
    npm \
		termux-services
	}

filetree() {
	mkdir -p .local/{bin,cache,lib,share,state} d p s
	mkdir -p .local/share/{vim,neovim}
	mkdir -p .local/state/{bash,zsh,neovim,vim}
	mkdir -p .local/state/vim/{backup,undo}
	mkdir -p .local/share/vim/spell
}

zdotdir() {
	echo "export ZDOTDIR='$HOME/.config/zsh'" >> .zshenv
  chsh -s "$PREFIX"/usr/bin/zsh
}

dotfiles() {
  echo "Cloning and stowing dotfiles..."
  bash << 'EOF'
  cd "$HOME/p"

  if [ ! -d "dots" ]; then
    git clone https://codeberg.org/sailorfe.dots.git
  fi

  cd dots

  cd shell && stow -t "$HOME" *
EOF
}

syncthing() {
	mkdir -p "$PREFIX"/var/service/syncthing
	echo "
	#!/data/data/com.termux/files/usr/bin/env bash

	exec syncthing --no-browser --no-restart --logflags=0
	" >> "$PREFIX"/var/service/syncthing/run
}

packages

setup_homedir=false
setup_syncthing=false
stow_dotfiles=false

for arg in "@"; do
	case "$arg" in
		--homedir) setup_homedir=true ;;
		--syncthing) setup_syncthing=true ;;
		--dotfiles) stow_dotfiles=true ;;
		*) echo "Unkown option: $arg"; exit 1 ;;
	esac
done

if [ "$setup_homedir" = true ] || [ "$stow_dotfiles" = true ]; then
	filetree
fi

if [ "$stow_dotfiles" = true ]; then
  filetree
  zdotir
  dotfiles
fi

if [ "$setup_syncthing" = true ]; then
	syncthing
fi
