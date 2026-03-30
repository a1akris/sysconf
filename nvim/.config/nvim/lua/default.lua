-- Essentials
require "essentials"
require "default.autocommands"

-- Plugins
local plugins = require "plugins"
plugins.setup_all_except("ai")

-- Extras
require "gui.neovide"
