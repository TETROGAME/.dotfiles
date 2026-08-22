require("config.lazy")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"

-- =========================================
-- Glass / transparency look
-- =========================================
-- Consistent rounded border on every floating window that doesn't
-- hardcode its own border (LSP hover, signature help, :h, diagnostics
-- float, etc). Lazy/Mason/Telescope/which-key/cmp set their own border
-- option in their respective plugin files, so this covers everything else.
vim.o.winborder = "rounded"

-- Slight blend instead of pure bg=none, so floats read as "frosted
-- glass" over the Ghostty transparency rather than punching a hard
-- hole through it.
vim.o.pumblend = 12 -- completion menu
vim.o.winblend = 10 -- other floats

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
	float = {
		border = "rounded",
	},
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- =========================================
-- Горячие клавиши для работы с кодом (LSP)
-- =========================================
-- 1. Вызвать меню быстрых исправлений (Code Actions)
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "Показать варианты исправления ошибки" })
vim.keymap.set({ 'n', 'v' }, '<leader>ce', function()
	vim.diagnostic.open_float({ border = 'rounded', max_width = 80 })
end, { desc = 'Show full diagnostic float' })

-- 2. Явно отформатировать файл (если не хочешь жать :w)
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
