return {
  { "brenoprata10/nvim-highlight-colors", event = "VeryLazy", opts = {
    enable_tailwind = true,
  } },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
  },
  {
    "folke/twilight.nvim",
    opts = {},
  },
  {
    "prisma/vim-prisma",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },
}
