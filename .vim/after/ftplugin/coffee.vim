if exists('b:did_after_ftplugin_coffee')
  finish
endif
let b:did_after_ftplugin_coffee = 1
let s:save_cpo = &cpo
set cpo&vim

setl ts=2 sw=2 sts=2 expandtab smarttab

augroup after_ftplugin_javascript
  autocmd! BufWritePre <buffer> :RTrim
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
