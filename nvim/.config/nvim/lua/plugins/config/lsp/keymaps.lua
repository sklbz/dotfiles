local buf = vim.lsp.buf

vim.keymap.set("n", "<leader>rn", buf.rename, { desc = "[R]e[n]ame" })
vim.keymap.set("n", "K", buf.hover, { desc = "[K] Hover definition" })
vim.keymap.set("n", "<leader>gd", buf.definition, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "<leader>gr", buf.references, { desc = "[G]oto [R]eferences" })
vim.keymap.set({ "n", "v" }, "<leader>ca", buf.code_action, { desc = "[C]ode [A]ction" })
