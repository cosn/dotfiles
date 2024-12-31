local keymap = vim.keymap

keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

keymap.set("n", "<leader>lrt", "<cmd>LspRestart typescript-tools<cr>", { desc = "LSP: Restart" })

keymap.set({ "n", "v" }, "<up>", ":m .-2<cr>==")
keymap.set({ "n", "v" }, "<down>", ":m .+1<cr>==")

keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

keymap.set("n", "<C-n>", "<cmd>enew<cr>", { desc = "New file" })
keymap.set("n", "<C-t>", "<cmd>tabnew<cr>", { desc = "New tab" })

keymap.set("n", "<leader>wr", "<cmd>set linebreak wrap<cr>", { desc = "Toggle [W]rap" })

keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
