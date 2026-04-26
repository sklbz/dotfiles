-- lua/config/init.lua
require("config.vim-options")
require("config.diagnostics")
require("config.autocmd")
require("config.mapping")
require("config.term")
require("config.init-lazy")
require("lazy").setup("plugins")
