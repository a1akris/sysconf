local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("lspconfig not found")
  return
end

vim.cmd "let g:rustfmt_autosave = 1"
require("default.plug.lsp.lsp-installer")
require("default.plug.lsp.handlers").setup()
