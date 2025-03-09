return {
	"alexghergh/nvim-tmux-navigation",
	opts = {},
	config = function(_, opts)
		require("nvim-tmux-navigation").setup(opts)
		vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { desc = "Navigate left" })
		vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { desc = "Navigate down" })
		vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { desc = "Navigate up" })
		vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { desc = "Navigate right" })
	end,
}
