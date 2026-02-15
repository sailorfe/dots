return {
	"https://codeberg.org/sailorfe/perona.nvim",
	dependencies = "rktjmp/lush.nvim",
	enabled = false,
--	enabled = true,
  init = function()
    vim.cmd.colorscheme("perona")
  end,
}
