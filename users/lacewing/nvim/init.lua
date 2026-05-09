local u = require('util')
local map = u.vim.map

vim.filetype.add({
  extension = {
    eex = 'eelixir',
    surface = 'surface',
    objdump = 'objdump',
    ipynb = 'jupyter',
    icas = 'icas',
  }
})

vim.opt.path:append('**')

vim.o.undofile = true
vim.o.swapfile = false

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.expandtab = true

vim.o.autocomplete = false

vim.o.signcolumn = 'yes'

vim.o.foldmethod = 'marker'
vim.o.foldcolumn = 'auto'
vim.o.foldlevelstart = 99

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

map({ 'n', 'v', 'x' }, ';', ':')
map({ 'n', 'v', 'x' }, ':', ':!')

map({ 'n', 'v', 'x', }, 'j', 'gj')
map({ 'n', 'v', 'x', }, 'k', 'gk')

map('n', '<LEADER>o', ':update<CR> :source<CR>')
map('n', '<LEADER>w', ':write<CR>')
map('n', '<LEADER>q', ':quit<CR>')

map({ 'n', 'v', 'x' }, '<LEADER>y', '"+y')
map({ 'n', 'v', 'x' }, '<LEADER>d', '"+d')
map({ 'n', 'v', 'x' }, '<LEADER>c', '"+c')
map({ 'n', 'v', 'x' }, '<LEADER>s', '"+s')
map({ 'n', 'v', 'x' }, '<LEADER>p', '"+p')

map({ 'n', 'v', 'x' }, '<LEADER>Y', '"+Y')
map({ 'n', 'v', 'x' }, '<LEADER>D', '"+D')
map({ 'n', 'v', 'x' }, '<LEADER>C', '"+C')
map({ 'n', 'v', 'x' }, '<LEADER>S', '"+S')
map({ 'n', 'v', 'x' }, '<LEADER>P', '"+P')

map('n', '<LEADER>n', ':make<CR>')
map('n', '<LEADER>m', ':make ')

map('n', '<LEADER>/', ':set hlsearch<CR>')

map('n', 'gd', vim.lsp.buf.definition)

-- Quick terminal normal mode
map('t', '<ESC>', '<C-\\><C-n>', { desc = 'Exit Ternimal Insert mode', noremap = true })
-- <C-w> in terminal mode
-- <C-\><C-o> for a command in terminal mode
map('t', '<C-w>', '<C-\\><C-o><C-w>', { desc = "Exit Ternimal Insert mode", noremap = true })
-- Enter terminal insert mode on enter window
vim.cmd([[
  autocmd BufWinEnter,BufEnter term://* startinsert
  autocmd BufWinLeave,BufLeave term://* stopinsert
]])
