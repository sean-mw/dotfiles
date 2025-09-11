local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 18

config.enable_tab_bar = false

config.window_decorations = "TITLE | RESIZE"

config.color_scheme = 'Catppuccin Mocha'

config.window_close_confirmation = 'NeverPrompt'

return config
