local status_ok, utils = pcall(require, "default.utils")

if not status_ok then
    print("Default utils not found")
    return
end

local remote_clippy_cmd = function(opts)
    utils.exec_cmd(utils.concat_array_tables({ "~/work/on-remote", "cargo", "clippy", "--all-features" }, opts.fargs))
end

local remote_build_cmd = function(opts)
    utils.exec_cmd(utils.concat_array_tables({ "~/work/on-remote", "cargo", "build", "--release" }, opts.fargs))
end

local remote_run_cmd = function(opts)
    utils.exec_cmd(utils.concat_array_tables({ "~/work/on-remote", "cargo", "run" }, opts.fargs))
end

local remote_test_cmd = function(opts)
    utils.exec_cmd(utils.concat_array_tables({ "~/work/on-remote", "cargo", "test", "--all-features" }, opts.fargs))
end

local local_clippy_cmd = function(opts)
    utils.exec_cmd(utils.concat_array_tables({ "cargo", "clippy", "--all-features" }, opts.fargs))
end

local local_build_cmd = function(opts)
    utils.exec_cmd(utils.concat_array_tables({ "cargo", "build", "--release" }, opts.fargs))
end

local local_run_cmd = function(opts)
    utils.exec_cmd(utils.concat_array_tables({ "cargo", "run" }, opts.fargs))
end

local local_test_cmd = function(opts)
    utils.exec_cmd(utils.concat_array_tables({ "cargo", "test", "--all-features" }, opts.fargs))
end



vim.api.nvim_create_user_command('Rcc', remote_clippy_cmd, {
    nargs = '*',
    bang = false,
    desc = "Remotely lint the Rust probram"
})

vim.api.nvim_create_user_command('Rbb', remote_build_cmd, {
    nargs = '*',
    bang = false,
    desc = "Remotely build the Rust program"
})

vim.api.nvim_create_user_command('Rrr', remote_run_cmd, {
    nargs = '*',
    bang = false,
    desc = "Remotely run the Rust program"
})

vim.api.nvim_create_user_command('Rtt', remote_test_cmd, {
    nargs = '*',
    bang = false,
    desc = "Remotely test the Rust program"
})

vim.api.nvim_create_user_command('Lcc', local_clippy_cmd, {
    nargs = '*',
    bang = false,
    desc = "Locally lint the Rust probram"
})

vim.api.nvim_create_user_command('Lbb', local_build_cmd, {
    nargs = '*',
    bang = false,
    desc = "Locally build the Rust program"
})

vim.api.nvim_create_user_command('Lrr', local_run_cmd, {
    nargs = '*',
    bang = false,
    desc = "Locally run the Rust program"
})

vim.api.nvim_create_user_command('Ltt', local_test_cmd, {
    nargs = '*',
    bang = false,
    desc = "Locally test the Rust program"
})
