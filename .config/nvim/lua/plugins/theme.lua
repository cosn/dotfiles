return {
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  -- 'folke/tokyonight.nvim',
  "catppuccin/nvim",
  priority = 1000,
  init = function()
    -- vim.cmd.colorscheme 'tokyonight-storm'
    vim.cmd.colorscheme 'catppuccin-frappe'
    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}

