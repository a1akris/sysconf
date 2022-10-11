local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify("Treesitter not found")
    return
end

configs.setup {
    ensure_installed = { "lua", "rust", "bash", "python" },
    sync_install = false,
    auto_install = true,
    ignore_install = { "" },
    highlight = {
        enable = true,
        disable = { "rust" },
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true }
}
