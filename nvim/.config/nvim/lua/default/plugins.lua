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
        -- LSP
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate"
        },
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
        },
        {
            "Bilal2453/luvit-meta",
            lazy = true
        }, -- optional `vim.uv` typings
        {
            "mrcjkb/rustaceanvim",
            version = '^4', -- Recommended
            lazy = false,
        },
        "rust-lang/rust.vim",
        -- Auto completion
        {
            "hrsh7th/nvim-cmp",
            -- Autocompletion source for lua modules/requires etc
            opts = function(_, opts)
                opts.sources = opts.sources or {}
                table.insert(opts.sources, {
                    name = "lazydev",
                    group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                })
            end,
        },
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        {
            "saadparwaiz1/cmp_luasnip",
            dependencies = "L3MON4D3/LuaSnip",
        },
        -- Code highlighting
        -- {
        --     "nvim-treesitter/nvim-treesitter",
        --     build = ':TSUpdate',
        -- },
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
        -- Debugging
        "mfussenegger/nvim-dap",
        {
            "mfussenegger/nvim-dap-ui",
            dependencies = {
                "mfussenegger/nvim-dap"
            },
            commit = "34160a7ce6072ef332f350ae1d4a6a501daf0159"
        },
        {
            "nvim-telescope/telescope-dap.nvim",
            dependencies = {
                "mfussenegger/nvim-dap",
                "nvim-telescope/telescope.nvim",
            }
        },
        {
            "theHamsta/nvim-dap-virtual-text",
            dependencies = {
                "mfussenegger/nvim-dap",
            }
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
