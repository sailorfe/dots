# type: ignore config
import socket

hostname = socket.gethostname()

palettes = {
    "luna": {
        "background": "#271b2d",
        "foreground": "#ead9f2",
        "black": "#372640",
        "red": "#f07575",
        "green": "#d1f075",
        "yellow": "#f0d175",
        "blue": "#7db2e8",
        "cyan": "#b27de8",
        "magenta": "#e87db3",
        "white": "#b99fc6",
        "brightBlack": "#483253",
        "brightRed": "#fa9e9e",
        "brightGreen": "#e3fa9e",
        "brightYellow": "#fae39e",
        "brightBlue": "#a3ccf5",
        "brightCyan": "#cca3f5",
        "brightMagenta": "#f5a3cc",
        "brightWhite": "#ead9f2",
    },
    "perona": {
        "background": "#261720",
        "foreground": "#eac3da",
        "black": "#331f2b",
        "red": "#d0435f",
        "green": "#d18de2",
        "yellow": "#e28d8d",
        "blue": "#8dafe2",
        "magenta": "#d65c8d",
        "cyan": "#ed82c2",
        "white": "#896c7d",
        "brightBlack": "#3f2735",
        "brightRed": "#f76e89",
        "brightGreen": "#e4a3f5",
        "brightYellow": "#f5a3a3",
        "brightBlue": "#a3c4f5",
        "brightCyan": "#f76ea5",
        "brightMagenta": "#fa9ed5",
        "brightWhite": "#eac3da",
    }
}

if hostname == "thousandsunny":
    colors = palettes["luna"]
else:
    colors = palettes["perona"]

background = colors["background"]
foreground = colors["foreground"]
black = colors["black"]
red = colors["red"]
green = colors["green"]
yellow = colors["yellow"]
blue = colors["blue"]
magenta = colors["magenta"]
cyan = colors["cyan"]
white = colors["white"]
brightBlack = colors["brightBlack"]
brightRed = colors["brightRed"]
brightGreen = colors["brightGreen"]
brightYellow = colors["brightYellow"]
brightBlue = colors["brightBlue"]
brightCyan = colors["brightCyan"]
brightMagenta = colors["brightMagenta"]
brightWhite = colors["brightWhite"]

# ----------------------------------------------------------------- // settings

config.load_autoconfig(False)

# keybinds

config.bind('gJ', 'tab-move +')
config.bind('gK', 'tab-move -')
config.bind('tT', 'config-cycle tabs.position top left')
config.bind('zl', 'spawn --userscript qute-pass')
config.bind('zpl', 'spawn --userscript qute-pass --password-only')
config.bind('tD', 'config-cycle colors.webpage.darkmode.enabled True False')

config.set('auto_save.session', True)

config.set('tabs.padding', {
    'bottom': 3,
    'left': 6,
    'right': 6,
    'top': 3
    })
config.set('tabs.title.format', "{audio}{private}{index} {current_title}")
config.set('tabs.title.format_pinned', "{index} {current_title}")
config.set('tabs.position', 'top')
config.set('tabs.show', 'multiple')
config.set('tabs.width', '15%')

config.set('statusbar.padding', {
    'bottom': 2,
    'left': 4,
    'right': 4,
    'top': 2
    })

# colors

config.set('colors.completion.even.bg', background)
config.set('colors.completion.odd.bg', background)
config.set('colors.completion.fg', foreground)
config.set('colors.completion.match.fg', cyan)
config.set('colors.completion.category.bg', black)
config.set('colors.completion.category.border.bottom', black)
config.set('colors.completion.category.border.top', black)
config.set('colors.completion.category.fg', foreground)
config.set('colors.completion.item.selected.bg', brightMagenta)
config.set('colors.completion.item.selected.border.bottom', brightMagenta)
config.set('colors.completion.item.selected.border.top', brightMagenta)
config.set('colors.completion.item.selected.fg', black)
config.set('colors.completion.item.selected.match.fg', background)
config.set('colors.completion.scrollbar.bg', background)
config.set('colors.completion.scrollbar.fg', foreground)

config.set('colors.contextmenu.disabled.bg', background)
config.set('colors.contextmenu.disabled.fg', white)
config.set('colors.contextmenu.menu.bg', background)
config.set('colors.contextmenu.menu.fg', foreground)
config.set('colors.contextmenu.selected.bg', magenta)
config.set('colors.contextmenu.selected.fg', background)

config.set('colors.downloads.bar.bg', background)
config.set('colors.downloads.start.bg', foreground)
config.set('colors.downloads.stop.bg', brightMagenta)
config.set('colors.downloads.start.fg', background)
config.set('colors.downloads.stop.fg', background)

config.set('colors.hints.bg', background)
config.set('colors.hints.fg', foreground)
config.set('colors.hints.match.fg', brightBlue)

