return {
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      toggler = {
        line = '<Backspace>',
      },
       opleader = {
        line = '<Backspace>',
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
}
