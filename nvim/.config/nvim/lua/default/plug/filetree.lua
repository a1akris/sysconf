local status_ok, nvim_tree = pcall(require, "nvim-tree")

if not status_ok then
    vim.notify("nvim-tree not found")
    return
end

nvim_tree.setup {
    auto_reload_on_write               = true,
    disable_netrw                      = true,
    hijack_cursor                      = false,
    hijack_netrw                       = true,
    hijack_unnamed_buffer_when_opening = false,
    open_on_tab                        = false,
    ignore_buf_on_tab_change           = {},
    sort_by                            = "name",
    root_dirs                          = {},
    prefer_startup_root                = false,
    sync_root_with_cwd                 = false,
    reload_on_bufenter                 = true,
    respect_buf_cwd                    = false,
    on_attach                          = "disable",
    select_prompts                     = true,
    view                               = {
        adaptive_size = true,
        centralize_selection = true,
        width = 30,
        side = 'left',
        preserve_window_proportions = true,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        float = {
            enable = false,
            open_win_config = {
                relative = "editor",
                border = "rounded",
                width = 30,
                height = 30,
                row = 1,
                col = 1,
            },
        },
    },
    renderer                           = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_width = 2,
        indent_markers = {
            enable = false,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                bookmark = "",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
    },
    hijack_directories                 = {
        enable = true,
        auto_open = true,
    },
    update_focused_file                = {
        enable      = false,
        update_cwd  = false,
        ignore_list = {}
    },
    system_open                        = {
        cmd = "",
        args = {},
    },
    diagnostics                        = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        }
    },
    filters                            = {
        dotfiles = false,
        custom = {},
        exclude = {},
    },
    filesystem_watchers                = {
        enable = true,
        debounce_delay = 50,
    },
    git                                = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        timeout = 400,
    },
    actions                            = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        expand_all = {
            max_folder_discovery = 300,
            exclude = {},
        },
        file_popup = {
            open_win_config = {
                col = 1,
                row = 1,
                relative = "cursor",
                border = "shadow",
                style = "minimal",
            },
        },
        open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
        remove_file = {
            close_window = true,
        },
    },
    trash                              = {
        cmd = "gio trash",
        require_confirm = true,
    },
    live_filter                        = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
    },
    log                                = {
        enable = false,
        truncate = false,
        types = {
            all = false,
            config = false,
            copy_paste = false,
            dev = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
        },
    },
}


local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Setup hot keys to open a tree
keymap('n', "<leader><Tab>", "<cmd>NvimTreeToggle<cr>", opts)
