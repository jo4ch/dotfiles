let &t_ZH="\e[3m"
let &t_ZR="\e[23m"


" ========== PLUGINS ==========
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
	Plug 'joshdick/onedark.vim'
	" Easier navigation
	Plug 'easymotion/vim-easymotion'
	Plug 'dstein64/nvim-scrollview'
	" Color match parentheses
	" Plug 'luochen1990/rainbow'
	" Indent color guides
	Plug 'nathanaelkane/vim-indent-guides'
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Themes:highlight Comment cterm=italic
    " Plug 'joshdick/onedark.vim'
    Plug 'rafi/awesome-vim-colorschemes'
	Plug 'arcticicestudio/nord-vim'
	" Auto completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Custom status line
	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'
    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
    " CSS Color previews
    Plug 'ap/vim-css-color'
    " File finder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " Commenting
    Plug 'tpope/vim-commentary'
    " Snippets
    Plug 'SirVer/ultisnips'
    " Auto close tags
    Plug 'alvan/vim-closetag'
	" tailwind intellisense
	Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}
	" Start page plugin
	Plug 'mhinz/vim-startify'
	" Show functions / classes etc.
	Plug 'yegappan/taglist'	
	" Show git changes in files
	Plug 'airblade/vim-gitgutter'
	" Surroinding tags management
	Plug 'tpope/vim-surround'
	" Multiple cursors like in sublime text
	Plug 'terryma/vim-multiple-cursors'
	" Git integrated in vim interface
	Plug 'tpope/vim-fugitive'
	" Better f functionality
	Plug 'rhysd/clever-f.vim'
	" Underlines all occurences of the word under the cursor
	Plug 'itchyny/vim-cursorword'
	Plug 'ryanoasis/vim-devicons'
	" Laravel blade
	Plug 'jwalton512/vim-blade'
call plug#end()



" ========= SETTINGS ==========
" set leader key
let g:mapleader = "\<Space>"

" let g:python3_host_prog = "/usr/bin/python3"
set t_ZH=^[[3m
set t_ZR=^[[23m

syntax enable                           " Enables syntax highlighing
set mouse=a                                                             " Enable scrolling using mouse
set hidden                              " Required to keep multiple buffers open multiple buffers
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler                               " Show the cursor position all the time
set iskeyword+=-                        " treat dash separated words as a word text object"
set breakindent                                                 " enable indentation
" set showbreak=>>                                              " append '>>' to indent
set t_Co=256                            " Support 256 colors
set tabstop=4                           " Insert 4 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set softtabstop=4
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set cindent                                                             " Indentation
set laststatus=2                        " Always display the status line
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set number                              " Line numbers
set relativenumber                                              " Relative line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus
" set clipboard=unnamed	               " Copy paste between vim and everything else
" set autochdir                           " Your working directory will always be the same as your working directory
set foldmethod=indent                                   " Indent based folding
set nofoldenable                                                " Don't fold by default
au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

let g:UltiSnipsJumpForwardTrigger = "<c-k>"
let g:UltiSnipsJumpBackwardTrigger = "<c-j>"
let g:fzf_colors =
\ { 'fg': ['fg', 'Normal'],
\ 'bg': ['bg', 'Normal'],
\ 'hl': ['fg', 'Comment'],
\ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+': ['fg', 'Statement'],
\ 'info': ['fg', 'PreProc'],
\ 'border': ['fg', 'Ignore'],
\ 'prompt': ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker': ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header': ['fg', 'Comment'] }

" show hidden files in nerdtree
let NERDTreeShowHidden=1

" ========= KEYBINDS =========
" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Copy file path
nmap <F3> :let @+ = expand("%:p") <enter>

" Ax-uploader
nmap <F10> :!python3 ~/Dev/Ax/ax-uploader/__main__.py "%:p" <enter>
nmap <F2> :split <BAR> term python3 ~/Dev/Ax/ax-uploader/__main__.py "%:p" <enter>

" Reveal file in thunar
nmap <leader>r :silent exec "!thunar '%:p'" <enter>

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
nnoremap <C-c> <Esc>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da
" Leader
" noremap y "*y
" noremap p "*p
" noremap <Leader>Y "+y
" noremap <Leader>P "+p

" " Copy to clipboard
vnoremap  <leader>y  "+y
" nnoremap  <leader>Y  "+yg_
" nnoremap  <leader>y  "+y
" nnoremap  <leader>yy  "+yy

" " " Paste from clipboard
" nnoremap <leader>p "+p
" nnoremap <leader>P "+P
" vnoremap <leader>p "+p
" vnoremap <leader>P "+P

" easier save
nnoremap <leader>s :w<cr>

" NERDTree toggle
nmap <leader>ne :NERDTreeToggle<cr>

" NERDTree toggle
nmap <leader>k :NERDTreeFind<cr>

" FZF toggle
nmap <leader>, :FZF<cr>

" Ag toggle
nmap <leader>f :Ag<cr>

" Reveal file in finder
" nmap <leader>r :Reveal<cr>

" Easier close
nmap <leader>w :bd<cr>

" Taglist toggle
nmap <leader>t :TlistToggle<cr>

" Move lines with J and K
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :m

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

" toggle indent guides
nmap <leader>i :IndentGuidesToggle<cr>

" easy motion navigation binds
map <leader>m <Plug>(easymotion-overwin-w)
map <leader>l <Plug>(easymotion-overwin-line)

" use coc for improved goto definition & reference list
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" show documention of code cursor is on wih 'K'
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" resize splits
nnoremap <silent> <c-Up> :resize -10<CR>
nnoremap <silent> <c-Down> :resize +10<CR>
nnoremap <silent> <c-left> :vertical resize -10<CR>
nnoremap <silent> <c-right> :vertical resize +10<CR>


" ========== SETTING THEMES =========
colorscheme nord
let g:airline_theme='nord'

" ========== EASYMOTION COLOR CONFIG =========
hi EasyMotionTarget ctermbg=none ctermfg=1
hi EasyMotionShade  ctermbg=none ctermfg=8

" ========== AIRLINE SETTINGS =========
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline                   
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline     
let g:airline#extensions#tabline#tabs_label = 'T'       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = 'B'    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab            
" let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline       
" let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers                      
" let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [[ 'paste' ], [ 'readonly', 'filename', 'modified' ]],
	  \	  'right': [[ 'filetype', 'percent', 'lineinfo' ]]
	  \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

" enable tabline
let g:airline#extensions#tabline#enabled = 1

let g:airline_powerline_fonts = 1

" Always show tabs
set showtabline=2

let NERDTreeQuitOnOpen=1
let NERDTreeWinSize = 60

let g:rainbow_active = 1

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.php,*.vue,*.xslt,*.xml'

highlight Comment cterm=italic
