if exists('b:did_after_ftplugin_markdown')
  finish
endif
let b:did_after_ftplugin_markdown = 1
let s:save_cpo = &cpo
set cpo&vim

setl ts=4 sw=4 sts=4 expandtab
let &cpo = s:save_cpo
unlet s:save_cpo
