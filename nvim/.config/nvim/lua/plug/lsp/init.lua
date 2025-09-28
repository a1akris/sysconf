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

local lsp_behavior = require("plug.lsp.behavior")

lsp_behavior.setup()

local rustacean_ok, _ = pcall(require, "rustaceanvim")

local ra_settings = {
    ["rust-analyzer"] = {
        diagnostics = {
            enable = true
        },
        cargo = {
            features = "all"
        },
        checkOnSave = true,
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
            }
            -- maxLength = ,
        }
    }
}

vim.lsp.config('*', {
    on_attach = lsp_behavior.on_attach_default,
    capabilities = lsp_behavior.capabilities,
})

if not rustacean_ok then
    vim.notify("Rust tools not found. Using raw rust-analyzer")
    vim.lsp.config("rust_analyzer", {
        on_attach = lsp_behavior.on_attach_default,
        capabilities = lsp_behavior.capabilities,
        settings = ra_settings
    })
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
                keymap("n", "gh", function() vim.cmd.RustLsp({ "renderDiagnostic", "current" }) end, opts)
            end,
            capabilities = lsp_behavior.capabilities,
            settings = ra_settings
        },
        dap = {
            autoload_configurations = true
        }
    }
end

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            }
        }
    }
})

mason.setup()

if rustacean_ok then
    mason_lspconfig.setup({
        automatic_enable = {
            exclude = { "rust_analyzer" }
        }
    })
else
    mason_lspconfig.setup()
end
