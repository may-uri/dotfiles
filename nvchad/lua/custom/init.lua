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

-- treesitter highlight works only without TSEnable function
-- vim.highlight.priorities.semantic_tokens = 95
-- Set transparency for the status line
-- vim.cmd([[ hi StatusLine   guibg=NONE ctermbg=NONE ]])
-- vim.cmd([[ hi StatusLineNC guibg=NONE ctermbg=NONE ]])

-- Set transparency for the active and inactive status line
-- vim.cmd([[ hi StatusLineNC   guibg=NONE ctermbg=NONE ]])

-- Set transparency for the active and inactive status line
-- vim.cmd([[ hi StatusLineNC   guibg=NONE ctermbg=NONE ]])

vim.api.nvim_exec(
	[[
  augroup MarkdownConceal
    autocmd!
    autocmd BufRead *.md setlocal conceallevel=2
  augroup END
]],
	false
)

-- Autocmd to jump to the last edited position after reading a buffer
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

-------------
-- Neovide --
-------------
if vim.g.neovide then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}

	-- vim.g.neovide_theme = "auto"
	vim.g.neovide_padding_left = 10
	vim.g.neovide_scroll_animation_length = 0.3
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_underline_stroke_scale = 0.9
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_no_custom_clipboard = true
	vim.keymap.set("v", "<C-c>", "y") -- Copy
	vim.keymap.set("n", "<C-v>", "P") -- Paste normal mode
	vim.keymap.set("v", "<C-v>", "P") -- Paste visual mode
	vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<C-v>", "<ESC>pa") -- Paste insert mode

	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_remember_window_size = true
	vim.g.remember_window_position = true

	vim.o.switchbuf = "newtab"
end

-----------------------
-- EnableAfterDelay --
-----------------------
function EnableAfterDelay()
	if vim.bo.filetype ~= "markdown" then
		vim.highlight.priorities.semantic_tokens = 95
		vim.cmd("silent TSEnable highlight")
	end
	vim.cmd("silent Neorg")
	vim.cmd("silent CmpStatus")
	vim.cmd("silent TSContextEnable")
	vim.cmd("command! GarbageDayLsp lua require('garbage-day.utils').start_lsp()")
	vim.cmd("silent GarbageDayLsp")
	vim.cmd("silent FocusEnable")
	vim.cmd("silent IlluminateResume")
end
-- execute the autocmd only if the file size is less than 100KB
local file_size = vim.fn.getfsize(vim.fn.expand("%"))

if file_size < 100 * 1024 then
	vim.api.nvim_exec(
		[[
            autocmd UIEnter * silent lua vim.defer_fn(function() EnableAfterDelay() end, 63)
        ]],
		false
	)
end
-- zen mode
-- vim.cmd("autocmd VimEnter * lua Zen()")

vim.o.path = ".,**"
