-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- customize sqlfluff diagnositics handler
local function handle_sqlfluff_diagnostics(params)
	local sqlfluff_diagnostics = {}
	for _, sqlfluff_diagnostic in ipairs(params.output) do
		-- Extract necessary information
		local row = sqlfluff_diagnostic.start_line
		local col = sqlfluff_diagnostic.start_column
		local end_row = sqlfluff_diagnostic.end_line
		local end_col = sqlfluff_diagnostic.end_column
		local message = sqlfluff_diagnostic.message

		-- Construct the diagnostic object
		table.insert(sqlfluff_diagnostics, {
			row = row,
			col = col,
			end_row = end_row,
			end_col = end_col,
			source = "sqlfluff",
			message = message,
			severity = vim.lsp.protocol.DiagnosticSeverity.Warning,
		})
	end
	return sqlfluff_diagnostics
end
-- Custom handler for sqlfluff diagnostics
--local function handle_sqlfluff_diagnostics(params)
--	for _, diagnostic in ipairs(params.output) do
--		print(vim.inspect(diagnostic))
--	end

--	return params.output
--end

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
		formatting.standardjs, --js/ts formatter
		diagnostics.standardjs, -- js/ts linter
		formatting.stylua, -- lua formatter
		formatting.sqlfmt.with({ --sql formatter
			command = { "sqlfmt" },
		}),
		diagnostics.sqlfluff.with({ --sql linter
			extra_args = { "--dialect", "postgres" },
			on_output = handle_sqlfluff_diagnostics,
			cwd = function()
				return vim.fn.fnamemodify(vim.fn.findfile("dbt_project.yml", vim.fn.getcwd() .. ";"), ":p:h")
			end,
		}),
		formatting.black, --python formatter
		formatting.isort.with({ extra_args = { "--profile", "black" } }),
		diagnostics.flake8,

		--diagnostics.eslint_d.with({ -- js/ts linter
		-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
		--  condition = function(utils)
		--    return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
		--  end,
		--}),
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
