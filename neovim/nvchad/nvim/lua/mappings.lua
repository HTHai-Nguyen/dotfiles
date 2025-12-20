require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

local fzf = require("fzf-lua")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Keymap for fzf
map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "fzf Find files" })
map("n", "<leader>fa", "<cmd>FzfLua files resume=true<cr>", { desc = "fzf Find all files" })
map("n", "<leader>fw", "<cmd>FzfLua live_grep<cr>", { desc = "fzf Live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "fzf Find buffers" })
map("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "fzf Help page" })
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<cr>", { desc = "fzf Find recent files" })
map("n", "<leader>fz", "<cmd>FzfLua current_buffer_fuzzy_find<cr>", { desc = "fzf Find in current buffer" })
map("n", "<leader>cm", "<cmd>FzfLua git_commits<cr>", { desc = "Git commits" })
map("n", "<leader>gt", "<cmd>FzfLua git_status<cr>", { desc = "Git status" })
map("n", "<leader>ma", "<cmd>FzfLua marks<cr>", { desc = "Find marks" })
