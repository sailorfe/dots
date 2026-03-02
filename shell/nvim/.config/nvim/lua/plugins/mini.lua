return {
	"echasnovski/mini.nvim",
	lazy = false,
	priority = 1000,
	version = "*",
	config = function()
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
	end,
	keys = {
		{ "<A-f>", "<cmd>:lua MiniFiles.open()<cr>" },
	},
}
