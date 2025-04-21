vim.api.nvim_set_hl(0, "nYankHighlight", { fg = "#1e1e2e", bg = "#89b4fa" })
vim.api.nvim_set_hl(0, "vYankHighlight", { fg = "#1e1e2e", bg = "#b4befe" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		if vim.api.nvim_get_mode().mode ~= "n" then
			vim.highlight.on_yank({ higroup = "nYankHighlight", timeout = 300 })
		else
			vim.highlight.on_yank({ higroup = "vYankHighlight", timeout = 300 })
		end
	end,
})
