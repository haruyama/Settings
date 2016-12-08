if exists('b:did_after_ftplugin_crystal')
  finish
endif
let b:did_after_ftplugin_crystal = 1
let s:save_cpo = &cpo
set cpo&vim

setl ts=2 sw=2 sts=2 expandtab
setl path+=lib
setl iskeyword+=?

setl formatoptions-=r " 挿入モードで改行した時に # を自動挿入しない
setl formatoptions-=o " ノーマルモードで o や O をした時に # を自動挿入しない

"let g:rails_level=4
"let g:rails_default_file="app/controllers/application.rb"
"let g:rails_default_database="sqlite3"

augroup after_ftplugin_crystal
  autocmd! BufWritePre <buffer> :RTrim
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
