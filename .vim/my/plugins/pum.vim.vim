call pum#set_option({
      \  'auto_select':  v:true,
      \})
inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1, 'empty')<CR>
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
inoremap <C-o>   <Cmd>call pum#map#confirm_word()<CR>
inoremap <Home>  <Cmd>call pum#map#insert_relative(-9999, 'ignore')<CR>
inoremap <End>   <Cmd>call pum#map#insert_relative(+9999, 'ignore')<CR>
inoremap <C-g>   <Cmd>call pum#set_option(#{
      \   preview: !pum#_options().preview,
      \ })<CR>
inoremap <C-t>   <C-v><Tab>
