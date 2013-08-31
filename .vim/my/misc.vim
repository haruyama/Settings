source $VIMRUNTIME/macros/matchit.vim
set omnifunc=syntaxcomplete#Complete

let g:yankring_history_dir            = $HOME . '/.vim/history'
let g:yankring_manual_clipboard_check = 1

map gf <C-W>f

augroup vimrc_auto_mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
          \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

let g:template_vim_template_dir  = $HOME . '/.vim/template'
let g:template_vim_template_dirs = [$HOME . '/.vim/template']

nnoremap <SID>(toggle-number)         :<C-u>set number!<CR>
nnoremap <SID>(toggle-relativenumber) :<C-u>set relativenumber!<CR>
nnoremap <SID>(toggle-paste)          :<C-u>set paste!<CR>

nmap <Leader>1 <SID>(toggle-number)
nmap <Leader>2 <SID>(toggle-relativenumber)
nmap <Leader>3 <SID>(toggle-paste)

let g:ref_clojure_cmd     = ['lein', 'trampoline', 'run', '-m', 'clojure.main']
let g:ref_clojure_precode = '(use ''[clojure.repl :only (doc find-doc)])'
let g:ref_javadoc_path    = '/usr/share/doc/openjdk-7-jre-headless/'

let g:vimfiler_as_default_explorer = 1
"hi MatchParen term=underline ctermfg=black ctermbg=yellow gui=underline guifg=black guibg=yellow
hi MatchParen term=bold,reverse cterm=bold,reverse gui=bold,reverse

"http://cohama.hateblo.jp/entry/20121017/1350482411
let g:endwise_no_mappings = 1
augroup my_endwise_with_smartinput
  autocmd!
  autocmd FileType lua,ruby,sh,zsh,vb,vbnet,aspvbs,vim imap <buffer> <CR> <CR><Plug>DiscretionaryEnd
augroup END

let g:niji_matching_filetypes = ['lisp', 'scheme']

vnoremap <silent> <Leader>a :EasyAlign<cr>

let g:syntastic_always_populate_loc_list=1

let g:gitgutter_enabled = 0
