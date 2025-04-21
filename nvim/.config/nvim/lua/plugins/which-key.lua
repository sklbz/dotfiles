return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 100
	end,
	opts = {
		groups = {
			{ "<leader>b", group = "buffer", mode = "n" },
			{ "<leader>d", group = "debug", mode = "n" },
			{ "<leader>p", group = "pane", mode = "n" },
			{ "<leader>s", group = "search", mode = "n" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.add(opts.groups)
	end,
}
