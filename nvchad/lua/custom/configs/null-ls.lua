local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local b = null_ls.builtins

local sources = {

	-- webdev stuff
	-- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
	-- b.formatting.cbfmt.with({ filetypes = { "markdown" } }),
	b.formatting.prettierd.with({ filetypes = { "html", "markdown", "css", "javascript" } }), -- so prettier works only on these filetypes
	-- b.formatting.htmlbeautifier.with({ filetypes = { "html" } }), -- for no warnings in w3 validator
	b.diagnostics.eslint_d,
	-- Lua
	b.formatting.stylua,
	-- Python
	b.formatting.autopep8.with({ filetypes = { "python" } }),
	-- cpp
	b.formatting.clang_format.with({ filetypes = { "c" } }),
	b.formatting.gofmt.with({ filetypes = { "go" } }),
}

null_ls.setup({
	debug = false,
	sources = sources,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = true })
				end,
			})
		end
	end,
})
