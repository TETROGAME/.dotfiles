return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "isort", "black" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      markdown = { "prettier" },
      sql = { "sqlfluff" },
    },
    -- Включаем магию: форматирование при каждом сохранении файла
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
