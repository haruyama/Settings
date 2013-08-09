imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"
" " SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ?  "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"
" " For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet/autoload/neosnippet/'
