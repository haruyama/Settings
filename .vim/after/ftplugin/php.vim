if exists('b:did_after_ftplugin_php')
  finish
endif
let b:did_after_ftplugin_php = 1
let s:save_cpo = &cpo
set cpo&vim

setl ts=4 sw=4 sts=4 expandtab
setl omnifunc=phpcomplete#CompletePHP
setl iskeyword-=-

augroup after_ftplugin_php
  autocmd! BufWritePre <buffer> :RTrim
  autocmd! BufWritePost <silent> :!phpcbf %
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
