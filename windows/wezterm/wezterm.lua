local wezterm = require 'wezterm'
local mappings = require 'mappings'
local config = wezterm.config_builder()
local act = wezterm.action

--- Keymap ---
config.leader = mappings.leader
config.keys = mappings.keys
config.key_tables = mappings.key_tables

config.max_fps = 120

--- Shell profiles ---
-- Set default shell
config.default_prog = { "nu" }
config.default_cwd = "D:/Codespace"
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

--- Status bar ---
-- config.use_fancy_tab_bar = true
-- config.status_update_interval = 1000

wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

--- Resurection
config.unix_domains = {
  {
    name = 'unix',
  },
}
config.default_gui_startup_args = { 'connect', 'unix' }

-- config.keys = {
--   {
--     key = 'r', mods = 'CTRL|ALT',
--     action = act.ActivateKeyTable {
--       name = 'resize_pane',
--       one_slotl= false,
--     },
--   },
-- }
--
-- config.key_tables = {
--   resize_pane = {
--     { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
--     { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
--     { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
--     { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },
--     -- Press Enter / Escape to exit resize mode
--     { key = 'Escape', action = 'PopKeyTable' },
--   },
-- }

return config
