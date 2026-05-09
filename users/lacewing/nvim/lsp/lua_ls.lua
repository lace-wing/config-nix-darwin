---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true)
			},
			telemetry = { enable = false },
      codeLens = { enable = true },
      hint = { enable = true, semicolon = 'Disable' },
		}
	}
}
