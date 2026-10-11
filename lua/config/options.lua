-- Options are automatically loaded before lazy.nvim startup
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- (number, tabstop/shiftwidth=2, expandtab, nowrap, ignorecase/smartcase, cursorline,
--  splitright/splitbelow are already LazyVim defaults)
local opt = vim.opt

opt.relativenumber = false -- keep plain line numbers like the old config
opt.clipboard = "unnamedplus" -- always use system clipboard (LazyVim skips this over SSH)
opt.iskeyword:append("-")

vim.lsp.log.set_level("off") -- reduce LSP logging
