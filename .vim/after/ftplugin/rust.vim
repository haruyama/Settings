if exists('b:did_after_ftplugin_rust')
  finish
endif
let b:did_after_ftplugin_rust = 1
let s:save_cpo = &cpo
set cpo&vim

setl iskeyword+=!

let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config['rust'] = {
            \   'exec' : 'cargo run',
            \ }
let &cpo = s:save_cpo
unlet s:save_cpo
