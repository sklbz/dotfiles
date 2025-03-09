return {
	"stevearc/oil.nvim",
	opts = {},
	config = function(_, opts)
		local oil = require("oil")

		oil.setup(opts)
		vim.keymap.set("n", "-", oil.toggle_float, { desc = "[-] Open parent directory" })
	end,
}
