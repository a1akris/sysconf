local ensure_lazy = function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)
end

ensure_lazy()

-- Verify that lazy exists
local status_ok, lazy = pcall(require, "lazy")

if not status_ok then
    vim.notify("Failed to setup a plugin manager. Time to live without plugins")
    return
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
        "folke/neodev.nvim",
        opts = {}
    },
    {
        "mrcjkb/rustaceanvim",
        version = '^3', -- Recommended
        ft = { 'rust' },
    },
    "rust-lang/rust.vim",
    -- Auto completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    -- {
    --     "saadparwaiz1/cmp_luasnip",
    --     dependencies = "L3MON4D3/LuaSnip",
    -- },
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
