-- Essentials
require "essentials"
require "default.autocommands"

-- Plugins
local plugins = require "plugins"
plugins.setup_all_except("treesitter", "ai")

-- Extras
require "gui.neovide"
