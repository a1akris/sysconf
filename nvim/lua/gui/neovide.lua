vim.g.neovide_refresh_rate = 60
vim.g.neovide_transparency = 1.0
vim.g.neovide_fullscreen = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_profiler = false
vim.g.neovide_input_use_logo = false
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_particle_density = 15.0
vim.g.neovide_cursor_vfx_particle_lifetime = 3.0

vim.g.gui_font_default_size = 8
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Fira Code Retina"

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function ()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({'n', 'i'}, "<C-+>", function() ResizeGuiFont(1)  end, opts)
vim.keymap.set({'n', 'i'}, "<C-->", function() ResizeGuiFont(-1) end, opts)
vim.keymap.set({'n', 'i'}, "<C-BS>", function() ResetGuiFont() end, opts)
