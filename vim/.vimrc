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
set cmdheight=2
set noshowmode 

" display line numbers on the left
set number
 
" quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" folding by syntax
set foldmethod=syntax
 
 
" indentation options

" using 4 spaces instead of tabs.
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd FileType dart setlocal shiftwidth=2 tabstop=2
 
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

" disable latex-box from vim-polyglot (use vimtex instead)
let g:polyglot_disabled = ['latex']

call plug#begin('~/.vim/plugged')

Plug 'zhou13/vim-easyescape'
Plug 'dylanaraps/wal.vim'
Plug 'scrooloose/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'yggdroot/indentline'
Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'

" colorschemes
Plug 'flrnprz/candid.vim'
Plug 'severij/vadelma'
Plug 'arzg/vim-colors-xcode'
Plug 'kjssad/quantum.vim'
Plug 'drewtempelmeyer/palenight.vim'


Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

""""""""""""
" coc.nvim "
"          "
""""""""""""

set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes

" use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" use <cr> to confirm completion
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" use [g and ]g to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" goto code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use K to show documentatino in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" symbol renaming
nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" formatting selected code
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>ff  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>



" easy escape
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
cnoremap jk <ESC>
cnoremap kj <ESC>

" colorscheme

" let g:solarized_termcolors=16
"set t_Co=256
"colorscheme quantum
"colorscheme wal
"colorscheme candid
"colorscheme vadelma

" 256 colors
set termguicolors
" for alacritty
if &term == "alacritty"
    let &t_8f = "\<Esc>[38;2;%lu;%lu;;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;;%lum"
    let &term = "xterm-256color"
endif

" dark mode
"colorscheme xcodedark
colorscheme palenight
let g:palenight_terminal_italics=1
let g:lightline = { 'colorscheme': 'palenight' }

set background=dark
"hi Normal guibg=#191919
"hi EndOfBuffer guibg=#191919

" in between
"hi Normal guibg=#444444
"hi EndOfBuffer guibg=#444444

" light mode
"colorscheme xcodelight
"hi Normal guibg=#c6c6c6
"hi EndOfBuffer guibg=#c6c6c6
"hi LineNr guifg=#707070


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
hi CursorLine guibg=#2a2a2a

"dark mode
"hi CursorLineNR guibg=#191919 guifg=#b7b0f2

"in between
"hi CursorLineNR guibg=#2a2a2a guifg=#b7b0f2

"light mode
"hi CursorLineNR guibg=#c6c6c6 guifg=#470660
