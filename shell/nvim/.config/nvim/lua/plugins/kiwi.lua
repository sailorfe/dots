return {
	'serenevoid/kiwi.nvim',
	opts = {
		{ name = "notes", path = "/home/sailorfe/w" },
	},
	keys = {
		{ "<leader>ww", ":lua require(\"kiwi\").open_wiki_index(\"notes\")<cr>", desc = "Open tasks" }
	},
	lazy = true
}
