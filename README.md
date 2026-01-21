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

these are my dotfiles for a linux ecosystem that currently includes a debian 13 desktop, a debian 13 dev server on a macbook air 2017, a void linux thinkpad, a termux for android. on my desktop and thinkpad, i run [sway](https://swaywm.org), and wayland gives me no real issues besides with flatpak electron apps.

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

i follow the [xdg base directory specification](https://specifications.freedesktop.org/basedir-spec/latest/) and try my best to keep hidden files tamed. i shove my [xdg-user-dirs](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/) under `.local`.

```
~
|-- .config/
|   |-- bash/
|   |-- ranger/
|   |-- sway/
|   |-- tmux/
|   `-- zsh/        => $ZDOTDIR
|       `-- .zshrc
|-- .local
|   |-- bin/
|   |-- doc/        => $XDG_DOCUMENTS_DIR
|   |   |-- flor/   => notes vault (florilegium)
|   |   |-- log/    => cron job logs
|   |   |-- sys/    => extraneous sysadmin stuff
|   |   `-- etc...
|   |-- cache/      => $XDG_CACHE_HOME
|   |-- lib/
|   |   |-- $CARGO_HOME
|   |   |-- $GOPATH
|   |   `-- etc...
|   |-- media/
|   |   |-- aud/
|   |   |-- cap/    => GRIM_DEFAULT_DIR
|   |   |-- den_den_mushi/  => kdeconnect file transfer
|   |   |-- doc/
|   |   |-- font/
|   |   |-- img/    => $XDG_PICTURES_DIR
|   |   |-- mus/    => $XDG_MUSIC_DIR
|   |   `-- vid/    => $XDG_VIDEOS_DIR
|   |-- share/      => $XDG_DATA_HOME
|   |-- src/
|   |   |-- p/      => my source code
|   |   |-- s/      = not-my source code
|   `-- vol/        => mountpoints
|-- .bashrc
|-- .bash_profile
|-- .password-store/
|-- .profile
`-- .ssh/
```


so before i even clone this repo, i run a command like this:

```sh
mkdir ~/.config &&
    mkdir -p ~/.local/{bin,cache,doc,lib,media,share,src/p,src/s} &&
    mkdir -p ~/.local/state/{bash,zsh}
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

i keep both zsh and bash configured, and only use bash on termux. i've made my shell config pretty much plug-and-play by hardcoding my prompts' hex codes and automating their selection by hostname with a case statement because i need at minimum three visual cues to know where tf i am.

one of my quirks is i changed all variations of `ls` to use `--group-directories-first`, which just makes sense to me. i'm a fan of `fish`-like `zsh-syntax-highlighting`, too. i am always in a [tmux](https://github.com/tmux/tmux) session for the practical reason of walking away from venv work in my dev box, and the silly reason of constantly having [mpv](https://mpv.io/) or [ncmpcpp](https://github.com/ncmpcpp/ncmpcpp) open on my desktop.

<a name="sway"></a>
## sway

i don't toil away at ricing linux, but what i do have are three custom neovim colorschemes that serve the functional purpose of reminding me what host i'm on, and which i want my machines with [sway](https://swaywm.org/) to match. besides colors, this customization takes different swaybar scripts per device (i don't need battery on desktop, for example). my modular sway setup looks like

```
.config/sway/
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

i love [foot](https://codeberg.org/dnkl/foot), the default wayland terminal emulator, but i sometimes switch to [alacritty](https://alacritty.org) on my desktop. i also test drive weird new ones on my void laptop like [rio](https://rioterm.com) or [ghostty](https://ghostty.org).

fonts are some of my greatest passions. these days i rotate between

- [cozette](https://github.com/the-moonwitch/Cozette)
- [ibm 3270](https://packages.debian.org/source/trixie/3270font) or [3270 nerd font](https://www.programmingfonts.org/#font3270)
- [recursive mono casual](https://www.recursive.design/)

<a name="previews"></a>
## previews

![moonqueen](./moonqueen.png)
