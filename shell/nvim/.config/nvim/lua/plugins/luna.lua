return {
	"sailorfe/luna.nvim",
	branch = main,
	enabled = false,
	lazy = true,
  priority = 1000,
	opts = {
		transparent = false,
	},
  init = function()
    vim.cmd.colorscheme("luna")
  end,
}
