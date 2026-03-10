local spell_dir = vim.fn.stdpath("data") .. "/spell"
if vim.fn.isdirectory(spell_dir) == 0 then
  vim.fn.mkdir(spell_dir, "p")
end
vim.opt_local.colorcolumn = "0"
vim.opt_local.spell = true
vim.opt_local.spelllang = "en"
vim.opt_local.spellcapcheck = ""
vim.opt_local.spellfile = spell_dir .. "/en.utf-8.add"

vim.cmd("packadd bullets.vim")

vim.keymap.set("i", "<CR>", "<Plug>(bullets-newline)", { buffer = true })

vim.cmd("packadd render-markdown.nvim")
if not _G._render_markdown_loaded then
  _G._render_markdown_loaded = true
  require("render-markdown").setup({
    link = {
      enabled = true,
      render_modes = false,
      footnote = { enabled = true, superscript = true, prefix = "", suffix = "" },
      image = "󰥶 ",
      email = "󰀓 ",
      hyperlink = "󰌹 ",
      highlight = "RenderMarkdownLink",
      wiki = {
        icon = "󱗖 ",
        body = function()
          return nil
        end,
        highlight = "RenderMarkdownWikiLink",
      },
      custom = {
        web = { pattern = "http", icon = "󰖟 " },
        codeberg = { pattern = "codeberg.org", icon = " " },
        github = { pattern = "github.com", icon = "󰊤 " },
        gitlab = { pattern = "gitlab.com", icon = "󰮠 " },
        stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
        wikipedia = { pattern = "wikipedia.org", icon = "󰖬 " },
        youtube = { pattern = "youtube.com", icon = "󰗃 " },
        tumblr = { pattern = "tumblr.com", icon = "" },
      },
    },
    heading = {
      width = "full",
      icons = { "☽ ", "☿ ", "♀ ", "♂ ", "♃ ", "♄ " },
      right_pad = 1,
    },
    code = { width = "block" },
    dash = { width = 30, highlight = "Comment" },
    win_options = {
      conceallevel = { rendered = 3 },
    },
  })
end
