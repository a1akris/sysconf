local utils = require "essentials.utils"

local exec_cmd_helper = function(opts)
    utils.exec_cmd(opts.fargs)
end

vim.api.nvim_create_user_command("L", exec_cmd_helper, {
    nargs = '+',
    desc = "Execute a command in a new split",
    bang = false
})

local fix_group = vim.api.nvim_create_augroup("small_fixes", {
    clear = true,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = fix_group,
    pattern = "*",
    command = "set nohlsearch",
    desc = "Disable highlight on cursor move",
})
