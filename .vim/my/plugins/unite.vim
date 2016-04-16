let g:unite_source_grep_default_opts = '-iRHn --color=none'

nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file file/new<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uc :<C-u>UniteWithBufferDir -buffer-name=files file<CR>

nnoremap <silent> ,ue :<C-u>Unite file_rec/async:!<CR>

nnoremap <silent> ,ug :<C-u>Unite grep:%<CR>

nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
nnoremap <silent> ,un :<C-u>UniteWithBufferDir file/new<CR>
nnoremap <silent> ,uo :<C-u>Unite -no-quit -vertical -winwidth=30 -direction=botright outline<CR>

nnoremap <silent> ,uq :<C-u>Unite -no-quit -direction=botright quickfix location_list<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>

nnoremap <silent> ,uu :<C-u>Unite buffer file_mru tab<CR>

call unite#custom#default_action('file',     'above')
call unite#custom#default_action('file_mru', 'above')
call unite#custom#default_action('file/new', 'above')

call unite#custom#default_action('buffer',   'above')
call unite#custom#default_action('tab',      'above')
call unite#custom#default_action('bookmark', 'above')
