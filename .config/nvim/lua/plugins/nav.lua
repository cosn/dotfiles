return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "\\", ":Neotree reveal<cr>", { desc = "NeoTree reveal" } },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ["\\"] = "close_window",
          },
        },
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", mode = "n", "<cmd>Oil<cr>", desc = "Open parent directory (oil)" },
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<cr>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<cr>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  { "mg979/vim-visual-multi" },
  {
    "hedyhli/outline.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>ou", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

      require("outline").setup({})
    end,
  },
}
