
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

Plug 'TornaxO7/auto-cosco.vim', {'branch' : 'stable'}
Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {
" these two plugins will add highlighting and indenting to JSX and TSX files.
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
" Plug 'preservim/nerdcommenter'

Plug 'preservim/nerdtree' " nerd tree to view files in currect directory

Plug 'ryanoasis/vim-devicons' " to add icons in nerd tree
Plug 'tpope/vim-commentary' " toggle commenting lines
" Plug 'folke/neodev.nvim' " not sure
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
" set cursorline
"set relativenumber
colorscheme tender 
" colo gruvbox
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(0) :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()


 " NN to open init config
" command! NN tabnew ~/.config/nvim/init.vim
nnoremap NN :tabnew ~/.config/nvim/init.vim<CR>

"inoremap <silent><expr> <TAB> coc#pum#visible() ? "\<C-n>" :  coc#refresh()




inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm()
			      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use <c-space> to trigger completion

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" Highlight the symbol and its references when holding the cursor

" autocmd CursorHold * silent call CocActionAsync('highlight')
"" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')
"save to ctrl+s
nnoremap <C-S> :Format<CR>:w<CR>
inoremap <C-S> <c-o>:w<cr>
 "close without save to ctrl+q
nnoremap <C-Q> :q!<CR>
" copy with ctrl+c
vnoremap <C-c> "+y
" >>>>>>>> NERD COMMENTER <<<<<<<<<< "
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
"nnoremap <C-/> :call nerdcommenter#Comment(0, "toggle")<CR>
nnoremap <A-/> :Commentary<CR>
"vnoremap <A-/> :<C-u>call nerdcommenter#Comment(0, "toggle")<CR>
vnoremap  <A-/> :Commentary<CR>
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

"run currect file in nodejs
nnoremap <A-e> :!node %<CR>



" Set Prettier configuration for JavaScript
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



" make lsp on top
" autocmd User CocOpenFloat call nvim_win_set_config(g:coc_last_float_win, {'relative': 'editor', 'row': 0, 'col': 0})
" autocmd User CocOpenFloat call nvim_win_set_width(g:coc_last_float_win, 9999)

nnoremap <A-b> :NERDTreeToggle<CR>
" 1 to end of line

