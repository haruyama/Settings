if exists('b:did_after_ftplugin_c')
  finish
endif
let b:did_after_ftplugin_c = 1
let s:save_cpo = &cpo
set cpo&vim

setl path+=/usr/include/x86_64-linux-gnu
setl ts=2 sw=2 sts=2 expandtab
setl omnifunc=ccomplete#Complete

let g:syntastic_c_compiler_options = ' -std=gnu11 -I ./inc -I ./include'

augroup after_ftplugin_c
  autocmd! BufWritePre <buffer> :RTrim
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
