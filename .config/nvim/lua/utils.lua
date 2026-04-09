local M = {}

function M.has_file(patterns)
  local root = vim.fn.getcwd()
  for _, pattern in ipairs(patterns) do
    if vim.fn.glob(root .. "/" .. pattern) ~= "" then
      return true
    end
  end
  return false
end

M.prettier_configs = {
  ".prettierrc", ".prettierrc.js", ".prettierrc.json", ".prettierrc.yml",
  ".prettierrc.yaml", "prettier.config.js", "prettier.config.mjs",
}

M.oxlint_configs = { "oxlint.json", "oxlintrc.json", ".oxlintrc.json" }

M.eslint_configs = {
  ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json",
  ".eslintrc.yml", ".eslintrc.yaml", "eslint.config.js", "eslint.config.mjs",
}

return M
