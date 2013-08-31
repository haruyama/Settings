if exists('b:did_after_ftplugin_ruby')
  finish
endif
let b:did_after_ftplugin_ruby = 1
let s:save_cpo = &cpo
set cpo&vim

setl ts=2 sw=2 sts=2 expandtab
setl path+=lib

setl omnifunc=rubycomplete#Complete
setl formatoptions-=r " 挿入モードで改行した時に # を自動挿入しない
setl formatoptions-=o " ノーマルモードで o や O をした時に # を自動挿入しない

let g:rails_level=4
let g:rails_default_file="app/controllers/application.rb"
let g:rails_default_database="sqlite3"

augroup after_ftplugin_ruby
  autocmd!
  autocmd BufWritePre *.rb :RTrim
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
augroup END

if executable("rvm")
  let g:syntastic_ruby_exec = '~/.rvm/bin/ruby'
endif
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let &cpo = s:save_cpo
unlet s:save_cpo
