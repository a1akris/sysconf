local M = {}
M.addons = {}

-- Colorscheme
M.addons["colorscheme"] = {
    lazy_plugins = {
        {
            "a1akris/neovim-ayu",
            lazy = false,
            priority = 1000,
        },
    },
    configuration = "plug.colorscheme"
}

M.addons["misc"] = {
    lazy_plugins = {
        {
            "zk-org/zk-nvim",
        },
        {
            "godlygeek/tabular",
            cmd = "Tab",
            lazy = false,
        },
        {
            "terrastruct/d2-vim"
        }
    },
    configuration = "plug.misc"
}

-- Base
M.addons["base"] = {
    lazy_plugins = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
    }
}

-- Git
M.addons["git"] = {
    lazy_plugins = {
        {
            "tpope/vim-fugitive",
            cmd = "Git",
            lazy = false
        }
    }
}

-- LSP
M.addons["LSP"] = {
    lazy_plugins = {
        -- LSP
        {
            "neovim/nvim-lspconfig",
            config = false
        },
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate"
        },
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
        -- optional `vim.uv` typings
        {
            "Bilal2453/luvit-meta",
            lazy = true
        },
        {
            "mrcjkb/rustaceanvim",
            version = '^6', -- Recommended
            lazy = false,
        },
        "rust-lang/rust.vim",
    },
    configuration = "plug.lsp"
}

-- Autocompletion
M.addons["autocompletion"] = {
    lazy_plugins = {
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
    },
    configuration = "plug.cmp"
}

-- Treesitter highlighting
M.addons["treesitter"] = {
    lazy_plugins = {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ':TSUpdate',
        },
    }
}

-- Telescope
M.addons["telescope"] = {
    lazy_plugins = {
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
    },
    configuration = "plug.telescope"
}

-- Filetree
M.addons["filetree"] = {
    lazy_plugins = {
        {
            "kyazdani42/nvim-tree.lua",
            dependencies = {
                "kyazdani42/nvim-web-devicons", -- optional, for file icon
            },
        },
    },
    configuration = "plug.filetree"
}

-- Statusline
M.addons["statusline"] = {
    lazy_plugins = {
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "kyazdani42/nvim-web-devicons" }
        },
    },
    configuration = "plug.lualine"
}

-- Debugging
M.addons["debug"] = {
    lazy_plugins = {
        "mfussenegger/nvim-dap",
        {
            "rcarriga/nvim-dap-ui",
            dependencies = {
                "mfussenegger/nvim-dap",
                "nvim-neotest/nvim-nio",
            },
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
    },
    configuration = "plug.dap"
}

-- #### SET UP IMPLEMENTATION ####

local init_lazy = function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
    return pcall(require, "lazy")
end


local include_filter = function(include_list)
    return function()
        for _, f in ipairs(include_list) do
            if M.addons[f] then
                for _, plug in ipairs(M.addons[f].lazy_plugins) do
                    table.insert(M.plugins, plug)
                end

                if M.addons[f].configuration then
                    table.insert(M.configurations, M.addons[f].configuration)
                end
            end
        end
    end
end


local exclude_filter = function(exclude_list)
    return function()
        local exclude_filter = {}

        for _, v in ipairs(exclude_list) do
            exclude_filter[v] = true
        end

        for k, v in pairs(M.addons) do
            if not exclude_filter[k] then
                for _, plug in ipairs(v.lazy_plugins) do
                    table.insert(M.plugins, plug)
                end

                if v.configuration then
                    table.insert(M.configurations, v.configuration)
                end
            end
        end
    end
end

local generic_setup = function(filter_fn)
    -- Verify that lazy exists
    local status_ok, lazy = init_lazy()

    if not status_ok then
        vim.notify("Failed to setup a plugin manager. Time to live without plugins!", vim.log.levels.ERROR)
        return status_ok
    end

    M.plugins = {}
    M.configurations = {}
    filter_fn()

    lazy.setup({ spec = M.plugins })

    for _, cfg in ipairs(M.configurations) do
        local cfg_ok, err = pcall(require, cfg)

        if not cfg_ok then
            vim.notify("Failed to import " .. cfg .. ": " .. err, vim.log.levels.WARN)
        end
    end

    return status_ok
end

function M.setup_all_except(...)
    local excluded_categories = { ... }
    return generic_setup(exclude_filter(excluded_categories))
end

function M.setup_all()
    M.setup_all_except()
end

function M.setup(...)
    local included_categories = { ... }
    return generic_setup(include_filter(included_categories))
end

return M
