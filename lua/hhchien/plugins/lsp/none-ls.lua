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
-- Custom handler for sqlfluff diagnostics
--local function handle_sqlfluff_diagnostics(params)
--for _, diagnostic in ipairs(params.output) do
--	print(vim.inspect(_), vim.inspect(diagnostic))
--end

--return params.output
--end

-- configure null_ls
null_ls.setup({
	default_timeout = 60000, -- 60 seconds global timeout
	flags = {
		debounce_text_changes = 150,
		allow_incremental_sync = true,
	},
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
		formatting.standardjs, --js/ts formatter
		diagnostics.standardjs, -- js/ts linter
		formatting.stylua, -- lua formatter
		formatting.sqlfluff.with({
			extra_args = { "--FIX-EVEN-UNPARSABLE" },
			cwd = function(params)
				-- Use the file's directory as the working directory so .sqlfluff config is found
				return vim.fn.fnamemodify(params.bufname, ":h")
			end,
			timeout = 30000, -- 30 seconds timeout for large SQL files
		}),
		--diagnostics.sqlfluff.with({ --sql linter
		--extra_args = { "--dialect", "sparksql" },
		--cwd = function()
		--return vim.fn.fnamemodify(vim.fn.findfile(".git", vim.fn.getcwd() .. ";"), ":p:h")
		--end,
		--}),
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
						timeout_ms = 60000, -- 60 seconds timeout for format
					})
				end,
			})
		end
	end,
})
