return {
  {
    "numToStr/Comment.nvim",
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
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
}
