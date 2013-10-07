set nocompatible
set ai
set backup
set history=500
set ruler showcmd showmode incsearch ignorecase smartcase expandtab number modeline shiftround infercase hidden
set tabstop=4 softtabstop=4 bs=2
set wildmenu
set wildmode=longest:full
set textwidth=0
set foldmethod=indent
set clipboard& clipboard+=autoselect
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif
set completeopt& completeopt+=longest
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).','.&ff.','.&ft.']'}%=%{fugitive#statusline()}\ %l,%c%V%8p
set backspace=indent,start,eol
"set listchars=tab:»-,trail:_,precedes:<,extends:>,nbsp:%
"set listchars=tab:»-,trail:_,extends:»,precedes:«,nbsp:%,eol:$
set listchars=tab:»-,trail:_,extends:»,precedes:«,nbsp:%
set laststatus=2
set list
set matchpairs& matchpairs+=<:>
set nrformats-=octal
let g:netrw_liststyle=1

"set cmdheight=3
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,default,latin
set fileformats=unix,dos,mac

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
