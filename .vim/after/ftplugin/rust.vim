if exists('b:did_after_ftplugin_rust')
  finish
endif
let b:did_after_ftplugin_rust = 1
let s:save_cpo = &cpo
set cpo&vim

augroup after_ftplugin_rust
  autocmd! BufWritePre <buffer> :RustFmt
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
