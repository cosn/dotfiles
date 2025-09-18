return {
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    opts = {
      enable_tailwind = true,
    }
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    opts = {},
  },
  {
    "prisma/vim-prisma",
    ft = "prisma",
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
