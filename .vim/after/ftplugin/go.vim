if exists('b:did_after_ftplugin_go')
  finish
endif
let b:did_after_ftplugin_go = 1
let s:save_cpo = &cpo
set cpo&vim

setl tabstop=4 noexpandtab shiftwidth=4 softtabstop=4 smarttab
let g:gocode_gofmt_tabs = ' -tabs=true'
let g:gocode_gofmt_tabwidth = ' -tabwidth=4'

let g:go_snippet_engine = 'neosnippet'

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = 'goimports'

let g:syntastic_go_checkers = ['go']

augroup after_ftplugin_go
"  autocmd! BufWritePre *.go :GoImports
"  autocmd! BufWritePost *_test.go :GoTest
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
