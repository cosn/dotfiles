return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    'bennypowers/nvim-ts-autotag',
    'nvim-treesitter/nvim-treesitter-context',
  },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "css",
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
      "markdown",
      "proto",
      "puppet",
      "python",
      "regex",
      "ruby",
      "rust",
      "scss",
      "sql",
      "tmux",
      "typescript",
      "vim",
      "xml",
      "yaml",
      "yaml",
    },
    auto_install = true,
    autotag = { enable = true },
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require("nvim-treesitter.install").prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup(opts)
    require("treesitter-context").setup()

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}
