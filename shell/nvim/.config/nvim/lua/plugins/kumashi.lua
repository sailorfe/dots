return {
	"sailorfe/kumashi.nvim",
	dependencies = "rktjmp/lush.nvim",
	enabled = false,
--	enabled = true,
  init = function()
    vim.cmd.colorscheme("kumashi")
  end,
}
