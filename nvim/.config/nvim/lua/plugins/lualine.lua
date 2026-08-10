return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- Подтягиваем иконки
	config = function()
		require("lualine").setup({
			options = {
				-- 'auto' заставит Lualine автоматически подхватить цвета твоей темы!
				theme = "auto",
				-- Включаем единую линию статуса для всего редактора
				globalstatus = true,
				-- Делаем разделители блоков более стильными
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
			},
			sections = {
				-- Добавляем отображение venv в секцию X (справа)
				-- Вы можете заменить lualine_x на lualine_y или lualine_z по вкусу
				lualine_x = {
					{
						function()
							local venv = os.getenv("VIRTUAL_ENV") or
							os.getenv("CONDA_PREFIX")
							return venv and (" " .. vim.fn.fnamemodify(venv, ":t")) or ""
						end,
						-- Условие: показывать только в Python-файлах
						cond = function() return vim.bo.filetype == "python" end,
					},
					-- Оставляем дефолтные компоненты секции X, чтобы не стереть их
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		})
	end,
}
