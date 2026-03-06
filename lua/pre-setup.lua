-- Explicitly use ripgrep
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.grepformat = '%f:%l:%c:%m'

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

vim.opt.colorcolumn = '80,' .. table.concat(vim.fn.range(120, 999), ',')

vim.o.relativenumber = true

vim.o.list = false
