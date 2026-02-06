# sailorfe dots

![perona](./perona.png)

```
                                                                
               ▄▄               ▄▄           █                  
                ██             ██           █  █▄       █▄      
             ▀▀ ██       ▄    ▄██▄         █   ██      ▄██▄     
 ▄██▀█ ▄▀▀█▄ ██ ██ ▄███▄ ████▄ ██ ▄█▀█▄   █ ▄████ ▄███▄ ██ ▄██▀█
 ▀███▄ ▄█▀██ ██ ██ ██ ██ ██    ██ ██▄█▀  █  ██ ██ ██ ██ ██ ▀███▄
█▄▄██▀▄▀█▄██▄██▄██▄▀███▀▄█▀   ▄██▄▀█▄▄▄ █  ▄█▀███▄▀███▀▄███▄▄██▀
                               ██                               
                              ▀▀                                
```

these are my configuration files for an overwhelmingly debian linux ecosystem across four devices: an hp compaq elite usdt 8000, a clamshelled macbook air 2017, a thinkpad t480s, and termux on android.

the desktop and thinkpad use [sway](https://swaywm.org). wayland is pretty good these days, but needy in that on debian it requires a slew of helper packages to cooperate with electron apps and the like.

this repo is designed to be modular and minimal. i'm neither or a gamer or a sysadmin or even that serious a ricer, just someone who frequently nukes my installations for no real reason.

### table of contents

- [homedir](#homedir)
- [dependencies](#dependencies)
- [installation](#installation)
- [shell](#shell)
- [sway](#sway)
- [previews](#previews)

<a name="homedir"></a>
## homedir layout

i follow the [xdg base directory specification](https://specifications.freedesktop.org/basedir-spec/latest/) and try my best to keep hidden files tamed. i keep [xdg-user-dirs](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/) under `.local` and the more colloquial `$XDG_{DOCUMENTS,MUSIC,PICTURES,VIDEOS}_DIR` visible at `~` with single-letter toplevels.

```sh
~
|-- .config/        => $XDG_CONFIG_HOME
|   |-- bash/
|   |-- ranger/
|   |-- sway/
|   |-- tmux/
|   `-- zsh/        => $ZDOTDIR
|       `-- .zshrc
|-- .local
|   |-- bin/
|   |-- cache/      => $XDG_CACHE_HOME
|   |-- lib/
|   |   |-- $CARGO_HOME
|   |   |-- $GOPATH
|   |   `-- etc...
|   |-- share/      => $XDG_DATA_HOME
|   |   |-- fonts
|   |   `-- gpg
|   `-- state/      => $XDG_STATE_HOME
|-- .password-store/
|-- .ssh/
|-- d/                  => $XDG_DOCUMENTS_DIR
|   |-- flor{illegium}  => notes + syncthing
|   |-- log             => logs from ~/.local/bin backups
|   `-- etc...
|-- m/
|   |-- app/            => *.deb, *.iso
|   |-- den_den_mushi/  => kdeconnect file transfer
|   |-- doc/            => *.cbz, *.epub, *.pdf
|   |-- img/            => $XDG_PICTURES_DIR
|   |   `-- cap/            => $GRIM_DEFAULT_DIR
|   |-- mus/            => $XDG_MUSIC_DIR + syncthing
|   `-- vid/            => $XDG_VIDEOS_DIR
|-- p/                  => my source code
|   |-- dots/               => this repo!
|   |-- lua/
|   |-- py/
|   `-- www/
`-- s/                  => not-my source code
    `-- neovim/
```

so before i even clone this repo, i run a command like this:

```sh
mkdir ~/.config &&
    mkdir -p ~/.local/{bin,cache,lib,share,state} &&
    mkdir -p ~/.local/state/{bash,zsh} &&
    mkdir -p ~/{d,m,p,s}
```

this has gone through some evolution through the years, but it's the combined influence of [xero](https://github.com/xero/dotfiles) and [elly](https://elly.town/d/blog/2021-10-06-homedir.txt).

<a name="dependencies"></a>
## dependencies

it goes without saying that this setup depends on git, and with it [gnu stow](https://www.gnu.org/software/stow/), which basically manages a mess of symlinks from this repository into my `.config` and home directories. i pretty much run debian all the time out of package manager muscle memory, and if i ever stray it's to alpine or something arch-based:

- `apt install git stow`
- `apk add git stow`
- `pacman -S git stow`

<a name="installation"></a>
## installation

once you've made the base directory structure, you can run `debian.sh` at the root of this repository or run its functions manually like

```sh
# move zsh home
sudo echo "export ZDOTDIR='$HOME'/.config/zsh" >> /etc/zsh/zshenv

# clone & stow dotfiles
cd ~/p &&
    git clone ssh://git@codeberg.org/sailorfe/dots.git &&
    cd dots/shell &&
    stow -t ~ *

    # if with a visual environment
    cd ~/p/dots/sway &&
    stow -t ~ *
```

the script has a few optional flags for whether this is a server or desktop installation:

```sh
./debian.sh --minimal      # only shell, ranger, and tmux
./debian.sh --sway         # only sway
./debian.sh --full         # shell with sway environment
```

<a name="shell"></a>
## shell

i keep both zsh and bash configured, and only use bash on termux. i've made my shell config pretty much plug-and-play by hardcoding my prompts' hex codes and automating their selection by hostname with a case statement because i need at minimum three visual cues to know where tf i am.

one of my quirks is i changed all variations of `ls` to use `--group-directories-first`, which just makes sense to me. i'm a fan of `fish`-like `zsh-syntax-highlighting`, too. i am always in a [tmux](https://github.com/tmux/tmux) session for the practical reason of walking away from venv work in my dev box, and the silly reason of constantly having [mpv](https://mpv.io/) or [ncmpcpp](https://github.com/ncmpcpp/ncmpcpp) open on my desktop.

<a name="sway"></a>
## sway

i don't toil away at ricing linux, but what i do have are three custom neovim colorschemes that serve the functional purpose of reminding me what host i'm on, and which i want my machines with [sway](https://swaywm.org/) to match. besides colors, this customization takes different swaybar scripts per device (i don't need battery on desktop, for example). my modular sway setup looks like

```
.config/sway/
|-- config.d/
|   |-- wall/
|   |   `-- {wallpapers}
|   |-- 00-base
|   |-- 10-goingmerry      => desktop
|   |-- 10-thousandsunny   => thinkpad
|   |-- 20-luna
|   |-- 20-moonqueen
|   `-- 20-perona
|-- config
|-- desktop.sh
`-- laptop.sh            => swaybar status scripts
```

where `config` is only a few lines to `include` relevant files from `config.d`. `10-$hostname` differ mostly by my laptop occasionally being plugged into a 4k tv; otherwise, i give myself six workspaces and the tray at 0 and keep it more or less the same besides sending one to hdmi. `20-$palette` correspond to my nvim schemes.

i love [foot](https://codeberg.org/dnkl/foot), the default wayland terminal emulator, but i sometimes switch to [alacritty](https://alacritty.org) on my desktop. i also test drive weird new ones on my alpine laptop like [rio](https://rioterm.com) or [ghostty](https://ghostty.org).

fonts are some of my greatest passions. these days i rotate between

- [cozette](https://github.com/the-moonwitch/Cozette)
- [ibm 3270](https://packages.debian.org/source/trixie/3270font) or [3270 nerd font](https://www.programmingfonts.org/#font3270)
- [recursive mono casual](https://www.recursive.design/)

<a name="previews"></a>
## previews

![moonqueen](./moonqueen.png)
