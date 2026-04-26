-- lua/config/diagnostics.lua
vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = "",
		format = function(diagnostic)
			return diagnostic.message
		end,
	},
})
