local p = require('util.parse')

local M = {
	map = vim.keymap.set
}

function M.hi(group, opt)
	vim.cmd('hi ' .. group .. ' ' .. p.tbl_kv_string(opt))
end

function M.hif(group, opt)
	vim.api.nvim_set_hl(0, group, opt)
end

function M.hc(group)
	vim.api.nvim_set_hl(0, group, {})
end

return M
