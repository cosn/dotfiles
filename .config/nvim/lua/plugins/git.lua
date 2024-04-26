return {
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
  {
    'lewis6991/gitsigns.nvim',
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    config = function(_, opts)
      local gitsigns = require('gitsigns')
      gitsigns.setup(opts)

      vim.keymap.set('v', '<leader>ghs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[g]it [h]unk [s]tage' })
      vim.keymap.set('v', '<leader>ghr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[g]it [h]unk [r]eset' })

      vim.keymap.set('n', '<leader>ghs', gitsigns.stage_hunk, { desc = '[g]it [s]tage hunk' })
      vim.keymap.set('n', '<leader>ghr', gitsigns.reset_hunk, { desc = '[g]it [r]eset hunk' })
      vim.keymap.set('n', '<leader>ghS', gitsigns.stage_buffer, { desc = '[g]it [S]tage buffer' })
      vim.keymap.set('n', '<leader>ghu', gitsigns.undo_stage_hunk, { desc = '[g]it [u]ndo stage hunk' })
      vim.keymap.set('n', '<leader>ghR', gitsigns.reset_buffer, { desc = '[g]it [R]eset buffer' })
      vim.keymap.set('n', '<leader>ghp', gitsigns.preview_hunk, { desc = '[g]it [p]review hunk' })
      vim.keymap.set('n', '<leader>ghb', gitsigns.blame_line, { desc = '[g]it [b]lame line' })
      vim.keymap.set('n', '<leader>ghd', gitsigns.diffthis, { desc = '[g]it [d]iff against index' })
      vim.keymap.set('n', '<leader>ghD', function()
        gitsigns.diffthis '@'
      end, { desc = '[g]it [D]iff against last commit' })

      vim.keymap.set('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = '[git] [t]oggle git show [b]lame line' })
      vim.keymap.set('n', '<leader>gtD', gitsigns.toggle_deleted, { desc = '[g]it [t]oggle git show [d]eleted' })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
}
