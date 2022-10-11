local M = {}

local lsp_behavior_group = vim.api.nvim_create_augroup("LspBehavior", {
    clear = true,
})

local function lsp_highlight_document(client, bufnr)
    if client.server_capabilities.document_highlight then
        vim.api.nvim_create_autocmd("CursorHold", {
            group = lsp_behavior_group,
            callback = function() vim.lsp.buf.document_highlight() end,
            desc = "LSP document highlight",
            buffer = bufnr,
        })

        vim.api.nvim_create_autocmd("CursorMoved", {
            group = lsp_behavior_group,
            callback = function() vim.lsp.buf.clear_references() end,
            desc = "LSP clear references",
            buffer = bufnr,
        })
    end
end

local function lsp_format_on_save(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lsp_behavior_group,
            callback = function() vim.lsp.buf.format() end,
            desc = "LSP format on save",
            buffer = bufnr,
        })
    end
end

local function lsp_keymaps(client, bufnr)
    -- May be used in the future for mappings based on
    -- server/client capabilities
    local _ = client
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local keymap = vim.keymap.set

    local telescope_loaded, telescope = pcall(require, "telescope.builtin")

    if telescope_loaded then
        keymap("n", "gd", telescope.lsp_definitions, opts)
        keymap("n", "gD", telescope.lsp_type_definitions, opts)
        keymap("n", "gi", telescope.lsp_implementations, opts)
        keymap("n", "g&", telescope.lsp_references, opts)
    else
        keymap("n", "gd", vim.lsp.buf.definition, opts)
        keymap("n", "gD", vim.lsp.buf.declaration, opts)
        keymap("n", "gi", vim.lsp.buf.implementation, opts)
        keymap("n", "g&", vim.lsp.buf.references, opts)
    end

    keymap("n", "g?", vim.lsp.buf.hover, opts)
    keymap("n", "ge", vim.diagnostic.open_float, opts)
    keymap("n", "gh", vim.lsp.buf.signature_help, opts)
    keymap("n", "gr", vim.lsp.buf.rename, opts)
    keymap("n", "g<Tab>", vim.lsp.buf.code_action, opts)

    keymap("n", "[d", vim.diagnostic.goto_prev, opts)
    keymap("n", "]d", vim.diagnostic.goto_next, opts)
    keymap("n", "gf", vim.diagnostic.setloclist, opts)

    -- Enable completion triggered by omnifunc
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
end

function M.setup()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

function M.on_attach_default(client, bufnr)
    lsp_keymaps(client, bufnr)
    lsp_highlight_document(client, bufnr)
    lsp_format_on_save(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return M
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
return M
