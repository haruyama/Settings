if exists('b:did_after_ftplugin_perl')
  finish
endif
let b:did_after_ftplugin_perl = 1
let s:save_cpo = &cpo
set cpo&vim

setl ts=4 sw=4 sts=4 expandtab shiftround
setlocal formatoptions-=r " 挿入モードで改行した時に # を自動挿入しない
setlocal formatoptions-=o " ノーマルモードで o や O をした時に # を自動挿入しない

let g:syntastic_perl_lib_path = './lib'

nnoremap <buffer> <silent> ,f :!perldoc -f <cword><Enter>

"setl path+=lib
"setl isfname-=-
noremap <buffer> gf :call Jump2pm('sp')<ENTER>
let &cpo = s:save_cpo
unlet s:save_cpo
