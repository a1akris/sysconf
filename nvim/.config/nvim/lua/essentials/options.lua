local options = {
    autoindent     = true,
    backup         = false,
    clipboard      = "unnamedplus",
    completeopt    = { 'longest', 'menu' },
    cursorline     = true,
    encoding       = "utf-8",
    expandtab      = true,
    fileencoding   = "utf-8",
    hlsearch       = true,
    incsearch      = true,
    ignorecase     = true,
    linebreak      = true,
    list           = false,
    listchars      = "space:_,multispace:___*,tab:<->,trail:!,eol:$",
    mouse          = "a",
    number         = true,
    numberwidth    = 4,
    preserveindent = true,
    rnu            = true,
    scrollback     = 100000,
    scrolloff      = 8,
    shiftwidth     = 4,
    showmatch      = true,
    showmode       = false,
    sidescrolloff  = 8,
    smartcase      = true,
    smartindent    = true,
    smarttab       = true,
    splitbelow     = false,
    splitright     = true,
    softtabstop    = 4,
    swapfile       = false,
    tabstop        = 4,
    termguicolors  = true,
    undofile       = true,
    undolevels     = 1000,
    updatetime     = 300,
    wrap           = true,
    writebackup    = false,
}

-- Disable netrw
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

for k, v in pairs(options) do
    vim.opt[k] = v
end
