-- Essentials
require "essentials"

-- Almost always useful
require "default.autocommands"

-- Plugins
local plugins = require "plugins"
plugins.setup_all_except("treesitter")

-- Extras
require "gui.neovide"
