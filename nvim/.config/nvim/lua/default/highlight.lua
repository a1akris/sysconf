-- TODO: Make semantic highlights work nice with the ayu color scheme
-- Hide all semantic highlights
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
end

vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#399ee6" })
