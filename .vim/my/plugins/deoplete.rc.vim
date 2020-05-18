"---------------------------------------------------------------------------
" deoplete.nvim
"

set completeopt+=noinsert
set completeopt+=noselect

" <TAB>: completion.
imap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

"inoremap <expr><C-g> deoplete#mappings#undo_completion()
" <C-l>: redraw candidates
"inoremap <expr><C-l>       deoplete#mappings#refresh()

" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function() abort
"  return deoplete#mappings#close_popup() . "\<CR>"
"endfunction

"inoremap <expr> '  pumvisible() ? deoplete#mappings#close_popup() : "'"

" call deoplete#custom#source('_', 'matchers', ['matcher_head'])
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])

" Use auto delimiter
" call deoplete#custom#source('_', 'converters',
"       \ ['converter_auto_paren',
"       \  'converter_auto_delimiter', 'remove_overlap'])
call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ ])

" call deoplete#custom#source('buffer', 'min_pattern_length', 9999)

call deoplete#custom#option('keyword_patterns', {
      \ '_': '[a-zA-Z_]\k*',
      \ 'ruby': '[a-zA-Z_]\w*[!?]?',
      \ 'tex': '[^\w|\s][a-zA-Z_]\w*',
      \})

" inoremap <silent><expr> <C-t> deoplete#mappings#manual_complete('file')

call deoplete#custom#var('enable_refresh_alway', 1)
let g:deoplete#enable_camel_case = 1

" deoplete-clang "{{{
" libclang shared library path
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'

" clang builtin header path
let g:deoplete#sources#clang#clang_header = '/usr/include/clang'

" libclang default compile flags
let g:deoplete#sources#clang#flags = ['-x', 'c++', '-std=c++11']

" compile_commands.json directory path
" Not file path. Need build directory path
" let g:deoplete#sources#clang#clang_complete_database =
"       \ expand('~/src/neovim/build')
"}}}
