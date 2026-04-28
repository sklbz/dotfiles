-- lua/plugins/matchup.lua
return {
	"andymass/vim-matchup",
	---@type matchup.Config
	opts = {
		treesitter = {
			stopline = 500,
		},
	},
}
