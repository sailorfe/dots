return {
  'stevearc/conform.nvim',
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      css = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      htmldjango = { "prettierd", "prettier", stop_after_first = true },
      python = { "ruff" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
