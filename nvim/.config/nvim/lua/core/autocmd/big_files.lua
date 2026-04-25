vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function(args)
		local path = vim.api.nvim_buf_get_name(args.buf)
		local filesize = vim.fn.getfsize(path)
		-- Disable features for files larger than 1MB
		if filesize > (1024 * 1024) then
			vim.bo.filetype = "bigfile"
			vim.cmd("TSBufDisable highlight")
			vim.cmd("TSBufDisable autotag")
			vim.cmd("LspStop")
		end
	end,
})
