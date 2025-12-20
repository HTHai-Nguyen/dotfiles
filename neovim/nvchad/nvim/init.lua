vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- Always use LF for unix/linux
vim.opt.fileformats = "unix,dos"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.o.scrolloff = 999
vim.o.relativenumber = true

-- Load keymap of fzf-lua for Dashboard
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nvdash",
  callback = function()
    local opts = { buffer = true, silent = true }
    vim.keymap.set("n", "ff", "<cmd>FzfLua files<cr>", opts)
    vim.keymap.set("n", "fw", "<cmd>FzfLua live_grep<cr>", opts)
    vim.keymap.set("n", "fo", "<cmd>FzfLua oldfiles<cr>", { buffer = true })
  end,
})
