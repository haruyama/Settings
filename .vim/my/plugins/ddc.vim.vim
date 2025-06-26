" <TAB>: completion.
inoremap <expr> <TAB>
      \ : pum#visible()
      \ ? '<Cmd>call pum#map#insert_relative(+1, "empty")<CR>'
      \ : col('.') <= 1 ? '<TAB>'
      \ : getline('.')[col('.') - 2] =~# '\s'
      \ ? '<TAB>'
      \ : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pum#visible() ? '<C-p>' : '<C-h>'
inoremap <expr> <C-l> ddc#map#complete_common_string()

call ddc#custom#patch_global(
      \ 'sources', ['around', 'lsp', 'vsnip', 'dictionary'] 
      \ )

call ddc#custom#patch_global('ui', 'pum')

call ddc#custom#patch_global('sourceOptions', #{
      \   _: #{
      \     matchers: ['matcher_head'],
      \     sorters: ['sorter_rank'],
      \     converters: ['converter_remove_overlap'],
      \   },
      \   around: #{
      \     mark: 'A',
      \     matchers: ['matcher_head', 'matcher_length'],
      \   },
      \   lsp: #{
      \     mark: 'lsp', 
      \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
      \   },
      \   dictionary: #{mark: 'D'},
      \   vsnip: #{
      \     mark: 'vsnip',
      \     dup: v:true,
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
