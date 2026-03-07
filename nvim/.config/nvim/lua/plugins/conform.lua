return {
	"stevearc/conform.nvim",
	event = { "BufReadPre" },
	opts = {
		formatters_by_ft = {
			css = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "markdown-toc" },
			html = { "prettierd", "prettier", stop_after_first = true },
			htmldjango = { "prettierd", "prettier", stop_after_first = true },
			python = { "ruff" },
			bash = { "shfmt" },
			lua = { "stylua" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
