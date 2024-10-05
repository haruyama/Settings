call ddu#custom#patch_global({
      \   'ui': 'filer',
      \   'sources': [{'name': 'file', 'params': {}}],
      \   'sourceOptions': {
      \     '_': {
      \       'ignoreCase': v:true,
      \       'matchers': ['matcher_substring'],
      \     },
      \     'file_old': {
      \       'matchers': [
      \         'matcher_substring', 'matcher_relative', 'matcher_hidden',
      \       ],
      \     },
      \     'file_external': {
      \       'matchers': [
      \         'matcher_substring', 'matcher_hidden',
      \       ],
      \     },
      \     'file_rec': {
      \       'matchers': [
      \         'matcher_substring', 'matcher_hidden',
      \       ],
      \     'path': expand('%:p:h'),
      \     },
      \     'dein': {
      \       'defaultAction': 'cd',
      \     },
      \   },
      \   'sourceParams': {
      \     'file_external': {
      \       'cmd': ['git', 'ls-files', '-co', '--exclude-standard'],
      \     },
      \   },
      \   'uiParams': {
      \     'ff': {
      \       'filterSplitDirection': 'floating',
      \     }
      \   },
      \   'kindOptions': {
      \     'file': {
      \       'defaultAction': 'open',
      \     },
      \     'word': {
      \       'defaultAction': 'append',
      \     },
      \     'deol': {
      \       'defaultAction': 'switch',
      \     },
      \     'action': {
      \       'defaultAction': 'do',
      \     },
      \   },
      \   'filterParams': {
      \     'matcher_substring': {
      \       'highlightMatched': 'Search',
      \     },
      \   }
      \ })
call ddu#custom#patch_local('files', {
      \   'uiParams': {
      \     'ff': {
      \       'split': 'floating',
      \     }
      \   },
      \ })

"call ddu#custom#action('kind', 'file', 'test',
"    \ { args -> execute('let g:foo = 1') })
"call ddu#custom#action('source', 'file_old', 'test2',
"    \ { args -> execute('let g:bar = 1') })

" nnoremap <buffer> <CR>
"       \ <Cmd>call ddu#ui#do_action('itemAction')<CR>
" nnoremap <buffer> <Space>
"       \ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
" nnoremap <buffer> i
"       \ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
" nnoremap <buffer> <C-l>
"       \ <Cmd>call ddu#ui#do_action('refreshItems')<CR>
" nnoremap <buffer> p
"       \ <Cmd>call ddu#ui#do_action('preview')<CR>
" nnoremap <buffer> q
"       \ <Cmd>call ddu#ui#do_action('quit')<CR>
" nnoremap <buffer> a
"       \ <Cmd>call ddu#ui#do_action('chooseAction')<CR>
" nnoremap <buffer> c
"       \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'cd'})<CR>
" nnoremap <buffer> d
"       \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<CR>
" nnoremap <buffer> e
"       \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'edit'})<CR>
" nnoremap <buffer> E
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ {'params': eval(input('params: '))})<CR>
" nnoremap <buffer> v
"       \ <Cmd>call ddu#ui#do_action('itemAction',
"       \ {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
" nnoremap <buffer> N
"       \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'new'})<CR>
" nnoremap <buffer> r
"       \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'quickfix'})<CR>
" nnoremap <buffer> u
"       \ <Cmd>call ddu#ui#do_action('updateOptions', {
"       \   'sourceOptions': {
"       \     '_': {
"       \       'matchers': [],
"       \     },
"       \   },
"       \ })<CR>


function! s:ddu_my_settings() abort
  " nnoremap <buffer><silent> <CR>
  "       \ <Cmd>call ddu#ui#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ {'name': 'open', 'params': {'command': 'split'}})<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
  nnoremap <buffer> o
        \ <Cmd>call ddu#ui#do_action('expandItem',
        \ {'mode': 'toggle'})<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
endfunction
autocmd FileType ddu-filer call s:ddu_my_settings()
