-- conform
require("conform").setup({
  formatters_by_ft = {
    css = { "prettierd" },
    html = { "prettierd" },
    htmldjango = { "prettierd" },
    python = { "ruff" },
    bash = { "shfmt" },
    lua = { "stylua" },
  },
  format_after_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

-- colorizer
require("colorizer").setup({
  "*", -- Highlight all files, but customize some others.
  "!markdown",
  css = { rgb_fn = true },
  sass = { rgb_fn = true },
  lua = { hsl_fn = true },
})

-- lsp
vim.lsp.enable("bashls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("html")
vim.lsp.enable("gopls")
vim.lsp.enable("clangd")
vim.lsp.enable("somesass_ls")
vim.lsp.enable("html-lsp")
vim.lsp.enable("ty")
vim.lsp.enable("ruff")
vim.lsp.enable("marksman")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gr", vim.lsp.buf.references, "Find references")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("ds", vim.lsp.buf.document_symbol, "Document symbols")
    map("K", vim.lsp.buf.hover, "Hover")
    map("<C-k>", vim.lsp.buf.signature_help, "Signature help")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
  end,
})

-- indent-blankline
require("ibl").setup({
  indent = { highlight = { "IblIndent" } },
  scope = {
    enabled = true,
    highlight = { "IblScope" },
  },
  whitespace = { highlight = { "IblWhitespace" } },
})

-- mason
require("mason").setup()

-- mini.nvim
require("mini.starter").setup({})
require("mini.statusline").setup({})
require("mini.comment").setup({})
require("mini.completion").setup({})
require("mini.files").setup({})
require("mini.git").setup({})
require("mini.icons").setup({})
require("mini.notify").setup({})
require("mini.pairs").setup({})
require("mini.pick").setup({})
require("mini.snippets").setup({})
require("mini.splitjoin").setup({})
require("mini.surround").setup({})
require("mini.diff").setup({})
vim.keymap.set("n", "<A-f>", "<cmd>lua MiniFiles.open()<cr>")

-- no-neck-pain
require("no-neck-pain").setup({ width = 100 })
vim.keymap.set("n", "<leader>nnp", "<cmd>NoNeckPain<cr>")

-- supermaven
require("supermaven-nvim").setup({
  keymaps = {
    accept_suggestion = "<Tab>",
    clear_suggestion = "<C-]>",
    accept_word = "<C-j>",
  },
  ignore_filetypes = { "markdown", "text", "csv" },
})

-- telescope
require("telescope").setup({})
require("telescope").load_extension("fzf")

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find Word" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffer" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Find Old Files" })
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find Marks" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Find Commands" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Find Registers" })
vim.keymap.set("n", "<leader>ft", "<cmd>Telescope live_grep<cr>", { desc = "Find Text" })

-- treesitter
require("nvim-treesitter").setup({
  parser_install_dir = vim.fn.stdpath("data") .. "/site",
})

-- trouble
require("trouble").setup()

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
  "n",
  "<leader>xX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
  "n",
  "<leader>cl",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "LSP Definitions / references" }
)
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- wordcount (local plugin)
vim.api.nvim_create_user_command("WordCount", function()
  require("wordcount").count()
end, {})
vim.keymap.set("n", "<leader>wc", ":WordCount<CR>", { desc = "Word count" })
