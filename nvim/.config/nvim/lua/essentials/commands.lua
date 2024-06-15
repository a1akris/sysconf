local utils = require "essentials.utils"

local exec_cmd_helper = function(opts)
    utils.exec_cmd(opts.fargs)
end

vim.api.nvim_create_user_command("L", exec_cmd_helper, {
    nargs = '+',
    desc = "Execute a command in a new split",
    bang = false
})
