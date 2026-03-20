return {
	"stevearc/oil.nvim",
	opts = {
		float = {
			border = "rounded",
			win_options = {
				winhl = "Normal:OilNormal,FloatBorder:OilBorder",
			},
		},
	},
	config = function(_, opts)
		local oil = require("oil")
		oil.setup(opts)

		local colors = require("catppuccin.palettes").get_palette("mocha")
		vim.api.nvim_set_hl(0, "OilBorder", { fg = colors.mauve })
		vim.api.nvim_set_hl(0, "OilNormal", { bg = "NONE" })

		vim.keymap.set("n", "-", oil.toggle_float, { desc = "[-] Open parent directory" })
	end,
}
