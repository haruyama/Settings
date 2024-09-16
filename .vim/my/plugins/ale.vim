let g:ale_linters = {
      \}
" \   'c': ['cpplint'],
" \   'cpp': ['cpplint'],
" \   'javascript': ['biome'],
" \   'typescript': ['biome'],
" \   'go': ['go build', 'go vet'],
" \   'html': ['alex', 'htmlhint', 'proselint', 'write-good'],
" \   'python': ['flake8', 'pycodestle', 'pyright'],
" \   'rust': ['cargo'],
nnoremap <silent> <leader>an :ALENextWrap<cr>
nnoremap <silent> <leader>ap :ALEPreviousWrap<cr>
let g:ale_go_bingo_executable = 'gopls'
let g:ale_javascript_eslint_suppress_missing_config = 1
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_cmake_cmakelint_options = '--filter=-readability/wonkycase,-linelength'
let g:ale_cpp_cpplint_options = '--linelength=120 --filter=-build/include_subdir,-legal/copyright,-build/c++11,-whitespace/braces'
let g:ale_php_phpcs_options = '--exclude=Generic.Files.LineLength'

" \   'go': ['go build', 'gosimple', 'go vet', 'staticcheck'],
