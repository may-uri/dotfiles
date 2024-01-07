-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
vim.g.syntastic_javascript_checkers = { "eslint" }
vim.g.syntastic_javascript_eslint_exec = "eslint_d"
vim.o.timeoutlen = 900
-- folding
vim.opt.foldlevelstart = 20
vim.opt.foldlevel = 20
-- use wider line for folding
-- vim.opt.fillchars = { fold = "⏤" }
-- vim.opt.foldtext = "antonk52#fold#it()"
-- Automatically add 'use strict' to the first line of new JavaScript files
vim.cmd([[
  augroup add_use_strict
    autocmd!
    autocmd BufNewFile *.js silent! 0r !echo "\"use strict\""
  augroup END
]])
-- Automatically add '<!-- prettier-ignore --> ' to the first line of new html files
vim.api.nvim_exec(
	[[
  augroup add_prettier_ignore
    autocmd!
    autocmd BufNewFile *.html call append(0, "<!-- prettier-ignore -->")
  augroup END
]],
	false
)

-- format on save
vim.cmd([[
  augroup FormatOnSave
    autocmd!
    autocmd BufWritePre *.css,*.html,*.py,*.lua,*.js lua vim.lsp.buf.format({ async = true })
  augroup end
]])
-- zen mode
vim.cmd("autocmd VimEnter * lua Zen()")
-- make doctype uppercase
-- vim.api.nvim_exec(
-- 	[[
-- augroup doctype_autocmd
--   autocmd!
--   autocmd BufWritePre *.html silent! %s/<!doctype html>/<!DOCTYPE html>/
-- augroup END
-- ]],
-- 	false
-- )
vim.highlight.priorities.semantic_tokens = 95
-- Set transparency for the status line
vim.cmd([[ hi StatusLine   guibg=NONE ctermbg=NONE ]])
vim.cmd([[ hi StatusLineNC guibg=NONE ctermbg=NONE ]])

-- Set transparency for the active and inactive status line
vim.cmd([[ hi StatusLineNC   guibg=NONE ctermbg=NONE ]])

-- Set transparency for the active and inactive status line
vim.cmd([[ hi StatusLineNC   guibg=NONE ctermbg=NONE ]])

vim.api.nvim_exec(
	[[
  augroup MarkdownConceal
    autocmd!
    autocmd BufRead *.md setlocal conceallevel=2
  augroup END
]],
	false
)
vim.cmd([[
  au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]])

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		if vim.fn.argv(0) == "" then
-- 			require("telescope.builtin").oldfiles()
-- 		end
-- 	end,
-- })
--
