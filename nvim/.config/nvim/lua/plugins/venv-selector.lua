return {
	"linux-cultist/venv-selector.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" }, -- you already have this
	ft = "python",                               -- lazy-load only on python buffers
	keys = {
		{ "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select venv" },
	},
	opts = {
		options = {
			notify_user_on_venv_activation = true, -- gives you a visible confirmation popup on selection
			override_notify = false,
		},
	},
}
