autocmd!

if has('lua') && ( v:version > 703 || (v:version == 703 && has('patch885')))
  let g:my_use_neocomplete = 1
else 
  let g:my_use_neocomplete = 0
endif

source $HOME/.vim/my/neobundle.vim

source $HOME/.vim/my/basic.vim
source $HOME/.vim/my/template.vim

if g:my_use_neocomplete
  source $HOME/.vim/my/neocomplete.vim
else
  source $HOME/.vim/my/neocomplcache.vim
endif

source $HOME/.vim/my/neosnippet.vim
source $HOME/.vim/my/unite.vim
source $HOME/.vim/my/command.vim
source $HOME/.vim/my/misc.vim

if filereadable(expand('~/.vimrc.local'))
  source $HOME/.vimrc.local
end
