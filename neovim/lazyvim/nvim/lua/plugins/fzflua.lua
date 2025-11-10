return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        "max-perf", -- preset tối ưu hiệu năng
        winopts = {
          height = 0.90,
          width = 0.90,
          preview = { layout = "vertical", scrollbar = "float" },
        },
      })
      -- Keymap
      vim.keymap.set("n", "<leader>ff", require("fzf-lua").files, { desc = "Find Files (fzf-lua)" })
      vim.keymap.set("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "Grep (fzf-lua)" })
      vim.keymap.set("n", "<leader>fb", require("fzf-lua").buffers, { desc = "Find Buffers (fzf-lua)" })
      vim.keymap.set("n", "<leader>fh", require("fzf-lua").help_tags, { desc = "Help Tags (fzf-lua)" })
    end,
  },
}
