return {
  {
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = {
      {
        "l3mon4d3/luasnip",
        version = "2.*",
        build = (function()
          return "make install_jsregexp"
        end)(),
      },
      "folke/lazydev.nvim",
      {
        "supermaven-inc/supermaven-nvim",
        opts = {
          disable_inline_completion = true,
          disable_keymaps = true,
        },
      },
      {
        "huijiro/blink-cmp-supermaven",
      },
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = "default",

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 100 },
      },

      sources = {
        default = { "lsp", "path", "snippets", "lazydev", "supermaven" },
        providers = {
          lazydev = { module = "lazydev.integrations.blink", score_offset = 5 },
          supermaven = { name = "supermaven", module = "blink-cmp-supermaven", async = true },
        },
      },

      snippets = { preset = "luasnip" },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = "lua" },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },
  {
    "github/copilot.vim",
    enabled = false,
    event = "VeryLazy",
  },
  {
    "supermaven-inc/supermaven-nvim",
    event = "VeryLazy",
  },
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    build = "make",
    opts = {
      mappings = {
        submit = {
          insert = "<C-y>",
        },
        diff = {
          ours = "<leader>co",
          theirs = "<leader>ct",
          none = "<leader>c0",
          both = "<leader>cb",
        },
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below is optional, make sure to setup it properly if you have lazy=true
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        keys = {
          { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
        },
      },
    },
  },
  {
    "joshuavial/aider.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      default_bindings = false,
    },
    keys = {
      { "<leader>ai", "<cmd>lua AiderOpen()<cr>", desc = "Aider Open" },
    },
  },
}
