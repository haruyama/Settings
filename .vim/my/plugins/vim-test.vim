nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>f :TestFile<CR>
nmap <silent> <leader>s :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

let g:test#python#pytest#options = {
      \ 'nearest': '-v',
      \ 'file':    '-v',
      \ 'suite':   '-v',
      \}
let g:test#go#gotest#options = {
      \ 'nearest': '-v',
      \ 'file':    '-v',
      \ 'suite':   '-v',
      \}

let g:test#javascript#jest#executable = 'npx jest'
