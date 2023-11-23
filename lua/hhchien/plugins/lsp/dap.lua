local dap_status, dap = pcall(require, "dap")
if not dap_status then
  return
end



for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
   {
    type = "node2",
    request = "attach",
    name = "node attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector"
    -- skipFiles = { "<node_internals>/**", "node_modules/**" },
  },
  {
    type = "node2",
    request = "attach",
    name = "node attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector"
  }}
end

dap.adapters.node2 = {
  type = "executable",
  command = "node-debug2-adapter",
  args = {}
}


-- require('dap-vscode-js').setup({
--     debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
--     debugger_cmd = { 'js-debug-adapter' },
--     adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
-- })

-- Set keymaps to control the debugger
vim.keymap.set('n', '<C-d>c', require 'dap'.continue)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<C-d>b', require 'dap'.toggle_breakpoint)
vim.keymap.set('n', '<leader>B', function()
  require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
