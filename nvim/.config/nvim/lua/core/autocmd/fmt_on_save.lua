local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
	pattern = "*",
	callback = function()
		vim.lsp.buf.format()
	end,
})
