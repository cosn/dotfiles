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
      -- Helper to check if file exists in project root
      local function has_file(patterns)
        local root = vim.fn.getcwd()
        for _, pattern in ipairs(patterns) do
          if vim.fn.glob(root .. "/" .. pattern) ~= "" then
            return true
          end
        end
        return false
      end

      -- Detect which JS formatter to use based on project config
      local function get_js_formatters()
        local prettier_configs = {
          ".prettierrc", ".prettierrc.js", ".prettierrc.json", ".prettierrc.yml",
          ".prettierrc.yaml", "prettier.config.js", "prettier.config.mjs"
        }
        local oxlint_configs = { "oxlint.json", "oxlintrc.json", ".oxlintrc.json" }

        if has_file(oxlint_configs) then
          return { "oxfmt" }
        elseif has_file(prettier_configs) then
          return { "prettierd", "prettier", stop_after_first = true }
        else
          return { "oxfmt" }  -- Default to faster option
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
          json = { "prettierd", "prettier", stop_after_first = true },
          lua = { "stylua" },
          markdown = { "prettierd", "prettier", stop_after_first = true },
          md = { "prettierd", "prettier", stop_after_first = true },
          scss = { "prettierd", "prettier", stop_after_first = true },
          txt = { "prettierd", "prettier", stop_after_first = true },
          yaml = { "prettierd", "prettier", stop_after_first = true },
          ["*"] = { "trim_whitespace" },
        },
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
        -- javascript = { "string", "template_string" },
        java = false, -- don't check treesitter on java
      },
    },
    setup = function()
      local autopairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      autopairs.add_rules({
        Rule("`", "'", "tex"),
        Rule("$", "$", "tex"),
        Rule(" ", " ")
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col, opts.col + 1)
            return vim.tbl_contains({ "$$", "()", "{}", "[]", "<>" }, pair)
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({ "$  $", "(  )", "{  }", "[  ]", "<  >" }, context)
          end),
        Rule("$ ", " ", "tex"):with_pair(cond.not_after_regex(" ")):with_del(cond.none()),
        Rule("[ ", " ", "tex"):with_pair(cond.not_after_regex(" ")):with_del(cond.none()),
        Rule("{ ", " ", "tex"):with_pair(cond.not_after_regex(" ")):with_del(cond.none()),
        Rule("( ", " ", "tex"):with_pair(cond.not_after_regex(" ")):with_del(cond.none()),
        Rule("< ", " ", "tex"):with_pair(cond.not_after_regex(" ")):with_del(cond.none()),
      })

      autopairs.get_rule("$"):with_move(function(opts)
        return opts.char == opts.next_char:sub(1, 1)
      end)

      -- import nvim-cmp plugin (completions plugin)
      local cmp = require("cmp")

      -- import nvim-autopairs completion functionality
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      -- make autopairs and completion work together
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({
          filetypes = {
            tex = false, -- Disable for tex
          },
        })
      )
    end,
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
