return {
	"jpwol/thorn.nvim",
	lazy = false,
	priority = 999, -- after transparent.nvim
	config = function()
		-- 1. Load the colorscheme
		vim.cmd([[colorscheme thorn]])

		-- 2. Custom highlights (background clearing is now handled by
		-- transparent.nvim in lua/plugins/transparent.lua)
		local function custom_highlights()
			vim.api.nvim_set_hl(0, "LineNr", { fg = "#9ec59b" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#9ec59b", bold = true })
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff5555" })
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffb86c" })
		end

		custom_highlights()

		-- transparent.nvim fires this User event every time it clears
		-- backgrounds (ColorScheme reload or :TransparentToggle), so
		-- reapply our own highlights right after so they never get
		-- clobbered regardless of plugin load order.
		vim.api.nvim_create_autocmd("User", {
			pattern = "TransparentClear",
			callback = custom_highlights,
		})
	end
}
