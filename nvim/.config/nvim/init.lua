local config

if vim.env.NVIM_CONFIG then
    config = vim.env.NVIM_CONFIG
else
    config = "default"
end

require(config)
vim.notify("Using config: " .. config)
