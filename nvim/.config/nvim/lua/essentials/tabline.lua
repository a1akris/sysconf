_G.__my_tabline = function()
    local tabline = 'views: '
    for i = 1, vim.fn.tabpagenr('$') do
        if i == vim.fn.tabpagenr() then
            tabline = tabline .. '%#TabLineSel#'
        else
            tabline = tabline .. '%#TabLine#'
        end

        tabline = tabline .. '%' .. i .. 'T' .. ' ' .. i .. ' ' .. '%T'
    end

    tabline = tabline .. '%#TabLineFill#%T'
    return tabline
end

vim.o.tabline = '%!v:lua.__my_tabline()'
