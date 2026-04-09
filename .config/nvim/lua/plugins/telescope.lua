return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "ahmedkhalf/project.nvim" },
      { "folke/trouble.nvim" },
      { "folke/noice.nvim" },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>/.", function() require("telescope.builtin").oldfiles() end, desc = "Search Recent Files" },
      { "<leader>//", function() require("telescope.builtin").resume() end, desc = "Search Resume" },
      { "<leader>/c", function() require("telescope.builtin").commands() end, desc = "Search Commands" },
      { "<leader>/d", function() require("telescope.builtin").diagnostics() end, desc = "Search Diagnostics" },
      { "<leader>/f", function() require("telescope.builtin").find_files() end, desc = "Search Files" },
      { "<leader>/g", function() require("telescope.builtin").live_grep() end, desc = "Search by Grep" },
      { "<leader>/h", function() require("telescope.builtin").help_tags() end, desc = "Search Help" },
      { "<leader>/k", function() require("telescope.builtin").keymaps() end, desc = "Search Keymaps" },
      { "<leader>/m", function() require("telescope.builtin").marks() end, desc = "Search Marks" },
      { "<leader>/o", function() require("telescope.builtin").vim_options() end, desc = "Search Vim Options" },
      { "<leader>/t", function() require("telescope.builtin").git_bcommits() end, desc = "Search Git Commits" },
      { "<leader>/w", function() require("telescope.builtin").grep_string() end, desc = "Search current Word" },
      { "<leader><leader>", function() require("telescope.builtin").buffers() end, desc = "Find existing buffers" },
      {
        "<leader>/b",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "Fuzzily search in current buffer",
      },
      {
        "<leader>/s",
        function()
          require("telescope.builtin").live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
        end,
        desc = "Search in Open Files",
      },
      {
        "<leader>/n",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Search Neovim files",
      },
      {
        "z=",
        function()
          require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))
        end,
        desc = "Spell suggest",
      },
      {
        "<leader>y",
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      local extensions = { "fzf", "projects", "ui-select", "notify", "noice", "yank_history" }
      for _, ext in ipairs(extensions) do
        pcall(telescope.load_extension, ext)
      end
    end,
  },
  {
    "gbprod/yanky.nvim",
    opts = { highlight = { timer = 150 } },
    keys = {
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" } },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" } },
    },
  },
}
