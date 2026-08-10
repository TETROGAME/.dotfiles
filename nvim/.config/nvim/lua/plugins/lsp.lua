return {
	-- 1. Установщик Mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},

	-- 2. Мост для автоустановки серверов (LSP)
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "marksman", "clangd", "sqlls" }
			})
		end
	},

	-- 3. НОВЫЙ БЛОК: Автоустановка форматтеров и линтеров
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black", -- Форматтер Python
					"isort", -- Сортировка импортов Python
					"ruff", -- Линтер Python
					"prettier", -- Форматтер Markdown
					"markdownlint", -- Линтер Markdown
					"clang-format", -- Форматтер C/C++
					"sqlfluff", -- Форматтер SQL
					"debugpy"
				},
				-- Автоматически запускать установку недостающих инструментов при старте
				run_on_start = true,
			})
		end
	},

	-- 4. Активация серверов
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config.lua_ls = {
				settings = { Lua = { diagnostics = { globals = { "vim" } } } }
			}

			vim.lsp.enable("lua_ls")
			vim.lsp.enable("pyright")
			vim.lsp.enable("marksman")
			vim.lsp.enable("clangd")
			vim.lsp.enable("sqlls")
		end
	}
}
