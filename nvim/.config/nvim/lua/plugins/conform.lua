-- lua/plugins/conform.lua
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				["*"] = { "trim_whitespace", "trim_newlines" },
				rust = { "rustfmt" },
				lean = { "lsp" },
				lua = { "stylua" },
				sh = { "shfmt" },
				ocaml = { "ocamlformat" },
			},

			format_on_save = {
				timeout_ms = 2000,
				lsp_fallback = true,
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ lsp_fallback = false })
		end, { desc = "Format buffer" })
	end,
}
