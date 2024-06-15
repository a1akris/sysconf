require "essentials"

local p = require "minimal.plugins"

if p.setup() then
    require "plug.colorscheme"
    require "plug.filetree"
    require "plug.telescope"
    require "plug.lualine"
end
