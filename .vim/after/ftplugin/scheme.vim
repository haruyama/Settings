if exists('b:did_after_ftplugin_scheme')
  finish
endif
let b:did_after_ftplugin_scheme = 1
let s:save_cpo = &cpo
set cpo&vim

augroup after_ftplugin_scheme
  autocmd!
  autocmd FileType scheme :let is_gauche=1
augroup END

if exists('*PareditInitBuffer')
  call PareditInitBuffer()
  nnoremap <SID>(toggle-paredit) :<C-u>call PareditToggle()<CR>
  nmap <Leader>4 <SID>(toggle-paredit)
endif

let g:gosh_enable_auto_use = 1
let &cpo = s:save_cpo
unlet s:save_cpo
