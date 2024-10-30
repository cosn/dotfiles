return {
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        css = { "prettierd", "prettier" },
        go = { "goimports", "gofmt" },
        graphql = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        javascript = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        lua = { "stylua" },
        markdown = { "prettierd", "prettier" },
        md = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
        txt = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        ["*"] = { "trim_whitespace" },
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("nvim-autopairs").setup({})
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },
}
