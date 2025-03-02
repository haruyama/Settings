autocmd!

lua <<EOS
vim.loader.enable()
EOS

source $HOME/.vim/my/basic.vim
source $HOME/.vim/my/template.vim

source $HOME/.vim/my/command.vim
"source $HOME/.vim/my/mark.vim
source $HOME/.vim/my/misc.vim
source $HOME/.vim/my/tab.vim
" source $HOME/.vim/my/quickfixgrep.vim

source $HOME/.vim/my/jetpack.vim

if has('vim_starting') && !empty(argv())
  if execute('filetype') =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endif


if filereadable(expand('~/.vimrc.local'))
  source $HOME/.vimrc.local
end

if has('nvim')
  set mouse=
end
call setcellwidths([[0x2500, 0x25ff, 1]])
