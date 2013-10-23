if exists('b:did_after_ftplugin_go')
  finish
endif
let b:did_after_ftplugin_go = 1
let s:save_cpo = &cpo
set cpo&vim

setl tabstop=4 expandtab shiftwidth=4 softtabstop=4 smarttab

let &cpo = s:save_cpo
unlet s:save_cpo
