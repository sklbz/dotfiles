local api = vim.api

-- api.nvim_command("autocmd TermOpen * startinsert") -- starts in insert mode
-- api.nvim_command("autocmd TermOpen * setlocal nonumber") -- no numbers
-- api.nvim_command("autocmd TermEnter * setlocal signcolumn=no") -- no sign column

api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = "*",
	group = api.nvim_create_augroup("term_callback", { clear = true }),
	callback = function()
		vim.opt_local.signcolumn = "no"
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})

api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = "*",
	group = api.nvim_create_augroup("term_command", { clear = true }),
	command = "startinsert",
})

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" }) -- exit terminal mode
