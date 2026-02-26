# type: ignore config
# type: ignore config
import socket

hostname = socket.gethostname()

palettes = {
    "luna": {
        "background": "#37273f",
        "foreground": "#dbc8e5",
        "color0": "#211726",
        "color1": "#e25057",
        "color2": "#b6ca68",
        "color3": "#efbb43",
        "color4": "#8dafe2",
        "color5": "#d65ca5",
        "color6": "#a98de2",
        "color7": "#9f87ab",
        "color8": "#432b50",
        "color9": "#f8777e",
        "color10": "#ccda95",
        "color11": "#f4d07c",
        "color12": "#b9d0f4",
        "color13": "#eb84c2",
        "color14": "#c0a7f1",
        "color15": "#ead9f2",
    },
    "perona": {
        "background": "#281520",
        "foreground": "#f4b9dc",
        "color0": "#24141e",
        "color1": "#c4314e",
        "color2": "#bb68ca",
        "color3": "#d65c5c",
        "color4": "#5c8dd6",
        "color5": "#b54067",
        "color6": "#f269ad",
        "color7": "#90647f",
        "color8": "#532742",
        "color9": "#e2506d",
        "color10": "#e28dde",
        "color11": "#eb8484",
        "color12": "#8dafe2",
        "color13": "#d65c85",
        "color14": "#ff99cc",
        "color15": "#f8d3e9",
    }
}

if hostname == "thousandsunny":
    colors = palettes["luna"]
else:
    colors = palettes["perona"]

background = colors["background"]
foreground = colors["foreground"]
color0 = colors["color0"]
color1 = colors["color1"]
color2 = colors["color2"]
color3 = colors["color3"]
color4 = colors["color4"]
color5 = colors["color5"]
color6 = colors["color6"]
color7 = colors["color7"]
color8 = colors["color8"]
color9 = colors["color9"]
color10 = colors["color10"]
color11 = colors["color11"]
color12 = colors["color12"]
color13 = colors["color13"]
color14 = colors["color14"]
color15 = colors["color15"]

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
config.set('colors.completion.match.fg', color6)
config.set('colors.completion.category.bg', color0)
config.set('colors.completion.category.border.bottom', color0)
config.set('colors.completion.category.border.top', color0)
config.set('colors.completion.category.fg', foreground)
config.set('colors.completion.item.selected.bg', color14)
config.set('colors.completion.item.selected.border.bottom', color14)
config.set('colors.completion.item.selected.border.top', color14)
config.set('colors.completion.item.selected.fg', color0)
config.set('colors.completion.item.selected.match.fg', background)
config.set('colors.completion.scrollbar.bg', background)
config.set('colors.completion.scrollbar.fg', foreground)

config.set('colors.contextmenu.disabled.bg', background)
config.set('colors.contextmenu.disabled.fg', color7)
config.set('colors.contextmenu.menu.bg', background)
config.set('colors.contextmenu.menu.fg', foreground)
config.set('colors.contextmenu.selected.bg', color5)
config.set('colors.contextmenu.selected.fg', background)

config.set('colors.downloads.bar.bg', background)
config.set('colors.downloads.start.bg', foreground)
config.set('colors.downloads.stop.bg', color14)
config.set('colors.downloads.start.fg', background)
config.set('colors.downloads.stop.fg', background)

config.set('colors.hints.bg', background)
config.set('colors.hints.fg', foreground)
config.set('colors.hints.match.fg', color12)

config.set('colors.keyhint.bg', background)
config.set('colors.keyhint.fg', foreground)
config.set('colors.keyhint.suffix.fg', color4)

config.set('colors.messages.error.bg', color0)
config.set('colors.messages.error.border', color0)
config.set('colors.messages.error.fg', color11)
config.set('colors.messages.info.bg', color0)
config.set('colors.messages.info.border', color0)
config.set('colors.messages.info.fg', foreground)
config.set('colors.messages.warning.bg', color0)
config.set('colors.messages.warning.border', color0)
config.set('colors.messages.warning.fg', color9)

config.set('colors.prompts.bg', color0)
config.set('colors.prompts.border', color0)
config.set('colors.prompts.fg', color15)
config.set('colors.prompts.selected.bg', color14)
config.set('colors.prompts.selected.fg', background)

config.set('colors.statusbar.normal.bg', color0)
config.set('colors.statusbar.normal.fg', color6)
config.set('colors.statusbar.caret.bg', color0)
config.set('colors.statusbar.caret.fg', foreground)
config.set('colors.statusbar.caret.selection.bg', color0)
config.set('colors.statusbar.caret.selection.fg', color11)
config.set('colors.statusbar.insert.bg', color0)
config.set('colors.statusbar.insert.fg', foreground)
config.set('colors.statusbar.command.bg', color0)
config.set('colors.statusbar.command.fg', foreground)
config.set('colors.statusbar.command.private.bg', color8)
config.set('colors.statusbar.command.private.fg', color15)
config.set('colors.statusbar.passthrough.bg', color0)
config.set('colors.statusbar.passthrough.fg', color6)
config.set('colors.statusbar.progress.bg', color4)
config.set('colors.statusbar.url.fg', color14)
config.set('colors.statusbar.url.error.fg', color9)
config.set('colors.statusbar.url.hover.fg', color12)
config.set('colors.statusbar.url.warn.fg', color11)
config.set('colors.statusbar.url.success.http.fg', color10)
config.set('colors.statusbar.url.success.https.fg', color10)

config.set('colors.tabs.bar.bg', background)
config.set('colors.tabs.even.bg', background)
config.set('colors.tabs.odd.bg', background)
config.set('colors.tabs.even.fg', color7)
config.set('colors.tabs.odd.fg', color7)
config.set('colors.tabs.indicator.start', color0)
config.set('colors.tabs.indicator.error', color1)
config.set('colors.tabs.indicator.stop', color14)
config.set('colors.tabs.selected.even.bg', color6)
config.set('colors.tabs.selected.odd.bg', color6)
config.set('colors.tabs.selected.even.fg', background)
config.set('colors.tabs.selected.odd.fg', background)
config.set('colors.tabs.pinned.even.bg', color8)
config.set('colors.tabs.pinned.odd.bg', color8)
config.set('colors.tabs.pinned.even.fg', foreground)
config.set('colors.tabs.pinned.odd.fg', foreground)
config.set('colors.tabs.pinned.selected.even.bg', color5)
config.set('colors.tabs.pinned.selected.odd.bg', color5)
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
    '!aw': 'https://wiki.archlinux.org/?search={}',
    '!apk': 'https://pkgs.alpinelinux.org/packages?name={}&branch=edge&repo=&arch=x86_64&origin=&flagged=&maintainer=',
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
