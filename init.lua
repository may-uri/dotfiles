if vim.loader then
	vim.loader.enable()
end

-- my config
-- Save with Ctrl+S
vim.api.nvim_set_keymap("n", "<C-S>", ":w<CR>", { noremap = true })
-- Close without saving with Ctrl+Q
vim.api.nvim_set_keymap("n", "<C-Q>", ":q!<CR>", { noremap = true })
-- Copy with Ctrl+C
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true })
-- Map F1 key to Telescope find by file
vim.api.nvim_set_keymap("n", "<F1>", ":Telescope find_files<CR>", { noremap = true })

-- Map F2 key to Telescope find by grep
vim.api.nvim_set_keymap("n", "<F2>", ":Telescope live_grep<CR>", { noremap = true })

-- Disable Ctrl+Z
vim.api.nvim_set_keymap("n", "<C-z>", "u", { noremap = true })

-- Run current file in neovim
vim.api.nvim_set_keymap("n", "<A-e>", ":!bun run %<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>e", ":!bun run %<CR>", { noremap = true })
-- Go to end of line with "1"
vim.api.nvim_set_keymap("n", "1", "$", { noremap = true })
-- Disable netrw banner
vim.g.netrw_banner = 0
-- Open init.lua
vim.api.nvim_set_keymap("n", "NN", ":tabnew $MYVIMRC<CR>", { noremap = true })
-- ctrl+a to select all
vim.api.nvim_set_keymap("n", "<C-a>", "<cmd> %y+ <CR><CR>", { noremap = true, silent = true })

vim.o.langmap =
	"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
-- vim.wo.colorcolumn = "79"
-- space + s to multi cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Disable swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false
-- require('nvim-ts-autotag').setup()
-- neoscroll scroll mappin
vim.keymap.set("n", "<ScrollWheelUp>", "<C-y>")
vim.keymap.set("n", "<ScrollWheelDown>", "<C-e>")
vim.keymap.set("i", "<ScrollWheelUp>", "<C-y>")
vim.keymap.set("i", "<ScrollWheelDown>", "<C-e>")
vim.keymap.set("v", "<ScrollWheelUp>", "<C-y>")
vim.keymap.set("v", "<ScrollWheelDown>", "<C-e>")
-- Add this code to your init.lua file
vim.api.nvim_set_keymap("n", "<M-b>", ":Neotree toggle float<CR>", { noremap = true, silent = true })
