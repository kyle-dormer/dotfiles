" Basics
set encoding=utf-8
set number relativenumber
set cursorline
set noshowmode
set updatetime=300

syntax on
filetype plugin on

" Remap leader key
let mapleader=","

" Use jk to in place of <esc>
imap jk <Esc>

" Shift-W to write file
noremap <S-w> :w<CR>

" Automatically delete all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splitting defaults
set splitbelow
set splitright

" Split navigation shortcuts
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Allow closing buffers without saving
set hidden

" Bind spellcheck to <leader>o
map <leader>o :setlocal spell! spelllang=en_gb<CR>

" View/select currently open buffers
nnoremap <leader>l :ls<CR>:b<space>

" View/select buffer and open in window split
nnoremap <leader>L :ls<CR>:sb<space>

" Count printed words in LaTeX
map <leader>wc :w !detex \| wc -w<CR>

" Compile TeX file
noremap <leader>t :!pdflatex %<CR>

" Set path for find command
set path=.,**

" Find file and open in new buffer
nnoremap <leader>f :find *

" Find file and open in new buffer with horizontal split
nnoremap <leader>s :sfind *

" Find file and open in new buffer with vertical split
nnoremap <leader>v :vert sfind *

" Find file recursively within directory of current file
nnoremap <leader>F :find <C-R>=expand('%:h').'/*'<CR>

" Find file within file directory and open in window split
nnoremap <leader>S :sfind <C-R>=expand('%:h').'/*'<CR>

" Find file within file directory and open in window vertical split
nnoremap <leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>

" Folds
noremap <leader>q :set foldmethod=indent<CR>zM<CR>:set foldcolumn=1<CR>
noremap <leader>Q :set foldmethod=manual<CR>zR<CR>

" Set max nested folds to 2
set foldnestmax=2

" Plugins
call plug#begin(stdpath('data'))
	Plug 'vim-airline/vim-airline'
	Plug 'arcticicestudio/nord-vim'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
	Plug 'vimwiki/vimwiki'
	Plug 'ryanoasis/vim-devicons'
call plug#end()

" vim-airline
let g:airline_powerline_fonts = 1

" Set separator characters for airline
if !exists("g:airline_symbols")
  let g:airline_symbols = {}
endif

let g:airline_left_alt_sep = '>'
let g:airline_right_alt_sep = '<'
let g:airline_symbols.branch = '⎇'

" Display buffers if only 1 tab
let g:airline#extensions#tabline#enabled = 1

" Colours
colorscheme nord
highlight LineNr ctermfg=7
highlight CursorLineNr ctermfg=12
highlight Comment ctermfg=5
highlight DiffAdd none
highlight DiffChange none
highlight DiffDelete none
let g:airline_theme='nord'


" Nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['^node_modules$']

" Close vim if nerdtree is the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeIgnore=['\.pyc$', '\~$']

" Coc.nvim
" Use tab for trigger completion with characters ahead and navigate.
let g:coc_global_extensions = ['coc-git', 'coc-pairs']

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Use tab and shift-tab to navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add ':OR' command to organise imports of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" VimWiki
let g:vimwiki_list = [{'path': '~/.local/share/vimwiki', 'path_html': '~/.local/share/vimwiki/html'}]
