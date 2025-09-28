local utils = require "essentials.utils"

local build = { "zig", "build" }
local test = { "zig", "build", "test" }
local run = { "zig", "build", "run" }

local build_user_cmd = function(command_args)
    return function(opts)
        utils.exec_cmd(utils.concat_array_tables(command_args, opts.fargs))
    end
end

vim.api.nvim_buf_create_user_command(0, 'Lbb', build_user_cmd(build), {
    nargs = '*',
    bang = false,
    desc = "Locally build the Rust program"
})

vim.api.nvim_buf_create_user_command(0, 'Lrr', build_user_cmd(run), {
    nargs = '*',
    bang = false,
    desc = "Locally run the Rust program"
})

vim.api.nvim_buf_create_user_command(0, 'Ltt', build_user_cmd(test), {
    nargs = '*',
    bang = false,
    desc = "Locally test the Rust program"
})
