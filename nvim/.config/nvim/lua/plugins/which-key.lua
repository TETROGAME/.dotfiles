return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		win = {
			border = "rounded", -- which-key builds its own float, doesn't inherit vim.o.winborder
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
