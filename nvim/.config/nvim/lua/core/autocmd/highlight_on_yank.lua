vim.api.nvim_set_hl(0, "yankHighlight", { fg = "#1e1e2e", bg = "#89b4fa" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "yankHighlight", timeout = 300 })
	end,
})