config.set('colors.keyhint.bg', background)
config.set('colors.keyhint.fg', foreground)
config.set('colors.keyhint.suffix.fg', blue)

config.set('colors.messages.error.bg', black)
config.set('colors.messages.error.border', black)
config.set('colors.messages.error.fg', brightYellow)
config.set('colors.messages.info.bg', black)
config.set('colors.messages.info.border', black)
config.set('colors.messages.info.fg', foreground)
config.set('colors.messages.warning.bg', black)
config.set('colors.messages.warning.border', black)
config.set('colors.messages.warning.fg', brightRed)

config.set('colors.prompts.bg', black)
config.set('colors.prompts.border', black)
config.set('colors.prompts.fg', brightWhite)
config.set('colors.prompts.selected.bg', brightMagenta)
config.set('colors.prompts.selected.fg', background)

config.set('colors.statusbar.normal.bg', black)
config.set('colors.statusbar.normal.fg', cyan)
config.set('colors.statusbar.caret.bg', black)
config.set('colors.statusbar.caret.fg', foreground)
config.set('colors.statusbar.caret.selection.bg', black)
config.set('colors.statusbar.caret.selection.fg', brightYellow)
config.set('colors.statusbar.insert.bg', black)
config.set('colors.statusbar.insert.fg', foreground)
config.set('colors.statusbar.command.bg', black)
config.set('colors.statusbar.command.fg', foreground)
config.set('colors.statusbar.command.private.bg', brightBlack)
config.set('colors.statusbar.command.private.fg', brightWhite)
config.set('colors.statusbar.passthrough.bg', black)
config.set('colors.statusbar.passthrough.fg', cyan)
config.set('colors.statusbar.progress.bg', blue)
config.set('colors.statusbar.url.fg', brightMagenta)
config.set('colors.statusbar.url.error.fg', brightRed)
config.set('colors.statusbar.url.hover.fg', brightBlue)
config.set('colors.statusbar.url.warn.fg', brightYellow)
config.set('colors.statusbar.url.success.http.fg', brightGreen)
config.set('colors.statusbar.url.success.https.fg', brightGreen)

config.set('colors.tabs.bar.bg', background)
config.set('colors.tabs.even.bg', background)
config.set('colors.tabs.odd.bg', background)
config.set('colors.tabs.even.fg', white)
config.set('colors.tabs.odd.fg', white)
config.set('colors.tabs.indicator.start', black)
config.set('colors.tabs.indicator.error', red)
config.set('colors.tabs.indicator.stop', brightMagenta)
config.set('colors.tabs.selected.even.bg', cyan)
config.set('colors.tabs.selected.odd.bg', cyan)
config.set('colors.tabs.selected.even.fg', background)
config.set('colors.tabs.selected.odd.fg', background)
config.set('colors.tabs.pinned.even.bg', brightBlack)
config.set('colors.tabs.pinned.odd.bg', brightBlack)
config.set('colors.tabs.pinned.even.fg', foreground)
config.set('colors.tabs.pinned.odd.fg', foreground)
config.set('colors.tabs.pinned.selected.even.bg', magenta)
config.set('colors.tabs.pinned.selected.odd.bg', magenta)
config.set('colors.tabs.pinned.selected.even.fg', foreground)
config.set('colors.tabs.pinned.selected.odd.fg', foreground)

config.set('colors.tooltip.bg', background)
config.set('colors.tooltip.fg', foreground)

# fonts

config.set('fonts.default_family', ['Cozette', 'monospace'])
config.set('fonts.default_size', '26px')
config.set('fonts.web.family.fixed', 'monospace')
config.set('fonts.web.family.sans_serif', 'sans-serif')
config.set('fonts.web.family.serif', 'serif')
config.set('fonts.web.family.standard', 'monospace')

# search
config.set('url.searchengines', {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    '!apk': 'https://pkgs.alpinelinux.org/packages?name={}&branch=edge&repo=&arch=x86_64&origin=&flagged=&maintainer=',
    '!dpkg': 'https://packages.debian.org/search?keywords={}',
    '!cb': "https://codeberg.org/search?q={}",
    '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
    '!yt': 'https://www.youtube.com/results?search_query={}',
    '!wiki': 'https://en.wikipedia.org/w/index.php?search={}',
    '!op': 'https://onepiece.fandom.com/wiki/Special:Search?query={}',
    '!pin': 'https://pinterest.com/search/pins/?q={}',
    '!uc': 'https://www.compart.com/en/unicode/search?q={}',
    '!ug': 'https://www.ultimate-guitar.com/search.php?search_type=title&value={}',
    '!adb': 'https://www.astro.com/wiki/astro-databank/index.php?search={}&title=Special%3ASearch&go=Go',
    '!ask': 'https://www.alicesparklykat.com/search/?search={}',
    '!tap': 'https://theastrologypodcast.com/?s={}'
    })

# privacy - adjust these settings based on your preference
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
