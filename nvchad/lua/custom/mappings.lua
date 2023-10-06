---@type MappingsTable
local M = {}
function ToggleStatusLine()
  if vim.o.laststatus == 0 then
    vim.cmd('set laststatus=2')
  else
    vim.cmd('set laststatus=0')
  end
end
M.general = {
	n = {
		["<leader>k"] = { ":Telescope keymaps<CR>", "[T]elescope [K]eymaps", opts = { nowait = true } },
		["<leader>o"] = { ":Telescope oldfiles<CR>", "[T]elescope [O]ldfiles", opts = { nowait = true } },
		["<leader>e"] = { ":!node %<CR>", "[R]un [N]ode", opts = { nowait = true } },
		["<leader>rr"] = { ":SnipClose<CR>", "[S]nip [C]lose", opts = { nowait = true } },
		["<leader>ww"] = { ":set wrap!CR>", "[T]oggle [W]rap", opts = { nowait = true } },
		["<leader>ts"] = { ":lua ToggleStatusLine()<CR>", "[T]oggle [S]tatus [L]ine", opts = { nowait = true } },
		["<leader>s"] = {
			[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
			"[S]ubstitute",
			silent = true,
			noremap = true,
		},
		["<A-b>"] = { ":Lexplore<CR>", "[T]oggle [N]etrw", opts = { nowait = true } },
		["<A-e>"] = { ":!node %<CR>", "[R]un [N]ode", opts = { nowait = true } },

		-- ["<C-s>"] = { ":w<CR>", "[S]ave [F]ile", opts = { nowait = true } },
		["<C-q>"] = { ":q!<CR>", "[Q]uit [W]ithout [S]ave", opts = { nowait = true } },
		["<C-z>"] = { "u", "[U]ndo", opts = { nowait = true } },
		["<C-a>"] = { "ggVG", "[S]elect [A]ll", opts = { nowait = true } },

		["<F2>"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
		["ge"] = { "G", "[L]ast [Line]", opts = { nowait = true } },
		["NN"] = { ":tabnew $MYVIMRC<CR>", "Open init.lua", opts = { nowait = true } },
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["1"] = { "$", "go to end of line", opts = { nowait = true } },
	},
	v = {
		["<C-c>"] = { '"+y', "[C]opy", opts = { nowait = true } },

		["<leader>rr"] = { ":SnipRun<CR>", "[S]nip [R]un", opts = { nowait = true } },
		[">"] = { ">gv", "indent" },
		["ge"] = { "G", "[L]ast [Line]", opts = { nowait = true } },
		["1"] = { "$", "go to end of line", opts = { nowait = true } },
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
