return {
	"xiyaowong/transparent.nvim",
	lazy = false,
	priority = 1000, -- load before theme.lua so ColorScheme order doesn't matter
	opts = {
		-- Extra groups on top of the plugin's own defaults (which already
		-- cover Normal, NormalNC, StatusLine, LineNr, SignColumn, etc).
		-- These are the float/plugin-specific groups that were left
		-- opaque before.
		extra_groups = {
			"NormalFloat", "FloatBorder", "FloatTitle",
			"WinSeparator", "VertSplit",
			"Pmenu", "PmenuSbar", "PmenuThumb",
			"TabLine", "TabLineFill", "TabLineSel",

			-- Neo-tree
			"NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeEndOfBuffer",

			-- Telescope
			"TelescopeNormal", "TelescopeBorder",
			"TelescopePromptNormal", "TelescopePromptBorder",
			"TelescopeResultsNormal", "TelescopeResultsBorder",
			"TelescopePreviewNormal", "TelescopePreviewBorder",

			-- which-key
			"WhichKeyFloat", "WhichKeyBorder", "WhichKeyNormal",

			-- nvim-cmp
			"CmpNormal", "CmpBorder", "CmpDocNormal", "CmpDocBorder",
		},
	},
}
