call ddc#custom#patch_global('sourceParams', {
      \ 'dictionary': {'dictPaths': 
      \ [
      \ '/usr/share/dict/words',
      \ ],
      \ 'smartCase': v:true,
      \ 'isVolatile': v:true,
      \ }
      \ })
