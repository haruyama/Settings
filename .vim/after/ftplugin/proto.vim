if exists('b:did_after_ftplugin_proto')
  finish
endif
let b:did_after_ftplugin_proto = 1
let s:save_cpo = &cpo
set cpo&vim

setl ts=2 sw=2 sts=2 expandtab

augroup after_ftplugin_proto
  autocmd! BufWritePre <buffer> :RTrim
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
