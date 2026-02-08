-- ________   _______   ________  ___      ___ ___  _____ ______
--|\   ___  \|\  ___ \ |\   __  \|\  \    /  /|\  \|\   _ \  _   \
--\ \  \\ \  \ \   __/|\ \  \|\  \ \  \  /  / | \  \ \  \\\__\ \  \
-- \ \  \\ \  \ \  \_|/_\ \  \\\  \ \  \/  / / \ \  \ \  \\|__| \  \
--  \ \  \\ \  \ \  \_|\ \ \  \\\  \ \    / /   \ \  \ \  \    \ \  \
--   \ \__\\ \__\ \_______\ \_______\ \__/ /     \ \__\ \__\    \ \__\
--    \|__| \|__|\|_______|\|_______|\|__|/       \|__|\|__|     \|__|

-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- formatted time inline at cursor
local function insert_date(fmt, use_utc)
  local prefix = use_utc and "!" or ""
  local date_str = vim.fn.strftime(prefix .. fmt)
  vim.api.nvim_feedkeys("i" .. date_str .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

-- ISO date only (YYYY-MM-DD)
vim.keymap.set("n", "<leader>id", function()
  insert_date("%F")
end, { desc = "Insert ISO date (YYYY-MM-DD)" })

-- ISO date + time (YYYY-MM-DD HH:MM)
vim.keymap.set("n", "<leader>dt", function()
  insert_date("%F %R")
end, { desc = "Insert date + time (YYYY-MM-DD HH:mm)" })

-- Full ISO timestamp to minute with offset
vim.keymap.set("n", "<leader>im", function()
  insert_date("%FT%R%z")
end, { desc = "Insert ISO 8601 timestamp (minutes)" })

-- Full ISO timestamp to second with offset
vim.keymap.set("n", "<leader>is", function()
  insert_date("%FT%T%z")
end, { desc = "Insert ISO 8601 timestamp (seconds)" })

-- chil and wee
vim.keymap.set("n", "<leader>td", function()
	insert_date("%m/%d")
end, { desc = "Insert date as MM/DD"})

-- "AP style"
vim.keymap.set("n", "<leader>ap", function()
  insert_date("%A, %B %d at %r")
end, { desc = "Insert long-form date" })

-- indent in visual mode
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")


-- switch windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
-- resize windows
vim.keymap.set("n", "H", "1<C-w>>")
vim.keymap.set("n", "J", "1<C-w>-")
vim.keymap.set("n", "K", "1<C-w>+")
vim.keymap.set("n", "L", "1<C-w><")
-- term windows
vim.keymap.set("n", "st", "<Cmd>split | term<CR>")
vim.keymap.set("n", "vt", "<Cmd>vsplit | term<CR>")


-- buffers
vim.keymap.set("n", "bn", "<Cmd>bnext<CR>")
vim.keymap.set("n", "bp", "<Cmd>bprev<CR>")
vim.keymap.set("n", "bq", "<Cmd>bdelete<CR>")

-- tabs
vim.keymap.set("n", "tn", "<Cmd>tabnext<CR>")
vim.keymap.set("n", "tp", "<Cmd>tabprev<CR>")
vim.keymap.set("n", "tq", "<Cmd>tabclose<CR>")


-- plugins
vim.keymap.set("n", "<leader>nnp", "<Cmd>NoNeckPain<CR>", opts)
vim.keymap.set('n', '<A-f>', '<cmd>:lua MiniFiles.open()<cr>')


-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = { buffer = event.buf }

    -- navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts, { desc = "Go to definition" })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts, { desc = "Find references" })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts, { desc = "Go to implementation" })

    -- docs
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts, { desc = "Hover" })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts, { desc = "Signature help" })

    -- refactoring
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts, { desc = "Rename" })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts, { desc = "Code action" })
  end,
})
