-- lua/plugins/config/lsp/keymaps.lua
local buf = vim.lsp.buf

vim.keymap.set("n", "<leader>rn", buf.rename, { desc = "[R]e[n]ame" })
vim.keymap.set("n", "K", buf.hover, { desc = "[K] Hover definition" })
vim.keymap.set("n", "<leader>gd", buf.definition, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "<leader>gr", buf.references, { desc = "[G]oto [R]eferences" })
vim.keymap.set({ "n", "v" }, "<leader>ca", buf.code_action, { desc = "[C]ode [A]ction" })
vim.keymap.set("n", "<leader>rs", function()
	local bufnr = vim.api.nvim_get_current_buf()
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		vim.lsp.stop_client(client.id, true)
	end
	vim.cmd("edit")
end, { desc = "[R]estart buffer LSP [S]erver" })
