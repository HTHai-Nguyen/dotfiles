--- Basic settings ---
vim.opt.hlsearch	= true
vim.opt.number		= true
vim.opt.relativenumber	= true
vim.opt.mouse		= "a"
vim.opt.mouse		= "v"
vim.opt.showmode	= false
vim.opt.clipboard:append({"unnamed", "unnamedplus"})

vim.api.nvim_create_autocmd({"InsertEnter"}, {
	pattern = "*",
	callback = function()
		vim.opt.relativenumber = false
        vim.opt.cursorline = false
	end,
})

vim.api.nvim_create_autocmd({"InsertLeave"}, {
	pattern = "*",
	callback = function()
		vim.opt.relativenumber = true
        vim.opt.cursorline = true
	end,
})

--- Leader ---
vim.g.mapleader 	= ","

--- nvim-tree ---
vim.g.loaded_netrw	= 1
vim.g.loaded_netrwPlugin = 1

--- Display settings ---
vim.opt.termguicolors	= true
vim.o.background	= "dark"

--- Scrollin and UI settings ---
vim.opt.cursorline	= true
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2e2e2e", underline = false})
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE", underline = false, fg = "#FFD700"})
vim.opt.cursorcolumn	= false
vim.opt.signcolumn	= 'no'
vim.opt.wrap		= true
vim.opt.sidescrolloff	= 8
vim.opt.scrolloff	= 8

--- Tab stuff ---
vim.opt.tabstop		= 4
vim.opt.shiftwidth	= 4
vim.opt.expandtab	= true
vim.opt.autoindent	= true

--- Search config ---
vim.opt.ignorecase  = true
vim.opt.smartcase   = true
vim.opt.gdefault    = true
