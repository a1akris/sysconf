local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    vim.notify("LSP: mason is not installed")
    return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
    vim.notify("LSP: mason-lspconfig is not installed")
    return
end

local lspconfig_ok, lsp_config = pcall(require, "lspconfig")
if not lspconfig_ok then
    vim.notify("LSP: lspconfig not found")
    return
end

local lsp_behavior = require("default.plug.lsp.behavior")

mason.setup()
mason_lspconfig.setup()
lsp_behavior.setup()

for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
    -- Use server == "<SERVER_NAME>" to alter configuration of the particular
    -- server
    local settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }

    lsp_config[server].setup {
        on_attach = lsp_behavior.on_attach_default,
        capabilities = lsp_behavior.capabilities,
        settings = settings,
    }
end
