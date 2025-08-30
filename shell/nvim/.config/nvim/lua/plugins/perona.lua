return {
	"sailorfe/perona.nvim",
	branch = main,
	enabled = true,
	lazy = true,
  priority = 1000,
	opts = {
		transparent = false,
	},
  init = function()
    vim.cmd.colorscheme("perona")
  end,
}
