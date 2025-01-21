local options_override = {
    expandtab = false,
    list = true,
}


for k, v in pairs(options_override) do
    vim.opt[k] = v
end
