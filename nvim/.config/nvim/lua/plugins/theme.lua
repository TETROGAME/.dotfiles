return {
	"jpwol/thorn.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- 1. Сначала загружаем саму тему
		vim.cmd([[colorscheme thorn]])

		vim.api.nvim_set_hl(0, "LineNr", { fg = "#9ec59b" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#9ec59b", bold = true })
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff5555" })
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffb86c" })
	end
}
