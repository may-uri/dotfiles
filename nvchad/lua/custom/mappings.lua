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
function DisableStatusLine()
	vim.o.laststatus = 0
end
-- Function to toggle status line and warn before closing buffer without saving
function ToggleAndWarn()
	-- Check for unsaved changes
	local unsaved_changes = vim.fn.getbufvar("%", "&modified") == 1
	if unsaved_changes then
		local choice = vim.fn.confirm("Buffer has unsaved changes. Do you really want to quit?", "&Yes\n&No", 2)
		if choice == 2 then
			return
		end
	end
	-- Quit or close the buffer
	vim.cmd("quit!")
end
-- vim.lsp.buf.format({ async = true })
M.general = {
	n = {
		["<leader>k"] = { ":Telescope keymaps theme=get_ivy<CR>", "[T]elescope [K]eymaps", opts = { nowait = true } },
		["<leader>o"] = { ":Telescope oldfiles theme=get_ivy <CR>", "[T]elescope [O]ldfiles", opts = { nowait = true } },
		["<leader>e"] = { ":!node %<CR>", "[R]un [N]ode", opts = { nowait = true } },
		["<leader>rr"] = { "<cmd>SnipClose<CR>", "[S]nip [C]lose", opts = { nowait = true } },
		["<leader>x"] = { "<cmd>bdelete %<CR>", "[S]nip [C]lose", opts = { nowait = true } },
		["<leader>lg"] = { "<cmd>LazyGit<CR>", "[L]azy [G]it", opts = { nowait = true } },
		["<leader>ww"] = { "<cmd>set wrap!<CR>", "[T]oggle [W]rap", opts = { nowait = true } },
		["<leader>tw"] = { "<cmd>Twilight<CR>", "[T]oggle [T]wilight", opts = { nowait = true } },
		-- ["<leader>z"] = { "<cmd>lua Zen()<CR>", "[Z]en [M]ode", opts = { nowait = true } },
		["<leader>z"] = { "<cmd>lua ToggleAndWarn()<CR>", "[Z]en [M]ode", opts = { nowait = true } },
		-- ["<A-b>"] = { ":Lexplore<CR>", "[T]oggle [N]etrw", opts = { nowait = true } },
		["<A-e>"] = { "<cmd>!node %<CR>", "[R]un [N]ode", opts = { nowait = true } },
		["gt"] = { "<cmd>bnext<CR>", "[N]ext [B]uffer", opts = { nowait = true } },
		["<tab>"] = { "<cmd>bnext<CR>", "[N]ext [B]uffer", opts = { nowait = true } },

		-- ["<C-s>"] = { ":w<CR>", "[S]ave [F]ile", opts = { nowait = true } },
		["<C-q>"] = { "<cmd>q!<CR>", "[Q]uit [W]ithout [S]ave", opts = { nowait = true } },
		-- ["<C-q>"] = { "<cmd>lua ToggleAndWarn()<CR>", "[Q]uit [W]ithout [S]ave", opts = { nowait = true } },
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
