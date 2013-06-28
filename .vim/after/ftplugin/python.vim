if exists('b:did_after_ftplugin_python')
  finish
endif
let b:did_after_ftplugin_python = 1
let s:save_cpo = &cpo
set cpo&vim

"http://dann.g.hatena.ne.jp/dann/20091128
setl autoindent
setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
setl tabstop=4 expandtab shiftwidth=4 softtabstop=4 smarttab
setl omnifunc=pythoncomplete#Complete

let python_highlight_all=1

setl tags+=~/.vim/tags/python/python.tags

setl formatoptions-=r " 挿入モードで改行した時に # を自動挿入しない
setl formatoptions-=o " ノーマルモードで o や O をした時に # を自動挿入しない

augroup after_ftplugin_python
  autocmd!
  autocmd BufWritePre *.py call RTrim()
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
