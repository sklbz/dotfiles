return {
	{
		"williamboman/mason.nvim",
		dependencies = { "mason-org/mason-registry" },
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local lspconf = require("lspconfig")

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lsp_list = require("plugins.config.lsp.lsp-list")

			local lsp_settings = {
				rust = require("plugins.config.lsp.rust-analyzer-opts"),
			}

			for _, lsp in ipairs(lsp_list) do
				local suffix = lsp == "dcm" and "ls" or ""

				-- local opts = lsp == "rust_analyzer" and lsp_settings.rust or {}
				if lsp == "rust_analyzer" then
					break
				end

				lspconf[lsp .. suffix].setup({
					capabilities = capabilities,
					opts,
				})
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
