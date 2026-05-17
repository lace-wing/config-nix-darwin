local u = require('util')
local map = u.vim.map

vim.diagnostic.config({
  virtual_lines = true,
})

vim.lsp.inlay_hint.enable()

vim.lsp.enable({
  'clangd',
  'lua_ls',
  'pyright',
  'tinymist',
  'easy_dotnet',
  'fsautocomplete',
  'nixd',
  'elixirls',
  'zls',
  'nu',
  'org'
})

require('orgmode').setup({
  org_agenda_files = '~/org/**/*',
  org_default_notes_file = '~/org/refile.org',
})

local conform = require('conform')
conform.setup({
  formatters_by_ft = {
    asm = { 'nasmfmt' },
    -- FIXME nufmt currently buggy
    -- nu = { 'nufmt' },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

map('n', '<LEADER>l', conform.format, { desc = 'Format' })

require('origami').setup({
  autoFold = {
    enabled = true,
    kinds = { "imports" }, ---@type lsp.FoldingRangeKind[]
  },
})
