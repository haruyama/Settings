if exists('b:did_after_ftplugin_go')
  finish
endif
let b:did_after_ftplugin_go = 1
let s:save_cpo = &cpo
set cpo&vim

setl tabstop=4 noexpandtab shiftwidth=4 softtabstop=4 smarttab
let g:gocode_gofmt_tabs = ' -tabs=true'
let g:gocode_gofmt_tabwidth = ' -tabwidth=4'

let &cpo = s:save_cpo
unlet s:save_cpo
