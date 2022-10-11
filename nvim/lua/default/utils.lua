local o   = vim.o
local fn  = vim.fn

local M = {}

function M.trim_trailing_whitespaces()
    if not o.binary and o.filetype ~= 'diff' then
        local current_view = fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        fn.winrestview(current_view)
    end
end

return M
