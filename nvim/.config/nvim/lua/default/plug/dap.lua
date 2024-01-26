local dap_ok, dap = pcall(require, "dap")

if not dap_ok then
    vim.notify("dap is not installed")
    return
end

-- DAP Config


local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'ErrorMsg', linehl = '', numhl = '' })

keymap('n', '<Leader>?', function() dap.toggle_breakpoint() end, opts)
keymap('n', '<Down>', function() dap.step_into() end, opts)
keymap('n', '<Up>', function() dap.step_out() end, opts)
keymap('n', '<Right>', function() dap.step_over() end, opts)
keymap('n', '<Left>', function() dap.step_back() end, opts)
keymap('n', '<C-Right>', function() dap.continue() end, opts)
keymap('n', '<C-Left>', function() dap.restart() end, opts)


-- DAP UI Config

local dapui_ok, dapui = pcall(require, "dapui")

if not dapui_ok then
    vim.notify("dapui not found")
    return
end

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end
