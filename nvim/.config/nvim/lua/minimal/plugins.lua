local M = {}

function M.setup()
    local utils = require "essentials.utils"
    -- Verify that lazy exists
    local status_ok, lazy = utils.init_lazy()

    if not status_ok then
        vim.notify("Failed to setup a plugin manager. Time to live without plugins!")
        return status_ok
    end

    lazy.setup({
        -- Colorscheme
        {
            "Shatur/neovim-ayu",
            lazy = false,
            priority = 1000,
        },
        -- Base
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        -- Search and navigation
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-fzf-native.nvim",
                "nvim-telescope/telescope-ui-select.nvim",
            }
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = 'make'
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
        {
            "kyazdani42/nvim-tree.lua",
            dependencies = {
                "kyazdani42/nvim-web-devicons", -- optional, for file icon
            },
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "kyazdani42/nvim-web-devicons" }
        },
        -- Git integration
        {
            "tpope/vim-fugitive",
            cmd = "Git"
        },
        -- Misc
        {
            "godlygeek/tabular",
            cmd = "Tab"
        },
    })

    return status_ok
end

return M
