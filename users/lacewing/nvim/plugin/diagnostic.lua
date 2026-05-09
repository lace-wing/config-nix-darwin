local u = require('util')
local map = u.vim.map

require('trouble').setup({
  auto_preview = false,
})

map('n', '<LEADER>xx', '<CMD>Trouble diagnostics toggle<CR>')
map('n', '<LEADER>xr', '<CMD>Trouble lsp_references toggle<CR>')
map('n', '<LEADER>xs', '<CMD>Trouble symbols toggle<CR>')
map('n', '<LEADER>xq', '<CMD>Trouble qflist toggle<CR>')
