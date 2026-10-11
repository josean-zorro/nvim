-- Keymaps are automatically loaded on the VeryLazy event
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local keymap = vim.keymap

-- LazyVim's tab maps live under <leader><tab>; drop them so <leader><Tab> toggles the explorer
for _, lhs in ipairs({ "l", "o", "f", "<tab>", "]", "d", "[" }) do
  pcall(keymap.del, "n", "<leader><tab>" .. lhs)
end

-- windows management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<cr>", { desc = "New tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<cr>", { desc = "Next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<cr>", { desc = "Previous tab" })

-- file explorer (snacks explorer replaces nvim-tree)
keymap.set("n", "<leader><Tab>", function() Snacks.explorer() end, { desc = "Toggle file explorer" })

-- finders (snacks picker replaces telescope; <leader>ff / <leader>fb are LazyVim defaults)
keymap.set("n", "<leader>fs", function() Snacks.picker.grep() end, { desc = "Grep (cwd)" })
keymap.set("n", "<leader>fc", function() Snacks.picker.grep_word() end, { desc = "Grep word under cursor" })
keymap.set("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "Help pages" })
