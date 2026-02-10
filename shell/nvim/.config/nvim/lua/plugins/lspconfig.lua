local vim = vim

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
	vim.lsp.enable('ruff'),

	-- keymaps
	vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(event)
			local opts = { buffer = event.buf }

			-- navigation
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts, { desc = "Go to definition" })
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts, { desc = "Find references" })
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts, { desc = "Go to implementation" })
			vim.keymap.set('n', 'ds', vim.lsp.buf.document_symbol, opts, { desc = "Document symbols" })

			-- docs
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts, { desc = "Hover" })
			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts, { desc = "Signature help" })

			-- refactoring
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts, { desc = "Rename" })
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts, { desc = "Code action" })
		end,
	})
}
