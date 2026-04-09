return {
  "nvim-mini/mini.nvim",
  event = "VeryLazy",
  init = function()
    -- starter must run before VeryLazy to show the start screen
    if vim.fn.argc() == 0 then
      require("mini.starter").setup()
    end
  end,
  config = function()
    require("mini.ai").setup({ n_lines = 500 })
    require("mini.basics").setup()
    require("mini.bracketed").setup()
    require("mini.bufremove").setup()
    require("mini.fuzzy").setup()
    require("mini.jump").setup()
    require("mini.icons").setup({
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    })
    require("mini.move").setup()
    -- only setup starter in config if it wasn't already set up in init
    if vim.fn.argc() > 0 then
      require("mini.starter").setup()
    end
  end,
}
