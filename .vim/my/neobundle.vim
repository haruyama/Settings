set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'Shougo/neobundle.vim'

NeoBundle 'paredit.vim'
NeoBundle 'surround.vim'
NeoBundle 'eregex.vim'
NeoBundle 'YankRing.vim'
NeoBundle 'errormarker.vim'
"NeoBundle 'thermometer'
NeoBundle 'fugitive.vim'
"NeoBundle 'coq-syntax'
NeoBundle 'neco-look'
"NeoBundle 'matchit.zip'
"NeoBundle 'multvals.vim'
"NeoBundle 'genutils'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-template'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'

NeoBundle 'honza/vim-snippets'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'sjl/gundo.vim'
NeoBundle 't9md/vim-textmanip'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'kmnk/vim-unite-giti.git'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'haruyama/EnhCommentify.vim'
NeoBundle 'haruyama/gtags.vim'
"NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'kablamo/vim-git-log'
NeoBundle 'hrsh7th/vim-versions'
NeoBundle 'superbrothers/vim-vimperator'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'haruyama/vim-matchopen'
NeoBundle 'gregsexton/gitv'
NeoBundle 'amdt/vim-niji'

NeoBundleLazy 'tpope/vim-classpath', {
      \ "autoload": {
      \   "filetypes": ["clojure", "java"],
      \ }}

NeoBundleLazy 'tpope/vim-fireplace', {
      \ "autoload": {
      \   "filetypes": ["clojure"],
      \ }}

NeoBundleLazy 'thinca/vim-ft-clojure', {
      \ "autoload": {
      \   "filetypes": ["clojure"],
      \ }}
"NeoBundleLazy 'liquidz/lein-vim', {
"      \ "autoload": {
"      \   "filetypes": ["clojure"],
"      \ }}

NeoBundleLazy "elixir-lang/vim-elixir", {
      \ "autoload": {
      \   "filetypes": ["elixir"],
      \ }}

NeoBundleLazy 'jimenezrick/vimerl', {
      \ "autoload": {
      \   "filetypes": ["erlang"],
      \ }}

NeoBundleLazy 'ujihisa/neco-ghc', {
      \ "autoload": {
      \   "filetypes": ["haskell"],
      \ }}
NeoBundleLazy 'eagletmt/unite-haddock' , {
      \ "autoload": {
      \   "filetypes": ["haskell"],
      \ }}

NeoBundleLazy 'html5.vim', {
      \ "autoload": {
      \   "filetypes": ["html"],
      \ }}

NeoBundleLazy 'pekepeke/ref-javadoc', {
      \ "autoload": {
      \   "filetypes": ["java"],
      \ }}


NeoBundleLazy 'Simple-Javascript-Indenter', {
      \ "autoload": {
      \   "filetypes": ["javascript"],
      \ }}

NeoBundleLazy 'nakatakeshi/jump2pm.vim.git', {
      \ "autoload": {
      \   "filetypes": ["perl"],
      \ }}
NeoBundleLazy 'vim-perl/vim-perl', {
      \ "autoload": {
      \   "filetypes": ["perl"],
      \ }}

NeoBundleLazy 'tpope/gem-ctags', {
      \ "autoload": {
      \   "filetypes": ["ruby"],
      \ }}
NeoBundleLazy 'tpope/vim-bundler', {
      \ "autoload": {
      \   "filetypes": ["ruby"],
      \ }}
NeoBundleLazy 'tpope/vim-rake', {
      \ "autoload": {
      \   "filetypes": ["ruby"],
      \ }}

NeoBundleLazy 'derekwyatt/vim-scala', {
      \ "autoload": {
      \   "filetypes": ["scala"],
      \ }}

NeoBundleLazy 'haruyama/scheme.vim', {
      \ "autoload": {
      \   "filetypes": ["scheme"],
      \ }}

NeoBundleLazy "vim-pandoc/vim-pandoc", {
      \ "autoload": {
      \   "filetypes": ["text", "pandoc", "markdown", "rst", "textile"],
      \ }}

"NeoBundle 'airblade/vim-gitgutter'
"NeoBundle 'haruyama/jump2clj.vim'
"NeoBundle 'glidenote/memolist.vim'

filetype plugin indent on
