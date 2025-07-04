local opt = vim.o

opt.breakindent = true
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.hidden = true
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = "split"
opt.incsearch = true
opt.jumpoptions = "stack"
opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.mouse = "a"
opt.relativenumber = true
opt.scrolloff = 10
opt.shiftwidth = 2
opt.showmode = false
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 200
opt.undofile = true
opt.updatetime = 50

vim.filetype.add({
  extension = {
    mdx = "markdown",
  },
})
