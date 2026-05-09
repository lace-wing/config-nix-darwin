local M = {}

function M.setup_completion()
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client:supports_method('textDocument/completion') then
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      end
    end,
  })
end

---@param client vim.lsp.Client
---@param bufnr integer
function M.setup_vs_onAutoInsert(client, bufnr)
  vim.api.nvim_create_autocmd("InsertCharPre", {
    buffer = bufnr,
    callback = function()
      local char = vim.v.char

      if char ~= '/' then
        return
      end

      local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
      row, col = row - 1, col + 1
      local uri = vim.uri_from_bufnr(bufnr)

      local params = {
        _vs_textDocument = { uri = uri },
        _vs_position = { line = row, character = col },
        _vs_ch = char,
        _vs_options = {
          tabSize = vim.bo[bufnr].tabstop,
          insertSpaces = vim.bo[bufnr].expandtab,
        },
      }

      vim.schedule(function()
        client:request(
        ---@diagnostic disable-next-line: param-type-mismatch
          "textDocument/_vs_onAutoInsert",
          params,
          function(err, result, _)
            if err or not result or not next(result) then
              return
            end

            local text = result._vs_textEdit.newText:gsub("\r\n", "\n"):gsub("\r", "\n"):gsub('\t', '')
            vim.snippet.expand(text)
          end,
          bufnr
        )
      end)
    end,
  })
end

return M
