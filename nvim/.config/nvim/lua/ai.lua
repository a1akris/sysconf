require "essentials"
require "default.autocommands"

local p = require "plugins"
p.setup_all_except("treesitter")

-- Extras
require "gui.neovide"
