local M = {}

M.name = (function()
  local osname
  -- ask LuaJIT first
  if jit then
    return jit.os
  end

  -- Unix, Linux variants
  local fh, _ = assert(io.popen('uname -o 2>/dev/null', 'r'))
  if fh then
    osname = fh:read()
  end

  return osname or 'Wisdows'
end)()

M.ext = {
  so = (function()
    if M.name == 'Linux' then
      return 'so'
    elseif M.name == 'OSX' then
      return 'dylib'
    elseif M.name == 'Windows' then
      return 'dll'
    end
  end)(),
}

return M
