return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = {"VeryLazy", "BufReadPre", "BufNewFile"},
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      local opts = {
        ensure_installed = {
          "bash",
          "comment",
          "css",
          "diff",
          "dockerfile",
          "elixir",
          "git_config",
          "gitcommit",
          "gitignore",
          "go",
          "graphql",
          "html",
          "javascript",
          "json",
          "kotlin",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "proto",
          "puppet",
          "python",
          "regex",
          "ruby",
          "rust",
          "scss",
          "sql",
          "terraform",
          "tmux",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
        },
        auto_install = true,
        highlight = {
          enable = true,
          -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
          --  If you are experiencing weird indenting issues, add the language to
          --  the list of additional_vim_regex_highlighting and disabled languages for indent.
          additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = true, disable = { "ruby" } },
        incremental_selection = { enable = true },
        textobjects = {
          select = {
            enable = true,
          },
          move = {
            enable = true,
          },
        },
      }

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require("nvim-treesitter.install").prefer_git = true
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      require("nvim-treesitter.configs").setup(opts)
      require("treesitter-context").setup(opts)
      require("nvim-ts-autotag").setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<C-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({
        settings = {
          tsserver_plugins = {
            "@styled/typescript-styled-plugin",
          },
        },
      })

      vim.keymap.set("n", "<leader>mi", ":TSToolsAddMissingImport<cr>", { desc = "Typescript Add Missing Imports" })
      vim.keymap.set("n", "<leader>ui", ":TSToolsRemoveUnusedImport<cr>", { desc = "Typescript Remove Unused Imports" })
      vim.keymap.set("n", "<leader>tfa", ":TSToolsFixAl<cr>", { desc = "Typescript Fix All" })
    end,
  },
}
