autocmd!

source $HOME/.vim/my/neobundle.vim

source $HOME/.vim/my/basic.vim
source $HOME/.vim/my/template.vim
if (v:version >= 703) && (has('if_lua') || has('patch885'))
  source $HOME/.vim/my/neocomplete.vim
else
  source $HOME/.vim/my/neocomplcache.vim
endif
source $HOME/.vim/my/neosnippet.vim
source $HOME/.vim/my/tabularize.vim
source $HOME/.vim/my/gitgrep.vim
source $HOME/.vim/my/misc.vim
source $HOME/.vim/my/textmanip.vim
source $HOME/.vim/my/unite.vim

if filereadable(expand('~/.vimrc.local'))
  source $HOME/.vimrc.local
end
