return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  config = function()
    require("ibl").setup({
      indent = {
        highlight = { "IblIndent" }
      },
      scope = {
        enabled = true,
        highlight = { "IblScope" }
      },
      whitespace = {
        highlight = { "IblWhitespace" }
      }
    })
  end,
}
