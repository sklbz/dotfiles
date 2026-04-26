-- lua/plugins/lsp-config.lua
return {
	{
		"williamboman/mason.nvim",
		dependencies = { "mason-org/mason-registry" },
		config = function()
			require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,

		config = function()
			require("lspconfig")

			local lsp_list = {
				"bashls",
				"clangd",
				"lua_ls",
				"tailwindcss",
				"ocamllsp",
				"jsonls",
			}
			for _, lsp in ipairs(lsp_list) do
				vim.lsp.enable(lsp)
			end
			require("plugins.config.lsp.keymaps")
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			auto_update = true,
			ensure_installed = require("plugins.config.lsp.ensure-installed"),
		},
	},
}
