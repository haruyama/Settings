let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:acp_enableAtStartup = 0

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

autocmd BufFilePost Manpageview* silent execute ":NeoComplCacheCachingBuffer"

"workaround for gvim
let g:neocomplcache_enable_prefetch=1

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
