local M = {}
M.addons = {}

-- Colorscheme
M.addons["colorscheme"] = {
    lazy_plugins = {
        {
            "Shatur/neovim-ayu",
            lazy = false,
            priority = 1000,
        },
    },
    configuration = "plug.colorscheme"
}

-- Misc
M.addons["misc"] = {
    lazy_plugins = {
        {
            "godlygeek/tabular",
            cmd = "Tab"
        },
    }
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
            cmd = "Git"
        }
    }
}

-- LSP
M.addons["LSP"] = {
    lazy_plugins = {
        -- LSP
        "neovim/nvim-lspconfig",
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
    },
    configuration = "plug.dap"
}

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

function M.setup_all_except(...)
    -- Verify that lazy exists
    local status_ok, lazy = init_lazy()

    if not status_ok then
        vim.notify("Failed to setup a plugin manager. Time to live without plugins!")
        return status_ok
    end

    local exclude_list = { ... }
    local exclude_filter = {}

    for _, v in ipairs(exclude_list) do
        exclude_filter[v] = true
    end

    local plugins = {}
    local configurations = {}

    for k, v in pairs(M.addons) do
        if not exclude_filter[k] then
            for _, plug in ipairs(v.lazy_plugins) do
                table.insert(plugins, plug)
            end

            if v.configuration then
                table.insert(configurations, v.configuration)
            end
        end
    end

    lazy.setup(plugins)

    for _, cfg in ipairs(configurations) do
        local cfg_ok, _ = pcall(require, cfg)

        if not cfg_ok then
            vim.error("Failed to import " .. cfg)
            return cfg_ok
        end
    end

    return status_ok
end

function M.setup_all()
    M.setup_all_except()
end

function M.setup(...)
    -- Verify that lazy exists
    local status_ok, lazy = init_lazy()

    if not status_ok then
        vim.notify("Failed to setup a plugin manager. Time to live without plugins!")
        return status_ok
    end

    local categories_filter = { ... }
    local plugins = {}
    local configurations = {}

    for _, f in ipairs(categories_filter) do
        if M.addons[f] then
            for _, plug in ipairs(M.addons[f].lazy_plugins) do
                table.insert(plugins, plug)
            end

            if M.addons[f].configuration then
                table.insert(configurations, M.addons[f].configuration)
            end
        end
    end

    lazy.setup({ spec = plugins })

    for _, cfg in ipairs(configurations) do
        local cfg_ok, _ = pcall(require, cfg)

        if not cfg_ok then
            vim.notify("Failed to import " .. cfg)
            return cfg_ok
        end
    end

    return status_ok
end

return M
