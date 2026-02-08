return {
	"neovim/nvim-lspconfig",
	event = {
		"BufReadPre",
		"BufNewFile"
	},
	vim.lsp.enable('bashls'),
	vim.lsp.enable('html'),
	vim.lsp.enable('lua_ls'),
	vim.lsp.enable('marksman'),
	vim.lsp.enable('ty'),
	vim.lsp.enable('somesass_ls'),
	vim.lsp.enable('gopls'),
	vim.lsp.enable('clangd')
}
