autocmd!

" source $HOME/.vim/my/neobundle.vim
source $HOME/.vim/my/dein.vim

source $HOME/.vim/my/basic.vim
source $HOME/.vim/my/template.vim

source $HOME/.vim/my/command.vim
"source $HOME/.vim/my/mark.vim
source $HOME/.vim/my/misc.vim
source $HOME/.vim/my/tab.vim
source $HOME/.vim/my/quickfixgrep.vim

if filereadable(expand('~/.vimrc.local'))
  source $HOME/.vimrc.local
end
