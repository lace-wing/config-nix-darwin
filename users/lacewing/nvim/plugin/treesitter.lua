local map = require('util').vim.map

local ts = require('nvim-treesitter')

ts.setup({
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  fold = { enable = true, },
})

require('nvim-treesitter-textobjects').setup({
  move = {
    set_jumps = true,
  },
})

local tosel = require('nvim-treesitter-textobjects.select')
local tomove = require('nvim-treesitter-textobjects.move')

------------
-- Select --
------------

vim.keymap.set({ "x", "o" }, "am", function()
  tosel.select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "im", function()
  tosel.select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
  tosel.select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
  tosel.select_textobject("@class.inner", "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o" }, "as", function()
  tosel.select_textobject("@local.scope", "locals")
end)

----------
-- Move --
----------

-- You can use the capture groups defined in `textobjects.scm`
map({ "n", "x", "o" }, "]m", function()
  tomove.goto_next_start("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "]]", function()
  tomove.goto_next_start("@class.outer", "textobjects")
end)
-- You can also pass a list to group multiple queries.
map({ "n", "x", "o" }, "]o", function()
  tomove.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm` or `folds.scm`
map({ "n", "x", "o" }, "]s", function()
  tomove.goto_next_start("@local.scope", "locals")
end)
map({ "n", "x", "o" }, "]z", function()
  tomove.goto_next_start("@fold", "folds")
end)

map({ "n", "x", "o" }, "]M", function()
  tomove.goto_next_end("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "][", function()
  tomove.goto_next_end("@class.outer", "textobjects")
end)

map({ "n", "x", "o" }, "[m", function()
  tomove.goto_previous_start("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "[[", function()
  tomove.goto_previous_start("@class.outer", "textobjects")
end)

map({ "n", "x", "o" }, "[M", function()
  tomove.goto_previous_end("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "[]", function()
  tomove.goto_previous_end("@class.outer", "textobjects")
end)

map({ "n", "x", "o" }, "]d", function()
  tomove.goto_next("@conditional.outer", "textobjects")
end)
map({ "n", "x", "o" }, "[d", function()
  tomove.goto_previous("@conditional.outer", "textobjects")
end)
