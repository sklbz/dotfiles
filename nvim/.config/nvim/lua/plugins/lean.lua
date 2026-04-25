-- lua/plugins/lean.lua
return {
	"Julian/lean.nvim",
	event = { "BufReadPre *.lean", "BufNewFile *.lean" },

	dependencies = {
		-- optional dependencies:

		-- a completion engine
		--    hrsh7th/nvim-cmp or Saghen/blink.cmp are popular choices

		-- 'nvim-telescope/telescope.nvim', -- for 2 Lean-specific pickers
		-- 'andymass/vim-matchup',          -- for enhanced % motion behavior
		-- 'andrewradev/switch.vim',        -- for switch support
		-- 'tomtom/tcomment_vim',           -- for commenting
	},

	---@type lean.Config
	opts = {
		mappings = false,
		lsp = {
			enable = true,
			on_attach = function(_, bufnr)
				vim.keymap.set("n", "<leader>li", function()
					vim.cmd("LeanInfoViewToggle")
				end, {
					buffer = bufnr,
					desc = "Toggle Infoview",
				})
			end,
		},
	},
}
