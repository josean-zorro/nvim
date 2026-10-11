-- blink.cmp (LazyVim default) replaces nvim-cmp, cmp-*, LuaSnip, cmp_luasnip and lspkind
return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    },
    -- like the old `confirm({ select = false })`: <CR> only accepts an explicitly selected item
    completion = { list = { selection = { preselect = false } } },
  },
}
