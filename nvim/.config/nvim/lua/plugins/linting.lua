return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    
    lint.linters_by_ft = {
      python = { "ruff" },
      markdown = { "markdownlint" },
    }

    -- Запускать линтер каждый раз, когда мы сохраняем файл или выходим из режима вставки
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end
}
