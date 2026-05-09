require('blink-cmp').setup({
  completion = {
    list = {
      selection = {
        preselect = false
      }
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },
  signature = {
    enabled = true
  },
  keymap = {
    preset = 'default',
    ['<C-k>'] = {},
  },
  appearance = {
    use_nvim_cmp_as_default = true,
  },
})

vim.cmd("set completeopt+=noselect")

require('util.lsp').setup_completion()

local msnip = require('mini.snippets')
msnip.setup({
  snippets = {
    msnip.gen_loader.from_lang()
  }
})
