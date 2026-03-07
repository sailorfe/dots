return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },

	config = function()
		-- mason
		vim.lsp.enable("bashls")
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("html")
		vim.lsp.enable("gopls")
		vim.lsp.enable("clangd")
		vim.lsp.enable("somesass_ls")
		vim.lsp.enable("html-lsp")
		-- manually installed
		vim.lsp.enable("ty")
		vim.lsp.enable("ruff")
		vim.lsp.enable("marksman") -- musl version for alpine; mason fine for debian

		-- buffer-local LSP keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local function map(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, {
						buffer = event.buf,
						desc = desc,
					})
				end

				-- navigation
				map("gd", vim.lsp.buf.definition, "Go to definition")
				map("gr", vim.lsp.buf.references, "Find references")
				map("gi", vim.lsp.buf.implementation, "Go to implementation")
				map("ds", vim.lsp.buf.document_symbol, "Document symbols")

				-- docs
				map("K", vim.lsp.buf.hover, "Hover")
				map("<C-k>", vim.lsp.buf.signature_help, "Signature help")

				-- refactoring
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code action")
			end,
		})
	end,
}
