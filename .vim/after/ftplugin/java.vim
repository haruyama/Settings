if exists('b:did_after_ftplugin_java')
  finish
endif
let b:did_after_ftplugin_java = 1
let s:save_cpo = &cpo
set cpo&vim

setl path+=src/main/java/**,src/test/java/**,src/java/**,src/test/**,src/core/**

let java_highlight_all=1
let java_highlight_functions="style"
let java_highlight_debug=1
let java_space_errors=1
let java_allow_cpp_keywords=1

setl ts=2 sw=2 sts=2 expandtab
let &cpo = s:save_cpo
unlet s:save_cpo
