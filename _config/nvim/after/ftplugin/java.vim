if exists('b:did_after_ftplugin_java')
  finish
endif
let b:did_after_ftplugin_java = 1
let s:save_cpo = &cpo
set cpo&vim

setl include=^\s*import
setl includeexpr=substitute(substitute(v:fname,'\\.','/','g'),';','','g')
setl path+=src/main/java/**,src/test/java/**,src/java/**,src/test/**,src/core/**

let java_highlight_all=1
let java_highlight_functions="style"
let java_highlight_debug=1
let java_space_errors=1
let java_allow_cpp_keywords=1

setl ts=4 sw=4 sts=4 expandtab

"augroup after_ftplugin_java
"  function! s:set_syntastic_java_javac_options()
"    let g:syntastic_java_javac_options = '-Xlint -cp ' . classpath#from_vim(&path)
"  endfunction
"  autocmd! BufWritePre <buffer> call s:set_syntastic_java_javac_options()
"augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
