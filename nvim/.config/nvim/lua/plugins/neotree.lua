return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- Красивые иконки для файлов
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	opts = {
		-- rounded border on rename/filter/etc popups (doesn't inherit
		-- vim.o.winborder since neo-tree builds these via nui.nvim)
		popup_border_style = "rounded",
		window = {
			position = "left",
			width = 25,
		},
		filesystem = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = true,
			},
			hijack_netrw_behavior = "open_current",
		},
	},
	keys = {
		{ "<leader>e", ":Neotree toggle<CR>", desc = "Toggle File Explorer" }
	},
}
