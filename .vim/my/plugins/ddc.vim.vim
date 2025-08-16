" Use TAB to select the next item, or trigger completion.
inoremap <silent><expr> <TAB>
\ pum#visible() ? pum#map#select_relative(+1) :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ? '<TAB>' :
\ ddc#map#manual_complete()

" Use S-TAB to select the previous item.
inoremap <silent><expr> <S-TAB>
\ pum#visible() ? pum#map#select_relative(-1) : '<S-TAB>'

" Use CR (Enter) to confirm completion, otherwise it's a normal Enter.
" Close the popup and confirm the selection.
inoremap <silent><expr> <CR>
\ pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'

" Use C-e to close the popup.
inoremap <silent><expr> <C-e>
\ pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<C-e>'

" Use C-l for completing common string.
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
      \     isVolatile: v:true,
      \     confirmBehavior: 'replace',
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
