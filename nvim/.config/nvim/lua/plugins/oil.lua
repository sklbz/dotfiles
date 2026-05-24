-- lua/plugins/oil.lua
return {
	"stevearc/oil.nvim",
	opts = {
		float = {
			border = "rounded",
			win_options = {
				winhl = "Normal:OilNormal,FloatBorder:OilBorder",
			},
		},
		keymaps = {
			["gx"] = {
				callback = function()
					local oil = require("oil")

					-- Full path of entry under cursor
					local entry = oil.get_cursor_entry()
					if not entry then
						return
					end

					local dir = oil.get_current_dir()
					local path = dir .. entry.name

					-- compress with xz -e
					vim.fn.jobstart({ "xz", "-e", path }, {
						detach = true,
					})

					print("Compressing: " .. path)
				end,
				desc = "Compress file with xz -e",
			},
		},
	},
	config = function(_, opts)
		local oil = require("oil")
		oil.setup(opts)

		local colors = require("catppuccin.palettes").get_palette("mocha")
		vim.api.nvim_set_hl(0, "OilBorder", { fg = colors.mauve })
		vim.api.nvim_set_hl(0, "OilNormal", { bg = "NONE" })

		vim.keymap.set("n", "-", oil.toggle_float, { desc = "[-] Open parent directory" })
	end,
}
