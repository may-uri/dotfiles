local opt = vim.opt
local g = vim.g
local config = require("core.utils").load_config()

-------------------------------------- globals -----------------------------------------
g.nvchad_theme = config.ui.theme
g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
g.toggle_theme_icon = ""
-- g.toggle_theme_icon = "   "
g.transparency = config.ui.transparency

-------------------------------------- options ------------------------------------------
opt.laststatus = 0 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = false

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- Mine
opt.breakindent = true -- break indentation for long lines
opt.breakindentopt = { shift = 2 }
-- opt.showbreak = "↳" -- character for line break
opt.showbreak = "↪"
opt.listchars = { eol = "↩", space = "·", tab = "→ " }
opt.fillchars = {
	diff = " ",
	eob = " ",
	fold = " ",
	foldopen = "",
	foldclose = "",
}
-- opt.scrolloff = 2 -- NOTE: перемещение экрана при перемещении курсора, невозможность пользоваться курсором, дерганное перемещение TESTING
-- vim.o.guicursor = "n-v-c-i:block" -- NOTE: bold caret in insert mode TESTING
opt.wrap = false
opt.list = false -- display trailing space
-- opt.sidescrolloff = 30
opt.swapfile = false
opt.backup = false
opt.relativenumber = false
opt.number = false
opt.langmap =
	"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
-- Disable netrw banner
g.netrw_banner = 0
-- Numbers
opt.number = true
opt.numberwidth = 1
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 500
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

g.mapleader = " "

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- reload some chadrc options on-save
autocmd("BufWritePost", {
	pattern = vim.tbl_map(function(path)
		return vim.fs.normalize(vim.loop.fs_realpath(path))
	end, vim.fn.glob(vim.fn.stdpath("config") .. "/lua/custom/**/*.lua", true, true, true)),
	group = vim.api.nvim_create_augroup("ReloadNvChad", {}),

	callback = function(opts)
		local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r") --[[@as string]]
		local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
		local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")

		require("plenary.reload").reload_module("base46")
		require("plenary.reload").reload_module(module)
		require("plenary.reload").reload_module("custom.chadrc")

		config = require("core.utils").load_config()

		vim.g.nvchad_theme = config.ui.theme
		vim.g.transparency = config.ui.transparency

		-- statusline
		require("plenary.reload").reload_module("nvchad.statusline." .. config.ui.statusline.theme)
		vim.opt.statusline = "%!v:lua.require('nvchad.statusline." .. config.ui.statusline.theme .. "').run()"

		-- tabufline
		-- if config.ui.tabufline.enabled then
		-- 	require("plenary.reload").reload_module("nvchad.tabufline.modules")
		-- 	vim.opt.tabline = "%!v:lua.require('nvchad.tabufline.modules').run()"
		-- end

		require("base46").load_all_highlights()
		-- vim.cmd("redraw!")
	end,
})

-------------------------------------- commands ------------------------------------------
local new_cmd = vim.api.nvim_create_user_command

new_cmd("NvChadUpdate", function()
	require("nvchad.updater")()
end, {})
