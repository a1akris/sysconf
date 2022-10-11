local status_ok, nvim_tree = pcall(require, "nvim-tree")

if not status_ok then
    vim.notify("nvim-tree not found")
    return
end

nvim_tree.setup {
  auto_reload_on_write               = true,
  create_in_closed_folder            = false,
  disable_netrw                      = true,
  hijack_cursor                      = false,
  hijack_netrw                       = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup             = false,
  open_on_setup                      = false,
  open_on_setup_file                 = false,
  open_on_tab                        = false,
  sort_by                            = "name",
  update_cwd                         = true,
  reload_on_bufenter                 = true,
  respect_buf_cwd                    = false,
  update_to_buf_dir = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd  = "",
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  },
  actions = {
    change_dir = {
      global = false,
    },
    open_file = {
      quit_on_open = false,
    }
  }
}


local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Setup hot keys to open a tree
keymap('n', "<leader><Tab>", "<cmd>NvimTreeToggle<cr>", opts)
