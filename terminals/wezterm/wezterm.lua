local wezterm = require("wezterm")
local config = wezterm.config_builder()

--- Appearance ---
config.font_size = 13.0
config.color_scheme = "Firewatch"

--- Tab bar & Window ---
config.window_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "NONE"
config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }

return config
