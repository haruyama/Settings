if exists('b:did_after_ftplugin_html')
  finish
endif
let b:did_after_ftplugin_html = 1
let s:save_cpo = &cpo
set cpo&vim

setl ts=2 sw=2 sts=2 expandtab
let &cpo = s:save_cpo
unlet s:save_cpo
