return {
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    keys = {
      { "<leader>h", group = "Git [H]unk" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>h", desc = "Git [H]unk", mode = "v" },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {},
  },
  {
    "m4xshen/hardtime.nvim",
    enabled = false,
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      restriction_mode = "hint",
    },
  },
}
