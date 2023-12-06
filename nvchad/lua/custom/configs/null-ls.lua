local null_ls = require("null-ls")

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
	-- b.formatting.clang_format,
}

null_ls.setup({
	debug = false,
	sources = sources,
})
