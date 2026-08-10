return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python", -- Специальный плагин для интеграции с Python
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Настраиваем красивый интерфейс (оставляем настройки по умолчанию)
    dapui.setup()

    -- Магия: автоматически открывать окна дебаггера при запуске и закрывать при остановке
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

    -- Указываем путь до отладчика debugpy, который скачал Mason
    local path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(path)

    -- Назначаем горячие клавиши
    vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end, { desc = "Поставить/Убрать точку останова" })
    vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "Запуск / Продолжить" })
    vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "Шаг без захода в функцию" })
    vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "Шаг внутрь функции" })
  end
}
