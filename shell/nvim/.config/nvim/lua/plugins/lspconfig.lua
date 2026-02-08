return {
	"neovim/nvim-lspconfig",
	event = {
		"BufReadPre",
		"BufNewFile"
	},
	-- mason
	vim.lsp.enable('bashls'),
	vim.lsp.enable('lua_ls'),
	vim.lsp.enable('marksman'),
	vim.lsp.enable('html'),
	vim.lsp.enable('gopls'),
	vim.lsp.enable('clangd'),
	vim.lsp.enable('somesass_ls'),
	-- uv tool
	vim.lsp.enable('ty'),
	vim.lsp.enable('ruff')
}
