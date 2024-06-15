local status_ok, ayu = pcall(require, "ayu")

if not status_ok then
    vim.notify("ayu not found")
    return
end

local colors = require("ayu.colors")
colors.generate(false)

ayu.setup({
    mirage = false,
    overrides = {
        WinSeparator = { fg = colors.entity },
        TabLineFill  = { bg = colors.selection_bg },
        TabLineSel   = { bg = colors.accent, fg = colors.bg },
        TabLine      = { bg = colors.selection_inactive, fg = colors.text },
    }
})

vim.cmd.colorscheme("ayu")

-- TODO: Make semantic highlights work nice with the ayu color scheme
-- Hide all semantic highlights
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
end
