return {
	"jpwol/thorn.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- 1. Load the colorscheme
		vim.cmd([[colorscheme thorn]])

		-- 2. Clear background highlights to enable Niri's compositor blur
		local groups = {
			"Normal",
			"NormalNC",
			"NormalFloat",
			"FloatBorder",
			"SignColumn",
			"EndOfBuffer",
			"NeoTreeNormal",
			"NeoTreeNormalNC",
		}

		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
		end

		-- 3. Apply your custom highlights
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#9ec59b" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#9ec59b", bold = true })
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff5555" })
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffb86c" })
	end
}
