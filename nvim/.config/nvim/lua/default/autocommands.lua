local utils = require "essentials.utils"

local user_utils_group = vim.api.nvim_create_augroup("user_utils", {
    clear = true,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = user_utils_group,
    pattern = "*",
    callback = utils.trim_trailing_whitespaces,
    desc = "Trim trailing whitespaces on save"
})
