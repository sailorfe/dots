local spell_dir = vim.fn.stdpath('share') .. '/spell'

if vim.fn.isdirectory(spell_dir) == 0 then
    vim.fn.mkdir(spell_dir, 'p')
end

vim.opt_local.colorcolumn = "0"
vim.opt_local.spell = true
vim.opt_local.spelllang = "en"
vim.opt_local.spellcapcheck = ""

vim.opt_local.spellfile = spell_dir .. '/en.utf-8.add'
