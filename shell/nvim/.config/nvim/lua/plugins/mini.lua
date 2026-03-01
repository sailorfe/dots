return {
	"echasnovski/mini.nvim",
	verson = "*",
	config = function()
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
		require("mini.starter").setup({})
		require("mini.statusline").setup({})
	end,
	keys = {
		{ "<A-f>", "<cmd>:lua MiniFiles.open()<cr>" },
	},
}
