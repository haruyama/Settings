if exists('b:did_after_ftplugin_php')
  finish
endif
let b:did_after_ftplugin_php = 1
let s:save_cpo = &cpo
set cpo&vim

setl ts=4 sw=4 sts=4 expandtab
setl omnifunc=phpcomplete#CompletePHP
setl tags+=./tags.vendors,tags.vendors

setl path+=src;/,lib;/,test;/,vendor;/
setl includeexpr=substitute(substitute(v:fname,'::.*$','',''),'\\\','/','g')

if !exists('g:neocomplete#delimiter_patterns')
  let g:neocomplete#delimiter_patterns = {}
endif
let g:neocomplete#delimiter_patterns['php'] = []

let g:syntastic_php_phpcs_args='--report=csv --standard=PSR2'
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']

let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <buffer> <Leader>d :call pdv#DocumentWithSnip()<CR>

augroup after_ftplugin_php
  autocmd! BufWritePre <buffer> :RTrim
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
