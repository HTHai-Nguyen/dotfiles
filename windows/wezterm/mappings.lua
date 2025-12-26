local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

--- Leader key: CTRL+a 
M.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

M.keys = {
  -- Navigations (vim-like)
  { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection('Left') },
  { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection('Down') },
  { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection('Up') },
  { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection('Right') },

  --- Workspaces / Sessions
  { key = 's', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'WORKSPACES' }, },

  -- Create new Workspace
  { key = 'N', mods = 'LEADER|SHIFT', action = act.SwitchToWorkspace },

  -- Close Workspace
  {
    key = 'X', mods = 'LEADER|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      local workspace = window:active_workspace()
      window:perform_action(act.InputSelector {
        title = "Do you want to Kill Workspace: " .. workspace .. "?",
        choices = {
          { label = "Yes", id = "yes" },
          { label = "No", id = "no" },
        },
        action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
          if id == "yes" then
            for _, win in ipairs(wezterm.mux.all_windows()) do
              if win:get_workspace() == workspace then
                win:gui_window():perform_action(act.CloseCurrentTab{ confirm = false }, inner_pane)
              end
            end
          end
        end),
      }, pane)
    end),
  },

  -- Move in Workspace
  { key = '(', mods = 'LEADER|SHIFT', action = act.SwitchWorkspaceRelative(1), },
  { key = ')', mods = 'LEADER|SHIFT', action = act.SwitchWorkspaceRelative(-1), },

  -- Rename Workspace
  {
    key = '$', mods = 'LEADER|SHIFT', 
    action = act.PromptInputLine { 
      description = "Rename Workspace:",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
          end
        end),
    },
  },

  --- Tabs / Windows ---
  -- Create new tab
  { key = 'c', mods = 'LEADER', action = act.SpawnTab('CurrentPaneDomain'), },
  { key = 't', mods = 'CTRL', action = act.ShowLauncher, },

  -- Switch tabs
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  
  -- Rename tab
  {
      key = ',', mods = 'LEADER',
      action = act.PromptInputLine {
        description = 'Rename current Tab:',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
  },

  -- List tabs
  { key = 'w', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'TABS' }, },

  -- Close tab
  { key = '&', mods = 'LEADER|SHIFT', action = act.CloseCurrentTab { confirm = false }, },


  --- Panes ---
  -- Split pane: '%' for Vertical and '"' for Horizontal
  { key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  { key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },

  -- Convert pane into a tab
  { 
    key = '!', mods = 'LEADER|SHIFT',
    action = wezterm.action_callback(function(win, pane)
      local tab, window = pane:move_to_new_tab()
    end),
  },

  -- Close pane
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true }, },
  
  -- Zoom pane
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState, },

  -- Resize
  {
    key = 'r', mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },

  -- Reload config
  {
    key = 'R', mods = 'LEADER|SHIFT', action = act.ReloadConfiguration,
  },

  --- Resurrection ---
  -- Save resurrect
  {
    key = 's', mods = 'LEADER|CTRL',
    action = wezterm.action_callback(function(win, pane)
      resurrect.save_state(resurrect.workspace_state.get_workspace_state())
    end),
  },
  -- Reload resurrect
  {
    key = 'r', mods = 'LEADER|CTRL',
    action = wezterm.action_callback(function(win, pane)
      resurrect.fuzzy_load(win, pane, function(id, lable)
        id = string.match(id, "([^/]+)$")
        resurrect.workspace_state.restore_workspace_state(resurrect.load_state(id, "workspace"))
      end)
    end),
  },

}

-- Key tables for resize
M.key_tables = {
  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },
    -- Press Enter / Escape to exit resize mode
    { key = 'Escape', action = 'PopKeyTable' },
  },
}

return M
