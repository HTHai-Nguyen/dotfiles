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

--- Tabs bar & Window ---
config.window_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.window_decorations = 'RESIZE'
config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }

--- Resurection ---
config.unix_domains = {
  {
    name = 'unix',
  },
}
config.default_gui_startup_args = { 'connect', 'unix' }

--- Appearance ---
config.font_size = 13.0
config.font = wezterm.font ('Hack Nerd Font')
config.color_scheme = 'Tokyo Night Storm'

--- Themes ---
local colors = {
  bg = '#1a1b26',        
  fg = '#c0caf5',     
  bg_dark = '#16161e',
  blue = '#7aa2f7',
  magenta = '#bb9af7',
  cyan = '#7dcfff',
  black = '#414868',
  green = '#9ece6a',
  yellow = '#e0af68',
  red = '#f77f68e',
  gray = '#565f89',
}

--------------------- Status bar -----------------------------

wezterm.on('update-status', function(window, pane)
  local workspace = window:active_workspace()
  local date = wezterm.strftime('%b-%d-%Y')
  local time = wezterm.strftime('%H:%M')
  local hostname = wezterm.hostname()

  window:set_right_status(wezterm.format({
    --- Right status
    -- TIME
    { Foreground = { Color = colors.magenta } },
    { Background = { Color = colors.bg } },
    { Text = '' },
    { Background = { Color = colors.magenta } },
    { Foreground = { Color = colors.bg_dark } },
    { Text = '  ' .. time .. ' ' },

    -- DATE
    { Foreground = { Color = colors.gray } },
    { Background = { Color = colors.magenta } },
    { Text = '' },
    { Background = { Color = colors.gray } },
    { Foreground = { Color = colors.bg_dark } },
    { Text = ' 󰃭 ' .. date .. " " },

    -- WORKSPACE
    { Foreground = { Color = colors.blue } },
    { Background = { Color = colors.gray } },
    { Text = '' },
    { Background = { Color = colors.blue } },
    { Foreground = { Color = colors.bg_dark } },
    { Text = ' 󱂬 ' .. workspace .. " " },
  }))

  --- Left status
  window:set_left_status(wezterm.format({
    { Background = { Color = colors.green } },
    { Foreground = { Color = colors.bg_dark } },
    { Text = ' 󰆍 '},
    { Text = hostname ..' ' },

    { Background = { Color = colors.bg } },
    { Foreground = { Color = colors.green } },
    { Text = '' },
  }))

end)

--- 🎯 TAB BAR ---

local function truncate_title(title, max_leng)
  if #title > max_leng then
    return string.sub(title, 1, max_leng - 2) .. '..'
  end 
  return title
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local is_active = tab.is_active
  local index = tab.tab_index 
  local bg = is_active and colors.blue or colors.bg_dark
  local fg = is_active and colors.bg_dark or colors.gray

  -- Tab width limit
  local title_width = 9

  -- Limit to displaying 5 tabs
  local max_tabs = 5 
  local active_idx = 0
  for _, t in ipairs(tabs) do 
    if t.is_active then 
      active_idx = t.tab_index
      break
    end
  end

  local start_idx = math.max(0, active_idx - math.floor(max_tabs /2 ))
  local end_idx = start_idx + max_tabs - 1

  if end_idx >= #tabs then 
    end_idx = #tabs - 1 
    start_idx = math.max(0, end_idx - max_tabs + 1)
  end

  if index >= start_idx and index <= end_idx then
    local text = tab.active_pane.title
    if tab.tab_title ~= '' then
      text = tab.tab_title
    else 
      text = wezterm.truncate_right(tab.active_pane.title:match("[^/]+$"), title_width )
    end
    local title = string.format(' %d:%s ', index + 1, text)

   if is_active then
    return {
      { Background = { Color = colors.bg } },
      { Foreground = { Color = bg } },
      { Text = '' },
      
      { Background = { Color = bg } },
      { Foreground = { Color = fg } },
      { Text = title },

      { Background = { Color = colors.bg } },
      { Foreground = { Color = bg } },
      { Text = '' },
    }
    end
    return { { Text = title } } 
  end

  if index == start_idx - 1 then
    return { { Text = '..' } }
  elseif index == end_idx + 1 then
    return { { Text = '..' } }
  end

  return ""    
end)


--------------------------------------------------------------------------------------

return config
