-- lsp/lua_ls.lua
return {
	capabilities = require("lsp.default").capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}
