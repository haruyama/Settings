if exists('b:did_after_ftplugin_r')
  finish
endif
let b:did_after_ftplugin_r = 1
let s:save_cpo = &cpo
set cpo&vim
let &cpo = s:save_cpo
unlet s:save_cpo
