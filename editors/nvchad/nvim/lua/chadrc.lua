-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

-- Theme
M.base46 = {
	theme = "chadracula",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- Dashboard
M.nvdash = { 
  load_on_startup = true, 
}

M.mappings = {
  -- Bước 1: Vô hiệu hóa mapping mặc định của Telescope trong NvChad
  disabled = {
    n = {
      ["ff"] = "",
      ["fo"] = "",
      ["fw"] = "",
    }
  },

  -- Bước 2: Định nghĩa lại ff cho fzf-lua
  general = {
    n = {
      ["ff"] = { "<cmd>FzfLua files<cr>", "fzf-lua find files" },
      ["fo"] = { "<cmd>FzfLua oldfiles<cr>", "fzf-lua oldfiles" },
      ["fw"] = { "<cmd>FzfLua live_grep<cr>", "fzf-lua live grep" },
    }
  }
}

M.ui = {
  transparency  = "true",
     --  tabufline = {
     --     lazyload = false
     -- }
  nvdash = {
    load_on_startup = true,
    buttons = {
      { name = "  Find File", keys = "ff", action = "FzfLua files" },
      { name = "󰈚  Recent Files", keys = "fo", action = "FzfLua oldfiles" },
      { name = "󰈭  Find Word", keys = "fw", action = "FzfLua live_grep" },    
    },
  },
}

return M
