if exists('b:did_after_ftplugin_c')
  finish
endif
let b:did_after_ftplugin_c = 1
let s:save_cpo = &cpo
set cpo&vim

setl path+=/usr/include/x86_64-linux-gnu
setl ts=2 sw=2 sts=2 expandtab
setl omnifunc=ccomplete#Complete

augroup after_ftplugin_c
  autocmd!
  autocmd BufWritePre  *.{c,h} call RTrim()
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
