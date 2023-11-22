---@type MappingsTable
local M = {}
function Zen()
	vim.cmd("set laststatus=2")
	vim.opt.showmode = true
	vim.o.statusline = "%f %m %r"
	-- vim.o.statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) %p%%"
	vim.o.showtabline = 0
	vim.opt.number = false
	vim.opt.relativenumber = false
end
-- vim.lsp.buf.format({ async = true })
M.general = {
	n = {
		["<leader>k"] = { ":Telescope keymaps theme=get_ivy<CR>", "[T]elescope [K]eymaps", opts = { nowait = true } },
		["<leader>o"] = { ":Telescope oldfiles theme=get_ivy <CR>", "[T]elescope [O]ldfiles", opts = { nowait = true } },
		["<leader>e"] = { ":!node %<CR>", "[R]un [N]ode", opts = { nowait = true } },
		["<leader>do"] = { ":!python3 done.py %<CR>", "[R]un [N]ode", opts = { nowait = true } },
		["<leader>rr"] = { "<cmd>SnipClose<CR>", "[S]nip [C]lose", opts = { nowait = true } },
		["<leader>lg"] = { "<cmd>LazyGit<CR>", "[L]azy [G]it", opts = { nowait = true } },
		["<leader>ww"] = { ":set wrap!<CR>", "[T]oggle [W]rap", opts = { nowait = true } },
		["<leader>tw"] = { ":Twilight<CR>", "[T]oggle [T]wilight", opts = { nowait = true } },
		["<leader>z"] = { ":lua Zen()<CR>", "[Z]en [M]ode", opts = { nowait = true } },
		["<A-b>"] = { ":Lexplore<CR>", "[T]oggle [N]etrw", opts = { nowait = true } },
		["<A-e>"] = { ":!node %<CR>", "[R]un [N]ode", opts = { nowait = true } },

		-- ["<C-s>"] = { ":w<CR>", "[S]ave [F]ile", opts = { nowait = true } },
		["<C-q>"] = { ":q!<CR>", "[Q]uit [W]ithout [S]ave", opts = { nowait = true } },
		["<C-z>"] = { "u", "[U]ndo", opts = { nowait = true } },
		["<C-a>"] = { "ggVG", "[S]elect [A]ll", opts = { nowait = true } },

		["<F1>"] = { "<cmd> Telescope find_files <CR>", "Live grep" },
		["<F2>"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
		["NN"] = { ":tabnew $MYVIMRC<CR>", "Open init.lua", opts = { nowait = true } },
		-- [";"] = { ":", "enter command mode", opts = { nowait = true } },
		["1"] = { "$", "go to end of line", opts = { nowait = true } },
	},
	v = {
		["<C-c>"] = { '"+y', "[C]opy", opts = { nowait = true } },

		["<leader>rr"] = { ":SnipRun<CR>", "[S]nip [R]un", opts = { nowait = true } },
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
