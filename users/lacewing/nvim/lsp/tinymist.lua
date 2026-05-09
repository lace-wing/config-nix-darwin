local u = require('util')
local map = u.vim.map

---@param client vim.lsp.Client
---@param bufnr integer
local function scroll_preview_to_cursor(client, bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local params = vim.lsp.util.make_position_params(0, 'utf-16')
  client:exec_cmd({
      title = 'Tinymist Scroll Preview',
      command = 'tinymist.scrollPreview',
      arguments = {
        bufname,
        {
          event = 'panelScrollTo',
          filepath = bufname,
          line = params.position.line,
          character = params.position.character + 1,
        }
      }
    },
    {
      bufnr = bufnr,
    },
    function(err, res)
      if err then
        return vim.notify(err.code .. ': ' .. err.message, vim.log.levels.ERROR)
      end
      vim.notify(vim.inspect(res), vim.log.levels.INFO)
    end
  )
end

---@param client vim.lsp.Client
---@param bufnr integer
local function pin_main(client, bufnr)
  client:exec_cmd({
    title = '',
    command = "tinymist.pinMain",
    arguments = {
      vim.api.nvim_buf_get_name(bufnr) }
  })
end

---@param client vim.lsp.Client
---@param bufnr integer
local function start_preview(client, bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  client:exec_cmd({
      title = 'Preview Typst',
      command = 'tinymist.doStartBrowsingPreview',
      arguments = { {
        '--task-id=' .. bufname,
        '--preview-mode=document',
        '--partial-rendering=true',
        '--data-plane-host=127.0.0.1:0',
        '--open',
        bufname,
      } }
    },
    {
      bufnr = bufnr
    },
    function(err, _)
      if err then
        return vim.notify(err.code .. ': ' .. err.message, vim.log.levels.ERROR)
      end
      vim.notify('Started Previewing Typst', vim.log.levels.INFO)
      map('n', 'ss', function() scroll_preview_to_cursor(client, bufnr) end,
        { desc = '[S]croll Typst Preview to Cursor' })
    end
  )
end

---@type vim.lsp.Config
return {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { 'typst.toml', '.git' },
  init_options = {
    formatterMode = 'typstyle',
    formatterProseWrap = false,
    completion = {
      postfix = false,
      symbol = 'stepless',
    },
  },
  on_attach = function(client, bufnr)
    map('n', 'sp', function() pin_main(client, bufnr) end, { desc = '[P]in Tinymist Main' })
    map('n', 'sv', function() start_preview(client, bufnr) end, { desc = 'Pre[v]iew Typst' })
  end
}
