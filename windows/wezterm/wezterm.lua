local wezterm = require("wezterm")
local config = wezterm.config_builder()

--- Shell profiles ---
-- Set default shell
config.default_prog = { "nu" }
config.launch_menu = {
  {
    label = "Nushell",
    args = { "nu" },
    cwd = "D:/Codespace",
  },
  {
    label = "Powershell7",
    args = { "pwsh.exe" },
    cwd = "D:/Codespace",
  },
  {
    label = "GitBash",
    args = { "C:/Program Files/Git/bin/bash.exe -i -l" },
    cwd = "D:/Codespace",
  },
  {
    label = "CMD",
    args = {"cmd"},
    cwd = "D:/Codespace",
  },
}

--- Appearance ---
config.font_size = 13.0
config.font = wezterm.font ("Hack Nerd Font")
config.color_scheme = "Firewatch"

--- Tabs bar & Window ---
config.window_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "TITLE | RESIZE"
config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }

return config
