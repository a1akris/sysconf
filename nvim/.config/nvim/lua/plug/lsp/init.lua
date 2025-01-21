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

local lsp_behavior = require("plug.lsp.behavior")

mason.setup()
mason_lspconfig.setup()
lsp_behavior.setup()

local rustacean_ok, _ = pcall(require, "rustaceanvim")

local ra_settings = {
    ["rust-analyzer"] = {
        diagnostics = {
            enable = false
        },
        cargo = {
            features = "all"
        },
        checkOnSave = false,
        hover = {
            actions = {
                references = {
                    enable = true,
                }
            }
        },
        imports = {
            granularity = {
                enforce = true,
            }
        },
        inlayHints = {
            lifetimeElisionHints = {
                enable = true,
            },
            expressionAdjustmentHints = {
                enable = true,
            },
            maxLength = "null",
        }
    }
}

if not rustacean_ok then
    vim.notify("Rust tools not found. Using raw rust-analyzer")
    lsp_config.rust_analyzer.setup {
        on_attach = lsp_behavior.on_attach_default,
        capabilities = lsp_behavior.capabilities,
        settings = ra_settings
    }
else
    vim.g.rustaceanvim = {
        server = {
            on_attach = function(client, bufnr)
                lsp_behavior.on_attach_default(client, bufnr)

                -- Rustacean's addons and overrides
                local opts = { noremap = true, silent = true, buffer = bufnr }
                local keymap = vim.keymap.set

                keymap("n", "g<Tab>", function() vim.cmd.RustLsp("codeAction") end, opts)
                keymap("n", "gE", function() vim.cmd.RustLsp("explainError") end, opts)
                keymap("n", "gh", function() vim.cmd.RustLsp("renderDiagnostic") end, opts)
            end,
            capabilities = lsp_behavior.capabilities,
            settings = ra_settings
        },
        dap = {
            autoload_configurations = true
        }
    }
end

lsp_config.lua_ls.setup {
    on_attach = lsp_behavior.on_attach_default,
    capabilities = lsp_behavior.capabilities,
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            }
        }
    }
}

lsp_config.gdscript.setup {
    on_attach = lsp_behavior.on_attach_default,
    capabilities = lsp_behavior.capabilities,
    settings = {}
}
