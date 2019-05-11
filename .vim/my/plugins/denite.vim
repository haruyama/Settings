nnoremap <silent> ,ua :<C-u>DeniteBufferDir -default-action=split file/rec<CR>

nnoremap <silent> ,uc :<C-u>Denite colorscheme<CR>
nnoremap <silent> ,ud :<C-u>Denite -default-action=split directory_rec<CR>
nnoremap <silent> ,uf :<C-u>Denite filetype<CR>
nnoremap <silent> ,ug :<C-u>Denite grep<CR>
nnoremap <silent> ,ul :<C-u>Denite line<CR>

nnoremap <silent> ,um :<C-u>Denite file_mru<CR>

nnoremap <silent> ,uu :<C-u>Denite -default-action=split buffer file_mru<CR>
nnoremap <silent> ,uy :<C-u>Denite neoyank<CR>

nnoremap <silent> ,ur :<C-u>Denite -resume=true<CR>
nnoremap <silent> ,up :<C-u>Denite -resume=true -select=-1 -immediately=true<CR>
nnoremap <silent> ,un :<C-u>Denite -resume=true -select=+1 -immediately=true<CR>

call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
\ [ '.git/', '.ropeproject/', '__pycache__/',
\   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', 'node_modules/', 'vendor/'])

call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
