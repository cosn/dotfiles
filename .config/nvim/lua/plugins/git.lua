return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gvdiffsplit", "Gread", "Gwrite", "Gdiffsplit", "Ggrep" },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
    config = function(_, opts)
      local gitsigns = require("gitsigns")
      gitsigns.setup(opts)

      vim.keymap.set("v", "<leader>ghs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "[g]it [h]unk [s]tage" })
      vim.keymap.set("v", "<leader>ghr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "[g]it [h]unk [r]eset" })

      vim.keymap.set("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "[g]it [s]tage hunk" })
      vim.keymap.set("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "[g]it [r]eset hunk" })
      vim.keymap.set("n", "<leader>ghS", gitsigns.stage_buffer, { desc = "[g]it [S]tage buffer" })
      vim.keymap.set("n", "<leader>ghR", gitsigns.reset_buffer, { desc = "[g]it [R]eset buffer" })
      vim.keymap.set("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "[g]it [p]review hunk" })
      vim.keymap.set("n", "<leader>ghb", gitsigns.blame_line, { desc = "[g]it [b]lame line" })
      vim.keymap.set("n", "<leader>ghd", gitsigns.diffthis, { desc = "[g]it [d]iff against index" })
      vim.keymap.set("n", "<leader>ghD", function()
        gitsigns.diffthis("@")
      end, { desc = "[g]it [D]iff against last commit" })

      vim.keymap.set(
        "n",
        "<leader>gtb",
        gitsigns.toggle_current_line_blame,
        { desc = "[git] [t]oggle git show [b]lame line" }
      )
      vim.keymap.set("n", "<leader>gtD", gitsigns.preview_hunk_inline, { desc = "[g]it [t]oggle git show [d]eleted" })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lg", ":LazyGit<cr>", desc = "LazyGit" },
    },
    config = function()
      pcall(require("telescope").load_extension, "lazygit")
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
    opts = {},
  },
}
