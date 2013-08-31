if exists('b:did_after_ftplugin_clojure')
  finish
endif
let b:did_after_ftplugin_clojure = 1
let s:save_cpo = &cpo
set cpo&vim

setl tabstop=2 expandtab shiftwidth=2 softtabstop=2 smarttab

if executable('lein') && filereadable('project.clj')
  let b:is_lein_available = 1
  call vimshell#set_dictionary_helper(g:vimshell_interactive_interpreter_commands, 'clojure', 'lein repl')
endif

if exists('*PareditInitBuffer')
  call PareditInitBuffer()
  nnoremap <SID>(toggle-paredit) :<C-u>call PareditToggle()<CR>
  nmap <buffer> <Leader>4 <SID>(toggle-paredit)
endif

setl includeexpr=substitute(substitute(v:fname,'/.*$','',''),'\\.','/','g')
setl path+=src;/,test;/
setl suffixesadd=.clj,.cljs

function! s:run_kibit()
  if !exists('b:is_lein_available')
    return
  endif
  call fireplace#session_eval('(require ''kibit.driver)(kibit.driver/run {:source-path "src"})')
endfunction

command! Kibit call s:run_kibit()

augroup after_ftplugin_clojure
  autocmd!
  autocmd BufWritePre *.{clj,cljs} :RTrim
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
