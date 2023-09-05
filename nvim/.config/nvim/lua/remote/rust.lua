local status_ok, utils = pcall(require, "default.utils")

if not status_ok then
    print("Default utils not found")
    return
end

local clippy_cmd = function(opts)
    utils.exec_cmd(utils.concat_array_tables({ "~/work/on-remote", "cargo", "clippy", "--all-features" }, opts.fargs))
end

local build_cmd = function(opts)
    utils.exec_cmd(utils.concat_array_tables({ "~/work/on-remote", "cargo", "build", "--release" }, opts.fargs))
end

local run_cmd = function(opts)
    utils.exec_cmd(utils.concat_array_tables({ "~/work/on-remote", "cargo", "run" }, opts.fargs))
end

local test_cmd = function(opts)
    utils.exec_cmd(utils.concat_array_tables({ "~/work/on-remote", "cargo", "test" }, opts.fargs))
end


vim.api.nvim_create_user_command('Rcc', clippy_cmd, { nargs = '*', bang = false })
vim.api.nvim_create_user_command('Rbb', build_cmd, { nargs = '*', bang = false })
vim.api.nvim_create_user_command('Rrr', run_cmd, { nargs = '*', bang = false })
vim.api.nvim_create_user_command('Rtt', test_cmd, { nargs = '*', bang = false })
