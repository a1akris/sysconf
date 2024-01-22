local dap_ok, dap = pcall(require, "dap")

if not dap_ok then
    vim.notify("dap is not installed")
    return
end

-- DAP Config


vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'ErrorMsg', linehl = '', numhl = '' })
vim.keymap.set('n', '<Leader>?', function() dap.toggle_breakpoint() end, {
    noremap = true,
    silent = true
})

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
