return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile', 'InsertLeave' },
  config = function()
    local lint = require 'lint'

    -- Helper to check if file exists in project root
    local function has_file(patterns)
      local root = vim.fn.getcwd()
      for _, pattern in ipairs(patterns) do
        if vim.fn.glob(root .. '/' .. pattern) ~= '' then
          return true
        end
      end
      return false
    end

    -- Detect which JS linter to use based on project config
    local function get_js_linters()
      local eslint_configs = {
        '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json',
        '.eslintrc.yml', '.eslintrc.yaml', 'eslint.config.js', 'eslint.config.mjs'
      }
      local oxlint_configs = { 'oxlint.json', 'oxlintrc.json', '.oxlintrc.json' }

      if has_file(oxlint_configs) then
        return { 'oxlint' }
      elseif has_file(eslint_configs) then
        return { 'eslint' }
      else
        return { 'oxlint' }  -- Default to faster option
      end
    end

    lint.linters_by_ft = {
      markdown = { 'markdownlint' },
    }

    -- JS/TS filetypes that need dynamic linter selection
    local js_filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        local ft = vim.bo.filetype
        -- Dynamically set JS linters before linting
        if vim.tbl_contains(js_filetypes, ft) then
          lint.linters_by_ft[ft] = get_js_linters()
        end
        lint.try_lint()
      end,
    })
  end,
}
