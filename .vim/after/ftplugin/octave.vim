if exists('b:did_after_ftplugin_octave')
  finish
endif
let b:did_after_ftplugin_octave = 1
let s:save_cpo = &cpo
set cpo&vim

setl tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab

setl omnifunc=syntaxcomplete#Complete

augroup after_ftplugin_octave
  autocmd!
  autocmd BufWritePre *.{m,oct} :RTrim
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
