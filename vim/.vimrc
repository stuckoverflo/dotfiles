if (has("termguicolors"))
    set termguicolors
endif

if !exists("g:syntax_on")
    syntax enable
endif

filetype plugin on
filetype indent on

call plug#begin()

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-perl/vim-perl'
Plug 'jiangmiao/auto-pairs'
Plug 'jessedhillon/vim-easycomment'
Plug 'junegunn/vim-easy-align'
Plug 'gioele/vim-autoswap'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'ajh17/VimCompletesMe'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'szw/vim-maximizer'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()

set background=dark
color gruvbox
let g:gruvbox_bold = 0

set fillchars=""

set ttyfast                     " for fast terminal connections

set history=1000                " sets how many lines of history VIM has to remember

set autoread                    " set to auto read when a file is changed from the outside

let mapleader = ","             " map comma as leader
let g:mapleader = ","

set number                      " show line number
set cursorline                  " highlight current line
set so=7                        " set 7 lines to the cursor - when moving vertically using j/k
set wildmenu                    " command completion

set wildignore=*.o,*~,*.pyc     " ignored stuff on command autocomplete
set ruler                       " always show current position
set cmdheight=1                 " height of the command bar

set backspace=eol,start,indent  " configure backspace so it acts as it should act
set whichwrap+=<,>,h,l,[,]      " movement keys wrap

set ignorecase                  " ignore case when searching
set smartcase                   " search string has upper case makes search case-sensitive
set incsearch                   " incremental search
set magic                       " allows regex matching with special characters

set lazyredraw                  " don't redraw while executing macros

set showmatch                   " show matching brackets when text indicator is over them
set mat=2                       " how many tenths of a second to blink when matching brackets

set noerrorbells                " no annoying sound on errors
set novisualbell                " no annoying flash on errors

set encoding=utf8               " set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac            " for fuck's sake, use Unix as the standard file type

set expandtab                   " use spaces instead of tabs
set smarttab                    " be smart when using tabs
set shiftwidth=4                " 1 tab == 4 spaces
set tabstop=4                   " how long tab is
set softtabstop=4

set ai                          " auto indent
set si                          " smart indent
set nowrap                      " don't wrap lines

set showcmd                     " show commands the user enters
set laststatus=2                " always show the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

set nohlsearch                  " turn off highlighting

set noshowmode                  " already taken care of by vim-airline

" F1 is evil
nnoremap <F1> <Esc>
inoremap <F1> <Esc>
vnoremap <F1> <Esc>

" treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
"
" don't get fucked by Shift
command! -complete=file -bang -nargs=? W  :w<bang> <args>
command! -complete=file -bang -nargs=? Wq :wq<bang> <args>
command! -complete=file -bang Q :q<bang>
command! -complete=file -bang Qa :qa<bang>

" disable arrow keys
noremap <up> :echo "use k"<cr>
noremap <down> :echo "use j"<cr>
noremap <left> :echo "use h"<cr>
noremap <right> :echo "use l"<cr>

" disable paste mode when exiting Insert mode
augroup disablePasteModeWhenExitingInsertMode
  autocmd!
  au InsertLeave * set nopaste
augroup END

" window management
nnoremap s <C-W>
augroup windowManagementShortcut
    autocmd!
    autocmd filetype netrw nnoremap <buffer> s <C-W>
augroup END

set mouse=a
map m :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo "Mouse usage disabled"
  else
    set mouse=a
    echo "Mouse usage enabled"
  endif
endfunction

" return the cursor to its previous location on load
augroup bufRead
  autocmd!
  autocmd BufReadPost * normal `"
augroup END

""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
""""""""""""""""""""""""""""""""""""""""""""
" <Esc> alternatives
inoremap jj <Esc>:update<CR>
inoremap jk <Esc>:update<CR>

" toggle pastemode
set pastetoggle=<F5>

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <TAB> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

" map <Space> to / (search) and ctrl+<Space> to ? (backwards search)
map <space> :set hlsearch<CR>/
map <c-@> ?

" toggle highlighting
noremap <leader><space> :set hlsearch! hlsearch?<CR>

" remove trailing whitespaces
noremap <leader><c-@> :%s/\s\+$<CR>

nnoremap <leader>, :update<CR>

" quickly edit and reload vimrc
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Enter mapped to : in normal mode
nnoremap <Enter> :

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" tab navigation
nnoremap J :tabprev<CR>
nnoremap K :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>

" Enter mapped to EasyAlign in visual mode
vnoremap <Enter> :EasyAlign

" keep search pattern at the center of the screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" toggle line wrapping
noremap <leader>w :set wrap!<cr>
noremap <leader>n :set number!<cr>

""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""
" nerdtree
map <Leader>d :NERDTreeToggle<CR>

"fzf
noremap <c-p> :FZF ~<cr>

vmap <silent> <C-_> :call ToggleCommentVisual()<CR>
nmap <silent> <C-_> :call ToggleCommentLine()<CR>
imap <silent> <C-_> <Esc>:call ToggleCommentLine()

augroup easyCommentPluginConfig
  autocmd!
  au FileType perl let b:comment_style="inline"
  au FileType perl let b:comment_opener="# "
  au FileType conf let b:comment_style="inline"
  au FileType conf let b:comment_opener="# "
  au FileType bash,sh let b:comment_style="inline"
  au FileType bash,sh let b:comment_opener="# "
  au FileType cpp let b:comment_style="block"
  au FileType cpp let b:comment_opener='/*'
  au FileType cpp let b:comment_closer='*/'
augroup END

" autoswap config
let g:autoswap_detect_tmux = 1

" auto-pairs
let g:AutoPairsCenterLine = 0

""""""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""""""

" returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" started In Diff-Mode set diffexpr (plugin not loaded yet)
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'component': {
    \   'lineinfo': ' %3l:%-2v',
    \ },
    \ 'component_function': {
    \   'readonly': 'LightlineReadonly',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }
function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

nnoremap <silent>so :MaximizerToggle<CR>
vnoremap <silent>so :MaximizerToggle<CR>gv

set swapfile
set backupdir=~/.vim/backup//   " custom location for vim safety net
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

