local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.documentFormattingProvider = false
		end
	end,
})
