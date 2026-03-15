# type: ignore config
import os

config.load_autoconfig(False)
config.set('auto_save.session', True)

# == constants =============================================================

theme = os.environ['THEME']
background = os.environ['COLOR_BACKGROUND']
foreground = os.environ['COLOR_FOREGROUND']
black = os.environ['COLOR_BLACK']
red = os.environ['COLOR_RED']
green = os.environ['COLOR_GREEN']
yellow = os.environ['COLOR_YELLOW']
blue = os.environ['COLOR_BLUE']
magenta = os.environ['COLOR_MAGENTA']
cyan = os.environ['COLOR_CYAN']
white = os.environ['COLOR_WHITE']
brightBlack = os.environ['COLOR_BRIGHT_BLACK']
brightRed = os.environ['COLOR_BRIGHT_RED']
brightGreen = os.environ['COLOR_BRIGHT_GREEN']
brightYellow = os.environ['COLOR_BRIGHT_YELLOW']
brightBlue = os.environ['COLOR_BRIGHT_BLUE']
brightMagenta = os.environ['COLOR_BRIGHT_MAGENTA']
brightCyan = os.environ['COLOR_BRIGHT_CYAN']
brightWhite = os.environ['COLOR_BRIGHT_WHITE']

if theme == "perona":
    accent = cyan
    alt = magenta
    brightAccent = brightCyan
    brightAlt = brightMagenta
else:
    accent = magenta
    alt = cyan
    brightAccent = brightMagenta
    brightAlt = brightCyan

# == colors ================================================================

# -*- completion -*-
config.set('colors.completion.even.bg', background)
config.set('colors.completion.odd.bg', background)
config.set('colors.completion.fg', foreground)
config.set('colors.completion.match.fg', accent)
config.set('colors.completion.category.bg', black)
config.set('colors.completion.category.border.bottom', black)
config.set('colors.completion.category.border.top', black)
config.set('colors.completion.category.fg', foreground)
config.set('colors.completion.item.selected.bg', alt)
config.set('colors.completion.item.selected.border.bottom', alt)
config.set('colors.completion.item.selected.border.top', alt)
config.set('colors.completion.item.selected.fg', black)
config.set('colors.completion.item.selected.match.fg', background)
config.set('colors.completion.scrollbar.bg', background)
config.set('colors.completion.scrollbar.fg', foreground)

# -*- contextmenu -*-
config.set('colors.contextmenu.disabled.bg', background)
config.set('colors.contextmenu.disabled.fg', white)
config.set('colors.contextmenu.menu.bg', background)
config.set('colors.contextmenu.menu.fg', foreground)
config.set('colors.contextmenu.selected.bg', alt)
config.set('colors.contextmenu.selected.fg', background)

# -*- downloads -*-
config.set('colors.downloads.bar.bg', background)
config.set('colors.downloads.start.bg', foreground)
config.set('colors.downloads.stop.bg', alt)
config.set('colors.downloads.start.fg', background)
config.set('colors.downloads.stop.fg', background)

# -*- hints -*-
config.set('colors.hints.bg', background)
config.set('colors.hints.fg', foreground)
config.set('colors.hints.match.fg', brightBlue)
config.set('colors.keyhint.bg', background)
config.set('colors.keyhint.fg', foreground)
config.set('colors.keyhint.suffix.fg', blue)

# -*- messages -*-
config.set('colors.messages.error.bg', black)
config.set('colors.messages.error.border', black)
config.set('colors.messages.error.fg', brightYellow)
config.set('colors.messages.info.bg', black)
config.set('colors.messages.info.border', black)
config.set('colors.messages.info.fg', foreground)
config.set('colors.messages.warning.bg', black)
config.set('colors.messages.warning.border', black)
config.set('colors.messages.warning.fg', brightRed)

# -*- prompts -*-
config.set('colors.prompts.bg', black)
config.set('colors.prompts.border', black)
config.set('colors.prompts.fg', brightWhite)
config.set('colors.prompts.selected.bg', brightAlt)
config.set('colors.prompts.selected.fg', background)

# -*- statusbar -*-
config.set('colors.statusbar.normal.bg', background)
config.set('colors.statusbar.normal.fg', accent)
config.set('colors.statusbar.caret.bg', black)
config.set('colors.statusbar.caret.fg', foreground)
config.set('colors.statusbar.caret.selection.bg', black)
config.set('colors.statusbar.caret.selection.fg', brightYellow)
config.set('colors.statusbar.insert.bg', black)
config.set('colors.statusbar.insert.fg', foreground)
config.set('colors.statusbar.command.bg', black)
config.set('colors.statusbar.command.fg', foreground)
config.set('colors.statusbar.passthrough.bg', black)
config.set('colors.statusbar.passthrough.fg', accent)
config.set('colors.statusbar.progress.bg', blue)
config.set('colors.statusbar.private.bg', black)
config.set('colors.statusbar.private.fg', white)
config.set('colors.statusbar.command.private.bg', brightBlack)
config.set('colors.statusbar.command.private.fg', brightWhite)
config.set('colors.statusbar.url.fg', alt)
config.set('colors.statusbar.url.error.fg', red)
config.set('colors.statusbar.url.hover.fg', blue)
config.set('colors.statusbar.url.warn.fg', yellow)
config.set('colors.statusbar.url.success.http.fg', green)
config.set('colors.statusbar.url.success.https.fg', green)

