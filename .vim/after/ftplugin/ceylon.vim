if exists('b:did_after_ftplugin_ceylon')
  finish
endif
let b:did_after_ftplugin_ceylon = 1
let s:save_cpo = &cpo
set cpo&vim
setl ts=4 sw=4 sts=4 expandtab
augroup after_ftplugin_ceylon
  autocmd! BufWritePre <buffer> :RTrim
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
