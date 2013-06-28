if exists('b:did_after_ftplugin_scala')
  finish
endif
let b:did_after_ftplugin_scala = 1
let s:save_cpo = &cpo
set cpo&vim

setl ts=2 sw=2 sts=2 expandtab
command! SbtVimShell execute ":VimShellInteractive sbt"
setl path+=src/main/scala/**,src/test/scala/**,src/scala/**,test/scala/**
setl suffixesadd+=.scala
augroup after_ftplugin_scala
  autocmd!
  autocmd BufWritePre *.scala call RTrim()
augroup END

let b:scommenter_class_author='HARUYAMA Seigo'
let b:scommenter_file_author='HARUYAMA Seigo'
let b:scommenter_extra_line_text_offset = 20

noremap <M-c> :call ScalaCommentWriter()<CR>
noremap <M-f> :call ScalaCommentFormatter()<CR>
noremap cm :call ScalaCommentWriter()<CR>
noremap cf :call ScalaCommentFormatter()<CR>
let &cpo = s:save_cpo
unlet s:save_cpo
