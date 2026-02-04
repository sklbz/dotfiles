vim.cmd("set shiftwidth=2")
vim.cmd("set tabstop=2")
vim.g.mapleader = " "
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.syntax = "on"
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.undofile = true

-- Highlight search
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Define how new splits open
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Change end of buffer character to blank spaces
vim.opt.fillchars = { eob = " " }

require("config.utils.utils_")
