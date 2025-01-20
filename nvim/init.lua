require("config.lazy")
require("config.autocmds")
require("config.keymaps")
vim.opt.smartindent = true
-- vim.opt.columns = 80
vim.opt.colorcolumn = {80}
vim.opt.number = true
vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.opt.filetype = on
