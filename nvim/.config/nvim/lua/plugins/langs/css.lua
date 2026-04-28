-- lua/plugins/langs/css.lua
return {
	"alexlafroscia/postcss-syntax.vim",
	{
		"sklbz/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
			"neovim/nvim-lspconfig", -- optional
		},
		opts = {}, -- your configuration
	},
}
