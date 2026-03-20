return {
	transparent_background = true,
	flavor = "mocha",

	integrations = {
		telescope = { enabled = true },
		cmp = true,
		treesitter = true,
		native_lsp = {
			enabled = true,
			underlines = {
				errors = { "undercurl" },
				hints = { "undercurl" },
				warnings = { "undercurl" },
				information = { "undercurl" },
			},
		},
		lsp_trouble = true,
		mason = true,
	},

	custom_highlights = function(colors)
		return {
			NormalFloat = { bg = "NONE" },
			FloatBorder = { fg = colors.blue, bg = "NONE" },
			FloatTitle = { fg = colors.blue, bg = "NONE" },

			LspInfoBorder = { fg = colors.blue, bg = "NONE" },

			TelescopeNormal = { bg = "NONE" },
			TelescopeBorder = { fg = colors.blue, bg = "NONE" },
			TelescopePromptNormal = { bg = "NONE" },
			TelescopePromptBorder = { fg = colors.blue, bg = "NONE" },
			TelescopePromptTitle = { fg = colors.text, bg = "NONE" },
			TelescopePreviewTitle = { fg = colors.text, bg = "NONE" },
			TelescopeResultsTitle = { fg = colors.text, bg = "NONE" },

			MasonNormal = { bg = "NONE" },
			LazyNormal = { bg = "NONE" },
		}
	end,
}
