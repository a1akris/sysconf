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

local rust_tools_ok, rt = pcall(require, "rust-tools")

local ra_settings = {
    ["rust-analyzer"] = {
        diagnostics = {
            enable = false
        },
        cargo = {
            features = "all"
        },
        checkOnSave = true,
        check = {
            command = "clippy",
            extraArgs = { "--", "-Aclippy::pedantic" },
        },
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

if not rust_tools_ok then
    vim.notify("Rust tools not found. Using raw rust-analyzer")
    lsp_config.rust_analyzer.setup {
        on_attach = lsp_behavior.on_attach_default,
        capabilities = lsp_behavior.capabilities,
        settings = ra_settings
    }
else
    rt.setup({
        server = {
            on_attach = function(client, bufnr)
                lsp_behavior.on_attach_default(client, bufnr)

                -- Rust tools additional actions and features
                rt.inlay_hints.enable()
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "g<space>", rt.runnables.runnables, opts)
                vim.keymap.set("n", "gm", rt.expand_macro.expand_macro, opts)
            end,
            capabilities = lsp_behavior.capabilities,
            settings = ra_settings
        }
    })
end

lsp_config.lua_ls.setup {
    on_attach = lsp_behavior.on_attach_default,
    capabilities = lsp_behavior.capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
}
