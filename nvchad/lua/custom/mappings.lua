---@type MappingsTable
local M = {}
--------------------------------Functions------------------------------------
-- Define a function to determine the file type and execute the appropriate command
function RunFile()
	local file_type = vim.bo.filetype
	if file_type == "javascript" or file_type == "jsx" then
		vim.cmd("!node %")
	elseif file_type == "c" or file_type == "cpp" then
		vim.cmd("!clang % && ./a.out")
	else
		print("Unsupported file type")
	end
end

function Zen()
	vim.cmd("set laststatus=2")
	vim.opt.showmode = true
	vim.o.statusline = "%f %m %r"
	-- vim.o.statusline = "%f %m %r %{luaeval('GitStatusLine()')}"
	-- vim.o.statusline = "%<%f %m %r %= %{luaeval('GitStatusLine()')}" -- display to the right
	-- vim.o.statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) %p%%"
	vim.o.showtabline = 0
	vim.opt.number = false
	vim.opt.relativenumber = false
end

function GitStatusLine()
	if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
		return ""
	end
	local git_status = vim.b.gitsigns_status_dict
	local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
	local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
	local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
	local branch_name = "  " .. git_status.head
	return branch_name .. added .. changed .. removed
end

function LSPDiagnostic()
	if not rawget(vim, "lsp") then
		return ""
	end

	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
	local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

	errors = (errors and errors > 0) and (" " .. errors .. " ") or ""
	warnings = (warnings and warnings > 0) and ("  " .. warnings .. " ") or ""
	hints = (hints and hints > 0) and ("󰛩 " .. hints .. " ") or ""
	info = (info and info > 0) and ("󰋼 " .. info .. " ") or ""

	return errors .. warnings .. hints .. info
end

function LSPStatus()
	if rawget(vim, "lsp") then
		for _, client in ipairs(vim.lsp.get_active_clients()) do
			if client.attached_buffers[vim.api.nvim_get_current_buf()] and client.name ~= "null-ls" then
				return (vim.o.columns > 100 and "~ " .. client.name .. " ") or client.name
			end
		end
	end
end
--------------------------------MappingsTable------------------------------------

M.general = {
	n = {
		["<leader>k"] = {
			"<cmd>Telescope keymaps <CR>",
			"[T]elescope [K]eymaps",
			opts = { nowait = true },
		},
		["<leader>ss"] = {
			"<cmd>Telescope persisted <CR>",
			"Telescope Session",
			opts = { nowait = true },
		},
		["<leader>se"] = {
			"<cmd>SessionLoadLast<CR>",
			"Telescope Session",
			opts = { nowait = true },
		},

		["<leader>gl"] = {
			"<cmd>Glow<CR>",
			"glow markdown preview",
			opts = { nowait = true },
		},

		-- ["<leader>dd"] = {
		--   "<cmd>DevdocsOpenFloat<CR>",
		--   "DevdocsOpenFloat",
		--   opts = { nowait = true },
		-- },
		["<leader>fr"] = {
			"<cmd>Telescope frecency <CR>",
			"[T]elescope [K]eymaps",
			opts = { nowait = true },
		},
		["<leader>pp"] = {
			"<cmd>Telescope projects <CR>",
			"[T]elescope [K]eymaps",
			opts = { nowait = true },
		},
		["<leader>re"] = {
			"<cmd>Telescope file_browser path=%:p:h select_buffer=true theme=get_ivy<CR>",
			"file browser telescope open in current buffer",
			opts = { nowait = true },
		},
		["<leader>gg"] = {
			"<cmd>lua require ('telescope.builtin').live_grep({grep_open_files=true}) theme=get_ivy<CR>",
			"live grep grep open files",
			opts = { nowait = true },
		},
		["<leader>o"] = {
			"<cmd>Telescope oldfiles theme=get_ivy <CR>",
			"[T]elescope [O]ldfiles",
			opts = { nowait = true },
		},
		["<leader>e"] = { "<cmd>:lua RunFile()<CR>", "run node or clang", opts = { nowait = true } },
		-- ["<leader>e"] = { "<cmd>!node %<CR>", "[R]un [N]ode", opts = { nowait = true } },
		["<leader>T"] = { "<cmd>ToggleTerm %<CR>", "[R]un [N]ode", opts = { nowait = true } },
		["<leader>rr"] = { "<cmd>SnipClose<CR>", "[S]nip [C]lose", opts = { nowait = true } },
		-- ["<leader>x"] = { "<cmd>bdelete %<CR>", "close buffer", opts = { nowait = true } },
		-- ["<leader>X"] = { "<cmd>bdelete! %<CR>", "close buffer", opts = { nowait = true } },
		["<leader>lg"] = { "<cmd>LazyGit<CR>", "lazygit", opts = { nowait = true } },
		["<leader>ww"] = { "<cmd>set wrap!<CR>", "toggle wrap", opts = { nowait = true } },
		["<leader>tw"] = { "<cmd>Twilight<CR>", "Toggle Twilight", opts = { nowait = true } },
		-- ["<leader>z"] = { "<cmd>lua Zen()<CR>", "[Z]en [M]ode", opts = { nowait = true } },
		["<leader>z"] = { "[[:normal za<CR>]]", "[Z]en [M]ode", opts = { nowait = true } },
		-- ["<A-b>"] = { ":Lexplore<CR>", "[T]oggle [N]etrw", opts = { nowait = true } },
		["<A-e>"] = { "<cmd>!node %<CR>", "[R]un [N]ode", opts = { nowait = true } },
		["gt"] = { "<cmd>bnext<CR>", "Next Buffer", opts = { nowait = true } },
		["<tab>"] = { "<cmd>bnext<CR>", "next buffer", opts = { nowait = true } },
		-- ["<C-s>"] = { ":w<CR>", "[S]ave [F]ile", opts = { nowait = true } },
		-- ["<M-b>"] = { "<cmd>Oil<CR>", "[O]il", opts = { nowait = true } },
		["<C-q>"] = { "<cmd>q!<CR>", "quit without save", opts = { nowait = true } },
		-- ["<C-q>"] = { "<cmd>lua ToggleAndWarn()<CR>", "[Q]uit [W]ithout [S]ave", opts = { nowait = true } },
		["<C-z>"] = { "u", "[U]ndo", opts = { nowait = true } },
		["<C-a>"] = { "ggVG", "[S]elect [A]ll", opts = { nowait = true } },

		["<F1>"] = { "<cmd> Telescope find_files <CR>", "Live grep" },
		["<F2>"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
		["NN"] = { "<cmd>tabnew $MYVIMRC<CR>", "Open init.lua", opts = { nowait = true } },
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["1"] = { "$", "go to end of line", opts = { nowait = true } },
	},
	v = {
		["<C-c>"] = { '"+y', "[C]opy", opts = { nowait = true } },

		[">"] = { ">gv", "indent" },
		["ge"] = { "G", "[L]ast [Line]", opts = { nowait = true } },
		["1"] = { "$h", "go to end of line", opts = { nowait = true } },
	},
}

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
return M
