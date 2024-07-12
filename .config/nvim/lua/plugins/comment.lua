return {
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
    opts = {},
  },
}
