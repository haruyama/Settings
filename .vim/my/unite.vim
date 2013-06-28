let g:unite_source_grep_default_opts = '-iRHn --color=none'

" unite mapping
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uc :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru tab<CR>
nnoremap <silent> ,uo :<C-u>Unite outline<CR>
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file file/new<CR>
nnoremap <silent> ,ug :<C-u>Unite grep:%<CR>

call unite#custom_default_action('file', 'above')
call unite#custom_default_action('file_mru', 'above')
call unite#custom_default_action('file/new', 'above')

call unite#custom_default_action('buffer', 'above')
call unite#custom_default_action('tab', 'above')
call unite#custom_default_action('bookmark', 'above')
