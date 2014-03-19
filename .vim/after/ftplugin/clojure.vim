if exists('b:did_after_ftplugin_clojure')
  finish
endif
let b:did_after_ftplugin_clojure = 1
let s:save_cpo = &cpo
set cpo&vim

setl tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab

if executable('lein') && filereadable('project.clj')
  let b:is_lein_available = 1
"  call vimshell#util#set_dictionary_helper(g:vimshell_interactive_interpreter_commands, 'clojure', 'lein repl')
endif

if exists('*PareditInitBuffer')
  call PareditInitBuffer()
  nnoremap <SID>(toggle-paredit) :<C-u>call PareditToggle()<CR>
  nmap <buffer> <Leader>4 <SID>(toggle-paredit)
endif

setl includeexpr=substitute(substitute(v:fname,'/.*$','',''),'\\.','/','g')
setl path+=src;/,test;/
setl suffixesadd=.clj,.cljs

augroup after_ftplugin_clojure
  autocmd! BufWritePre <buffer> :RTrim
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
