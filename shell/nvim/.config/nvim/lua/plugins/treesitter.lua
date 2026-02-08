return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"python",
			"lua",
			"vim",
			"bash",
			"sass",
			"scss",
			"css",
			"html",
			"json",
			"javascript",
			"yaml",
			"markdown",
			"markdown_inline",
			"c"
		}
	}
}
