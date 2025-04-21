-- Open new panes faster
vim.keymap.set(
	"n",
	"<leader>ph",
	":vspl<enter> <Cmd>NvimTmuxNavigateLeft<CR>",
	{ silent = true, noremap = true, desc = "Open [P]ane [L]eft" }
)
vim.keymap.set(
	"n",
	"<leader>pj",
	":spl<enter> <Cmd>NvimTmuxNavigateDown<CR>",
	{ silent = true, noremap = true, desc = "Open [P]ane [D]own" }
)
vim.keymap.set(
	"n",
	"<leader>pk",
	":spl<enter> <Cmd>NvimTmuxNavigateUp<CR>",
	{ silent = true, noremap = true, desc = "Open [P]ane [U]p" }
)
vim.keymap.set(
	"n",
	"<leader>pl",
	":vspl<enter> <Cmd>NvimTmuxNavigateRight<CR>",
	{ silent = true, noremap = true, desc = "Open [P]ane [R]ight" }
)
