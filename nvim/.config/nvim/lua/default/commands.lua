local status_ok, utils = pcall(require, "default.utils")

if not status_ok then
    print("Default utils not found")
    return
end

local user_utils_group = vim.api.nvim_create_augroup("user_utils", {
    clear = true,
})

local exec_cmd_helper = function(opts)
    utils.exec_cmd(opts.fargs)
end

vim.api.nvim_create_autocmd("BufWritePre", {
    group = user_utils_group,
    pattern = "*",
    callback = utils.trim_trailing_whitespaces,
    desc = "Trim trailing whitespaces on save"
})

vim.api.nvim_create_user_command("L", exec_cmd_helper, {
    nargs = '+',
    desc = "Execute a command in a new split",
    bang = false
})
