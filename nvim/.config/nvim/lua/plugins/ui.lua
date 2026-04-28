-- lua/plugins/ui.lua
return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		main = "ibl",
		---@module "ibl"
		---@diagnostic disable-next-line: undefined-doc-name
		---@type ibl.config
		opts = {},
	},
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = {}, -- required, even if empty
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			local options = require("plugins.config.catppuccin-options")
			require("catppuccin").setup(options)

			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			local button = dashboard.button

			dashboard.section.header.val = {
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                     ]],
				[[       ████ ██████           █████      ██                     ]],
				[[      ███████████             █████                             ]],
				[[      █████████ ███████████████████ ███   ███████████   ]],
				[[     █████████  ███    █████████████ █████ ██████████████   ]],
				[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
				[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
				[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
			}

			dashboard.section.buttons.val = {
				button("e", "  New file", "<cmd>ene<CR>"),
				button("SPC s f", "󰈞  Find file"),
				button("SPC s .", "  Recently opened files"),
				button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
				button("q", "󰅚  Quit", "<cmd>qa<CR>"),
			}

			alpha.setup(dashboard.opts)
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local color = function()
				local mode_color = {
					n = "#89b4fa",
					i = "#a6e3a1",
					v = "#cba6f7",
					-- [''] = colors.blue,
					V = "#cba6f7",
					c = "#fab387",
					-- no = colors.red,
					-- s = colors.orange,
					-- S = colors.orange,
					-- [''] = colors.orange,
					-- ic = colors.yellow,
					r = "#f38ba8",
					R = "#f38ba8",
					Rv = "#f38ba8",
					-- cv = colors.red,
					-- ce = colors.red,
					-- rm = colors.cyan,
					-- ['r?'] = colors.cyan,
					-- ['!'] = colors.red,
					t = "#a6e3a1",
				}
				return {
					fg = mode_color[vim.fn.mode()],
					bg = nil,
				}
			end

			local lsp_name = function()
				local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
				local clients = vim.lsp.get_clients()
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return nil
			end

			local opts = {
				options = {
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = [[]] },
					theme = "auto",
				},
				sections = {
					lualine_a = {
						{
							"mode",
							color = color,
						},
					},
					lualine_b = {
						"diff",
						{
							"diagnostics",
							symbols = { error = " ", warn = " ", info = " " },
						},
					},
					lualine_c = {
						{
							"filetype",
							icon_only = true,
							padding = { left = 1, right = 0 },
						},
						{
							"buffers",
							icons_enabled = true,
						},
					},
					lualine_x = {
						{
							function()
								local server_name = lsp_name()
								return server_name or "No Active Lsp"
							end,
							icon = function()
								return lsp_name() and " LSP:" or ""
							end,
							color = function()
								return { fg = lsp_name() and "#90f3c5" or "#f38b98" }
							end,
						},
					},
					lualine_y = {},
					lualine_z = {},
				},
			}

			require("lualine").setup(opts)
		end,
	},
}
