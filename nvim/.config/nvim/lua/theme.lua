if vim.env.NVIM_DEV then
  vim.opt.runtimepath:prepend(vim.fn.expand("~/p/lua/perona.nvim"))
  vim.opt.runtimepath:prepend(vim.fn.expand("~/p/lua/luna.nvim"))
  vim.opt.runtimepath:prepend(vim.fn.expand("~/p/lua/moonqueen.nvim"))
else
  vim.cmd('packadd perona.nvim')
  vim.cmd('packadd luna.nvim')
  vim.cmd('packadd moonqueen.nvim')
end

local host = vim.fn.expand("$HOST")

local host_themes = {
  ["thousandsunny"] = "luna",
  ["goingmerry"] = "perona",
  ["minimerry"] = "moonqueen",
  ["localhost"] = "rose-pine",
}

local theme = host_themes[host] or "habamax"

vim.api.nvim_command("silent! colorscheme " .. theme)
