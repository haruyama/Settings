call pum#set_option({
      \  'auto_select':  v:true,
      \})

" inoremap <silent><expr> <PageDown> pum#visible() ? "<Cmd>call pum#map#insert_relative_page(+1)<CR>" : "<PageDown>"
" inoremap <silent><expr> <PageUp>   pum#visible() ? "<Cmd>call pum#map#insert_relative_page(-1)<CR>" : "<PageUp>"
" inoremap <silent><expr> <S-Tab>    pum#visible() ? "<Cmd>call pum#map#insert_relative(-1, 'empty')<CR>" : "<S-Tab>"
" inoremap <silent><expr> <C-n>      pum#visible() ? "<Cmd>call pum#map#select_relative(+1)<CR>" : "<C-n>"
" inoremap <silent><expr> <C-p>      pum#visible() ? "<Cmd>call pum#map#select_relative(-1)<CR>" : "<C-p>"
" inoremap <silent><expr> <C-y>      pum#visible() ? "<Cmd>call pum#map#confirm_word()<CR>" : "<C-y>"
" inoremap <silent><expr> <C-e>      pum#visible() ? "<Cmd>call pum#map#cancel()<CR>" : "<C-e>"
" inoremap <silent><expr> <Home>     pum#visible() ? "<Cmd>call pum#map#insert_relative(-9999, 'ignore')<CR>" : "<Home>"
" inoremap <silent><expr> <End>      pum#visible() ? "<Cmd>call pum#map#insert_relative(+9999, 'ignore')<CR>" : "<End>"
" inoremap <silent><expr> <C-g>      pum#visible() ? "<Cmd>call pum#map#set_option(#{preview: !pum#_options().preview,})<CR>" : "<C-g>"
" inoremap <silent><expr> <C-t>      pum#visible() ? "<C-v><Tab>" : "<C-t>"

inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1, 'empty')<CR>
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
"inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm_suffix()<CR>
inoremap <C-o>   <Cmd>call pum#map#confirm_matched_pattern('^\S\+')<CR>
inoremap <Home>  <Cmd>call pum#map#insert_relative(-9999, 'ignore')<CR>
inoremap <End>   <Cmd>call pum#map#insert_relative(+9999, 'ignore')<CR>
inoremap <C-g>   <Cmd>call pum#map#toggle_preview()<CR>
inoremap <C-t>   <C-v><Tab>
"inoremap <C-z>   <Cmd>call pum#update_current_item(#{ display: 'hoge' })<CR>
"inoremap <C-y>   <Cmd>call pum#map#scroll_preview(+1)<CR>
"inoremap <C-e>   <Cmd>call pum#map#scroll_preview(-1)<CR>

inoremap <expr> <C-g>   ddc#map#insert_item(0)
cnoremap <expr> <C-g>   ddc#map#insert_item(0)
