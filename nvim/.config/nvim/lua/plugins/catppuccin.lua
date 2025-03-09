return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		local options = require("plugins.config.catppuccin-options")
		require("catppuccin").setup(options)

		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
