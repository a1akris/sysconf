local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal - 'n'
--   insert - 'i'
--   visual - 'v'
--   visual block - 'x'
--   term - 't'
--   command - 't'

-- Split switching
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

-- Tab switching
keymap("n", "<Tab>", "gt", opts)
keymap("n", "<S-Tab>", "gT", opts)

-- Buf switching
keymap("n", "<leader>[", ":bprev!<cr>", opts)
keymap("n", "<leader>]", ":bnext!<cr>", opts)
keymap("n", "<leader><leader>", "<C-^>", opts)
keymap("n", "<leader>w", ":bn<bar>:sp<bar>:bp<bar>:bd<cr>", opts)
keymap("n", "<leader>q", ":bd!<cr>", opts)

-- Scrolling
keymap("n", "J", "<C-d>", opts)
keymap("n", "K", "<C-u>", opts)

-- Edits
keymap("i", ";j", "<esc>", opts)
keymap("i", "{<cr>", "{<cr>}<C-o>O", opts)
keymap("n", "<leader>o", "o<esc>", opts)
keymap("n", "<leader>O", "O<esc>", opts)
keymap("n", "<leader>j", "J", opts)

-- Terminal keys
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
keymap("t", ";j", "<C-\\><C-n>", opts)

-- File ops
keymap("n", "<leader>s", ":w<cr>", opts)

-- Move text
keymap("v", "J", ":m '>+1<cr>gv=gv", opts)
keymap("v", "K", ":m '<-2<cr>gv=gv", opts)

keymap("x", "J", ":m '>+1<cr>gv=gv", opts)
keymap("x", "K", ":m '<-2<cr>gv=gv", opts)

-- Highlight fix
keymap("n", "n", "n:set hlsearch<cr>", opts)
keymap("n", "N", "N:set hlsearch<cr>", opts)

local fix_group = vim.api.nvim_create_augroup("small_fixes", {
    clear = true,
})

vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
    group = fix_group,
    pattern = "*",
    command = "set nohlsearch",
    desc = "Disable highlight on cursor move",
})
