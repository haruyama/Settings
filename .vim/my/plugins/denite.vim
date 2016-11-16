nnoremap <silent> ,ua :<C-u>DeniteBufferDir file_rec directory_rec<CR>

nnoremap <silent> ,uc :<C-u>Denite colorscheme<CR>
nnoremap <silent> ,ud :<C-u>Denite directory_rec<CR>
nnoremap <silent> ,uf :<C-u>Denite filetype<CR>
nnoremap <silent> ,ug :<C-u>Denite grep<CR>
nnoremap <silent> ,ul :<C-u>Denite line<CR>

nnoremap <silent> ,um :<C-u>Denite file_mru<CR>


nnoremap <silent> ,uu :<C-u>Denite buffer file_mru<CR>
nnoremap <silent> ,uy :<C-u>Denite neoyank<CR>

nnoremap <silent> ,ur :<C-u>Denite -resume=true<CR>
nnoremap <silent> ,up :<C-u>Denite -resume=true -select=-1 -immediately=true<CR>
nnoremap <silent> ,un :<C-u>Denite -resume=true -select=+1 -immediately=true<CR>

call denite#custom#map('_', "\<C-n>", 'move_to_next_line')
call denite#custom#map('_', "\<C-p>", 'move_to_prev_line')
