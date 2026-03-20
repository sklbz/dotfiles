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
			{ "<leader>x", group = "diagnostics", mode = "n" },
		},
		win = {
			border = "rounded", -- style du cadre : single, double, rounded, solid
			wo = {
				winhl = "Normal:WhichKeyNormal,FloatBorder:WhichKeyBorder",
			},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")

		wk.setup({
			win = opts.win,
		})
		wk.add(opts.groups)

		local colors = require("catppuccin.palettes").get_palette("mocha")
		vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = colors.red })
		vim.api.nvim_set_hl(0, "WhichKeyNormal", { bg = "NONE" })
	end,
}
