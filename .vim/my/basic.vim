scriptencoding utf-8
set autoindent
set backup
set history=500
set ruler showcmd showmode incsearch ignorecase smartcase expandtab number modeline shiftround infercase hidden
"set cursorline cursorcolumn
set tabstop=4 softtabstop=4 bs=2 shiftwidth=0
set wildmenu
set wildmode=list:longest,full
set textwidth=0
set foldmethod=manual
if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
  else
    set clipboard=unnamed
  endif
endif
set completeopt=menuone
set backspace=indent,start,eol
set listchars=tab:»-,trail:_,extends:»,precedes:«,nbsp:%
set laststatus=2
set list
set matchpairs+=<:>
set nrformats-=octal
let g:netrw_liststyle=1
set autoread
set noswapfile
set nobackup
set viewoptions=folds,options,cursor,unix,slash
set iskeyword-=.
set iskeyword-=#

set ttyfast
set lazyredraw

set report=0
set synmaxcol=200

set t_Co=256
"set cmdheight=3
if &t_Co > 2 || has('gui_running')
  syntax on
  set hlsearch
endif

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,default,latin
set fileformats=unix,dos,mac

set ambiwidth=double

nnoremap Y y$
set display=lastline
set pumheight=11

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif
