return {
	"norcalli/nvim-colorizer.lua",
	event = "BufReadPost",
	config = function()
		require("colorizer").setup({
			"*",
			markdown = { names = false },
			html = { names = false },
		})
	end,
}
