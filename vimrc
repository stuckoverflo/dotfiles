" Install vim-plug if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }

Plug 'wincent/ferret'

Plug 'itchyny/vim-gitbranch'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'

Plug 'sheerun/vim-polyglot'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'mattn/emmet-vim'

Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'

Plug 'Vimjas/vim-python-pep8-indent'
Plug 'fisadev/vim-isort'

Plug 'chrisbra/vim-diff-enhanced'
Plug 'vim-scripts/VimCompletesMe'
Plug 'szw/vim-maximizer'

Plug 'mtth/scratch.vim'
Plug 'google/vim-searchindex'
Plug 'romainl/vim-cool'

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'jacoborus/tender.vim'

" test if they will be useful
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'tweekmonster/braceless.vim'
Plug 'posva/vim-vue'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jsborjesson/vim-uppercase-sql'
Plug 'airblade/vim-gitgutter'

call plug#end()

if (has("termguicolors"))
    set termguicolors
endif

if !exists("g:syntax_on")
    syntax enable
endif

filetype plugin on
filetype indent on

set background=dark
color gruvbox
let g:gruvbox_bold = 0

set fillchars=""

set ttyfast                     " for fast terminal connections

set history=1000                " sets how many lines of history VIM has to remember

set autoread                    " set to auto read when a file is changed from the outside

let mapleader = " "             " map space as leader
let g:mapleader = " "

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

set ai                          " auto indent
set si                          " smart indent
set nowrap                      " don't wrap lines

set showcmd                     " show commands the user enters
set laststatus=2                " always show the status line

set nohlsearch                  " turn off highlighting

set noshowmode                  " already taken care of by vim-airline

set directory=/tmp
set nobackup                    " disable backup
set nowritebackup               " disable backup
set noswapfile                  " disable swapfiles

set colorcolumn=120
set fillchars=vert:\│

let python_highlight_all=1

set expandtab
set tabstop=4
set shiftwidth=4

" use hard tabs for Makefile
autocmd FileType make setlocal noexpandtab
autocmd FileType typescript,javascript,jsx,tsx,css,html,ruby,elixir,kotlin,vim,plantuml,vue,json
  \ setlocal expandtab tabstop=2 shiftwidth=2

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
command! -complete=file -bang -nargs=? Wqa :wqa<bang> <args>
command! -complete=file -bang -nargs=? WQa :wqa<bang> <args>
command! -complete=file -bang -nargs=? Q :q<bang>
command! -complete=file -bang -nargs=? Qa :qa<bang>

" disable arrow keys
noremap <up> :echo "use k"<cr>
noremap <down> :echo "use j"<cr>
noremap <left> :echo "use h"<cr>
noremap <right> :echo "use l"<cr>

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

" <Esc> alternatives
inoremap jj <Esc>:update<CR>
inoremap JJ <Esc>:update<CR>
inoremap jk <Esc>:update<CR>

" returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  en
    return ''
endfunction
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" disable paste mode when exiting Insert mode
augroup disablePasteModeWhenExitingInsertMode
  autocmd!
  au InsertLeave * set nopaste
augroup END

" buffers
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

" automatically turn search highlighting on when searching
nnoremap / :set hlsearch<CR>/
nnoremap ? :set hlsearch<CR>?

" remove trailing whitespaces
noremap <leader><c-@> :%s/\s\+$<CR>

" quick save
nnoremap <leader><space> :update<cr>

" quickly edit and reload vimrc
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" copy to clipboard
" noremap <leader>y "*y
noremap <leader>y y

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

" toggle line wrapping
nnoremap <leader>w :set wrap!<cr>
nnoremap <leader>n :set number!<cr>
nnoremap <leader>r :set relativenumber!<cr>

""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""

" autoswap config
let g:autoswap_detect_tmux = 1

" auto-pairs
let g:AutoPairsCenterLine = 0

" vim-ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_sign_error = '✹'
let g:ale_sign_warning = '✹'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %code: %%s [%severity%]'

let g:ale_linters = {
  \ 'javascript': ['standard'],
  \ 'json': ['fixjson'],
  \ }

let g:ale_fixers = {
  \ 'javascript': ['standard'],
  \ 'json': ['fixjson'],
  \ 'python': ['black'],
  \ }

" started In Diff-Mode set diffexpr (plugin not loaded yet)
if &diff
   let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

let g:lightline = {
   \ 'colorscheme': 'gruvbox',
   \ 'active': {
   \   'left': [ [ 'mode', 'paste' ],
   \             [ 'gitbranch', 'readonly', 'filename', 'modified' ]  ],
   \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
   \              [ 'lineinfo' ]],
   \ },
   \ 'component': {
   \   'lineinfo': ' %3l:%-2v',
   \ },
   \ 'component_expand': {
   \   'linter_checking': 'lightline#ale#checking',
   \   'linter_warnings': 'lightline#ale#warnings',
   \   'linter_errors': 'lightline#ale#errors',
   \   'linter_ok': 'lightline#ale#ok',
   \ },
   \ 'component_function': {
   \   'readonly': 'LightlineReadonly',
   \   'gitbranch': 'gitbranch#name'
   \ },
   \ 'component_type': {
   \   'linter_checking': 'left',
   \   'linter_warnings': 'warning',
   \   'linter_errors': 'error',
   \   'linter_ok': 'left',
   \ },
   \ 'mode_map': {
   \   'n' : ' N ',
   \   'i' : ' I ',
   \   'R' : ' R ',
   \   'v' : ' V ',
   \   'V' : ' V ',
   \   "\<C-v>": ' V ',
   \   's' : ' S ',
   \   'S' : ' S ',
   \   "\<C-s>": ' S ',
   \   "c" : ' / '
   \   }
   \ }
function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

command! LightlineReload call LightlineReload()

function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071\u0020"
let g:lightline#ale#indicator_errors = "\uf05e\u0020"
let g:lightline#ale#indicator_ok = "\uf00c"

" vim-maximizer
nnoremap <silent>so :MaximizerToggle<CR>
vnoremap <silent>so :MaximizerToggle<CR>gv

" fzf
nnoremap <silent> <TAB> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

noremap <c-p> :FZF <cr>

" Z - fzf to recent / frequent directories
command! -nargs=* Z :call Z(<f-args>)
function! Z(...)
  let cmd = 'fasd -d -e printf'
  for arg in a:000
    let cmd = cmd . ' ' . arg
  endfor
  let path = system(cmd)
  if isdirectory(path)
    echo path
    exec 'FZF' fnameescape(path)
  endif
endfunction

" scratch plugin
let g:scratch_insert_autohide = 0
let g:scratch_height = 60
let g:scratch_horizontal = 0
let g:scratch_top = 0
nnoremap gs <Esc> :Scratch <cr>
xnoremap gs <Esc> :Scratch <cr>

" braceless
autocmd FileType python BracelessEnable +indent

" vim-cool
let g:CoolTotalMatches = 1

" ultisnips 
let g:UltiSnipsExpandTrigger="<C-@>"
let g:UltiSnipsJumpForwardTrigger="<c-@>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" vim-gitgutter
set updatetime=100
let g:gitgutter_override_sign_column_highlight = 0
let g:gruvbox_sign_column = 'bg0'
nnoremap <leader>g :GitGutterToggle<cr>

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'

if system('uname -r') =~ "Microsoft"
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe ',@")
  augroup END
endif

