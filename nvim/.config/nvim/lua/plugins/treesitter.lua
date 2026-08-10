return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = "nvim-treesitter", -- Говорим Lazy, какой именно модуль запускать
  opts = {
    -- Список языков для установки
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "javascript" },
    
    -- Включаем умную подсветку
    highlight = {
      enable = true,
    },
    
    -- Включаем умное выделение кода
    incremental_selection = {
      enable = true,
    },
  },
}
