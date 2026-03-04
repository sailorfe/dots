local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font_size = 11
config.font = wezterm.font('Rec Mono Casual')
config.color_scheme = 'Luna'
config.use_fancy_tab_bar = false
config.window_background_opacity = 1.0
config.initial_cols = 120
config.initial_rows = 28
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

return config
