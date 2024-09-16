" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? '<C-n>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'
inoremap <silent><expr> <C-l> ddc#map#complete_common_string()

call ddc#custom#patch_global(
      \ 'sources', ['around', 'lsp', 'dictionary', 'vsnip']
      \ )
call ddc#custom#patch_global('ui', 'pum')

call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank'],
      \   'converters': ['converter_remove_overlap'],
      \ },
      \ 'around': {
      \   'mark': 'A',
      \   'matchers': ['matcher_head', 'matcher_length'],
      \ },
      \ 'lsp': {
      \   'mark': 'lsp', 
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \  },
      \  'vsnip': #{
      \     mark: 'vsnip',
      \   },
      \ })
call ddc#custom#patch_global('sourceParams', #{
      \   lsp: #{
      \     enableResolveItem: v:true,
      \     enableAdditionalTextEdit: v:true,
      \   },
      \ })
call ddc#custom#patch_filetype(
      \   ['vim', 'toml'], 'sources', ['around']
      \ )

call ddc#enable(#{
      \   context_filetype: 'treesitter',
      \ })

