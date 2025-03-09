return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = require("plugins.config.null-ls.sources"),
		})
	end,
}
