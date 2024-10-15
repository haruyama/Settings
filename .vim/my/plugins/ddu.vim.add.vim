nnoremap <silent> ,ua
      \ <Cmd>Ddu -name=files file_rec<CR>
nnoremap <silent> ,ub
      \ <Cmd>Ddu -name=files buffer<CR>
nnoremap <silent> ,uu
      \ <Cmd>Ddu -name=files mr<CR>
nnoremap <silent> ,uc
      \ <Cmd>Ddu -name=files -source-param-current=true mr<CR>
nnoremap <silent> ,uw
      \ <Cmd>Ddu -name=files -source-param-kind=mrw mr<CR>
nnoremap <silent> ,ug
      \ <Cmd>Ddu -name=files -source-param-kind=mrr mr<CR>
