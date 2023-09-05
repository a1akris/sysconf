local o  = vim.o
local fn = vim.fn

local M  = {}

function M.trim_trailing_whitespaces()
    if not o.binary and o.filetype ~= 'diff' then
        local current_view = fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        fn.winrestview(current_view)
    end
end

function M.concat_array_tables(a1, a2)
    local result = {}
    local n = 0

    for _, v in ipairs(a1) do
        n = n + 1;
        result[n] = v
    end

    for _, v in ipairs(a2) do
        n = n + 1;
        result[n] = v
    end

    return result
end

function M.exec_cmd(args)
    vim.cmd("split")
    vim.cmd { cmd = "te", args = args }
end

return M
