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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lsp_list = require("plugins.config.lsp.lsp-list")

			for _, lsp in ipairs(lsp_list) do
				local suffix = lsp == "dcm" and "ls" or ""

				-- local opts = lsp == "rust_analyzer" and lsp_settings.rust or {}
				if lsp == "rust_analyzer" then
					break
				end

				local lsp_name = lsp == "json-lsp" and "jsonls" or lsp

				local lsp_server = lsp_name .. suffix

				if lsp ~= "rust_analyzer" then
					vim.lsp.config(lsp_server, {
						capabilities = capabilities,
						-- opts,
					})
				end
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
