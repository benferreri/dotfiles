" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" indenting based on file type
filetype indent plugin on
 
" syntax highlighting
syntax on
 
" for working with multiple files in one window 
set hidden
 
" better command-line completion
set wildmenu
 
" show partial commands in the last line of the screen
set showcmd
 
" highlight searches
set hlsearch
 
" use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" keep same indent as previous line, if no filetype-specific indenting
set autoindent
 
" stop certain movements from always going to the first character of a line.
set nostartofline
 
" display cursor position on status bar
set ruler
 
" always display status bar
set laststatus=2
 
" raise dialog to ask to confirm unsaved changes
set confirm
 
" use visual bell instead of beeping when doing something wrong
set visualbell
 
" set visual bell to do nothing
set t_vb=
 
" enable use of the mouse for all modes
set mouse=a
 
" set the command window height to 2 lines
set cmdheight=1
set noshowmode 

" display line numbers on the left
set number
 
" quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
 
 
" indentation options

" using 4 spaces instead of tabs.
set shiftwidth=4
set softtabstop=4
set expandtab
 
" mappings
 
" map Y to yank until EOL instead of whole line
map Y y$
 
" map <C-L> (redraw screen) to also unhighlight searched words
nnoremap <C-L> :nohl<CR><C-L>

" leader is space key
let mapleader = " "
let g:mapleader = " "

" easier write
nmap <leader>w :w<cr>

" easier quit
nmap <leader>q :q<cr>

" move between tabs
map <A-h> :tabp<cr>
map <A-l> :tabn<cr>

" colors
highlight Normal ctermfg=White

" relative line numbers
set number relativenumber
set relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained * set relativenumber
    autocmd BufLeave,FocusLost * set norelativenumber
augroup END

" plugins

" install vim-plug if not yet installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'zhou13/vim-easyescape'
Plug 'dylanaraps/wal.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'yggdroot/indentline'
Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'
Plug 'flrnprz/candid.vim'
Plug 'severij/vadelma'
Plug 'arzg/vim-colors-xcode'
Plug 'kjssad/quantum.vim'

call plug#end()

" easy escape
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
cnoremap jk <ESC>
cnoremap kj <ESC>

" disable latex-box from vim-polyglot (use vimtex instead)
let g:polyglot_disabled = ['latex']

" colorscheme

" let g:solarized_termcolors=16
"set t_Co=256
set termguicolors
"colorscheme quantum
colorscheme xcodedark
"colorscheme wal
"colorscheme candid
"colorscheme vadelma
"set background=light
set background=dark

" ycm
let g:ycm_global_ycm_extra_conf = '$HOME/.vim/ycm_extra_conf/ycm_extra_conf.py'

" nerdtree
map <C-n> :NERDTreeToggle<cr>

" powerline
set rtp+=/usr/lib/python3.8/site-packages/powerline/bindings/vim/
set laststatus=2

" vimtex
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'
let g:vimtex_compiler_progname = 'latexmk'

" current line number color
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline
hi CursorLineNR guibg=#2a2a2a guifg=#b7b0f2
