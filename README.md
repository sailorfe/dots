# sailorfe dots

![perona](./perona.png)

```
     '                                                     .         o
 '                                    .*   '    o
                          .  |
          *         *+     - o -                                              .
*  +    +           /        |               +   |       +~~                 ''
      '            /            o   '           -+-  +  .           .
                  *                          .   |         .
  .                           sailorfe's dotfiles                        +*
         +                                    .       .      +   '      .
        '        *  '    ':.    ' .   '      '        _..                    o
  '                        '::._  .           +   + '`-. `.             +
                             '._)                       \  \
  o                       *       '                     |  |                 '
   +                   '         '     '                /  /
           +   .                            .       _.-`_.`                   .
                     '                               '''     '        '
.       '         |                                    +  .
'                -+-                                  .          .
                  |                                 .                   +  .
                  '   *           +       +                           +       *
```

these are my dotfiles for a linux ecosystem that currently includes a debian 13 desktop, a debian 13 dev server on a macbook air 2017, and an endeavourOS thinkpad. on my desktop and thinkpad, i run [sway](https://swaywm.org), and wayland gives me no real issues besides with flatpak electron apps.

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

i follow the [xdg base directory specification](https://specifications.freedesktop.org/basedir-spec/latest/) and try my best to keep hidden files tamed and my [xdg-user-dirs](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/) as single-character directories.

```sh
.
├── .config/
│   ├── bash/
│   ├── ranger/
│   ├── sway/
│   ├── tmux/
│   └── zsh/      $ZDOTDIR
│       └── .zshrc
├── .local/
│   ├── bin/
│   ├── cache/    $XDG_CACHE_HOME
│   ├── lib/                      => CARGO_HOME, GOPATH, etc
│   ├── share/    $XDG_DATA_HOME
│   └── state/    $XDG_STATE_HOME
│       └── {bash,zsh}
│           └── history
├── a/                            => .deb files and pre-built binaries
├── d/                            => personal documents
├── m/    $XDG_$media_DIR
├── p/                            => my source code
│   ├── dots/                     => this repository
│   ├── py/                       => i divide dev projects by language stack
│   └── www/
├── s/                            => not-my source code
│   └── neovim
├── v/
└── .profile                      => referenced by bash and zsh
```

so before i even clone this repo, i run a command like this:

```sh
mkdir ~/.config &&
    mkdir -p ~/.local/{bin,cache,lib,share} &&
    mkdir -p ~/.local/state/{bash,zsh} &&
    mkdir -p ~/{a,d,m,p,s,v}
```

<a name="dependencies"></a>
## dependencies

it goes without saying that this setup depends on git, and with it [gnu stow](https://www.gnu.org/software/stow/), which basically manages a mess of symlinks from this repository into my `.config` and home directories. the package name in the same for `apt` and `pacman`:

- `apt install git stow`
- `pacman -S git stow`

<a name="installation"></a>
## installation

once you've made the base directory structure, you can run `install.sh` at the root of this repository or run its functions manually like

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
./install.sh --minimal      # only shell, ranger, and tmux
./install.sh --sway         # only sway
./install.sh --full         # shell with sway environment
```

<a name="shell"></a>
## shell

i keep both zsh and bash configured. i'm not totally sure why, but i use bash on my dev box server but zsh on my environments with sway. i've made my shell config pretty much plug-and-play by hardcoding my prompts' hex codes and automating their selection by hostname with a case statement because i need at minimum three visual cues to know where tf i am.

i have a stack of git aliases i lifted from [xero](https://github.com/xero/dotfiles). otherwise one of my quirks is i changed all variations of `ls` to use `--group-directories-first`, which just makes sense to me. i'm a fan of `fish`-like `zsh-syntax-highlighting`, too. i am always in a [tmux](https://github.com/tmux/tmux) session for the practical reason of walking away from venv work in my dev box (though i'm migrating my projects to uv now...), and the silly reason of constantly having [mpv](https://mpv.io/) or [ncmpcpp](https://github.com/ncmpcpp/ncmpcpp) open on my desktop.

<a name="sway"></a>
## sway

i don't toil away at ricing linux, but what i do have are three custom neovim colorschemes that serve the functional purpose of reminding me what host i'm on, and which i want my machines with [sway](https://swaywm.org/) to match. besides colors, this customization takes different swaybar scripts per device (i don't need battery on desktop, for example). my modular sway setup looks like

```
.
├── config.d/
│   ├── wall/
│   │   └── {wallpapers}
│   ├── 00-base
│   ├── 10-goingmerry      => desktop
│   ├── 10-thousandsunny   => thinkpad
│   ├── 20-luna
│   ├── 20-moonqueen
│   └── 20-perona
├── config
├── desktop.sh
└── laptop.sh            => swaybar status scripts
```

where `config` is only a few lines to `include` relevant files from `config.d`. `10-$hostname` differ mostly by my laptop occasionally being plugged into a 4k tv; otherwise, i give myself six workspaces and the tray at 0 and keep it more or less the same besides sending one to hdmi. `20-$palette` correspond to my nvim schemes.

i switch between [alacritty](https://alacritty.org) and the default wayland terminal emulator [foot](https://codeberg.org/dnkl/foot) by binding a config file for each colorscheme to use to `Super + Return`, so with alacritty this looks like `alacritty --config-file ~/.config/alacritty/perona.toml`. i also spin up [wezterm](https://wezterm.org/) on occassion. but on my endeavourOS laptop, i test drive exciting new emulators like [rio](https://rioterm.com) and [ghostty](https://ghostty.org), which i have no real reason to stray to or integrate into my desktop usage since managing apt external repos for newer packages is my longtime nemesis.

fonts are one of my greatest passions. these days i rotate between

- [cozette](https://github.com/the-moonwitch/Cozette)
- [ibm 3270](https://packages.debian.org/source/trixie/3270font) or [3270 nerd font](https://www.programmingfonts.org/#font3270)
- [recursive mono casual](https://www.recursive.design/)

<a name="previews"></a>
## previews

![moonqueen](./moonqueen.png)
