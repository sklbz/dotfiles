local null_ls = require("null-ls")
local builtins = null_ls.builtins
local fmt = builtins.formatting
local diag = builtins.diagnostics
local cmp = builtins.completion

return {
	fmt.stylua,
	fmt.shfmt,
	diag.codespell,
	cmp.spell,
}
