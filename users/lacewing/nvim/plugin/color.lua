local u = require('util')
local hi = u.vim.hi

-- colorscheme
vim.cmd("colorscheme alabaster")

-- transparency
hi('statusline', { ctermbg = 'NONE', guibg = 'NONE' })
hi('statuslineNC', { ctermbg = 'NONE', guibg = 'NONE' })

hi('SpellBad', { gui = 'undercurl', cterm = 'undercurl' })

hi('Normal', { ctermbg = 'NONE', guibg = 'NONE' })
hi('NormalNC', { ctermbg = 'NONE', guibg = 'NONE' })

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    hi('TreesitterContext', { guisp = 'NONE' })
  end
})

-- highlights
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})
