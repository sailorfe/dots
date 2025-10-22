return {
	"sailorfe/moonqueen.nvim",
	dependencies = "rktjmp/lush.nvim",
	enabled = false,
--	enabled = true,
  init = function()
    vim.cmd.colorscheme("moonqueen")
  end,
}
