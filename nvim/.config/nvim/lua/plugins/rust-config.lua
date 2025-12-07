return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"cordx56/rustowl",
		version = "*", -- Latest stable version
		build = "cargo install rustowl",
		lazy = false, -- This plugin is already lazy
		opts = {},
	},
	{
		"saecki/crates.nvim",
		ft = { "toml", "rust" },
		config = function()
			local crates = require("crates")
			crates.setup({})
			crates.show()

			vim.keymap.set("n", "<leader>uc", crates.upgrade_all_crates, { desc = "[U]pgrade [C]rates" })
			vim.keymap.set("n", "<leader>u.", crates.upgrade_crate, { desc = '[u]pgrade crate ("." for single crate)' })
		end,
	},
}
