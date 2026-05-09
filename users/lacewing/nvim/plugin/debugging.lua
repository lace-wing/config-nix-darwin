local dap = require('dap')

require('nvim-dap-virtual-text').setup({})

dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-dap',
  name = 'lldb'
}

dap.configurations.c = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.cpp = dap.configurations.c
