-- ________   _______   ________  ___      ___ ___  _____ ______
--|\   ___  \|\  ___ \ |\   __  \|\  \    /  /|\  \|\   _ \  _   \
--\ \  \\ \  \ \   __/|\ \  \|\  \ \  \  /  / | \  \ \  \\\__\ \  \
-- \ \  \\ \  \ \  \_|/_\ \  \\\  \ \  \/  / / \ \  \ \  \\|__| \  \
--  \ \  \\ \  \ \  \_|\ \ \  \\\  \ \    / /   \ \  \ \  \    \ \  \
--   \ \__\\ \__\ \_______\ \_______\ \__/ /     \ \__\ \__\    \ \__\
--    \|__| \|__|\|_______|\|_______|\|__|/       \|__|\|__|     \|__|

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
