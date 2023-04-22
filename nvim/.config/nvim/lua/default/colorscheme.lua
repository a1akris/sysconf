local status_ok, ayu = pcall(require, "ayu")

if not status_ok then
    vim.notify("ayu not found")
    return
end

ayu.setup({
    mirage = false,
    overrides = {}
})

vim.cmd.colorscheme("ayu")
