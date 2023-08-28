
" this will install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/plugged')
  Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
   Plug 'nvim-lua/plenary.nvim'
Plug 'jacoborus/tender.vim' " colorscheme learn vim
Plug 'ThePrimeagen/vim-be-good' " learn vim 
" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more. The plugin provides mappings to easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-surround' " plugin provides mappings to easily delete, change and add such surroundings in pairs.

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " this is for auto complete, prettier and tslinting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']  " list of CoC extensions needed

Plug 'TornaxO7/auto-cosco.vim', {'branch' : 'stable'} " auto semicolon
Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {
" these two plugins will add highlighting and indenting to JSX and TSX files.
Plug 'yuezk/vim-js' "syntax javascript
Plug 'HerringtonDarkholme/yats.vim' " Yet Another TypeScript Syntax
Plug 'maxmellon/vim-jsx-pretty'
" Plug 'preservim/nerdcommenter'

Plug 'wakatime/vim-wakatime' " track spent time in vim :> 
Plug 'tpope/vim-fugitive' " git in nvim
Plug 'tpope/vim-commentary' " toggle commenting lines
" Plug 'folke/neodev.nvim' " not sure
Plug 'morhetz/gruvbox'
Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
Plug 'romgrk/barbar.nvim'

Plug 'andrewferrier/wrapping.nvim'


Plug 'joshdick/onedark.vim'
Plug 'nvim-neo-tree/neo-tree.nvim'

Plug 'MunifTanjim/nui.nvim'
Plug 'jdhao/better-escape.vim'
Plug 'lewis6991/gitsigns.nvim' 
call plug#end()


filetype plugin on
"lang map make keys position over key typed
 set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" set background=light
set number relativenumber
set noswapfile
set mouse =a
set shiftwidth=2
set updatetime=300
set colorcolumn=79
set noswapfile
" yow (toggle wrap mode)
" set wrap
" Sync clipboard between OS and Neovim.
" Remove this option if you want your OS clipboard to remain independent.
" See `:help 'clipboard'`
set clipboard=unnamedplus
" set nohlsearch
" noh - no highlight
map <esc> :noh <CR>

" Set highlight on search
set hlsearch

" Save undo history
set undofile

" Case-insensitive searching UNLESS \C or capital in search
set ignorecase
set smartcase

" Set completeopt to have a better completion experience
set completeopt=menuone,noselect

let mapleader = "\<Space>"
" set cursorline
"set relativenumber
colorscheme tender
" colorscheme gruvbox

" colo gruvbox
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
" UNCOMMENT
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" UNCOMMENT
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(0) :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()


" NN to open init config
" command! NN tabnew ~/.config/nvim/init.vim
nnoremap NN :tabnew ~/.config/nvim/init.vim<CR>

"inoremap <silent><expr> <TAB> coc#pum#visible() ? "\<C-n>" :  coc#refresh()



" UNCOMMENT
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
" UNCOMMENT
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm()
			      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" UNCOMMENT
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use <c-space> to trigger completion
" UNCOMMENT
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" Highlight the symbol and its references when holding the cursor

" autocmd CursorHold * silent call CocActionAsync('highlight')
"" Add `:Format` command to format current buffer
" UNCOMMENT
command! -nargs=0 Format :call CocActionAsync('format')
"save to ctrl+s
nnoremap <C-S> :w<CR>
" nnoremap <C-S> :Format<CR>:w<CR>
inoremap <C-S> <c-o>:w<cr>
 "close without save to ctrl+q
" nnoremap <C-Q> :bd!<CR>
" nnoremap <C-Q> :q!<CR>
nnoremap <C-Q> :bd! <Bar> q!<CR>
" copy with ctrl+c
vnoremap <C-c> "+y
" select all with ctrl+a
nnoremap <C-a> ggVG
"nnoremap <C-/> :call nerdcommenter#Comment(0, "toggle")<CR>
nnoremap <A-/> :Commentary<CR>
nnoremap <leader>/ :Commentary<CR>
"vnoremap <A-/> :<C-u>call nerdcommenter#Comment(0, "toggle")<CR>
vnoremap  <A-/> :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>


"run currect file in nodejs
nnoremap <A-e> :!node %<CR>
nnoremap <leader>e :!node %<CR>
" Add the hijack_netrw_behavior option using Lua
lua << EOF
require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_hidden = true,
      hide_by_name = {},
      hide_by_pattern = {},
      always_show = {},
      never_show = {},
      never_show_by_pattern = {},
    },
    follow_current_file = {
      enabled = false,
      leave_dirs_open = false,
    },
    group_empty_dirs = false,
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = false,
  },
})
EOF
" Set Prettier configuration for JavaScript
" UNCOMMENT
let g:prettier#autoformat = 1
let g:prettier#config#filetype_map = {
      \ "javascript": {
      \   "prettier_command": "prettier --stdin-filepath % --config $HOME/.prettierrc"
      \ }
      \}
" Remove existing F1 key mapping
noremap <F1>
" Map F1 key to Telescope find by file
nnoremap <F1> :Telescope find_files<CR>
" map F2 key to Telescope finy by grep
nnoremap <F2> <cmd>Telescope live_grep<cr>
" disable ctrl + z
nnoremap <c-z> u
" shift up-down cursor still in one place
lua << EOF
vim.keymap.set("n", "<S-Up>", "<C-u>zz")
vim.keymap.set("n", "<S-Down>", "<C-d>zz")
EOF

" map double jj to ESC
imap jj <Esc>
"
let g:netrw_banner = 0
let g:loaded_netrwPlugin = 1


" make lsp on top
" autocmd User CocOpenFloat call nvim_win_set_config(g:coc_last_float_win, {'relative': 'editor', 'row': 0, 'col': 0})
" autocmd User CocOpenFloat call nvim_win_set_width(g:coc_last_float_win, 9999)

nnoremap <A-b> :Neotree toggle<CR>
nnoremap <leader>f :Neotree toggle<CR>
" Neotree toggle" 1 to end of line
nnoremap 1 $
 " add use strict in new javascript files
autocmd BufNewFile *.js call append(0, "'use strict';")

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=700})
augroup END



lua << EOF
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
})
EOF

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" use jj to escape insert mode.
let g:better_escape_shortcut = 'jj'



" coc suggest width :>

" autocmd User CocOpenFloat call nvim_win_set_config(g:coc_last_float_win, {'relative': 'editor', 'row': 0, 'col': 0})
" autocmd User CocOpenFloat call nvim_win_set_width(g:coc_last_float_win, 9999)
lua << EOF
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '┆' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,
  numhl      = false,
  linehl     = false,
  word_diff  = false,
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 1000,
    ignore_whitespace = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 3,
    col = 2
  },
  yadm = {
    enable = false
  },
}
EOF

lua << EOF
require("wrapping").setup()
EOF
" test
