let g:quickrun_config = {
      \    "octave" : {
      \       "command" : "octave",
      \       "cmdopt"  : "--silent",
      \   },
      \    "ceylon" : {
      \       "command" : "ceylon",
      \       "cmdopt"  : "compile",
      \   },
      \}
nnoremap <silent> <leader>r :QuickRun<cr>
