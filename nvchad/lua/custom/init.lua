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
vim.opt.fillchars = { fold = "⏤" }

-- format on save
-- vim.cmd([[
--   augroup FormatOnSave
--     autocmd!
--     autocmd BufWritePre *.css,*.html,*.py,*.lua,*.js, *.c, lua vim.lsp.buf.format({ async = true })
--   augroup end
-- ]])
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
-- vim.opt.scrolloff = 20 -- Кол-во строк, которые видны над и под текущей позицией курсора
-- vim.opt.sidescrolloff = 40 -- Кол-во строк, которые видны над и под текущей позицией курсора
-- vim.opt.wrap = true -- Включить перенос строк, игнорируя целостность слов
vim.opt.linebreak = true -- Включить перенос строк, сохраняя целостность слов
-- Set Fish shell as default for Neovim
vim.cmd([[set shell=fish]])

-- autocmd to jump to the last edited position after reading a buffer
vim.cmd([[
au BufReadPost * if line("'\"")>=1 && line ("'\"") <= line("$") | exe "normal! g`\"" | endif]])

if vim.g.neovide then
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_refresh_rate_idle = 5
end

function EnableAfterDelay()
	-- Check if the filetype is not 'md'
	if vim.bo.filetype ~= "markdown" then
		vim.highlight.priorities.semantic_tokens = 95
		vim.cmd("silent TSEnable highlight")
	end
	vim.cmd("silent TSContextEnable")
	-- Add a 50ms delay
	-- vim.schedule(function()
	-- 	vim.wait(50)
	-- end)
	vim.cmd("silent IlluminateToggle")
	vim.cmd("silent IlluminateResume")
	vim.cmd("silent CmpStatus")
	vim.cmd("command! GarbageDayLsp lua require('garbage-day.utils').start_lsp()")
	vim.cmd("silent GarbageDayLsp")

	-- Disable all notifications
	-- vim.opt.shortmess:append("c") -- Suppress 'ins-completion' messages
	-- vim.opt.shortmess:append("F") -- Suppress 'file' messages
	-- vim.opt.shortmess:append("o") -- Suppress 'overlength' messages
	-- vim.opt.shortmess:append("O") -- Suppress 'msg-overflow' messages
	-- vim.opt.shortmess:append("A") -- Suppress 'autocmd' messages
	-- vim.opt.shortmess:append("c") -- Suppress 'ins-completion' messages
	-- vim.opt.shortmess:append("t") -- Suppress 'truncate' messages
end
vim.api.nvim_exec([[autocmd UIEnter * silent lua vim.defer_fn(function() EnableAfterDelay() end,100)]], false)
-- vim.highlight.priorities.semantic_tokens = 90
