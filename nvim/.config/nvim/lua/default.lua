-- Essentials
require "essentials"

-- Almost always useful
require "default.autocommands"

-- Plugins
local p = require "default.plugins"

if p.setup() then
    require "plug.cmp"
    require "plug.colorscheme"
    require "plug.dap"
    require "plug.filetree"
    require "plug.lsp"
    require "plug.lualine"
    require "plug.telescope"
else
    vim.error("Failed to setup plugins!")
end

-- Extras
require "gui.neovide"
