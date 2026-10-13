-- mason / mason-lspconfig / nvim-lspconfig are configured by LazyVim.
-- lua_ls comes from LazyVim, ts_ls is replaced by vtsls via the typescript extra.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
        cssls = {},
        pylsp = {},
        emmet_ls = {
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        },
        sqlls = {
          -- root of sql files is the directory where dbt_project.yml is located
          enabled = false,
          --root_dir = function(bufnr, on_dir)
          --  on_dir(vim.fs.root(bufnr, { "dbt_project.yml" }) or vim.uv.cwd())
          --end,
          --on_attach = function(client, bufnr)
          -- disable sqlls diagnostics inside dbt projects
          -- if vim.fs.root(bufnr, { "dbt_project.yml" }) then
          --   client.handlers["textDocument/publishDiagnostics"] = function() end
          -- end
          --end,
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "sql", "html", "css" } },
  },
}
