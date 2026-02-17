local vim = vim

-- enable mouse
vim.opt.mouse = "nv"

-- highlights
vim.opt.termguicolors = true
vim.opt.synmaxcol = 512
vim.opt.showmatch = true
vim.opt.listchars = { tab = "  ", trail = "·", extends = "»", precedes = "«", nbsp = "░" }
vim.opt.list = true
vim.opt.conceallevel = 2
 
-- disable startup message
vim.opt.shortmess:append("sI")

-- interface
vim.opt.colorcolumn = "80,120"
vim.opt.cursorline = true
vim.opt.fillchars = { vert = "▒" }
vim.opt.number = true
vim.opt.signcolumn = "auto:2"
vim.opt.splitbelow = true
vim.opt.splitright = true
