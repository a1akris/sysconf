local status_ok, telescope = pcall(require, "telescope")

if not status_ok then
    vim.notify("telescope not found")
    return
end

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- Mappings to invoke telescope
keymap('n', "<C-p>", ":Telescope find_files<cr>", opts)
keymap('n', "<leader>h", ":Telescope oldfiles<cr>", opts)
keymap('n', "<leader>b", ":Telescope buffers<cr>", opts)
keymap('n', "<leader>f", ":Telescope live_grep<cr>", opts)
keymap('n', "<leader>l", ":Telescope quickfix<cr>", opts)

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
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        },

        ["ui-select"] = {
            codeactions = true,
        }
    }
}

telescope.load_extension('fzf')
telescope.load_extension('ui-select')
