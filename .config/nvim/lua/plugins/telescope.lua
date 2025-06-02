return {
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
    { "gbprod/yanky.nvim", opts = {
      highlight = { timer = 150 },
    } },
  },
  config = function()
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- See `:help telescope` and `:help telescope.setup()`
    local telescope = require("telescope")
    telescope.setup({
      -- pickers = {}
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
    })

    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "projects")
    pcall(telescope.load_extension, "ui-select")
    pcall(telescope.load_extension, "notify")
    pcall(telescope.load_extension, "noice")
    pcall(telescope.load_extension, "yank_history")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>/.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader>//", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>/c", builtin.commands, { desc = "[S]earch [C]ommands" })
    vim.keymap.set("n", "<leader>/d", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>/f", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>/g", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>/h", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>/k", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>/m", builtin.marks, { desc = "[S]earch [M]arks" })
    vim.keymap.set("n", "<leader>/o", builtin.vim_options, { desc = "[S]earch Vim [O]ptions" })
    vim.keymap.set("n", "<leader>/t", builtin.git_bcommits, { desc = "[S]earch Gi[T] Commits" })
    vim.keymap.set("n", "<leader>/w", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    vim.keymap.set("n", "<leader>/b", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/b] Fuzzily search in current buffer" })

    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set("n", "<leader>/s", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[/] [S]earch in Open Files" })

    vim.keymap.set("n", "<leader>/n", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })

    vim.keymap.set("n", "z=", function()
      builtin.spell_suggest(require("telescope.themes").get_cursor({}))
    end, { desc = "[S]pell current word" })

    vim.keymap.set({ "n", "x" }, "<leader>y", function()
      telescope.extensions.yank_history.yank_history({})
    end, { desc = "Open [Y]ank History" })

    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
    vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
    vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
  end,
}
