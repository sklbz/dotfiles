-- lua/plugins/langs/rust.lua
return {
	{
		"mrcjkb/rustaceanvim",
		ft = { "rust", "toml" },
		version = "^5",
		lazy = false,
		init = function()
			vim.g.rustaceanvim = {
				-- ── Outils (inlay hints, etc.) ───────────────────────────────
				tools = {
					hover_actions = { auto_focus = true },
					inlay_hints = { auto = true },
				},

				-- ── Serveur LSP ──────────────────────────────────────────────
				server = {
					on_attach = function(_, bufnr)
						local opts = { buffer = bufnr, silent = true }

						-- Actions rust-analyzer
						vim.keymap.set("n", "<leader>rr", function()
							vim.cmd.RustLsp("runnables")
						end, vim.tbl_extend("force", opts, { desc = "Runnables" }))

						vim.keymap.set("n", "<leader>rd", function()
							vim.cmd.RustLsp("debuggables")
						end, vim.tbl_extend("force", opts, { desc = "Debuggables" }))
					end,
				},
				-- ── Intégration DAP (debug) ──────────────────────────────────
				dap = {
					adapter = {
						type = "executable",
						command = "codelldb", -- nécessite codelldb installé via mason
						name = "codelldb",
					},
				},
			}
		end,
	},
	{
		"cordx56/rustowl",
		ft = { "rust" },
		version = "*", -- Latest stable version
		build = "cargo install rustowl",
		lazy = false, -- This plugin is already lazy
		opts = {},
	},
	{
		"saecki/crates.nvim",
		ft = { "toml", "rust" },
		config = function()
			local crates = require("crates")
			crates.setup({})
			crates.show()

			vim.keymap.set("n", "<leader>uc", crates.upgrade_all_crates, { desc = "[U]pgrade [C]rates" })
			vim.keymap.set("n", "<leader>u.", crates.upgrade_crate, { desc = '[u]pgrade crate ("." for single crate)' })
		end,
	},
}
