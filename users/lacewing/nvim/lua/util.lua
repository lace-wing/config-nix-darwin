local M = {
  vim = require('util.vim'),
  parse = require('util.parse'),
  lsp = require('util.lsp'),
  os = require('util.os')
}

function M.use(module, force)
  force = force or false
  for k, v in pairs(module) do
    if not force and _G[k] then
      -- vim.notify('use: skipping duplicate symbol `' .. k .. '`\n', vim.log.levels.INFO)
    else
      _G[k] = v
    end
  end
end

return M
