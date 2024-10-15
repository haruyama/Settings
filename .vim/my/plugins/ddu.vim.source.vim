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
