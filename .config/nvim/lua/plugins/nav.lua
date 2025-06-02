return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    lazy = false,
    keys = {
      { "\\", ":Neotree reveal<cr>", { desc = "NeoTree reveal" } },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ["\\"] = "close_window",
          },
        },
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", mode = "n", "<cmd>Oil<cr>", desc = "Open parent directory (oil)" },
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<cr>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<cr>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  { "mg979/vim-visual-multi" },
  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup({
        on_attach = function(bufnr)
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Aerial jump backwards" })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Aerial Jump forwards" })
        end,
      })
      vim.keymap.set("n", "<leader>at", "<cmd>AerialToggle!<CR>", { desc = "Toggle [A]erial" })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = { "kevinhwang91/promise-async" },
    keys = function()
      local ufo_keys = {
        { "z?", vim.cmd.UfoInspect, desc = "󱃄 :UfoInspect" },
        {
          "zm",
          function()
            require("ufo").closeAllFolds()
          end,
          desc = "󱃄 Close All Folds",
        },
        {
          "zr",
          function()
            require("ufo").openFoldsExceptKinds({ "comment", "imports" })
          end,
          desc = "󱃄 Open Regular Folds",
        },
      }
      for i = 1, 9 do
        table.insert(ufo_keys, {
          "z" .. i,
          function()
            require("ufo").closeFoldsWith(i)
          end,
          desc = "󱃄 Close L" .. i .. " Folds",
        })
      end

      return ufo_keys
    end,
    init = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
    end,
    opts = {
      close_fold_kinds_for_ft = {
        default = { "comment" },
      },
      provider_selector = function(_, ft, _)
        local lspWithOutFolding = { "css", "html", "git", "json", "log", "markdown", "python", "zsh" }
        if vim.tbl_contains(lspWithOutFolding, ft) then
          return { "treesitter", "indent" }
        end
        return { "lsp", "indent" }
      end,
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local hlgroup = "NonText"
        local icon = ""
        local newVirtText = {}
        local suffix = ("  %s %d"):format(icon, endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, hlgroup })
        return newVirtText
      end,
    },
  },
}
