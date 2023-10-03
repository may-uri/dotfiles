---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>k"] = { ":Telescope keymaps<CR>", "[T]elescope [K]eymaps", opts = { nowait = true } },
    ["<leader>o"] = { ":Telescope oldfiles<CR>", "[T]elescope [O]ldfiles", opts = { nowait = true } },
    -- ["<leader>k"] = { ":Telescope keymaps<CR>", "Telescope to watch all keymaps", opts = { nowait = true } },
    -- ["<leader>k"] = { ":Telescope keymaps<CR>", "Telescope to watch all keymaps", opts = { nowait = true } },
    ["<A-b>"] = { ":Lexplore<CR>", "[T]oggle [N]etrw", opts = { nowait = true } },
    ["ge"] = { "G", "[L]ast [Line]", opts = { nowait = true } },
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent"},
    ["ge"] = { "G", "[L]ast [Line]", opts = { nowait = true } },
  },
}

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
return M
