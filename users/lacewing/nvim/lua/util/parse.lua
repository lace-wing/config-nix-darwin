local M = {}

function M.tbl_kv_string(tbl, sep, delim)
    sep = sep or ' '
    delim = delim or '='

    local result = {}

    for k, v in pairs(tbl) do
        if type(k) == "string" or type(k) == "number" then
            local key_str = tostring(k)
            local value_str = tostring(v)
            table.insert(result, key_str .. delim .. value_str)
        end
    end
    return table.concat(result, sep)
end

return M
