local host = vim.env.HOSTNAME or vim.fn.expand("$HOSTNAME")

local host_themes = {
	["sunnygo"] = "luna",
	["merrygo"] = "perona",
	["default"] = "moonqueen",
}

local theme = host_themes[host] or "habamax"

vim.api.nvim_command("silent! colorscheme " .. theme)
