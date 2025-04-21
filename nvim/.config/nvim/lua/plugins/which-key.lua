return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 100
	end,
	opts = {},
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>d", group = "debug", mode = "n" },
			{ "<leader>p", group = "pane", mode = "n" },
			{ "<leader>s", group = "search", mode = "n" },
		})
	end,
}
