if exists('b:did_after_ftplugin_elm')
  finish
endif
let b:did_after_ftplugin_elm = 1
let s:save_cpo = &cpo
set cpo&vim

let g:elm_format_autosave = 1

let &cpo = s:save_cpo
unlet s:save_cpo
