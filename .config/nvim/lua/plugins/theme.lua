return {
  {
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "catppuccin/nvim",
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin-frappe'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'folke/tokyonight.nvim',
    enabled = false,
    init = function()
      vim.cmd.colorscheme 'catppuccin-frappe'
      vim.cmd.hi 'Comment gui=none'
    end,
  }
}

