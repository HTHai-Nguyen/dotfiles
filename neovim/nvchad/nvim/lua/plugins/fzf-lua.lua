return {
  -- Disable telescope
  { "nvim-telescope/telescope.nvim", enabled = false },
  { "nvim-telescope/telescope-fzf-native.nvim", enabled = false },
  { "nvim-telescope/telescope-ui-select.nvim", enabled = false },

  -- Add fzf-lua
  {
    "ibhagwan/fzf-lua",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        "max-perf", -- preset tối ưu hiệu năng
      })
    end,
  },

}
