-- lua/plugins/ui.lua
return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		cond = function()
			return vim.fn.argc() == 0
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			if vim.fn.argc() > 0 then
				return
			end

			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			local button = dashboard.button

			local function shift_line(line)
				local max_shift = 3
				local shift = math.random(0, max_shift)
				return line:sub(shift + 1)
			end

			local function generate_frame(lines)
				local out = {}

				for i, line in ipairs(lines) do
					if math.random() < 0.15 then
						out[i] = shift_line(line)
					else
						out[i] = line
					end
				end

				return out
			end

			local function start_glitch_cycle(header)
				local state = false
				local function run()
					local count = #vim.fn.getbufinfo({ buflisted = 1 })
					if count ~= 0 then
						return
					end

					if state then
						dashboard.section.header.val = generate_frame(header)
						vim.defer_fn(run, 150)
					else
						dashboard.section.header.val = header
						vim.defer_fn(run, 500)
					end

					state = not state
					require("alpha").redraw()
				end

				vim.defer_fn(run, 200)
			end

			dashboard.section.header.val = {
				[[                                                                     ]],
				[[       ████ ██████           █████      ██                     ]],
				[[      ███████████             █████                             ]],
				[[      █████████ ███████████████████ ███   ███████████   ]],
				[[     █████████  ███    █████████████ █████ ██████████████   ]],
				[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
				[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
				[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			}

			dashboard.section.buttons.val = {
				button("e", "  New file", "<cmd>ene<CR>"),
				button("SPC s f", "󰈞  Find file"),
				button("SPC s .", "  Recently opened files"),
				button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
				button("q", "󰅚  Quit", "<cmd>qa<CR>"),
			}

			dashboard.section.footer.val = function()
				local stats = require("lazy").stats()
				return "⚡ Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins"
			end

			dashboard.section.footer.opts = {
				position = "center",
				hl = "Comment",
			}
			dashboard.config.layout = {
				{ type = "padding", val = 4 },
				dashboard.section.header,
				{ type = "padding", val = 3 },
				dashboard.section.buttons,
				{ type = "padding", val = 2 },
				dashboard.section.footer,
			}

			alpha.setup(dashboard.opts)
			start_glitch_cycle(dashboard.section.header.val)
		end,
	},
	{
		"rebelot/heirline.nvim",
		config = function()
			local conditions = require("heirline.conditions")

			-- 🎨 Color
			local mode_color = function()
				local m = vim.fn.mode()
				local map = {
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
				return map[m] or "#cdd6f4"
			end

			-- Mode name
			local mode_name = function()
				local m = vim.fn.mode()
				local map = {
					n = "NORMAL",
					i = "INSERT",
					v = "VISUAL",
					V = "V-LINE",
					[""] = "V-BLOCK",
					c = "COMMAND",
					no = "OPERATOR",
					s = "SELECT",
					S = "S-LINE",
					ic = "INSERT (COMPL)",
					r = "REPLACE",
					R = "REPLACE",
					Rv = "V-REPLACE",
					cv = "EX",
					ce = "EX",
					rm = "MORE",
					["r?"] = "CONFIRM",
					["!"] = "SHELL",
					t = "TERMINAL",
				}

				return map[m] or ""
			end

			-- 🔌 LSP
			local lsp_name = function()
				local buf_ft = vim.bo.filetype
				for _, client in ipairs(vim.lsp.get_clients()) do
					local ft = client.config.filetypes
					if ft and vim.tbl_contains(ft, buf_ft) then
						return client.name
					end
				end
				return nil
			end

			-- 🧠 components

			local Mode = {
				provider = function()
					return " " .. mode_name() .. " "
				end,
				hl = function()
					return { fg = mode_color(), bold = true }
				end,
			}

			local FileTypeIcon = {
				provider = function()
					return " " .. vim.bo.filetype .. " "
				end,
			}

			local Buffers = {
				provider = function()
					return " " .. vim.fn.bufname("%:t") .. " "
				end,
			}

			local Diagnostics = {
				condition = conditions.has_diagnostics,
				init = function(self)
					self.errs = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
					self.warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
					self.infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
				end,

				{
					condition = function(self)
						return self.errs > 0
					end,
					provider = function(self)
						return "  " .. self.errs .. " "
					end,
					hl = { fg = "#f38ba8" }, -- red (catppuccin)
				},
				{
					condition = function(self)
						return self.warns > 0
					end,
					provider = function(self)
						return " " .. self.warns .. " "
					end,
					hl = { fg = "#f9e2af" }, -- yellow (catppuccin)
				},
				{
					condition = function(self)
						return self.infos > 0
					end,
					provider = function(self)
						return " " .. self.infos .. " "
					end,
					hl = { fg = "#89b4fa" }, -- blue (catppuccin)
				},
			}

			local LSP = {
				provider = function()
					local name = lsp_name()
					return name and ("  LSP:" .. name .. " ") or " No Active Lsp "
				end,
				hl = function()
					return {
						fg = lsp_name() and "#90f3c5" or "#f38b98",
					}
				end,
			}

			-- 🧱 layout

			require("heirline").setup({
				statusline = {
					Mode,
					Diagnostics,
					FileTypeIcon,
					Buffers,
					{ provider = "%=" }, -- push right
					LSP,
				},
			})
		end,
	},
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
}
