-- conform.nvim + nvim-lint (LazyVim defaults) replace none-ls and mason-null-ls.
-- Format on save is on by default (toggle with <leader>uf).
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "standardjs", "sqlfluff", "black", "isort", "flake8" },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      default_format_opts = { timeout_ms = 60000 },
      formatters_by_ft = {
        javascript = { "standardjs" },
        javascriptreact = { "standardjs" },
        typescript = { "standardjs" },
        typescriptreact = { "standardjs" },
        sql = { "sqlfluff" },
        python = { "isort", "black" },
      },
      formatters = {
        sqlfluff = {
          args = function(_, ctx)
            -- --stdin-filename lets sqlfluff find the nearest .sqlfluff config for this file
            local args = { "fix", "--FIX-EVEN-UNPARSABLE", "--stdin-filename", ctx.filename }
            -- no project config → fall back to a default dialect instead of erroring
            local has_config = vim.fs.find(function(name, path)
              if name == ".sqlfluff" then
                return true
              end
              if name == "setup.cfg" or name == "tox.ini" or name == "pyproject.toml" then
                return table.concat(vim.fn.readfile(path .. "/" .. name), "\n"):find("sqlfluff") ~= nil
              end
              return false
            end, { upward = true, path = vim.fs.dirname(ctx.filename), limit = 1 })[1]
            if not has_config then
              vim.list_extend(args, { "--dialect", "bigquery" })
            end
            table.insert(args, "-")
            return args
          end,
          cwd = function(_, ctx)
            return vim.fs.dirname(ctx.filename)
          end,
          require_cwd = false,
        },
        isort = { prepend_args = { "--profile", "black" } },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "standardjs" },
        javascriptreact = { "standardjs" },
        typescript = { "standardjs" },
        typescriptreact = { "standardjs" },
        python = { "flake8" },
      },
    },
  },
}
