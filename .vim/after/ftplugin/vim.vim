if exists('b:did_after_ftplugin_vim')
  finish
endif
let b:did_after_ftplugin_vim = 1
let s:save_cpo = &cpo
set cpo&vim

setl tabstop=2 expandtab shiftwidth=2 softtabstop=2 smarttab
let &cpo = s:save_cpo
unlet s:save_cpo
