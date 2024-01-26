local status_ok, telescope = pcall(require, "telescope")

if not status_ok then
    vim.notify("telescope not found")
    return
end

local telescope_builtin = require('telescope.builtin')
local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }
-- Mappings to invoke telescope
keymap('n', '<C-p>', telescope_builtin.find_files, opts)
keymap('n', '<leader>h', telescope_builtin.oldfiles, opts)
keymap('n', '<leader>b', telescope_builtin.buffers, opts)
keymap('n', '<leader>f', telescope_builtin.live_grep, opts)
keymap('n', '<leader>l', telescope_builtin.quickfix, opts)
keymap('n', '<leader>d', telescope_builtin.diagnostics, opts)
keymap('n', '<leader>c', telescope_builtin.resume, opts)

-- Telescope window mappings
local custom_mappings = {
    i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<C-l>"] = require("telescope.actions").send_to_qflist,
    }
}

telescope.setup {
    path_display = { "smart" },

    defaults = {
        mappings = custom_mappings,
    },

    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
        ["ui-select"] = {
            codeactions = true,
        }
    }
}

telescope.load_extension('fzf')
telescope.load_extension('ui-select')
