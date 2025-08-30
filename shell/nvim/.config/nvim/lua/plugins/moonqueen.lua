return {
	"sailorfe/moonqueen.nvim",
	branch = main,
	enabled = false,
	lazy = true,
  priority = 1000,
	opts = {
		transparent = false,
	},
  init = function()
    vim.cmd.colorscheme("moonqueen")
  end,
}
