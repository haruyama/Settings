call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
\ [ '.git/', '.ropeproject/', '__pycache__/',
\   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', 'node_modules/', 'vendor/'])

call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])

" Define mappings
augroup my_denite
  autocmd!

  autocmd FileType denite call s:denite_my_settings()
augroup END

function! s:denite_my_settings() abort
nnoremap <silent><buffer><expr> <CR>
\ denite#do_map('do_action')
nnoremap <silent><buffer><expr> d
\ denite#do_map('do_action', 'delete')
nnoremap <silent><buffer><expr> p
\ denite#do_map('do_action', 'preview')
nnoremap <silent><buffer><expr> q
\ denite#do_map('quit')
nnoremap <silent><buffer><expr> i
\ denite#do_map('open_filter_buffer')
nnoremap <silent><buffer><expr> <Space>
\ denite#do_map('toggle_select').'j'
nnoremap <silent><buffer><expr> u
\ denite#do_map('move_up_path')
endfunction
