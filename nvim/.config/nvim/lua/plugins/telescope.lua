return {
	'nvim-telescope/telescope.nvim',
	version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live Grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Help Tags" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Recent Files" },

		{ "<leader>fs", "<cmd>Telescope grep_string<cr>", mode = "n",           desc = "Grep Word Under Cursor" },
		{ "<leader>fs", "<cmd>Telescope grep_string<cr>", mode = "v",           desc = "Grep Selection" },
	},
	opts = {
		defaults = {
			-- Rounded border to match the rest of the glass look
			-- (Telescope builds its floats itself, so it doesn't
			-- inherit vim.o.winborder).
			border = true,
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

			file_ignore_patterns = {
				"%.git/.*", -- Игнорируем внутренности git
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
			live_grep = {
				hidden = true,
			},
		},
	}
}
