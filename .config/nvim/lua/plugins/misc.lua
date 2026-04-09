return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>h", group = "Git [H]unk" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>h", desc = "Git [H]unk", mode = "v" },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle [Z]en Mode" },
    },
    opts = {},
  },
  {
    "folke/persistence.nvim",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore session" },
      { "<leader>qS", function() require("persistence").select() end, desc = "Select session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Stop persistence" },
    },
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
