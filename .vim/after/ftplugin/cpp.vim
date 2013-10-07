if exists('b:did_after_ftplugin_cpp')
  finish
endif
let b:did_after_ftplugin_cpp = 1
let s:save_cpo = &cpo
set cpo&vim

let g:syntastic_cpp_compiler_options = ' -std=c++11 -I ./inc -I ./include'

setl ts=2 sw=2 sts=2 expandtab
setl omnifunc=ccomplete#Complete

setl path+=src;/,inc;/,include;/
setl suffixesadd=.hpp,.cpp

augroup after_ftplugin_cpp
  autocmd! BufWritePre <buffer> :RTrim
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
