if exists('b:did_after_ftplugin_haskell')
  finish
endif
let b:did_after_ftplugin_haskell = 1
let s:save_cpo = &cpo
set cpo&vim

setlocal omnifunc=necoghc#omnifunc

nnoremap <silent> ,uh :<C-u>Unite haddock<CR>
let &cpo = s:save_cpo
unlet s:save_cpo
