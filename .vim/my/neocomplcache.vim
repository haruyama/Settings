let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

autocmd BufFilePost Manpageview* silent execute ":NeoComplCacheCachingBuffer"

"workaround for gvim
let g:neocomplcache_enable_prefetch=1
