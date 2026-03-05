local host = vim.fn.expand("$HOST")

local host_themes = {
  ["thousandsunny"] = "luna",
  ["goingmerry"] = "perona",
  ["minimerry"] = "moonqueen",
  ["localhost"] = "moonqueen",
}

local theme = host_themes[host] or "habamax"

vim.api.nvim_command("silent! colorscheme " .. theme)
