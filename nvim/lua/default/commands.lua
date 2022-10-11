local status_ok, utils = pcall(require, "default.utils")

if not status_ok then
    print("Default utils not found")
    return
end

local user_utils_group = vim.api.nvim_create_augroup("user_utils", {
    clear = true,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = user_utils_group,
    pattern = "*",
    callback = utils.trim_trailing_whitespaces,
    desc = "Trim trailing whitespaces on save"
})
