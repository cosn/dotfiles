return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  config = function()
    local lint = require 'lint'
    local utils = require('utils')

    local function get_js_linters()
      if utils.has_file(utils.oxlint_configs) then
        return { 'oxlint' }
      elseif utils.has_file(utils.eslint_configs) then
        return { 'eslint' }
      else
        return { 'oxlint' }
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
