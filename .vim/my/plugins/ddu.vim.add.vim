" nnoremap <silent> / <Cmd>Ddu
" \ -name=search line
" \ -ui-param-startFilter=v:true<CR>
" nnoremap <silent> * <Cmd>Ddu
" \ -name=search line -input=`expand('<cword>')`
" \ -ui-param-startFilter=v:false<CR>
" nnoremap <silent> n <Cmd>Ddu
" \ -name=search -resume -refresh<CR>
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
