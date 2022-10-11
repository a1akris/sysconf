local fn = vim.fn

-- Bootstrap packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Verify that packer exists
local status_ok, packer = pcall(require, "packer")

if not status_ok then
  return
end

local packer_group = vim.api.nvim_create_augroup("PackerConfig", {
    clear = true,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group   = packer_group,
    pattern = "plugins.lua",
    command = "source <afile> | PackerSync",
    desc    = "Update/Install plugins on save"
})

-- Configure packer
packer.init {
  display = {
    non_interactive = false,
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    open_cmd = '65vnew \\[packer\\]',
    show_all_info = true,
    prompt_border = 'rounded'
  }
}

-- Install plugins
packer.startup(function(use)
  -- Base
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  -- Colorscheme
  use "Shatur/neovim-ayu"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"

  -- Auto completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Code highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'rust-lang/rust.vim'
  use 'ziglang/zig.vim'

  -- Search and navigation
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {'nvim-telescope/telescope-ui-select.nvim' }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Git integration
  use 'tpope/vim-fugitive'

  -- Misc
  use 'godlygeek/tabular'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
