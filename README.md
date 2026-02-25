![perona](./perona.png)

these are my configuration files for an overwhelmingly [debian linux](https://debian.org) ecosystem across four devices of advancing age. the newest is termux on android; the oldest is an hp compaq elite 8000 usdt; and the outlier is a thinkpad on [alpine linux](https://alpinelinux.org).

my desktop and laptop use [sway](https://swaywm.org). wayland is pretty good these days with the help of `xwayland` and `xdg-desktop-portal-*` to fill some gaps.

this repo is designed to be modular and minimal. i'm neither or a gamer or a sysadmin or even that serious a ricer, just someone who frequently nukes my installations (i swear by separate `/home` and `/`).

### table of contents

- [installation](#installation)
- [dependencies](#dependencies)
- [homedir](#homedir)
- [shell](#shell)
- [neovim](#neovim)
- [sway](#sway)
- [previews](#previews)
- [license](#license)

<a name="installation"></a>
## installation

**the install scripts at the root of this repository are iterated through a few installations, so proceed with caution! i haven't actually run them in their current form.**

they have a few optional flags for whether this is a server or desktop installation:

```sh
# if on alpine, doas apk add bash
{doas bash,sudo} ./$DISTRO.sh                # base packages
{doas bash,sudo} ./$DISTRO.sh --sway         # only sway
{doas bash,sudo} ./$DISTRO.sh --homedir      # sets up homedir and zdotdir
```

but if you want to move a bit slower than a script that i haven't fully tested (need to set up VMs or something for that), the order of operations is really:

1. install base packages, most importantly zsh and neovim dependencies
2. create file tree
3. clone and stow dotfiles

<a name="dependencies"></a>
### dependencies

it goes without saying that this setup depends on git, and with it [gnu stow](https://www.gnu.org/software/stow/), which basically manages a mess of symlinks from this repository into my `.config` and home directories.

- debian: `apt install git stow`
- alpine: `apk add git stow`

ostensibly, you could install `curl` only and run `curl -LO https://codeberg.org/sailorfe/dots/raw/branch/main/$DISTRO.sh`, `chmod +x $DISTRO.sh`, and it'll install git and stow for you before anything else. there are many ways to go about this.

<a name="homedir"></a>
### homedir layout

i follow the [xdg base directory specification](https://specifications.freedesktop.org/basedir-spec/latest/) and try my best to keep hidden files tamed. i keep [xdg-user-dirs](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/) under `.local` and the more colloquial `$XDG_{DOCUMENTS,MUSIC,PICTURES,VIDEOS}_DIR` visible at `~` with single-letter toplevels.

```sh
~
|-- .config/        => $XDG_CONFIG_HOME
|   |-- bash/
|   |-- nvim/
|   |-- sway/
|   |-- tmux/
|   `-- zsh/        => $ZDOTDIR
|       `-- .zshrc
|-- .local
|   |-- bin/
|   |-- cache/      => $XDG_CACHE_HOME
|   |-- lib/        => $GOPATH, $CARGO_HOME, etc
|   |-- share/      => $XDG_DATA_HOME
|   `-- state/      => $XDG_STATE_HOME
|-- d/              => personal documents
|   |-- flor{ilegium}   => notes -> syncthing
|   `-- etc...
|-- m/
|   |-- app/            => *.deb, *.iso
|   |-- doc/            => *.cbz, *.epub, *.pdf
|   |-- img/
|   |   `-- cap/            => $GRIM_DEFAULT_DIR
|   |-- mus/            => music library -> syncthing
|   `-- vid/
|-- p/                  => my source code
|   `-- dots/               => this repo!
`-- s/                  => not-my source code
```

before i even clone this repo, i run a command like this to make sure the XDG directories themselves don't become symlinks:

```sh
mkdir ~/.config &&
    mkdir -p ~/.local/{bin,cache,lib,share,state} &&
    mkdir -p ~/.local/state/{bash,zsh} &&
    mkdir -p ~/{d,m,p,s}
```

this has gone through some evolution through the years, but it's the combined influence of [xero](https://github.com/xero/dotfiles) and [elly](https://elly.town/d/blog/2021-10-06-homedir.txt). i feel especially strongly about xdg and develop and configure with it in mind!

once you've made a filetree of a kind, you're free to run `git clone https://codeberg.org/sailorfe/dotfiles.git` and stow away:

```sh
cd dots/shell && stow -t ~ *
cd ../sway && stow -t ~ *
```

<a name="shell"></a>
## shell

i use zsh on all devices, though i keep a close-enough bash config. i've made my shell config pretty much plug-and-play by hardcoding my prompts' hex codes and automating their selection by hostname with a case statement because i need at minimum three visual cues to know where tf i am.

one of my quirks is i changed all variations of `ls` to use `--group-directories-first`, which just makes sense to me. i'm a fan of `fish`-like `zsh-syntax-highlighting`, too. i am always in a [tmux](https://github.com/tmux/tmux) session for the practical reason of walking away from venv work in my dev box, and the silly reason of constantly having [mpv](https://mpv.io/) or [ncmpcpp](https://github.com/ncmpcpp/ncmpcpp) open on my desktop.

<a name="neovim"></a>
## neovim

i use neovim for writing prose and code, and i do more of the former than the latter, with the combined might of [the built-in lsp](https://github.com/neovim/nvim-lspconfig) and [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter). i manage plugins with [lazy](https://github.com/folke/lazy.nvim), but i've been curious about [forgoing a plugin manager altogether](https://whynothugo.nl/journal/2026/01/08/you-dont-need-a-neovim-plugin-manager/)...

- **language servers + linters**: [ty](https://docs.astral.sh/ty/features/language-server/), [ruff](https://astral.sh/ruff), [clangd](https://clangd.llvm.org/), [Marksman](https://github.com/artempyanykh/marksman), [bashls](https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#neovim), among others
- **notable plugins**:
    * [bullets.vim](https://github.com/bullets-vim/bullets.vim): for the markdown-pilled
    * [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim): indentation guides, very important for python and yaml
    * [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): unobtrusive git diff in the number gutter
    * my own colorschemes made with [lush.nvim](https://github.com/rktjmp/lush.nvim) and [shipwright.nvim](https://github.com/rktjmp/shipwright.nvim):
        + [perona](https://codeberg.org/sailorfe/perona.nvim)
        + [luna](https://codeberg.org/sailorfe/luna.nvim)
        + [moonqueen](https://codeberg.org/sailorfe/moonqueen.nvim)
    * [mason.nvim](https://github.com/mason-org/mason.nvim): manages language servers that i find annoying to hunt down or don't want from debian repositories or other package managers. so basically anything that i can't get with `uv`
    * [mini.nvim](https://github.com/nvim-mini/mini.nvim): comment, completion, files, git, icons, notify, pairs, pick, snippets, splitjoin, surround, starter, statusline
    * [no-neck-pain.nvim](https://github.com/shortcuts/no-neck-pain.nvim): 👵🏼
    * [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim): really great for codeblocks and such
    * [telescope.nvim](https:///github.com/nvim-telescope/telescope.nvim): tbh i mostly use this for `:Telescope lsp_document_symbols`
    * [trouble.nvim](https://github.com/folke/trouble.nvim): diagnostics

i have `Space` as my leader key in part because i use [a 40% mechanical keyboard](https://codeberg.org/sailorfe/qmk-planck) that puts `\` and `|` on the same key as `'`/`"`.

i have a fair bit of config geared toward writing markdown, which i've been doing in neo/vim for years before i started programming. it all relies on vim's built-in spellcheck and a Markdown `ftplugin` i've tinkered with longer than anything. i make liberal use of neovim's `runtimepath` and love squirreling stuff away in `XDG_{DATA,STATE}_HOME`.

```sh
~
|-- .local/
|   |-- share/
|   |   `-- nvim/
|   |       |-- lazy/
|   |       |-- mason/
|   |       |-- spell/
|   |       `-- undo/
|   `-- state/
|       `-- nvim/
|           |-- lsp.log
|           `-- mason.log
`-- .config/
    `-- nvim/
        |-- ftplugin/
        |   |-- markdown.lua
        |-- lua/
        |   |-- core/
        |   |   |-- editor.lua
        |   |   |-- keys.lua
        |   |   |-- lazy.lua
        |   |   `-- ui.lua
        |   `-- plugins/
        |       `-- {not too many!}
        `-- init.lua
```

<a name="sway"></a>
## sway

i don't toil away at ricing linux, but what i do have are three custom neovim colorschemes that serve the functional purpose of reminding me what host i'm on, and which i want my machines with [sway](https://swaywm.org/) to match. besides colors, this customization takes different swaybar scripts per device (i don't need battery on desktop, for example). my modular sway setup looks like

```sh
.config/sway
|-- config.d/
|   |-- 00-base
|   |-- 10-goingmerry      => debian desktop
|   |-- 10-thousandsunny   => alpine laptop; exec's a few background services
|   |-- 20-luna
|   |-- 20-moonqueen
|   `-- 20-perona
|-- config
|-- desktop.sh
`-- laptop.sh           => swaybar status scripts
```

where `config` is only a few lines to `include` relevant files from `config.d`. `10-$hostname` differ mostly by my laptop occasionally being plugged into a 4k tv; otherwise, i give myself six workspaces and the tray at 0 and keep it more or less the same besides sending one to hdmi. `20-$palette` correspond to my nvim schemes.

### browsers

my browser of choice is either [qutebrowser](https://qutebrowser.org/) or [librewolf](https://librewolf.net/). qutebrowser is written and configured with python, so it's a lot of fun. i also sometime go rogue and use [w3m](https://github.com/tats/w3m).

### terminal emulator

i love [foot](https://codeberg.org/dnkl/foot), the default wayland terminal emulator, but i sometimes switch to [alacritty](https://alacritty.org) when utf-8 gets weird. i also test drive newer ones like [rio](https://rioterm.com) or [ghostty](https://ghostty.org) and used [wezterm](https://wezterm.org) for a long time.

### fonts

fonts are some of my greatest passions. these days i rotate between

- [recursive mono casual](https://www.recursive.design/): very fun and almost pen-like with great italics. i also use the sans serif for my resumes.
- [cozette](https://github.com/the-moonwitch/Cozette): takes enabling bitmapped fonts on debian and alpine. i use this in my swaybar, wmenu, and rarely-seen sway window titles. it's also my cope for having 1080p monitors. i will sincerely look at 11pt bitmaps to get 3 neovim windows side by side.
- [ibm 3270](https://packages.debian.org/source/trixie/3270font) or [3270 nerd font](https://www.programmingfonts.org/#font3270): honestly? extremely readable.

in the past, i've gotten a lot of mileage out of [iosevka](https://typeof.net/Iosevka/) and [jetbrains mono](https://www.jetbrains.com/lp/mono/).

<a name="previews"></a>
## previews

![moonqueen](./moonqueen.png)

<a name="license"></a>
## license

these configs and scripts are released with [the unlicense](https://unlicense.org) / [kopimi](https://kopimi.com).

![kopimi](https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Kopimi_k.svg/250px-Kopimi_k.svg.png)
