set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'Shougo/neobundle.vim'

NeoBundle 'paredit.vim'
NeoBundle 'YankRing.vim'
NeoBundle 'errormarker.vim'

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

if g:my_use_neocomplete
  NeoBundle 'Shougo/neocomplete'
else
  NeoBundle 'Shougo/neocomplcache'
endif

NeoBundle 'Shougo/neosnippet'

NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'amdt/vim-niji'
NeoBundle 'bling/vim-airline'
NeoBundle 'gregsexton/gitv'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'haruyama/EnhCommentify.vim'
NeoBundle 'haruyama/vim-matchopen'
NeoBundle 'honza/vim-snippets'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'othree/eregex.vim'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-template'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'violetyk/gitquick.vim'

NeoBundleLazy 'mattn/excitetranslate-vim', {
      \ 'depends': 'mattn/webapi-vim',
      \ 'autoload' : { 'commands': ['ExciteTranslate']}
      \ }

NeoBundleLazy 'tpope/vim-classpath', {
      \ "autoload": {
      \   "filetypes": ["clojure", "java", "scala"],
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

NeoBundleLazy 'kongo2002/fsharp-vim', {
      \ "autoload": {
      \   "filetypes": ["fsharp"],
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

NeoBundleLazy 'superbrothers/vim-vimperator', {
      \ "autoload": {
      \   "filetypes": ["vimperator"],
      \ }}

"NeoBundle 't9md/vim-textmanip'
"NeoBundle 'sjl/gundo.vim'
"NeoBundle 'majutsushi/tagbar'
"NeoBundle 'kmnk/vim-unite-giti.git'
"NeoBundle 'nathanaelkane/vim-indent-guides'
"NeoBundle 'haruyama/gtags.vim'

filetype plugin indent on
