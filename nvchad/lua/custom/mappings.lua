---@type MappingsTable
local M = {}
-- Use wslview for gx in WSL
if vim.fn.has("win32") and vim.fn.has("unix") then
	vim.g.netrw_browsex_viewer = "wslview"
end

function Zen()
	vim.cmd("set laststatus=2")
	vim.opt.showmode = true
	vim.o.statusline = "%f %m %r"
	-- vim.o.statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) %p%%"
	vim.o.showtabline = 0
	vim.opt.number = true
	vim.opt.relativenumber = false
end
function DisableStatusLine()
	vim.o.laststatus = 0
end
-- vim.lsp.buf.format({ async = true })
M.general = {
	n = {

		["<leader>gx"] = {
			"<cmd>VisitLinkNearest<CR>",
			"go to link gx",
			opts = { nowait = true },
		},
		["<leader>gf"] = {
			"vi{gf}",
			"go to link gf",
			opts = { nowait = true },
		},

		["<leader>k"] = {
			"<cmd>Telescope keymaps theme=get_ivy<CR>",
			"[T]elescope [K]eymaps",
			opts = { nowait = true },
		},
		["<leader>dd"] = {
			"<cmd>DevdocsOpenFloat<CR>",
			"dev docs float",
			opts = { nowait = true },
		},

		["<leader>pp"] = {
			"<cmd>Telescope projects theme=get_ivy<CR>",
			"telescope list all projects",
			opts = { nowait = true },
		},
		["<leader>bb"] = {
			"<cmd>Telescope file_browser path=%:p:h select_buffer=true theme=get_ivy<CR>",
			"file browser telescope open in current buffer",
			opts = { nowait = true },
		},
		["<leader>gg"] = {
			"<cmd>lua require ('telescope.builtin').live_grep({grep_open_files=true}) theme=get_ivy<CR>",
			"live grep grep open files",
			opts = { nowait = true },
		},
		["<leader>o"] = { ":Telescope oldfiles theme=get_ivy <CR>", "[T]elescope [O]ldfiles", opts = { nowait = true } },
		["<leader>e"] = { ":!node %<CR>", "[R]un [N]ode", opts = { nowait = true } },
		["<leader>rr"] = { "<cmd>SnipClose<CR>", "[S]nip [C]lose", opts = { nowait = true } },
		["<leader>x"] = { "<cmd>bdelete %<CR>", "close buffer", opts = { nowait = true } },
		["<leader>lg"] = { "<cmd>LazyGit<CR>", "lazygit", opts = { nowait = true } },
		["<leader>ww"] = { "<cmd>set wrap!<CR>", "toggle wrap", opts = { nowait = true } },
		["<leader>tw"] = { "<cmd>Twilight<CR>", "Toggle Twilight", opts = { nowait = true } },
		-- ["<leader>z"] = { "<cmd>lua Zen()<CR>", "[Z]en [M]ode", opts = { nowait = true } },
		-- ["<A-b>"] = { ":Lexplore<CR>", "[T]oggle [N]etrw", opts = { nowait = true } },
		["<A-e>"] = { "<cmd>!node %<CR>", "[R]un [N]ode", opts = { nowait = true } },
		["sj"] = { "<C-w>w", "cycle through windows", opts = { nowait = true } },
		["gt"] = { "<cmd>bnext<CR>", "Next Buffer", opts = { nowait = true } },
		["<tab>"] = { "<cmd>bnext<CR>", "next buffer", opts = { nowait = true } },
		-- ["<C-s>"] = { ":w<CR>", "[S]ave [F]ile", opts = { nowait = true } },
		-- ["<M-b>"] = { "<cmd>Oil<CR>", "[O]il", opts = { nowait = true } },
		["<C-q>"] = { "<cmd>q!<CR>", "quit without save", opts = { nowait = true } },
		["<C-z>"] = { "u", "[U]ndo", opts = { nowait = true } },
		["<C-a>"] = { "gg<S-v>G", "[S]elect [A]ll", opts = { nowait = true } },
		["<F1>"] = { "<cmd> Telescope find_files <CR>", "Live grep" },
		["<F2>"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
		["NN"] = { ":tabnew $MYVIMRC<CR>", "Open init.lua", opts = { nowait = true } },
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["1"] = { "$", "go to end of line", opts = { nowait = true } },

		-- probably working :x
		["<leader>y"] = {
			function()
				local cursor_position = vim.fn.getpos(".")
				local line = vim.fn.getline(cursor_position[2])
				local start_col, end_col = string.find(line, "https://[^ %c}]*")
				if start_col then
					local url = string.sub(line, start_col, end_col):gsub("[%c)}]+$", "") -- Remove trailing symbols after ')' and '}'
					if vim.fn.has("clipboard") == 1 then
						vim.fn.setreg("+", url) -- Use system clipboard
					else
						vim.fn.setreg('"', url) -- Fallback to default register
					end
					print(url)
				else
					print("No URL found under the cursor.")
				end
			end,
			"Yank URL under cursor to system clipboard and remove trailing symbols after '}'",
			opts = { nowait = true },
		},
	},
	v = {
		["<C-c>"] = { '"+y', "[C]opy", opts = { nowait = true } },

		["<leader>rr"] = { ":SnipRun<CR>", "[S]nip [R]un", opts = { nowait = true } },
		[">"] = { ">gv", "indent" },
		["ge"] = { "G", "[L]ast [Line]", opts = { nowait = true } },
		["1"] = { "$h", "go to end of line", opts = { nowait = true } },
	},
	i = {
		-- ["jj"] = { "<Esc>", "Next Buffer", opts = { nowait = true } },
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
