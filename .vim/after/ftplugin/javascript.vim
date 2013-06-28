if exists('b:did_after_ftplugin_javascript')
  finish
endif
let b:did_after_ftplugin_javascript = 1
let s:save_cpo = &cpo
set cpo&vim

setl tabstop=2 expandtab shiftwidth=2 softtabstop=2 smarttab
let g:SimpleJsIndenter_BriefMode = 1

augroup after_ftplugin_javascript
  autocmd!
  autocmd BufWritePre *.js call RTrim()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
