require("config.lazy")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"


-- Fast comment hotkeys
vim.keymap.set('n', '<C-_>', 'gcc', { remap = true, desc = 'Toggle comment' })
vim.keymap.set('v', '<C-_>', 'gc', { remap = true, desc = 'Toggle comment' })

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "**/ghostty/config",
	callback = function()
		-- Wait until the event loop is clear and Lazy is done
		vim.schedule(function()
			pcall(vim.cmd, "ColorizerAttachToBuffer")
		end)
	end,
})

vim.diagnostic.config({
	virtual_text = {
		prefix = '●',
		spacing = 4,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- =========================================
-- Горячие клавиши для работы с кодом (LSP)
-- =========================================

-- 1. Вызвать меню быстрых исправлений (Code Actions)
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "Показать варианты исправления ошибки" })

-- 2. Явно отформатировать файл (если не хочешь жать :w)

vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
