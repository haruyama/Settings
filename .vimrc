autocmd!

source $HOME/.vim/my/basic.vim
source $HOME/.vim/my/template.vim

source $HOME/.vim/my/command.vim
"source $HOME/.vim/my/mark.vim
source $HOME/.vim/my/misc.vim
source $HOME/.vim/my/tab.vim
source $HOME/.vim/my/quickfixgrep.vim

source $HOME/.vim/my/dein.vim

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

if has('gui_running')
  set guifont=DejaVu\ Sans\ Mono:h20
end
let g:neovide_cursor_animate_in_insert_mode = 0
let g:neovide_cursor_animate_command_line = 0

if has('nvim')
  set mouse=
else
  call setcellwidths([[0x2500, 0x25ff, 1]])
end
