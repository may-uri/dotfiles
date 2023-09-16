if vim.loader and vim.fn.has "nvim-0.9.1" == 1 then vim.loader.enable() end

for _, source in ipairs {
  "astronvim.bootstrap",
  "astronvim.options",
  "astronvim.lazy",
  "astronvim.autocmds",
  "astronvim.mappings",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end

if astronvim.default_colorscheme then
  if not pcall(vim.cmd.colorscheme, astronvim.default_colorscheme) then
    require("astronvim.utils").notify(
      ("Error setting up colorscheme: `%s`"):format(astronvim.default_colorscheme),
      vim.log.levels.ERROR
    )
  end
end

require("astronvim.utils").conditional_func(astronvim.user_opts("polish", nil, false), true)

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

-- Run current file in Node.js
vim.api.nvim_set_keymap("n", "<A-e>", ":!bun %<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>e", ":!bun %<CR>", { noremap = true })
-- Go to end of line with "1"
vim.api.nvim_set_keymap("n", "1", "$", { noremap = true })
-- Disable netrw banner
vim.g.netrw_banner = 0
-- Open init.lua 
vim.api.nvim_set_keymap('n', 'NN', ':tabnew $MYVIMRC<CR>', { noremap = true })
-- ctrl+a to select all
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { noremap = true, silent = true })

require("wrapping").setup()

vim.o.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
vim.wo.colorcolumn = "79"
 -- space + s to multi cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Disable swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false
-- require('nvim-ts-autotag').setup()
-- neoscroll scroll mappin
vim.keymap.set('n', '<ScrollWheelUp>', '<C-y>')
vim.keymap.set('n', '<ScrollWheelDown>', '<C-e>')
vim.keymap.set('i', '<ScrollWheelUp>', '<C-y>')
vim.keymap.set('i', '<ScrollWheelDown>', '<C-e>')
vim.keymap.set('v', '<ScrollWheelUp>', '<C-y>')
vim.keymap.set('v', '<ScrollWheelDown>', '<C-e>')
