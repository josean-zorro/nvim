-- nvim-dap, nvim-dap-ui and mason-nvim-dap come from the dap.core extra;
-- js/ts debugging (pwa-node via js-debug-adapter) comes from the typescript extra.
-- LazyVim maps everything under <leader>d; these are the old shortcuts kept on top.
return {
  "mfussenegger/nvim-dap",
  keys = {
    { "<C-d>c", function() require("dap").continue() end, desc = "Debug: Continue" },
    { "<C-d>b", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
    { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
    { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
    { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
    {
      "<leader>B",
      function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
      desc = "Debug: Conditional Breakpoint",
    },
  },
}
