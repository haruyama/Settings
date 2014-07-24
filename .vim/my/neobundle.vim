set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'subosito/vim-256colors'

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neomru.vim'

NeoBundle 'AutoTag'
NeoBundle 'paredit.vim'
NeoBundle 'errormarker.vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

if g:my_use_neocomplete
  NeoBundleLazy 'Shougo/neocomplete', {
        \   'depends' : ['Shougo/neosnippet', 'Shougo/context_filetype.vim'],
        \   'vim_version' : '7.3.885',
        \   'autoload' : {
        \       'insert' : 1,
        \   }
        \ }
else
  NeoBundleLazy 'Shougo/neocomplcache', {
        \   'depends' : ['Shougo/neosnippet'],
        \   'autoload' : {
        \       'insert' : 1,
        \   }
        \}
endif

NeoBundleLazy 'Shougo/vimfiler', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload' : {
      \       'commands' : [ 'VimFilerTab', 'VimFiler', 'VimFilerExplorer', 'VimFilerBufferDir' ],
      \       'mappings' : ['<Plug>(vimfiler_switch)'],
      \       'explorer' : 1,
      \   }
      \}

NeoBundleLazy 'Shougo/vimshell', {
      \ 'depends' : ['Shougo/vimproc'],
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'VimShell',
      \                   'complete' : 'customlist,vimshell#complete'},
      \                 'VimShellExecute', 'VimShellInteractive',
      \                 'VimShellTerminal', 'VimShellPop'],
      \   'mappings' : ['<Plug>(vimshell_switch)']
      \ }}

NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'amdt/vim-niji'
NeoBundle 'bling/vim-airline'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'haruyama/EnhCommentify.vim'
NeoBundle 'haruyama/vim-matchopen'
NeoBundle 'honza/vim-snippets'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-template'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'LeafCage/yankround.vim'

if v:version > 702
  NeoBundle 'osyo-manga/vim-precious', {
        \   'depends' : ['Shougo/context_filetype.vim'],
        \ }
endif

NeoBundle 'kana/vim-textobj-user'
NeoBundle 'osyo-manga/vim-textobj-multiblock'
NeoBundle 'osyo-manga/vim-textobj-multitextobj'
NeoBundle 'sgur/vim-textobj-parameter'

NeoBundleLazy 'gregsexton/gitv', {
      \ 'autoload' : { 'commands': ['Gitv']}
      \ }

NeoBundleLazy 'tyru/capture.vim' , {
      \ 'autoload' : { 'commands': ['Capture']}
      \ }

NeoBundleLazy 'thinca/vim-prettyprint', {
      \ 'autoload' : { 'commands': ['PP']}
      \ }

NeoBundleLazy 'mattn/excitetranslate-vim', {
      \ 'depends' : 'mattn/webapi-vim',
      \ 'autoload' : { 'commands': ['ExciteTranslate']}
      \ }

NeoBundleLazy 'thinca/vim-ref', {
      \ 'autoload' : { 'commands': ['Ref']}
      \ }

NeoBundleLazy 'violetyk/gitquick.vim', {
      \ 'autoload' : { 'commands': ['Gitquick']}
      \ }

"NeoBundleLazy 'chochos/ceylon-vim', {
"      \ "autoload": {
"      \   "filetypes": ["ceylon"],
"      \ }}
"
NeoBundleLazy 'kchmck/vim-coffee-script', {
      \ "autoload": {
      \   "filetypes": ["coffee"],
      \ }}

NeoBundleLazy 'tpope/vim-classpath', {
      \ "autoload": {
      \   "filetypes": ["clojure", "java", "scala"],
      \ }}

NeoBundleLazy 'tpope/vim-fireplace', {
      \ "autoload": {
      \   "filetypes": ["clojure"],
      \ }}

NeoBundleLazy 'guns/vim-clojure-static', {
      \ "autoload": {
      \   "filetypes": ["clojure"],
      \ }}

NeoBundleLazy 'guns/vim-clojure-highlight', {
      \ "autoload": {
      \   "filetypes": ["clojure"],
      \ }}

NeoBundleLazy 'aohta/blockdiag.vim', {
      \ "autoload": {
      \   "filetypes": ["diag"],
      \ }}

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

"NeoBundleLazy 'Blackrush/vim-gocode', {
"NeoBundleLazy 'jnwhiteh/vim-golang', {
NeoBundleLazy 'fatih/vim-go', {
      \ "autoload": {
      \   "filetypes": ["go"],
      \ }}

NeoBundleLazy 'rhysd/vim-go-impl', {
      \ "autoload": {
      \   "filetypes": ["go"],
      \ }}

NeoBundleLazy 'ujihisa/neco-ghc', {
      \ "autoload": {
      \   "filetypes": ["haskell"],
      \ }}
NeoBundleLazy 'eagletmt/unite-haddock' , {
      \ "autoload": {
      \   "filetypes": ["haskell"],
      \ }}

NeoBundleLazy 'othree/html5.vim', {
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

NeoBundleLazy 'groenewege/vim-less', {
      \ "autoload": {
      \   "filetypes": ["less"],
      \ }}

NeoBundleLazy 'plasticboy/vim-markdown', {
      \ "autoload": {
      \   "filetypes": ["markdown"],
      \ }}

NeoBundleLazy 'quangquach/octave.vim--', {
      \ "autoload": {
      \   "filetypes": ["octave"],
      \ }}

NeoBundleLazy 'arnaud-lb/vim-php-namespace', {
      \ "autoload": {
      \   "filetypes": ["php"],
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

NeoBundleLazy 'cespare/vim-toml', {
      \ 'autoload': {
      \   'filetypes': ['toml'],
      \ }}

NeoBundleLazy 'evidens/vim-twig', {
      \ "autoload": {
      \   "filetypes": ["twig"],
      \ }}

NeoBundleLazy 'dbakker/vim-lint', {
      \ 'depends' : 'scrooloose/syntastic',
      \ "autoload": {
      \   "filetypes": ["vim"],
      \ }}

NeoBundleLazy 'superbrothers/vim-vimperator', {
      \ "autoload": {
      \   "filetypes": ["vimperator"],
      \ }}

NeoBundleLazy 'mrk21/yaml-vim', {
      \ "autoload": {
      \   "filetypes": ["yaml"],
      \ }}

filetype plugin indent on