# -*- tabs -*-
config.set('colors.tabs.bar.bg', background)
config.set('colors.tabs.even.bg', background)
config.set('colors.tabs.odd.bg', background)
config.set('colors.tabs.even.fg', white)
config.set('colors.tabs.odd.fg', white)
config.set('colors.tabs.indicator.start', black)
config.set('colors.tabs.indicator.error', red)
config.set('colors.tabs.indicator.stop', brightAlt)
config.set('colors.tabs.selected.even.bg', accent)
config.set('colors.tabs.selected.odd.bg', accent)
config.set('colors.tabs.selected.even.fg', background)
config.set('colors.tabs.selected.odd.fg', background)
config.set('colors.tabs.pinned.even.bg', brightBlack)
config.set('colors.tabs.pinned.odd.bg', brightBlack)
config.set('colors.tabs.pinned.even.fg', foreground)
config.set('colors.tabs.pinned.odd.fg', foreground)
config.set('colors.tabs.pinned.selected.even.bg', alt)
config.set('colors.tabs.pinned.selected.odd.bg', alt)
config.set('colors.tabs.pinned.selected.even.fg', foreground)
config.set('colors.tabs.pinned.selected.odd.fg', foreground)

# -*- tooltips -*-
config.set('colors.tooltip.bg', background)
config.set('colors.tooltip.fg', foreground)

# == fonts ================================================================

config.set('fonts.default_family', ['Cozette', 'monospace'])
config.set('fonts.default_size', '26px')
config.set('fonts.web.family.fixed', 'monospace')
config.set('fonts.web.family.sans_serif', 'sans-serif')
config.set('fonts.web.family.serif', 'serif')
config.set('fonts.web.family.standard', 'sans-serif')

# == keybinds ==============================================================

config.bind('gJ', 'tab-move +')
config.bind('gK', 'tab-move -')
config.bind('tT', 'config-cycle tabs.position top left')
config.bind('zl', 'spawn --userscript qute-pass')
config.bind('zpl', 'spawn --userscript qute-pass --password-only')
config.bind('tD', 'config-cycle colors.webpage.darkmode.enabled True False')

config.set('tabs.padding', {
    'bottom': 3,
    'left': 6,
    'right': 3,
    'top': 6
    })
config.set('tabs.title.format', "{audio}{private}{index} {current_title}")
config.set('tabs.title.format_pinned', "{index} {current_title}")
config.set('tabs.position', 'top')
config.set('tabs.show', 'multiple')
config.set('tabs.width', '15%')

config.set('statusbar.padding', {
    'bottom': 3,
    'left': 6,
    'right': 6,
    'top': 3
    })

# == search ===============================================================

config.set('url.searchengines', {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    '!apk': 'https://pkgs.alpinelinux.org/packages?name={}&branch=edge&repo=&arch=x86_64&origin=&flagged=&maintainer=',
    '!dd': 'https://devdocs.io/#q={}',
    '!dpkg': 'https://packages.debian.org/search?keywords={}',
    '!cb': "https://codeberg.org/explore/repos?q={}",
    '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
    '!yt': 'https://www.youtube.com/results?search_query={}',
    '!wiki': 'https://en.wikipedia.org/w/index.php?search={}',
    '!op': 'https://onepiece.fandom.com/wiki/Special:Search?query={}',
    '!jj': 'https://jojowiki.com/index.php?search={}&title=Special%3ASearch&go=Go',
    '!pin': 'https://pinterest.com/search/pins/?q={}',
    '!uc': 'https://www.compart.com/en/unicode/search?q={}',
    '!ug': 'https://www.ultimate-guitar.com/search.php?search_type=title&value={}',
    '!adb': 'https://www.astro.com/wiki/astro-databank/index.php?search={}&title=Special%3ASearch&go=Go',
    '!ask': 'https://www.alicesparklykat.com/search/?search={}',
    '!tap': 'https://theastrologypodcast.com/?s={}'
    })

# == privacy ==============================================================
# config.set('completion.cmd_history_max_items', 0)
# config.set('content.private_browsing', True)
config.set('content.webgl', False, '*')
config.set('content.canvas_reading', False)
config.set('content.geolocation', False)
config.set('content.webrtc_ip_handling_policy', 'default-public-interface-only')
config.set('content.cookies.accept', 'all')
config.set('content.cookies.store', True)
# config.set('content.javascript.enabled', False) # tsh keybind to toggle
config.set('content.blocking.enabled', True)
