-- lua/plugins/lean.lua
return {
	"Julian/lean.nvim",
	event = { "BufReadPre *.lean", "BufNewFile *.lean" },
	opts = {
		mappings = false,
		lsp = {
			enable = true,
		},
	},
	config = function(_, opts)
		require("lean").setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "lean",
			callback = function(ev)
				local bufnr = ev.buf
				vim.keymap.set("n", "<leader>lr", function()
					require("lean.lsp").restart_file(bufnr)
				end, { buffer = bufnr, desc = "Restart file" })
				vim.keymap.set("n", "<leader>li", function()
					require("lean.infoview").toggle()
				end, { buffer = bufnr, desc = "Toggle Infoview" })
			end,
		})
	end,
}
