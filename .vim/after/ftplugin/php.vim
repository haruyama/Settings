if exists('b:did_after_ftplugin_php')
  finish
endif
let b:did_after_ftplugin_php = 1
let s:save_cpo = &cpo
set cpo&vim

setl ts=4 sw=4 sts=4 expandtab
setl omnifunc=phpcomplete#CompletePHP
setl tags+=./tags.vendors,tags.vendors

noremap <Leader>d :call PhpDoc()<CR>

inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>

inoremap <Leader>e <C-O>:call PhpExpandClass()<CR>
noremap <Leader>e :call PhpExpandClass()<CR>

setl path+=src;/,lib;/,test;/,vendor;/
setl includeexpr=substitute(substitute(v:fname,'::.*$','',''),'\\\','/','g')

if !exists('g:neocomplcache_delimiter_patterns')
  let g:neocomplete#delimiter_patterns = {}
endif
let g:neocomplete#delimiter_patterns['php'] = []

augroup after_ftplugin_php
  autocmd! BufWritePre <buffer> :RTrim
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
