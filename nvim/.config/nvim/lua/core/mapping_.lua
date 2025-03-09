local map = vim.keymap.set

map({ "i", "v" }, "<c-j>", "<Esc>", { noremap = true, desc = "Normal mode" })

-- Open new panes faster
map(
	"n",
	"<leader>ph",
	":vspl<enter> <Cmd>NvimTmuxNavigateLeft<CR>",
	{ silent = true, noremap = true, desc = "Open [P]ane [L]eft" }
)
map(
	"n",
	"<leader>pj",
	":spl<enter> <Cmd>NvimTmuxNavigateDown<CR>",
	{ silent = true, noremap = true, desc = "Open [P]ane [D]own" }
)
map(
	"n",
	"<leader>pk",
	":spl<enter> <Cmd>NvimTmuxNavigateUp<CR>",
	{ silent = true, noremap = true, desc = "Open [P]ane [U]p" }
)
map(
	"n",
	"<leader>pl",
	":vspl<enter> <Cmd>NvimTmuxNavigateRight<CR>",
	{ silent = true, noremap = true, desc = "Open [P]ane [R]ight" }
)
