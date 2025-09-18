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

      -- Configure Treesitter with error handling
      local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        ts_configs.setup(opts)
      else
        vim.notify("Failed to load nvim-treesitter.configs", vim.log.levels.ERROR)
      end

      -- Setup treesitter-context
      local context_ok, ts_context = pcall(require, "treesitter-context")
      if context_ok then
        ts_context.setup(opts)
      end

      -- Setup autotag
      local autotag_ok, autotag = pcall(require, "nvim-ts-autotag")
      if autotag_ok then
        autotag.setup(opts)
      end

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
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      local ok, ts_tools = pcall(require, "typescript-tools")
      if not ok then
        vim.notify("Failed to load typescript-tools", vim.log.levels.ERROR)
        return
      end

      ts_tools.setup({
        settings = {
          tsserver_plugins = {
            "@styled/typescript-styled-plugin",
          },
        },
      })

      -- Only set keymaps if typescript-tools loaded successfully
      vim.keymap.set("n", "<leader>mi", ":TSToolsAddMissingImport<cr>", { desc = "Typescript Add Missing Imports" })
      vim.keymap.set("n", "<leader>ui", ":TSToolsRemoveUnusedImport<cr>", { desc = "Typescript Remove Unused Imports" })
      vim.keymap.set("n", "<leader>tfa", ":TSToolsFixAll<cr>", { desc = "Typescript Fix All" })
    end,
  },
}
