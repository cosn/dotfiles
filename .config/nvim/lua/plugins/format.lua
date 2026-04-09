return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = function()
      local utils = require("utils")

      local function get_js_formatters()
        if utils.has_file(utils.oxlint_configs) then
          return { "oxfmt" }
        elseif utils.has_file(utils.prettier_configs) then
          return { "prettierd", "prettier", stop_after_first = true }
        else
          return { "oxfmt" }
        end
      end

      return {
        notify_on_error = false,
        format_on_save = function(bufnr)
          -- Disable "format_on_save lsp_fallback" for languages that don't
          -- have a well standardized coding style. You can add additional
          -- languages here or re-enable it for the disabled ones.
          local disable_filetypes = { c = true, cpp = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          else
            return {
              timeout_ms = 1000,
              lsp_format = "fallback",
            }
          end
        end,
        formatters_by_ft = {
          css = { "prettierd", "prettier", stop_after_first = true },
          go = { "goimports", "gofmt" },
          graphql = { "prettierd", "prettier", stop_after_first = true },
          html = { "prettierd", "prettier", stop_after_first = true },
          javascript = get_js_formatters,
          typescript = get_js_formatters,
          javascriptreact = get_js_formatters,
          typescriptreact = get_js_formatters,
          json = { "jq", "prettierd", "prettier", stop_after_first = true },
          lua = { "stylua" },
          markdown = { "prettierd", "prettier", stop_after_first = true },
          md = { "prettierd", "prettier", stop_after_first = true },
          scss = { "prettierd", "prettier", stop_after_first = true },
          txt = { "prettierd", "prettier", stop_after_first = true },
          xml = { "xmllint" },
          yaml = { "prettierd", "prettier", stop_after_first = true },
          ["*"] = { "trim_whitespace" },
        },
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        java = false,
      },
    },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "NMAC427/guess-indent.nvim",
    event = "VeryLazy",
  },
}
