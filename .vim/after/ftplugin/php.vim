if exists('b:did_after_ftplugin_php')
  finish
endif
let b:did_after_ftplugin_php = 1
let s:save_cpo = &cpo
set cpo&vim

setl ts=4 sw=4 sts=4 expandtab
setl omnifunc=phpcomplete#CompletePHP
setl tags+=./tags.vendors,tags.vendors

augroup after_ftplugin_php
  autocmd! BufWritePre <buffer> :RTrim
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
