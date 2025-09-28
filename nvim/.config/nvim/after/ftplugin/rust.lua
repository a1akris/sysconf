local utils = require "essentials.utils"

local remote_runner = "~/e/dev/remote/exec"
local clippy = { "cargo", "clippy", "--all-features", "--all-targets" }
local build = { "cargo", "build", "--release" }
local test = { "cargo", "test", "--all-features", "--all-targets" }
local run = { "cargo", "run" }
local playground = "~/e/dev/rust-playground"

local build_user_cmds = function(command_args)
    return function(opts)
        utils.exec_cmd(utils.concat_array_tables(command_args, opts.fargs))
    end, function(opts)
        local remote_command = utils.concat_arrays(remote_runner, command_args)
        utils.exec_cmd(utils.concat_array_tables(remote_command, opts.fargs))
    end
end

local local_clippy_cmd, remote_clippy_cmd = build_user_cmds(clippy)
local local_build_cmd, remote_build_cmd = build_user_cmds(build)
local local_test_cmd, remote_test_cmd = build_user_cmds(test)
local local_run_cmd, remote_run_cmd = build_user_cmds(run)

local open_playground = function(opts)
    local arg = opts.args or ""
    local cmd = playground

    if arg == "continue" then
        cmd = cmd .. " -c"
    end

    cmd = cmd .. " --nvim"

    local original_dir = vim.fn.fnameescape(vim.fn.getcwd())
    local file = vim.fn.fnameescape(vim.fn.system(cmd):match("^%s*(.-)%s*$"))

    if not file or file == "" then
        vim.error("Failed to receive a command output")
    end

    local playground_dir = vim.fn.fnamemodify(file, ":h:h")
    vim.cmd("tabnew")
    vim.cmd("tcd " .. playground_dir)
    vim.cmd("edit " .. file)

    local bufnr = vim.api.nvim_get_current_buf()

    local tmpgrp = vim.api.nvim_create_augroup("RustPlaygroundHook", {
        clear = true,
    })

    vim.api.nvim_create_autocmd("BufDelete", {
        group = tmpgrp,
        desc = "Go out of a workspace when it's not needed anymore",
        callback = function()
            vim.cmd("tabclose")
            vim.cmd("cd " .. original_dir)
        end,
        buffer = bufnr,
    })
end


vim.api.nvim_buf_create_user_command(0, 'Rcc', remote_clippy_cmd, {
    nargs = '*',
    bang = false,
    desc = "Remotely lint the Rust probram"
})

vim.api.nvim_buf_create_user_command(0, 'Rbb', remote_build_cmd, {
    nargs = '*',
    bang = false,
    desc = "Remotely build the Rust program"
})

vim.api.nvim_buf_create_user_command(0, 'Rrr', remote_run_cmd, {
    nargs = '*',
    bang = false,
    desc = "Remotely run the Rust program"
})

vim.api.nvim_buf_create_user_command(0, 'Rtt', remote_test_cmd, {
    nargs = '*',
    bang = false,
    desc = "Remotely test the Rust program"
})

vim.api.nvim_buf_create_user_command(0, 'Lcc', local_clippy_cmd, {
    nargs = '*',
    bang = false,
    desc = "Locally lint the Rust probram"
})

vim.api.nvim_buf_create_user_command(0, 'Lbb', local_build_cmd, {
    nargs = '*',
    bang = false,
    desc = "Locally build the Rust program"
})

vim.api.nvim_buf_create_user_command(0, 'Lrr', local_run_cmd, {
    nargs = '*',
    bang = false,
    desc = "Locally run the Rust program"
})

vim.api.nvim_buf_create_user_command(0, 'Ltt', local_test_cmd, {
    nargs = '*',
    bang = false,
    desc = "Locally test the Rust program"
})

vim.api.nvim_buf_create_user_command(0, 'Playground', open_playground, {
    nargs = '?',
    bang = false,
    desc = "Open Rust playground in new Tab",
    complete = function(_, _, _)
        return { "continue" }
    end
})
