return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = { "lua", "rust", "vim" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				textobjects = { enable = false },
			})

			local function cycle_brackets()
				local next_brak = {
					["("] = "{",
					[")"] = "}",
					["{"] = "[",
					["}"] = "]",
					["["] = "<",
					["]"] = ">",
					["<"] = "(",
					[">"] = ")",
				}
				local pair_of = {
					["("] = ")",
					["{"] = "}",
					["["] = "]",
					["<"] = ">",
					[")"] = "(",
					["}"] = "{",
					["]"] = "[",
					[">"] = "<",
				}
				local is_open = { ["("] = true, ["{"] = true, ["["] = true, ["<"] = true }

				local bufnr = vim.api.nvim_get_current_buf()
				local row1, col0 = unpack(vim.api.nvim_win_get_cursor(0))
				local row0 = row1 - 1 -- 0-based

				local function char_at(r, c)
					local l = vim.api.nvim_buf_get_lines(bufnr, r, r + 1, false)[1] or ""
					return l:sub(c + 1, c + 1)
				end

				local function lit(s)
					return "\\V" .. vim.fn.escape(s, "\\")
				end

				-- r0, c0 : tous les deux 0-based en interne
				-- setpos attend col 1-based → on passe c0+1
				-- searchpairpos retourne {lnum 1-based, col 1-based} → on soustrait 1
				local function find_close(open_ch, r0, c0)
					local saved = vim.fn.getcurpos()
					vim.fn.setpos(".", { 0, r0 + 1, c0 + 1, 0 })
					local pos = vim.fn.searchpairpos(lit(open_ch), "", lit(pair_of[open_ch]), "W")
					vim.fn.setpos(".", saved)
					if pos[1] == 0 then
						return nil, nil
					end
					return pos[1] - 1, pos[2] - 1
				end

				local function find_open(open_ch, r0, c0)
					local saved = vim.fn.getcurpos()
					vim.fn.setpos(".", { 0, r0 + 1, c0 + 1, 0 })
					local pos = vim.fn.searchpairpos(lit(open_ch), "", lit(pair_of[open_ch]), "bW")
					vim.fn.setpos(".", saved)
					if pos[1] == 0 then
						return nil, nil
					end
					return pos[1] - 1, pos[2] - 1
				end

				local open_r, open_c, close_r, close_c, open_ch
				local ch = char_at(row0, col0)

				-- ── Étape 1 : curseur directement sur un bracket ─────────────────────────
				if next_brak[ch] then
					-- % est la méthode la plus fiable pour bracket matching
					local saved = vim.fn.getcurpos()
					vim.cmd("normal! %")
					local mpos = vim.fn.getcurpos()
					vim.fn.setpos(".", saved)

					local moved = (mpos[2] ~= saved[2] or mpos[3] ~= saved[3])

					if moved then
						-- getcurpos retourne col 1-based → -1 pour 0-based
						local mr0, mc0 = mpos[2] - 1, mpos[3] - 1
						if is_open[ch] then
							open_r, open_c, open_ch = row0, col0, ch
							close_r, close_c = mr0, mc0
						else
							close_r, close_c = row0, col0
							open_ch = pair_of[ch]
							open_r, open_c = mr0, mc0
						end
					else
						-- % n'a pas bougé (ex: < > hors HTML) → fallback searchpairpos
						if is_open[ch] then
							open_r, open_c, open_ch = row0, col0, ch
							close_r, close_c = find_close(ch, row0, col0)
						else
							close_r, close_c = row0, col0
							open_ch = pair_of[ch]
							open_r, open_c = find_open(open_ch, row0, col0)
						end
					end

				-- ── Étape 2 : Treesitter — remonte l'arbre ───────────────────────────────
				else
					local ts_ok, node = pcall(vim.treesitter.get_node, { bufnr = bufnr, pos = { row0, col0 } })
					if ts_ok and node then
						local n = node
						while n do
							local sr, sc, er, ec = n:range()
							if ec > 0 then
								local fc = char_at(sr, sc)
								local lc = char_at(er, ec - 1)
								if is_open[fc] and lc == pair_of[fc] then
									open_r, open_c = sr, sc
									close_r, close_c = er, ec - 1
									open_ch = fc
									break
								end
							end
							n = n:parent()
						end
					end

					-- ── Étape 3 : fallback searchpairpos ─────────────────────────────────
					if not open_ch then
						for _, b in ipairs({ "(", "{", "[" }) do
							local r, c = find_open(b, row0, col0)
							if r and (not open_r or r > open_r or (r == open_r and c > open_c)) then
								open_r, open_c, open_ch = r, c, b
							end
						end
						if open_ch then
							close_r, close_c = find_close(open_ch, open_r, open_c)
						end
					end
				end

				if not open_ch or not close_r then
					vim.notify("cycle_brackets: aucune paire de brackets trouvée", vim.log.levels.WARN)
					return
				end

				local new_open = next_brak[open_ch]
				local new_close = next_brak[pair_of[open_ch]]

				-- Remplace le fermant EN PREMIER pour ne pas décaler la col de l'ouvrant
				local cl = vim.api.nvim_buf_get_lines(bufnr, close_r, close_r + 1, false)[1]
				vim.api.nvim_buf_set_lines(
					bufnr,
					close_r,
					close_r + 1,
					false,
					{ cl:sub(1, close_c) .. new_close .. cl:sub(close_c + 2) }
				)

				local ol = vim.api.nvim_buf_get_lines(bufnr, open_r, open_r + 1, false)[1]
				vim.api.nvim_buf_set_lines(
					bufnr,
					open_r,
					open_r + 1,
					false,
					{ ol:sub(1, open_c) .. new_open .. ol:sub(open_c + 2) }
				)
			end

			vim.keymap.set("n", "<leader>cb", cycle_brackets, { desc = "Cycle Brackets ( -> { -> [ -> <" })
		end,
	},
}
